
# Building DevEnv Test Configs

Magento

    cd ~/projects/test-lab/dev-centos8-min.lan/
    vagrant halt && vagrant destroy -f
    (cd source/ && git pull)
    time (vagrant up && vagrant ssh -c "~/magento-demo/install-magento.sh config_site.json" -- -q)
    (cd source/provisioning/ && ansible-playbook -i ../persistent/inventory/devenv cache_sync.yml --diff)

    cd ~/projects/test-lab/dev-centos8-latest.lan/
    vagrant halt && vagrant destroy -f
    (cd source/ && git pull)
    time (vagrant up && vagrant ssh -c "~/magento-demo/install-magento.sh config_site.json" -- -q)
    (cd source/provisioning/ && ansible-playbook -i ../persistent/inventory/devenv cache_sync.yml --diff)

    cd ~/projects/test-lab/dev-centos7-old.lan/
    vagrant halt && vagrant destroy -f
    (cd source/ && git pull)
    time (vagrant up && vagrant ssh -c "~/magento-demo/install-magento.sh config_site.json" -- -q)
    (cd source/provisioning/ && ansible-playbook -i ../persistent/inventory/devenv cache_sync.yml --diff)

    cd ~/projects/test-lab/dev-centos7-latest.lan/
    vagrant halt && vagrant destroy -f
    (cd source/ && git pull)
    time (vagrant up && vagrant ssh -c "~/magento-demo/install-magento.sh config_site.json" -- -q)
    (cd source/provisioning/ && ansible-playbook -i ../persistent/inventory/devenv cache_sync.yml --diff)

    cd ~/projects/test-lab/dev-centos7-common.lan/
    vagrant halt && vagrant destroy -f
    (cd source/ && git pull)
    time (vagrant up && vagrant ssh -c "~/magento-demo/install-magento.sh config_site.json" -- -q)
    (cd source/provisioning/ && ansible-playbook -i ../persistent/inventory/devenv cache_sync.yml --diff)

Laravel

    cd ~/projects/test-lab/dev-laravel.lan/
    vagrant halt && vagrant destroy -f
    (cd source/ && git pull)
    time (vagrant up && vagrant ssh -c "~/laravel-demo/install-laravel.sh config_site.json" -- -q)
    (cd source/provisioning/ && ansible-playbook -i ../persistent/inventory/devenv cache_sync.yml --diff)

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
