# -- Digital Ocean --
#digitalocean_region = "sfo2"
digitalocean_domain = "cldev.io"

# -- Application --
app_name = "stage-do-centos7-upgrade"
app_dns = [
  "stage-do-centos7-upgrade", # stage-do-centos7-upgrade.cldev.io
]

# -- Access --
ssh_access_ip_cidr = [
  "76.77.137.178/31"
]
digitalocean_fingerprints = [
    "44:fb:cf:7c:5e:ea:26:9b:de:22:1f:a1:3e:c0:81:9c", # Matt Johnson
]

# -- System Configurations --
app_droplet_image = "centos-7-x64" # Supported system images (centos-8-x64, centos-7-x64)
app_droplet_size = "s-6vcpu-16gb"
# Options for Droplet size:
#   s-2vcpu-4gb ($20/month)
#   s-4vcpu-8gb ($40/month)
#   s-6vcpu-16gb ($80/month)
#   s-8vcpu-32gb ($160/month)
#   s-12vcpu-48gb ($240/month)
#   s-16vcpu-64gb ($320/month)
#   s-20vcpu-96gb ($480/month)
#   s-24vcpu-128gb ($640/month)
#   s-32vcpu-192gb ($960/month)
#   g-2vcpu-8gb ($60/month)
#   g-4vcpu-16gb ($120/month)
#   gd-2vcpu-8gb ($65/month)
#   gd-4vcpu-16gb ($130/month)
#   c-4 ($80/month)
#   c-8 ($160/month)
#   c-16 ($320/month)
#   c-32 ($640/month)

app_data_volume_size = 100
