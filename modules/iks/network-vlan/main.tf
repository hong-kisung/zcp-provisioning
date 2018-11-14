data "ibm_network_vlan" "network_vlan" {
  count = "${var.name == "" && (var.number == 0 || var.router_hostname == "") ? 0 : 1}"

  name = "${var.name}"
  number = "${var.number}"
  router_hostname = "${var.router_hostname}"
}