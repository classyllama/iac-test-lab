
# Building DevEnv Test Configs

Magento

    set -k
    # setopt INTERACTIVE_COMMENTS
    
    declare -a dirs=(
      "dev-centos7-common.lan"
      "dev-centos7-latest.lan"
      "dev-centos7-old.lan"
      "dev-centos8-latest.lan"
      "dev-centos8-min.lan"
    )
    currentDir=$PWD
    for dir in "${dirs[@]}"; do
      cd ${dir}
      pwd
      
      DOMAIN="${PWD##*/}"
      IP_ADDRESS=$(cat /etc/hosts | grep ${DOMAIN} | head -n 1 | grep -Eo -m 1 '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
      ssh-keygen -R ${DOMAIN}
      [[ "${IP_ADDRESS}" != "" ]] && ssh-keygen -R ${IP_ADDRESS}
      
      vagrant halt
      vagrant destroy -f
      rm -f ./*.vmdk
      vagrant box update
      gitman update
      
      #(cd source/ && git pull)
      #time (vagrant up && vagrant ssh -c "~/magento-demo/install-magento.sh config_site.json" -- -q)
      #(cd source/provisioning/ && ansible-playbook -i ../persistent/inventory/devenv cache_sync.yml --diff)
      cd ${currentDir}
    done

Laravel

    set -k
    # setopt INTERACTIVE_COMMENTS
    
    declare -a dirs=(
      "dev-laravel.lan"
    )
    currentDir=$PWD
    for dir in "${dirs[@]}"; do
      cd ${dir}
      pwd
      vagrant halt
      vagrant destroy -f
      #(cd source/ && git pull)
      #time (vagrant up && vagrant ssh -c "~/magento-demo/install-laravel.sh config_site.json" -- -q)
      #(cd source/provisioning/ && ansible-playbook -i ../persistent/inventory/devenv cache_sync.yml --diff)
      cd ${currentDir}
    done

# Re-run Ansible Provisioning Playbook and Other Playbooks

    cd source/provisioning/
    ansible-playbook -i ../persistent/inventory/devenv virtualbox.yml --diff
    ansible-playbook -i ../persistent/inventory/devenv cache_sync.yml --diff

    ansible-playbook -i ../persistent/inventory/devenv action_xdebug_enable.yml --diff
    ansible-playbook -i ../persistent/inventory/devenv action_xdebug_disable.yml --diff

    # alternatively use shortcut commands
    ./devenv xdebug enable
    ./devenv xdebug disable

# Rebuild Magento Demo

    ~/magento-demo/uninstall-magento.sh config_site.json
    ~/magento-demo/install-magento.sh config_site.json
