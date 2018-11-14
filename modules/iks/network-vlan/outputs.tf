output "id" {
  // This is trick for avoiding "not found for variable 'data.ibm_network_vlan.network_vlan.id'"
  value = "${var.id == "" ? (var.name == "" && (var.number == 0 || var.router_hostname == "") ? "" : element(concat(data.ibm_network_vlan.network_vlan.*.id, list("")), 0)) : var.id}"
}