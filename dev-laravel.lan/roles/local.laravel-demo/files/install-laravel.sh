#!/usr/bin/env bash

set -eu

# Move execution to realpath of script
cd $(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)

########################################
## Command Line Options
########################################
declare CONFIG_FILE=""
for switch in $@; do
    case $switch in
        *)
            CONFIG_FILE="${switch}"
            if [[ "${CONFIG_FILE}" =~ ^.+$ ]]; then
              if [[ ! -f "${CONFIG_FILE}" ]]; then
                >&2 echo "Error: Invalid config file given"
                exit -1
              fi
            fi
            ;;
    esac
done
if [[ $# < 1 ]]; then
  echo "An argument was not specified:"
  echo " <config_filename>    Specify config file to use to override default configs."
  echo ""
  echo "Exampe: install-laravel.sh config_stage.json"
  exit;
fi






# Config Files
CONFIG_DEFAULT="config_default.json"
CONFIG_OVERRIDE="${CONFIG_FILE}"
[[ "${CONFIG_OVERRIDE}" != "" && -f ${CONFIG_OVERRIDE} ]] || CONFIG_OVERRIDE=""


# Read merged config JSON files
declare CONFIG_NAME=$(cat ${CONFIG_DEFAULT} ${CONFIG_OVERRIDE} | jq -s add | jq -r '.CONFIG_NAME')
declare SITE_HOSTNAME=$(cat ${CONFIG_DEFAULT} ${CONFIG_OVERRIDE} | jq -s add | jq -r '.SITE_HOSTNAME')

declare ENV_ROOT_DIR=$(cat ${CONFIG_DEFAULT} ${CONFIG_OVERRIDE} | jq -s add | jq -r '.ENV_ROOT_DIR')
declare LARAVEL_ROOT_DIR=$(cat ${CONFIG_DEFAULT} ${CONFIG_OVERRIDE} | jq -s add | jq -r '.LARAVEL_ROOT_DIR')
declare SITE_ROOT_DIR=$(cat ${CONFIG_DEFAULT} ${CONFIG_OVERRIDE} | jq -s add | jq -r '.SITE_ROOT_DIR')

declare REDIS_OBJ_HOST=$(cat ${CONFIG_DEFAULT} ${CONFIG_OVERRIDE} | jq -s add | jq -r '.REDIS_OBJ_HOST')
declare REDIS_OBJ_PORT=$(cat ${CONFIG_DEFAULT} ${CONFIG_OVERRIDE} | jq -s add | jq -r '.REDIS_OBJ_PORT')
declare REDIS_OBJ_DB=$(cat ${CONFIG_DEFAULT} ${CONFIG_OVERRIDE} | jq -s add | jq -r '.REDIS_OBJ_DB')
declare REDIS_SES_HOST=$(cat ${CONFIG_DEFAULT} ${CONFIG_OVERRIDE} | jq -s add | jq -r '.REDIS_SES_HOST')
declare REDIS_SES_PORT=$(cat ${CONFIG_DEFAULT} ${CONFIG_OVERRIDE} | jq -s add | jq -r '.REDIS_SES_PORT')
declare REDIS_SES_DB=$(cat ${CONFIG_DEFAULT} ${CONFIG_OVERRIDE} | jq -s add | jq -r '.REDIS_SES_DB')


# Dynamic Variables
DB_HOST=$(echo $(grep "^\s*host " ~/.my.cnf | cut -d= -f2 | perl -p -e 's/^\s*(.*?)\s*$/$1/'))
DB_USER=$(echo $(grep "^\s*user " ~/.my.cnf | cut -d= -f2 | perl -p -e 's/^\s*(.*?)\s*$/$1/'))
DB_PASS=$(echo $(grep "^\s*password " ~/.my.cnf | cut -d= -f2 | perl -p -e 's/^\s*(.*?)\s*$/$1/'))
DB_NAME=$(echo $(grep "^\s*database " ~/.my.cnf | cut -d= -f2 | perl -p -e 's/^\s*(.*?)\s*$/$1/'))

BASE_URL="https://${SITE_HOSTNAME}"


# Moving to Environment Root Directory
echo "----: Move to Environment Root ${ENV_ROOT_DIR}"
cd ${ENV_ROOT_DIR}





# Install Laravel Installer
echo "----: Install Laravel Installer"
composer global require laravel/installer

# Add composer global vendor bin to user's profile PATH
echo "----: Add composer global vendor bin to user's profile PATH"
export PATH="/home/www-data/.composer/vendor/bin:$PATH"
cat ~/.bash_profile | grep 'export PATH="/home/www-data/.composer/vendor/bin:$PATH"' || \
  echo -e "\n"'export PATH="/home/www-data/.composer/vendor/bin:$PATH"'"\n" >> ~/.bash_profile

# Use Laravel Installer to setup new project
echo "----: Setup new Laravel project"
laravel new laravel

# Use composer to setup new project
# composer create-project --prefer-dist laravel/laravel

# Generate environment key 
# - This is done automatically when installing using Laravel Installer or compoer create-project
# php artisan key:generate

# Moving to Application Root Directory
echo "----: Move to Application Root ${LARAVEL_ROOT_DIR}"
cd ${LARAVEL_ROOT_DIR}



# Create SymLink for site root
echo "----: Creating Site Root Symlink to Laravel Root"
ln -s ${LARAVEL_ROOT_DIR} ${ENV_ROOT_DIR}/${SITE_ROOT_DIR}

# Display install results as indicator that script completed successfully
echo "----: Displaying Install Results"
INSTALL_RESULTS=$(cat <<CONTENTS_HEREDOC
{
  "base_url": "${BASE_URL}"
}
CONTENTS_HEREDOC
)
echo "${INSTALL_RESULTS}" | jq .

echo "----: Laravel Demo Install Finished"
