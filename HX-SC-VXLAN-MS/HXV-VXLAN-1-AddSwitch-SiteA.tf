#-----------------------------------------------------------------------------------------------------------
# Variables for adding a Leaf switch pair in Site-A to the VXLAN Multi-Site fabric. The Leaf switches serve 
# as ToR/access switches for connecting to Cisco UCS Domain with HyperFlex Stretch Cluster nodes in Site-A. 
#-----------------------------------------------------------------------------------------------------------

resource "dcnm_inventory" "HXV_Leafs_SiteA" {
  fabric_name     = var.hxv_vxlan_siteA_switch.fabric_name
  username        = var.hxv_vxlan_siteA_switch.username
  password        = var.hxv_vxlan_siteA_switch.password
  max_hops        = var.hxv_vxlan_siteA_switch.max_hops
  preserve_config = var.hxv_vxlan_siteA_switch.preserve_config
  auth_protocol   = var.hxv_vxlan_siteA_switch.auth_protocol
  config_timeout  = var.hxv_vxlan_siteA_switch.config_timeout
  
  switch_config {
    ip   = var.hxv_vxlan_siteA_switch1.ip
    role = var.hxv_vxlan_siteA_switch1.role
  }
  switch_config {
    ip   = var.hxv_vxlan_siteA_switch2.ip
    role = var.hxv_vxlan_siteA_switch2.role
  }
}
