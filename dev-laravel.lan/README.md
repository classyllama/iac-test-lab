# Initialize DevEnv

  Initialize DevEnv repo source files

    gitman install
  
  Build machine
  
    vagrant up
  
  Diagnosing Hostname/IP

    vagrant ssh -c "hostname -I | cut -d ' ' -f 2" -- -q

  Ansible Provisioning

    ansible-playbook -i ../persistent/inventory/devenv virtualbox.yml --diff

  Install Laravel Demo

    ~/laravel-demo/install-laravel.sh config_site.json

  Start Mutagen

    mutagen project start
    mutagen sync monitor

  Open in browser

    https://dev-laravel.lan/
  
  Stop Mutagen
  
    mutagen sync terminate magento
  
  Stop Vagrant
  
    vagrant halt
