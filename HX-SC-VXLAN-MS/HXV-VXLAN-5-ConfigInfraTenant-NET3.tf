
#-------------------------------------------------------------------------------------------------------
# Create and attach Infrastructure Tenant Networks in Site-A and Site-B for HyperFlex Stretched Cluster
#-------------------------------------------------------------------------------------------------------


# Create HyperFlex Infra Network: vMotion Network 

resource "dcnm_rest" "HXV-vMotion_NET_Create" {
  path    = "/rest/top-down/fabrics/MSD_Fabric_East/networks"
  payload = <<EOF
  { 
      "fabric": "MSD_Fabric_East", 
      "vrf": "NA",
      "networkName": "${var.hxv_vxlan_vMotion_NET.networkName}",
      "displayName": "${var.hxv_vxlan_vMotion_NET.networkName}",
      "networkId": "22003",
      "networkTemplateConfig": "{\"gatewayIpAddress\":\"\",\"gatewayIpV6Address\":\"\",\"vlanName\":\"\",\"intfDescription\":\"\",\"mtu\":\"\",\"secondaryGW1\":\"\",\"secondaryGW2\":\"\",\"secondaryGW3\":\"\",\"secondaryGW4\":\"\",\"suppressArp\":false,\"rtBothAuto\":false,\"tag\":\"12345\",\"vrfName\":\"NA\",\"isLayer2Only\":${var.hxv_vxlan_vMotion_NET.isLayer2Only},\"nveId\":1,\"vlanId\":${var.hxv_vxlan_vMotion_NET.vlanId},\"segmentId\":\"22003\",\"networkName\":\"HXV-vMotion_NET\"}",
      "networkTemplate": "Default_Network_Universal",
      "networkExtensionTemplate": "Default_Network_Extension_Universal",
      "source": null,
      "serviceNetworkTemplate": null
  }
  EOF 
}

# Attach HyperFlex Infra Network: (vMotion Network) to Site-A and Site-B switches
resource "dcnm_rest" "HXV-vMotion_NET_Attach" {
  path    = "/rest/top-down/fabrics/MSD_Fabric_East/networks/attachments"
  payload = <<EOF
  [
    {
      "networkName": "${var.hxv_vxlan_vMotion_NET.networkName}", 
      "lanAttachList": [ 
      {
        "switchPorts": "${var.hxv_vxlan_NET_Attach_SiteA.switchPorts}",
        "detachSwitchPorts": "",
        "dot1QVlan": 0,
        "untagged": false,
        "fabric": "Site-A",
        "networkName": "${var.hxv_vxlan_vMotion_NET.networkName}",
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteA.Leaf_1_SN}",
        "vlan": 0,
        "deployment": true,
        "extensionValues": "",
        "instanceValues": ""
      },
      {
        "switchPorts": "${var.hxv_vxlan_NET_Attach_SiteA.switchPorts}",
        "detachSwitchPorts": "",
        "dot1QVlan": 0,
        "untagged": false,
        "fabric": "Site-A",
        "networkName": "${var.hxv_vxlan_vMotion_NET.networkName}",
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteA.Leaf_2_SN}",
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
        "networkName": "${var.hxv_vxlan_vMotion_NET.networkName}",
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
        "networkName": "${var.hxv_vxlan_vMotion_NET.networkName}",
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteA.BGW_2_SN}", 
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
        "networkName": "${var.hxv_vxlan_vMotion_NET.networkName}",
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
        "networkName": "${var.hxv_vxlan_vMotion_NET.networkName}",
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteA.BorderLeaf_2_SN}", 
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
        "networkName": "${var.hxv_vxlan_vMotion_NET.networkName}",
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
        "networkName": "${var.hxv_vxlan_vMotion_NET.networkName}",
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteB.Leaf_2_SN}", 
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
        "networkName": "${var.hxv_vxlan_vMotion_NET.networkName}",
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
        "networkName": "${var.hxv_vxlan_vMotion_NET.networkName}",
        "serialNumber": "${var.hxv_vxlan_NET_Attach_SiteB.BGW_2_SN}", 
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
        "networkName": "${var.hxv_vxlan_vMotion_NET.networkName}",
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
        "networkName": "${var.hxv_vxlan_vMotion_NET.networkName}",
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
