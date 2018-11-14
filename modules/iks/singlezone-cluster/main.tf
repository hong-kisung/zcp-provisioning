data "ibm_resource_group" "zcp_group" {
  name = "${var.resource_group_name}"
}

module "private-vlan" {
  source = "../network-vlan"

  id = "${var.private_vlan["id"]}"
  name = "${var.private_vlan["name"]}"
  number = "${var.private_vlan["number"]}"
  router_hostname = "${var.private_vlan["router_hostname"]}"
}

module "public-vlan" {
  source = "../network-vlan"

  id = "${var.public_vlan["id"]}"
  name = "${var.public_vlan["name"]}"
  number = "${var.public_vlan["number"]}"
  router_hostname = "${var.public_vlan["router_hostname"]}"
}

module "zone-private-vlan" {
  source = "../network-vlan"

  id = "${var.zone_private_vlan["id"]}"
  name = "${var.zone_private_vlan["name"]}"
  number = "${var.zone_private_vlan["number"]}"
  router_hostname = "${var.zone_private_vlan["router_hostname"]}"
}

module "zone-public-vlan" {
  source = "../network-vlan"

  id = "${var.zone_public_vlan["id"]}"
  name = "${var.zone_public_vlan["name"]}"
  number = "${var.zone_public_vlan["number"]}"
  router_hostname = "${var.zone_public_vlan["router_hostname"]}"
}

locals {
  private_vlan_id = "${module.private-vlan.id}"
  public_vlan_id = "${module.public-vlan.id}"
  zone_private_vlan_id = "${module.zone-private-vlan.id == "" ? local.private_vlan_id : module.zone-private-vlan.id}"
  zone_public_vlan_id  = "${module.zone-public-vlan.id == "" ? local.public_vlan_id : module.zone-public-vlan.id}"

  zone = "${var.zone == "" ? var.datacenter : var.zone}"
}

resource "ibm_container_cluster" "zcp-cluster" {
  name              = "${var.cluster_name}"
  datacenter        = "${var.datacenter}"
  machine_type      = "u2c.2x4"
  billing           = "${var.billing}"
  hardware          = "shared"
  private_vlan_id   = "${local.private_vlan_id}"
  public_vlan_id    = "${local.public_vlan_id}"
  region            = "${var.region}"
  resource_group_id = "${data.ibm_resource_group.zcp_group.id}"
  kube_version      = "${var.kube_version}"

//  default_pool_size = 1
  no_subnet         = "${var.no_subnet}"

}

resource "null_resource" "ibmcloud_access" {
  provisioner "local-exec" {
    command = <<-EOF
      ibmcloud login --apikey ${var.ibm_bluemix_api_key} -g ${var.resource_group_name}
      ibmcloud cs region-set ${ibm_container_cluster.zcp-cluster.region}
      ibmcloud cs cluster-config ${ibm_container_cluster.zcp-cluster.name}
      export KUBECONFIG=/Users/$USER/.bluemix/plugins/container-service/clusters/${ibm_container_cluster.zcp-cluster.name}/kube-config-${ibm_container_cluster.zcp-cluster.datacenter}-${ibm_container_cluster.zcp-cluster.name}.yml
    EOF
  }
}

module "edge-worker-pool" {
  source = "../worker-pool"

  enable = "${var.edge["enable"]}"
  name = "${var.edge["name"]}"
  machine_type_prefix = "${var.edge["machine_type_prefix"]}"
  cluster = "${ibm_container_cluster.zcp-cluster.name}"
  size_per_zone = "${var.edge["size_per_zone"]}"
  cpu = "${var.edge["cpu"]}"
  memory = "${var.edge["memory"]}"
  hardware = "${var.edge["hardware"]}"
  node_role = "${var.edge["node_role"]}"
  taint = "${var.edge["taint"]}"
  region = "${ibm_container_cluster.zcp-cluster.region}"

  zone = "${local.zone}"
  private_vlan_id = "${local.zone_private_vlan_id}"
  public_vlan_id = "${local.zone_public_vlan_id}"
  zones = "${var.edge_zones}"
}

module "management-worker-pool" {
  source = "../worker-pool"

  enable = "${var.management["enable"]}"
  name = "${var.management["name"]}"
  machine_type_prefix = "${var.management["machine_type_prefix"]}"
  cluster = "${ibm_container_cluster.zcp-cluster.name}"
  size_per_zone = "${var.management["size_per_zone"]}"
  cpu = "${var.management["cpu"]}"
  memory = "${var.management["memory"]}"
  hardware = "${var.management["hardware"]}"
  node_role = "${var.management["node_role"]}"
  taint = "${var.management["taint"]}"
  region = "${ibm_container_cluster.zcp-cluster.region}"

  zone = "${local.zone}"
  private_vlan_id = "${local.zone_private_vlan_id}"
  public_vlan_id = "${local.zone_public_vlan_id}"
  zones = "${var.management_zones}"
}

module "logging-worker-pool" {
  source = "../worker-pool"

