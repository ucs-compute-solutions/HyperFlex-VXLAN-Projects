
resource "dcnm_rest" "HXV-SiteB-vPC-Pairing" {
  path    = "/rest/vpcpair"
  payload = <<EOF
  { 
      "peerOneId": "${var.hxv_vxlan_siteB_vPC_Pair.peerOneId}",
      "peerTwoId": "${var.hxv_vxlan_siteB_vPC_Pair.peerTwoId}",
      "useVirtualPeerlink": true 
  }
 EOF 
}


