# Global variables that are specific to the project and override the default
# variables from the source repo.
# This file should be committed to the project repo

# Environment Configs
$dev_machine_name = 'dev-centos7-transition.lan'
$dev_additional_hostnames = %w()

# System Configs
$vagrant_base_box = 'bento/centos-7' # support for 'bento/centos-7' and 'bento/centos-8'
# $dev_vm_cpus = 2
# $dev_vm_ram = 4096
# $ssh_private_key = '~/.ssh/id_rsa'
# $ssh_public_key_paths = ['~/.ssh/id_rsa.pub']

# $persistent_disks = [
#   {
#     "description" => "data",
#     "persistDiskPath" => "data_disk.vmdk",
#     "persistDiskSizeGb" => 50
#   },
#   {
#     "description" => "datadb",
#     "persistDiskPath" => "datadb_disk.vmdk",
#     "persistDiskSizeGb" => 50
#   }
# ]
