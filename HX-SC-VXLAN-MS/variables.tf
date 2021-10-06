
#-----------------------------------------------------------------------------------
# Access Info for Cisco DCNM 
#-----------------------------------------------------------------------------------

# Cisco DCNM Access Info 

variable "hxv_vxlan_dcnm" {
  description = "Cisco DCNM Access Info"
  type = map
}

#---------------------------------------------------------------------------------------------
# Variables for adding a leaf switch pair in Site-A and Site-B of the VXLAN Multi-Site Fabric
#---------------------------------------------------------------------------------------------

variable "hxv_vxlan_siteA_switch" {
  description = "Switch Access Info for adding to VXLAN fabric"
}

variable "hxv_vxlan_siteA_switch1" {
  description = "First Switch in the pair being added to the VXLAN Fabric"
}

variable "hxv_vxlan_siteA_switch2" {
  description = "Second Switch in the pair being added to the VXLAN Fabric"
}

variable "hxv_vxlan_siteB_switch" {
  description = "Switch Access Info for adding to VXLAN fabric"
}

variable "hxv_vxlan_siteB_switch1" {
  description = "First Switch in the pair being added to the VXLAN Fabric"
}

variable "hxv_vxlan_siteB_switch2" {
  description = "Second Switch in the pair being added to the VXLAN Fabric"
}


#---------------------------------------------------------------------------------------------
# Variables for setting up the leaf switch pair as vPC peers in Site-A and Site-B
#---------------------------------------------------------------------------------------------

variable "hxv_vxlan_siteA_vPC_Pair" {
  description = "Leaf switch pair in the Site-A vPC"
}

variable "hxv_vxlan_siteB_vPC_Pair" {
  description = "Leaf switch pair in the Site-B vPC"
}

#------------------------------------------------------------------------------------------------
# Variables for setting up access layer (vPC) connectivity to UCS Fabric Interconnects in Site-A 
#------------------------------------------------------------------------------------------------

variable "hxv_vxlan_siteA_Switch1_Access" {
  description = "Access Layer (vPC) Configuration for the 1st Leaf switch in Site-A vPC pair"
}

variable "hxv_vxlan_siteA_Switch2_Access" {
  description = "Access Layer (vPC) Configuration for the 2nd Leaf switch in Site-A vPC pair"
}

#------------------------------------------------------------------------------------------------
# Variables for setting up access layer (vPC) connectivity to UCS Fabric Interconnects in Site-B 
#------------------------------------------------------------------------------------------------

variable "hxv_vxlan_siteB_Switch1_Access" {
  description = "Access Layer (vPC) Configuration for the 1st Leaf switch in Site-B vPC pair"
}

variable "hxv_vxlan_siteB_Switch2_Access" {
  description = "Access Layer (vPC) Configuration for the 2nd Leaf switch in Site-B vPC pair"
}

#------------------------------------------------------------
# Variables for creating and deploying Infrastructure Tenant 
#------------------------------------------------------------

variable "hxv_vxlan_Infra_Tenant" {
  description = "Tenant for HyperFlex Stretched Cluster Infrastructure Connectivity"
}

variable "hxv_vxlan_VRF_Attach_SiteA" {
  description = "Deploy Tenant in Site-A for HyperFlex Stretched Cluster Infrastructure Connectivity"
}

variable "hxv_vxlan_VRF_Attach_SiteB" {
  description = "Deploy Tenant in Site-B for HyperFlex Stretched Cluster Infrastructure Connectivity"
}

#---------------------------------------------------------------------
# Variables for creating and deploying Infrastructure Tenant Networks 
#---------------------------------------------------------------------

variable "hxv_vxlan_IBMGMT_NET" {
  description = "HyperFlex and ESXI In-Band Management Network"
}

variable "hxv_vxlan_StorageData_NET" {
  description = "HyperFlex and ESXI Storage Data Network"
}

variable "hxv_vxlan_vMotion_NET" {
  description = "HyperFlex and ESXI vMotion Network"
}

variable "hxv_vxlan_NET_Attach_SiteA" {
  description = "Deploy Infrastructure Networks in Site-A for HyperFlex Stretched Cluster Connectivity"
}

variable "hxv_vxlan_NET_Attach_SiteB" {
  description = "Deploy Infrastructure Networks in Site-B for HyperFlex Stretched Cluster Connectivity"
}