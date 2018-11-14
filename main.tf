provider "ibm" {
  bluemix_api_key    = "${var.ibm_bluemix_api_key}"
  softlayer_username = "${var.ibm_softlayer_username}"
  softlayer_api_key  = "${var.ibm_softlayer_api_key}"
//  region             = "jp-tok"
}

module "zcp-singlezone-cluster" {
  source = "./modules/iks/singlezone-cluster"

  ibm_bluemix_api_key = "${var.ibm_bluemix_api_key}"

  region = "${var.region}"
  datacenter = "${var.datacenter}"
  resource_group_name = "${var.resource_group_name}"
  private_vlan = "${var.private_vlan}"
  public_vlan = "${var.public_vlan}"
  cluster_name = "${var.cluster_name}"
  billing = "${var.billing}"
  kube_version = "${var.kube_version}"
  no_subnet = "${var.no_subnet}"

  zone = "${var.zone}"
  zone_private_vlan = "${var.zone_private_vlan}"
  zone_public_vlan = "${var.zone_public_vlan}"

  edge = "${var.edge}"
  edge_zones = "${var.edge_zones}"
  management = "${var.management}"
  management_zones = "${var.management_zones}"
  logging = "${var.logging}"
  logging_zones = "${var.logging_zones}"
  zcp_shared = "${var.zcp_shared}"
  zcp_shared_zones = "${var.zcp_shared_zones}"
  zcp_dedicated = "${var.zcp_dedicated}"
  zcp_dedicated_zones = "${var.zcp_dedicated_zones}"
}