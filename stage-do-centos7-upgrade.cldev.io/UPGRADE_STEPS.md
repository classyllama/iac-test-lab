# Set Upgrade From Configs

    rm app_vars.config.yml
    ln -s app_vars.config.upgrade_from.yml app_vars.config.yml

# Confirm Anisble changes are current

    ansible-playbook -i inventories/app app.yml --diff --check

# Put site in mainteanance mode / Disable cron

    # Put site in mainteanance mode
    cd /var/www/data/current
    bin/magento maintenance:enable

    # Disable cron
    crontab -e

# Run new backup

    systemctl stop php-fpm
    /usr/local/bin/dbbackup.sh /data/dbbackup

# Uninstall Old Versions Manually

    # Stop services
    systemctl stop php-fpm
    systemctl stop mysql
    systemctl stop varnish
    systemctl stop nginx
    redis-cli -p 6379 flushall
    redis-cli -p 6380 flushall
    systemctl stop redis-obj
    systemctl stop redis-ses
    systemctl stop elasticsearch

    # Backup mysql root credentials
    cp /root/.my.cnf /root/.my.cnf.percona56.bak

    # Remove installed packages
    yum -y remove php73-bcmath php73-cli php73-common php73-devel php73-fpm php73-gd php73-intl php73-json php73-mbstring php73-mysqlnd php73-opcache php73-pdo php73-pecl-igbinary php73-pecl-imagick php73-pecl-msgpack php73-pecl-redis php73-process php73-soap php73-sodium php73-xml php73-xmlrpc
    yum -y remove Percona-Server-server-56 Percona-Server-client-56 Percona-Server-shared-56 percona-release
    yum -y remove varnish
    yum -y remove nginx
    yum -y remove redis32u
    yum -y remove elasticsearch elasticsearch-oss

# Change Ansible Configs

    rm app_vars.config.yml
    ln -s app_vars.config.upgrade_to.yml app_vars.config.yml

# Run Ansible to Install New Versions

    # Run Ansible to install newer versions
    ansible-playbook -i inventories/app app.yml --diff

    # After Percona 5.7 is installed playbook will likely fail checking permissions at:
    # list mysql user account without passwords
    # this is because it's expecting 5.7 permission tables, and you'll need to run an upgrade command first
    # on the server run the following upgrade command:
    mysql_upgrade
    systemctl restart mysql

    # Then you can re-run the playbook, and it should pick up where it left off
    ansible-playbook -i inventories/app app.yml --diff
