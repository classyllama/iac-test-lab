# Set Upgrade From Configs

    rm app_vars.config.yml
    ln -s app_vars.config.upgrade_from.yml app_vars.config.yml

# Confirm Anisble changes are current

    ansible-playbook -i inventories/app app.yml --diff --check

# Uninstall Old Versions Manually

    systemctl stop php-fpm
    yum -y remove php73-bcmath php73-cli php73-common php73-devel php73-fpm php73-gd php73-intl php73-json php73-mbstring php73-mysqlnd php73-opcache php73-pdo php73-pecl-igbinary php73-pecl-imagick php73-pecl-msgpack php73-pecl-redis php73-process php73-soap php73-sodium php73-xml php73-xmlrpc
    systemctl stop mysql
    yum -y remove Percona-Server-server-56 Percona-Server-client-56 Percona-Server-shared-56 percona-release
    cp /root/.my.cnf /root/.my.cnf.percona56.bak
    systemctl stop varnish
    yum -y remove varnish
    systemctl stop nginx
    yum -y remove nginx
    redis-cli -p 6379 flushall
    redis-cli -p 6380 flushall
    systemctl stop redis-obj
    systemctl stop redis-ses
    yum -y remove redis32u
    systemctl stop elasticsearch
    yum -y remove elasticsearch

# Change Ansible Configs

    rm app_vars.config.yml
    ln -s app_vars.config.upgrade_to.yml app_vars.config.yml

# Run Ansible to Install New Versions

    ansible-playbook -i inventories/app app.yml --diff
    # After Percona 5.7 is installed playbook will likely fail checking permissions at:
    # list mysql user account without passwords
    # this is because it's expecting 5.7 permission tables, and you'll need to run an upgrade command first
    # run the following upgrade command:
    # mysql_upgrade
    # service mysql restart
    # then you can re-run the playbook, and it should pick up where it left off
    ansible-playbook -i inventories/app app.yml --diff
