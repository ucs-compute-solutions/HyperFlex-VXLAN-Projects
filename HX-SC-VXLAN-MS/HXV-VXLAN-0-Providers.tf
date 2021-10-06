
#---------------------------------------------------------------------------------------------------
# Configure Terraform Providers and Access Credentials for the components in the solution 
#---------------------------------------------------------------------------------------------------

terraform {
  required_providers {
    dcnm = {
      source = "CiscoDevNet/dcnm"
      version = "1.0.0"
    }
    # vsphere = {
     # source = "hashicorp/vsphere"
     # version = "2.0.0"
    # }
  }
}

provider "dcnm" {
  username = var.hxv_vxlan_dcnm.usr
  password = var.hxv_vxlan_dcnm.pwd
  url      = var.hxv_vxlan_dcnm.url
  insecure = true
  # proxy_url = "https://proxy_server:proxy_port"
}

provider "time" {
  # Configuration options
}