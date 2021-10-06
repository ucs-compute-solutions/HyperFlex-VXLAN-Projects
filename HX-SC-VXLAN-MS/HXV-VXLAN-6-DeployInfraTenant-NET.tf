
#-------------------------------------------------------------------------------------------------------
# Deploy Infrastructure Tenant Networks in Site-A and Site-B for HyperFlex Stretched Cluster
#-------------------------------------------------------------------------------------------------------

# HyperFlex Infra Networks (In-Band Mgmt,StorageData,vMotion) 

resource "time_sleep" "wait_30_seconds" {
  depends_on = [dcnm_rest.HXV-IB-MGMT_NET_Attach_SiteA, dcnm_rest.HXV-IB-MGMT_NET_Attach_SiteB, dcnm_rest.HXV-IB-MGMT_NET_BGW_Attach, dcnm_rest.HXV-IB-MGMT_NET_BL_Attach]
  create_duration = "30s"
}

resource "dcnm_rest" "HXV-IB-MGMT_NET_Deploy" {
  #depends_on = [dcnm_rest.HXV-IB-MGMT_NET_Attach, dcnm_rest.HXV-IB-MGMT_NET_BGW_Attach, dcnm_rest.HXV-IB-MGMT_NET_BL_Attach]
  depends_on = [time_sleep.wait_30_seconds]
  path    = "/rest/top-down/fabrics/MSD_Fabric_East/networks/deployments"
  payload = <<EOF
  {
   "networkNames": "${var.hxv_vxlan_IBMGMT_NET.networkName}"
  }
  EOF
}

resource "dcnm_rest" "HXV-CL1-StorageData_NET_Deploy" {
  #depends_on = [dcnm_rest.HXV-CL1-StorageData_NET_Attach]
  depends_on = [time_sleep.wait_30_seconds]
  path    = "/rest/top-down/fabrics/MSD_Fabric_East/networks/deployments"
  payload = <<EOF
  {
   "networkNames": "${var.hxv_vxlan_StorageData_NET.networkName}"
  }
  EOF
}

resource "dcnm_rest" "HXV-vMotion_NET_Deploy" {
  #depends_on = [dcnm_rest.HXV-vMotion_NET_Attach]
  depends_on = [time_sleep.wait_30_seconds]
  path    = "/rest/top-down/fabrics/MSD_Fabric_East/networks/deployments"
  payload = <<EOF
  {
   "networkNames": "${var.hxv_vxlan_vMotion_NET.networkName}"
  }
  EOF
}