  enable = "${var.logging["enable"]}"
  name = "${var.logging["name"]}"
  machine_type_prefix = "${var.logging["machine_type_prefix"]}"
  cluster = "${ibm_container_cluster.zcp-cluster.name}"
  size_per_zone = "${var.logging["size_per_zone"]}"
  cpu = "${var.logging["cpu"]}"
  memory = "${var.logging["memory"]}"
  hardware = "${var.logging["hardware"]}"
  node_role = "${var.logging["node_role"]}"
  taint = "${var.logging["taint"]}"
  region = "${ibm_container_cluster.zcp-cluster.region}"

  zone = "${local.zone}"
  private_vlan_id = "${local.zone_private_vlan_id}"
  public_vlan_id = "${local.zone_public_vlan_id}"
  zones = "${var.logging_zones}"
}

module "zcp-shared-worker-pool" {
  source = "../worker-pool"

  enable = "${var.zcp_shared["enable"]}"
  name = "${var.zcp_shared["name"]}"
  machine_type_prefix = "${var.zcp_shared["machine_type_prefix"]}"
  cluster = "${ibm_container_cluster.zcp-cluster.name}"
  size_per_zone = "${var.zcp_shared["size_per_zone"]}"
  cpu = "${var.zcp_shared["cpu"]}"
  memory = "${var.zcp_shared["memory"]}"
  hardware = "${var.zcp_shared["hardware"]}"
  node_role = "${var.zcp_shared["node_role"]}"
  taint = "${var.zcp_shared["taint"]}"
  region = "${ibm_container_cluster.zcp-cluster.region}"

  zone = "${local.zone}"
  private_vlan_id = "${local.zone_private_vlan_id}"
  public_vlan_id = "${local.zone_public_vlan_id}"
  zones = "${var.zcp_shared_zones}"
}

module "zcp-dedicated-worker-pool" {
  source = "../worker-pool"

  enable = "${var.zcp_dedicated["enable"]}"
  name = "${var.zcp_dedicated["name"]}"
  machine_type_prefix = "${var.zcp_dedicated["machine_type_prefix"]}"
  cluster = "${ibm_container_cluster.zcp-cluster.name}"
  size_per_zone = "${var.zcp_dedicated["size_per_zone"]}"
  cpu = "${var.zcp_dedicated["cpu"]}"
  memory = "${var.zcp_dedicated["memory"]}"
  hardware = "${var.zcp_dedicated["hardware"]}"
  node_role = "${var.zcp_dedicated["node_role"]}"
  taint = "${var.zcp_dedicated["taint"]}"
  region = "${ibm_container_cluster.zcp-cluster.region}"

  zone = "${local.zone}"
  private_vlan_id = "${local.zone_private_vlan_id}"
  public_vlan_id = "${local.zone_public_vlan_id}"
  zones = "${var.zcp_dedicated_zones}"
}

module "zdb-shared-worker-pool" {
  source = "../worker-pool"

  enable = "${var.zdb_shared["enable"]}"
  name = "${var.zdb_shared["name"]}"
  machine_type_prefix = "${var.zdb_shared["machine_type_prefix"]}"
  cluster = "${ibm_container_cluster.zcp-cluster.name}"
  size_per_zone = "${var.zdb_shared["size_per_zone"]}"
  cpu = "${var.zdb_shared["cpu"]}"
  memory = "${var.zdb_shared["memory"]}"
  hardware = "${var.zdb_shared["hardware"]}"
  node_role = "${var.zdb_shared["node_role"]}"
  taint = "${var.zdb_shared["taint"]}"
  region = "${ibm_container_cluster.zcp-cluster.region}"

  zone = "${local.zone}"
  private_vlan_id = "${local.zone_private_vlan_id}"
  public_vlan_id = "${local.zone_public_vlan_id}"
  zones = "${var.zdb_shared_zones}"
}

resource "null_resource" "albs" {
  count = "${var.no_subnet ? 0 : 1}"
  depends_on = ["null_resource.ibmcloud_access"]

  provisioner "local-exec" {
    command = <<-EOF
      ibmcloud cs alb-configure --albID ${ibm_container_cluster.zcp-cluster.albs.0.id} --enable
    EOF
  }

  provisioner "local-exec" {
    when = "destroy"
    command = <<-EOF
      ibmcloud cs alb-configure --albID ${ibm_container_cluster.zcp-cluster.albs.0.id} --disable
    EOF
  }
}

resource "null_resource" "subnet" {
  depends_on = ["null_resource.ibmcloud_access"]

  provisioner "local-exec" {
    command = <<-EOF
      ibmcloud cs cluster-subnet-create --cluster ${ibm_container_cluster.zcp-cluster.id} --size 64 --vlan ${local.private_vlan_id}
      ibmcloud cs cluster-subnet-create --cluster ${ibm_container_cluster.zcp-cluster.id} --size 64 --vlan ${local.public_vlan_id}
    EOF
  }
}

resource "null_resource" "default_worker_pool" {
  provisioner "local-exec" {
    command = "ibmcloud cs worker-pool-rm --worker-pool ${ibm_container_cluster.zcp-cluster.worker_pools.0.id} --cluster ${var.cluster_name}"
  }
}