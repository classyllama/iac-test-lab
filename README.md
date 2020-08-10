# Reference Infrastructure Examples for Testing (Magento 2)
Some references for implementation of some IaC (Infrastructure as Code) tooling encomassing a consistency across development testing and production environments. The concept is to provide a consistent and reproducable environment at each stage of a project's lifecycle for continued change management of the infrastructure that runs the application.

Allowing the development environment to utilize the same tooling as the staging and production environments provides the oportunity to introduce changes in each step so that improvments can flow from development -> testing -> production and for maintaining an operational site reproduce environment specific configurations at any point flowing from production -> staging -> development. With the ability to easily create multiple environments, changes can be more easily introduced independently while maintaining existing running configurations as well.

Some tools used here:
Ansible https://www.ansible.com/
Vagrant https://www.vagrantup.com/
Terraform https://www.terraform.io/

[Additional Notes](NOTES.md)

### Development Environment
https://github.com/classyllama/devenv-vagrant
This is a Vagrant/Virtualbox based local development environment that is intended to operate on a per project basis so that each project can manage a development environment that represents how testing and production environments will also be configured. 

Some work has also been put into the ability to run a remote development environment on Digital Ocean, and operate from both MacOS/Windows hosts, though most testing has been done with MacOS/Virtualbox configurations.

### Stage/Test Environment
TODO
  [ ] Publish stageenv publically
  [ ] Cache sensetive Let's Encrypt SSL keys locally for rebuild
  
### Production Environment
TODO
  [ ] Create reference prod environment

## License

This work is licensed under the MIT license. See LICENSE file for details.

## Author Information

This reference was created in 2020 by [Matt Johnson](https://github.com/mttjohnson/).
