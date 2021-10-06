
#-------------------------------------------------------------------------------------------------------
# Create and attach Infrastructure Tenant Networks in Site-A and Site-B for HyperFlex Stretched Cluster
#-------------------------------------------------------------------------------------------------------

# Create HyperFlex Infra Network: In-Band Management (VLAN ID Specified in the TemplateConfig)

resource "dcnm_rest" "HXV-IB-MGMT_NET_Create" {
  path    = "/rest/top-down/fabrics/MSD_Fabric_East/networks"
  payload = <<EOF
  { 
      "fabric": "MSD_Fabric_East", 
      "vrf": "${var.hxv_vxlan_Infra_Tenant.vrfName}",
      "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}",
      "displayName": "${var.hxv_vxlan_IBMGMT_NET.networkName}",
      "networkId": "22001",
      "networkTemplateConfig": "{\"gatewayIpAddress\":\"${var.hxv_vxlan_IBMGMT_NET.gatewayIpAddress}\",\"gatewayIpV6Address\":\"\",\"vlanName\":\"\",\"intfDescription\":\"\",\"mtu\":\"\",\"secondaryGW1\":\"\",\"secondaryGW2\":\"\",\"secondaryGW3\":\"\",\"secondaryGW4\":\"\",\"suppressArp\":${var.hxv_vxlan_IBMGMT_NET.suppressArp},\"rtBothAuto\":false,\"tag\":\"12345\",\"vrfName\":\"HXV-Foundation_VRF\",\"isLayer2Only\":false,\"nveId\":1,\"vlanId\":\"${var.hxv_vxlan_IBMGMT_NET.vlanId}\",\"segmentId\":\"22001\",\"networkName\":\"HXV-IB-MGMT_NET\"}",
      "networkTemplate": "Default_Network_Universal",
      "networkExtensionTemplate": "Default_Network_Extension_Universal",
      "source": null,
      "serviceNetworkTemplate": null
  }
  EOF 
}

# Attach HyperFlex Infra Network: (InBand Management) to Site-A and Site-B switches

resource "dcnm_rest" "HXV-IB-MGMT_NET_Attach_SiteA" {
  path    = "/rest/top-down/fabrics/MSD_Fabric_East/networks/attachments"
  payload = <<EOF
  [
    {
      "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}", 
      "lanAttachList": [ 
      {
        "switchPorts": "${var.hxv_vxlan_NET_Attach_SiteA.switchPorts}",
        "detachSwitchPorts": "",
        "dot1QVlan": 0,
        "untagged": false,
        "fabric": "Site-A",
        "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}",
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteA.Leaf_1_SN}",
        "vlan": 0,
        "deployment": false,
        "extensionValues": "",
        "instanceValues": ""
      },
      {
        "switchPorts": "${var.hxv_vxlan_NET_Attach_SiteA.switchPorts}",
        "detachSwitchPorts": "",
        "dot1QVlan": 0,
        "untagged": false,
        "fabric": "Site-A",
        "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}",
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteA.Leaf_2_SN}",
        "vlan": 0,
        "deployment": false,
        "extensionValues": "",
        "instanceValues": ""
      }
     ] 
   } 
  ]
 EOF 
}

resource "dcnm_rest" "HXV-IB-MGMT_NET_Attach_SiteB" {
  path    = "/rest/top-down/fabrics/MSD_Fabric_East/networks/attachments"
  payload = <<EOF
  [
    {
      "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}", 
      "lanAttachList": [ 
      {
        "switchPorts": "${var.hxv_vxlan_NET_Attach_SiteB.switchPorts}",
        "detachSwitchPorts": "",
        "dot1QVlan": 0,
        "untagged": false,
        "fabric": "Site-B",
        "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}",
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteB.Leaf_1_SN}",
        "vlan": 0,
        "deployment": true,
        "extensionValues": "",
        "instanceValues": ""
      },
      {
        "switchPorts": "${var.hxv_vxlan_NET_Attach_SiteB.switchPorts}",
        "detachSwitchPorts": "",
        "dot1QVlan": 0,
        "untagged": false,
        "fabric": "Site-B",
        "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}",
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteB.Leaf_2_SN}",
        "vlan": 0,
        "deployment": true,
        "extensionValues": "",
        "instanceValues": ""
      }
     ] 
   } 
  ]
 EOF 
}

resource "dcnm_rest" "HXV-IB-MGMT_NET_BGW_Attach" {
  path    = "/rest/top-down/fabrics/MSD_Fabric_East/networks/attachments"
  payload = <<EOF
  [
    {
      "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}", 
      "lanAttachList": [ 
      { 
        "switchPorts": "", 
        "detachSwitchPorts": "", 
        "dot1QVlan": 0, "untagged": false, 
        "fabric": "Site-A", 
        "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}", 
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteA.BGW_1_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      }, 
      { 
        "switchPorts": "", 
        "detachSwitchPorts": "",
        "dot1QVlan": 0, 
        "untagged": false, 
        "fabric": "Site-A", 
        "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}", 
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteA.BGW_2_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      },
      { 
        "switchPorts": "", 
        "detachSwitchPorts": "", 
        "dot1QVlan": 0, "untagged": false, 
        "fabric": "Site-B", 
        "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}", 
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteB.BGW_1_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      }, 
      { 
        "switchPorts": "", 
        "detachSwitchPorts": "",
        "dot1QVlan": 0, 
        "untagged": false, 
        "fabric": "Site-B", 
        "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}", 
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteB.BGW_2_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      }
     ] 
   } 
  ]
EOF
}

resource "dcnm_rest" "HXV-IB-MGMT_NET_BL_Attach" {
  path    = "/rest/top-down/fabrics/MSD_Fabric_East/networks/attachments"
  payload = <<EOF
  [
    {
      "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}", 
      "lanAttachList": [ 
      { 
        "switchPorts": "", 
        "detachSwitchPorts": "", 
        "dot1QVlan": 0, "untagged": false, 
        "fabric": "Site-A", 
        "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}", 
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteA.BorderLeaf_1_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      }, 
      { 
        "switchPorts": "", 
        "detachSwitchPorts": "",
        "dot1QVlan": 0, 
        "untagged": false, 
        "fabric": "Site-A", 
        "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}", 
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteA.BorderLeaf_2_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      },
      { 
        "switchPorts": "", 
        "detachSwitchPorts": "", 
        "dot1QVlan": 0, "untagged": false, 
        "fabric": "Site-B", 
        "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}", 
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteB.BorderLeaf_1_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      }, 
      { 
        "switchPorts": "", 
        "detachSwitchPorts": "",
        "dot1QVlan": 0, 
        "untagged": false, 
        "fabric": "Site-B", 
        "networkName": "${var.hxv_vxlan_IBMGMT_NET.networkName}", 
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteB.BorderLeaf_2_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      }
     ] 
   } 
  ]
EOF
}
