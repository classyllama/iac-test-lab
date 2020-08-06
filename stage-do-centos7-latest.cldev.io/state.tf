# Declare required terraform version to avoid mistakes on new machine setups

# Store Terraform state file in persistent directory
terraform {
  backend "local" {
    path = "../persistent/terraform.tfstate"
  }
}
