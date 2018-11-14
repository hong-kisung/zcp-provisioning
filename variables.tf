// IBM Cloud Authentication variables
variable "ibm_bluemix_api_key" {}
variable "ibm_softlayer_username" {}
variable "ibm_softlayer_api_key" {}

// Cluster variables
variable "region" {
  default = "jp-tok"
}

variable "datacenter" {
  default = "seo01"
}

variable "resource_group_name" {
  default = "Default"
}

variable "private_vlan" {
  type = "map"

  default = {
    id = ""
    name = ""
    number = 0
    router_hostname = ""
  }
}

variable "public_vlan" {
  type = "map"

  default = {
    id = ""
    name = ""
    number = 0
    router_hostname = ""
  }
}

variable "cluster_name" {}

variable "billing" {
  default = "hourly"
}

variable "kube_version" {}

variable "no_subnet" {
  default = true
}

//variable "tag" {
//  default = "zcp"
//}

variable "zone" {
  default = "seo01"
}

variable "zone_private_vlan" {
  type = "map"

  default = {
    id = ""
    name = ""
    number = 0
    router_hostname = ""
  }
}

variable "zone_public_vlan" {
  type = "map"

  default = {
    id = ""
    name = ""
    number = 0
    router_hostname = ""
  }
}

variable "edge" {
  type = "map"
}
variable "edge_zones" {
  type = "list"
}

variable "management" {
  type = "map"
}
variable "management_zones" {
  type = "list"
}

variable "logging" {
  type = "map"
}
variable "logging_zones" {
  type = "list"
}

variable "zcp_shared" {
  type = "map"
}
variable "zcp_shared_zones" {
  type = "list"
}

variable "zcp_dedicated" {
  type = "map"
}
variable "zcp_dedicated_zones" {
  type = "list"
}

variable "zdb_shared" {
  type = "map"
}
variable "zdb_shared_zones" {
  type = "list"
}