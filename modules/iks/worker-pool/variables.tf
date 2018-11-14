// Cluster variables
variable "region" {
  default = "jp-tok"
}

variable "cluster" {}

variable "zone"{
  default = "seo01"
}

variable "private_vlan_id" {}

variable "public_vlan_id" {
  default = ""
}

variable "enable" {
  default = true
}

variable "name" {}
variable "size_per_zone" {}
variable "machine_type_prefix" {}
variable "cpu" {}
variable "memory" {}
variable "hardware" {}
variable "node_role" {}
variable "taint" {}

variable "zones" {
  type = "list"
}