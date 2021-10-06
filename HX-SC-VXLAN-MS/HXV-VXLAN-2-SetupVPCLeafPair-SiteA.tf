
# resource "dcnm_inventory" "HXV_Leafs_SiteA"
# switch_config.serial_number 
resource "dcnm_rest" "HXV-SiteA-vPC-Pairing" {
  path    = "/rest/vpcpair"
  payload = <<EOF
  { 
       "peerOneId": "${var.hxv_vxlan_siteA_vPC_Pair.peerOneId}", 
       "peerTwoId": "${var.hxv_vxlan_siteA_vPC_Pair.peerTwoId}",
       "useVirtualPeerlink": true 
  }
 EOF 
}




