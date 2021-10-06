
#----------------------------------------------------------------------------------------------
# Create and deploy Infrastructure Tenant in Site-A and Site-B for HyperFlex Stretched Cluster
#----------------------------------------------------------------------------------------------

resource "dcnm_rest" "HXV-Foundation_VRF_Create" {
  path    = "/rest/top-down/fabrics/MSD_Fabric_East/vrfs"
  payload = <<EOF
   { 
      "fabric": "${var.hxv_vxlan_Infra_Tenant.fabric}", 
      "vrfName": "${var.hxv_vxlan_Infra_Tenant.vrfName}", 
      "vrfId": "30010", 
      "vrfTemplate": "Default_VRF_Universal",
      "vrfTemplateConfig": "{\"vrfVlanName\":\"HXV-Foundation_VRF_VLAN\",\"vrfIntfDescription\":\"HXV-Foundation_VRF_INTF\",\"vrfDescription\":\"HXV-Foundation_VRF\",\"ipv6LinkLocalFlag\":true,\"mtu\":\"9216\",\"tag\":\"12345\",\"vrfRouteMap\":\"FABRIC-RMAP-REDIST-SUBNET\",\"maxBgpPaths\":\"1\",\"maxIbgpPaths\":\"2\",\"vrfSegmentId\":\"30010\",\"vrfName\":\"HXV-Foundation_VRF\",\"vrfVlanId\":\"3510\",\"nveId\":1,\"asn\":\"null\"}",
      "vrfExtensionTemplate": "Default_VRF_Extension_Universal", 
      "source": null, 
      "serviceVrfTemplate": null 
  }
  EOF 
}

# Attach and deploy Infrastructure Tenant VRF to Site-A and Site-B switches

resource "dcnm_rest" "HXV-Foundation_VRF_Attach" {
  path    = "/rest/top-down/fabrics/MSD_Fabric_East/vrfs/attachments"
  payload = <<EOF
  [
    {
    "lanAttachList": [ 
      { 
        "fabric": "Site-A", 
        "vrfName": "HXV-Foundation_VRF", 
        "serialNumber": "${var.hxv_vxlan_VRF_Attach_SiteA.Leaf_1_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      },
      { 
        "fabric": "Site-A", 
        "vrfName": "HXV-Foundation_VRF", 
        "serialNumber": "${var.hxv_vxlan_VRF_Attach_SiteA.Leaf_2_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      },
      { 
        "fabric": "Site-A", 
        "vrfName": "HXV-Foundation_VRF", 
        "serialNumber": "${var.hxv_vxlan_VRF_Attach_SiteA.BGW_1_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      },
      { 
        "fabric": "Site-A", 
        "vrfName": "HXV-Foundation_VRF", 
        "serialNumber": "${var.hxv_vxlan_VRF_Attach_SiteA.BGW_2_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      }, 
      { 
        "fabric": "Site-A", 
        "vrfName": "HXV-Foundation_VRF", 
        "serialNumber": "${var.hxv_vxlan_VRF_Attach_SiteA.BorderLeaf_1_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      },
      { 
        "fabric": "Site-A", 
        "vrfName": "HXV-Foundation_VRF", 
        "serialNumber": "${var.hxv_vxlan_VRF_Attach_SiteA.BorderLeaf_2_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      },
      { 
        "fabric": "Site-B", 
        "vrfName": "HXV-Foundation_VRF", 
        "serialNumber": "${var.hxv_vxlan_VRF_Attach_SiteB.Leaf_1_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      },
      { 
        "fabric": "Site-B", 
        "vrfName": "HXV-Foundation_VRF", 
        "serialNumber": "${var.hxv_vxlan_VRF_Attach_SiteB.Leaf_2_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      },
      { 
        "fabric": "Site-B", 
        "vrfName": "HXV-Foundation_VRF", 
        "serialNumber": "${var.hxv_vxlan_VRF_Attach_SiteB.BGW_1_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      },
      { 
        "fabric": "Site-B", 
        "vrfName": "HXV-Foundation_VRF", 
        "serialNumber": "${var.hxv_vxlan_VRF_Attach_SiteB.BGW_2_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      },
      { 
        "fabric": "Site-B", 
        "vrfName": "HXV-Foundation_VRF", 
        "serialNumber": "${var.hxv_vxlan_VRF_Attach_SiteB.BorderLeaf_1_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      },
      { 
        "fabric": "Site-B", 
        "vrfName": "HXV-Foundation_VRF", 
        "serialNumber": "${var.hxv_vxlan_VRF_Attach_SiteB.BorderLeaf_2_SN}", 
        "vlan": 0, 
        "deployment": true, 
        "extensionValues": "", 
        "instanceValues": "" 
      }    
    ], 
    "vrfName": "HXV-Foundation_VRF" 
   } 
 ]
 EOF
}


# deploy
resource "dcnm_rest" "HXV-Foundation_VRF_Deploy" {
  path    = "/rest/top-down/fabrics/MSD_Fabric_East/vrfs/deployments"
  payload = <<EOF
  { 
      "vrfNames":"${var.hxv_vxlan_Infra_Tenant.vrfName}"
  }
  EOF
}



