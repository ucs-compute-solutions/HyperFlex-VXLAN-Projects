#--------------------------------------------------------------------------------------------------
# Enable Access Layer Connectivity to HyperFlex Nodes in Site-A. 
# No VLANs are specified here. VLANs used by edge networks will be added to the vPC trunk when the 
# networks are created.  
#--------------------------------------------------------------------------------------------------

resource "dcnm_interface" "HXV-SiteB-Switch1-Access" {
  policy                    = "int_vpc_trunk_host_11_1"
  type                      = var.hxv_vxlan_siteB_Switch1_Access.type 
  name                      = var.hxv_vxlan_siteB_Switch1_Access.name   
  fabric_name               = "Site-B"
  switch_name_1             = "BB10-93180YC-EX-EAST-1"
  switch_name_2             = "BB10-93180YC-EX-EAST-2"
  vpc_peer1_id              = var.hxv_vxlan_siteB_Switch1_Access.vpc_peer1_id  
  vpc_peer2_id              = var.hxv_vxlan_siteB_Switch1_Access.vpc_peer2_id
  vpc_peer1_interface       = var.hxv_vxlan_siteB_Switch1_Access.vpc_peer1_interface  
  vpc_peer2_interface       = var.hxv_vxlan_siteB_Switch1_Access.vpc_peer2_interface
  mode                      = "active"
  bpdu_gaurd_flag           = "true"
  port_fast_flag            = "true"
  mtu                       = "jumbo"
  vpc_peer1_allowed_vlans   = "none"
  vpc_peer2_allowed_vlans   = "none"
  #vpc_peer1_access_vlans   = ""
  #vpc_peer2_access_vlans   = ""
  vpc_peer1_desc            = var.hxv_vxlan_siteB_Switch1_Access.vpc_peer1_desc
  vpc_peer2_desc            = var.hxv_vxlan_siteB_Switch1_Access.vpc_peer2_desc  
  #vpc_peer1_conf           = ""
  #vpc_peer2_conf           = ""

  deploy                    = true

}                           

resource "dcnm_interface" "HXV-SiteB-Switch2-Access" {
  policy                    = "int_vpc_trunk_host_11_1"
  type                      = var.hxv_vxlan_siteB_Switch2_Access.type 
  name                      = var.hxv_vxlan_siteB_Switch2_Access.name   
  fabric_name               = "Site-B"
  switch_name_1             = "BB10-93180YC-EX-EAST-1"
  switch_name_2             = "BB10-93180YC-EX-EAST-2"
  vpc_peer1_id              = var.hxv_vxlan_siteB_Switch2_Access.vpc_peer1_id  
  vpc_peer2_id              = var.hxv_vxlan_siteB_Switch2_Access.vpc_peer2_id
  vpc_peer1_interface       = var.hxv_vxlan_siteB_Switch2_Access.vpc_peer1_interface  
  vpc_peer2_interface       = var.hxv_vxlan_siteB_Switch2_Access.vpc_peer2_interface
  mode                      = "active"
  bpdu_gaurd_flag           = "true"
  port_fast_flag            = "true"
  mtu                       = "jumbo"
  vpc_peer1_allowed_vlans   = "none"
  vpc_peer2_allowed_vlans   = "none"
  #vpc_peer1_access_vlans   = ""
  #vpc_peer2_access_vlans   = ""
  vpc_peer1_desc            = var.hxv_vxlan_siteB_Switch2_Access.vpc_peer1_desc
  vpc_peer2_desc            = var.hxv_vxlan_siteB_Switch2_Access.vpc_peer2_desc  
  #vpc_peer1_conf           = ""
  #vpc_peer2_conf           = ""

  deploy                    = true

}

          
