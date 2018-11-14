data "template_file" "worker_pool_name" {
  template = "$${name}_$${cpu}_$${memory}_$${hardware}"

  vars {
    name     = "${var.name}"
    cpu      = "${var.cpu}"
    memory   = "${var.memory}"
    hardware = "${var.hardware}"
  }
}

data "template_file" "machine_type" {
  template = "$${machine_type_prefix}.$${cpu}x$${memory}"

  vars {
    machine_type_prefix = "${var.machine_type_prefix}"
    cpu                 = "${var.cpu}"
    memory              = "${var.memory}"
  }
}

resource "ibm_container_worker_pool" "worker_pool" {
  count = "${var.enable ? 1 : 0}"

  worker_pool_name = "${data.template_file.worker_pool_name.rendered}"
  machine_type     = "${data.template_file.machine_type.rendered}"
  cluster          = "${var.cluster}"
  size_per_zone    = "${var.size_per_zone}"
  hardware         = "${var.hardware}"
  disk_encryption  = true
  region           = "${var.region}"

  // FIXME if role label is not used in nodeAffinity, remove "role" = "${var.node_role}"
  labels = "${map("node-role.kubernetes.io/${var.node_role}", "", "role", "${var.node_role}")}"

}

resource "ibm_container_worker_pool_zone_attachment" "zone_attachments" {
  count = "${var.enable ? length(var.zones) : 0}"

  cluster         = "${ibm_container_worker_pool.worker_pool.cluster}"
  worker_pool     = "${ibm_container_worker_pool.worker_pool.worker_pool_name}"
  zone            = "${var.zone == "" ? lookup(var.zones[count.index], "zone") == "" ? var.zone : lookup(var.zones[count.index], "zone") : var.zone}"

  private_vlan_id = "${var.private_vlan_id == "" ? (lookup(var.zones[count.index], "private_vlan_id") == "" ? "" : lookup(var.zones[count.index], "private_vlan_id")) : var.private_vlan_id}"
  public_vlan_id  = "${var.public_vlan_id == "" ? (lookup(var.zones[count.index], "public_vlan_id") == "" ? "" : lookup(var.zones[count.index], "public_vlan_id")) : var.public_vlan_id}"
  region          = "${var.region}"

  //User can increase timeouts
  /*timeouts {
      create = "90m"
      update = "3h"
      delete = "30m"
  }*/

}

resource "null_resource" "taint" {
  count = "${var.enable ? 1 : 0}"

  provisioner "local-exec" {
    command = <<-EOF
      echo "Worker Pool ID : "${element(split("/", ibm_container_worker_pool_zone_attachment.zone_attachments.id), 1)}
      if [ ${var.taint} ]; then
        kubectl taint nodes -l node-role.kubernetes.io/${var.node_role} ${var.node_role}=true:NoSchedule
      fi
    EOF
  }
}