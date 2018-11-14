variable "ibm_bluemix_api_key" {}

// Cluster variables
variable "region" {}

variable "datacenter" {}

variable "resource_group_name" {}

variable "private_vlan" {
  type = "map"
}

variable "public_vlan" {
  type = "map"
}

variable "cluster_name" {}

variable "billing" {}

variable "kube_version" {}

variable "no_subnet" {}


// Worker Pool Variables
variable "zone" {}

variable "zone_private_vlan" {
  type = "map"
}

variable "zone_public_vlan" {
  type = "map"
}

variable "edge" {
  type = "map"
  default = {
    enable = true
    name = "edge"
    size_per_zone = 2
    machine_type_prefix = "u2c"
    cpu = 2
    memory = 4
    hardware = "shared"
    node_role = "edge"
    taint = true
  }
}

variable "edge_zones" {
  type = "list"
  default = [
    {
      zone = "seo01"
      private_vlan_id = ""
      public_vlan_id = ""
    }
  ]
}

variable "management" {
  type = "map"
  default = {
    enable = true
    name = "mngt"
    size_per_zone = 2
    machine_type_prefix = "b2c"
    cpu = 8
    memory = 32
    hardware = "shared"
    node_role = "management"
    taint = true
  }
}

variable "management_zones" {
  type = "list"
  default = [
    {
      zone = "seo01"
      private_vlan_id = ""
      public_vlan_id = ""
    }
  ]
}

variable "logging" {
  type = "map"
  default = {
    enable = false
    name = "logging"
    size_per_zone = 3
    machine_type_prefix = "b2c"
    cpu = 4
    memory = 16
    hardware = "shared"
    node_role = "logging"
    taint = true
  }
}

variable "logging_zones" {
  type = "list"
  default = [
    {
      zone = "seo01"
      private_vlan_id = ""
      public_vlan_id = ""
    }
  ]
}

variable "zcp_shared" {
  type = "map"
  default = {
    enable = true
    name = "zcp"
    size_per_zone = 3
    machine_type_prefix = "b2c"
    cpu = 4
    memory = 16
    hardware = "shared"
    node_role = "worker"
    taint = false
  }
}

variable "zcp_shared_zones" {
  type = "list"
  default = [
    {
      zone = "seo01"
      private_vlan_id = ""
      public_vlan_id = ""
    }
  ]
}

variable "zcp_dedicated" {
  type = "map"
  default = {
    enable = false
    name = "zcp"
    size_per_zone = 1
    machine_type_prefix = "b2c"
    cpu = 4
    memory = 16
    hardware = "dedicated"
    node_role = "worker"
    taint = false
  }
}

variable "zcp_dedicated_zones" {
  type = "list"
  default = [
    {
      zone = "seo01"
      private_vlan_id = ""
      public_vlan_id = ""
    }
  ]
}

variable "zdb_shared" {
  type = "map"
  default = {
    enable = false
    name = "zdb"
    size_per_zone = 3
    machine_type_prefix = "b2c"
    cpu = 4
    memory = 16
    hardware = "shared"
    node_role = "zdb"
    taint = false
  }
}

variable "zdb_shared_zones" {
  type = "list"
  default = [
    {
      zone = "seo01"
      private_vlan_id = ""
      public_vlan_id = ""
    }
  ]
}