# IBM Cloud Authentication
ibm_bluemix_api_key = ""
ibm_softlayer_username = ""
ibm_softlayer_api_key = ""

# Cluster variables
resource_group_name = "Default"
region = "jp-tok"
datacenter = "seo01"
private_vlan = {
  id = ""
  name = "zcp_backend_w_vyatta"
  number = 0
  router_hostname = ""
}
public_vlan = {
  id = ""
  name = "zcp_frontend"
  number = 0
  router_hostname = ""
}
cluster_name = "mycluster"
kube_version = "1.10.8"
billing = "hourly"
no_subnet = false
//tag                 = "zcp"

# Worker Pool common variables
zone = ""
zone_private_vlan = {
  id = ""
  name = ""
  number = 0
  router_hostname = ""
}
zone_public_vlan = {
  id = ""
  name = ""
  number = 0
  router_hostname = ""
}

# Worker Pool each variables
edge = {
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

edge_zones = [
  {
    zone = "seo01"

    private_vlan_id = ""
    private_vlan_name = ""
    private_vlan_number = 0
    private_vlan_router_hostname = ""

    public_vlan_id = ""
    public_vlan_name = ""
    public_vlan_number = 0
    public_vlan_router_hostname = ""

    zone_private_vlan_id = ""
    zone_public_vlan_id = ""
  }
]

management = {
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

management_zones = [
  {
    zone = "seo01"

    private_vlan_id = ""
    private_vlan_name = ""
    private_vlan_number = 0
    private_vlan_router_hostname = ""

    public_vlan_id = ""
    public_vlan_name = ""
    public_vlan_number = 0
    public_vlan_router_hostname = ""

    zone_private_vlan_id = ""
    zone_public_vlan_id = ""
  }
]

logging = {
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

logging_zones = [
  {
    zone = "seo01"

    private_vlan_id = ""
    private_vlan_name = ""
    private_vlan_number = 0
    private_vlan_router_hostname = ""

    public_vlan_id = ""
    public_vlan_name = ""
    public_vlan_number = 0
    public_vlan_router_hostname = ""

    zone_private_vlan_id = ""
    zone_public_vlan_id = ""
  }
]

zcp_shared = {
  enable = false
  name = "zcp"
  size_per_zone = 3
  machine_type_prefix = "b2c"
  cpu = 4
  memory = 16
  hardware = "shared"
  node_role = "worker"
  taint = false
}

zcp_shared_zones = [
  {
    zone = "seo01"

    private_vlan_id = ""
    private_vlan_name = ""
    private_vlan_number = 0
    private_vlan_router_hostname = ""

    public_vlan_id = ""
    public_vlan_name = ""
    public_vlan_number = 0
    public_vlan_router_hostname = ""

    zone_private_vlan_id = ""
    zone_public_vlan_id = ""
  }
]

zcp_dedicated = {
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

zcp_dedicated_zones = [
  {
    zone = "seo01"
    zone_private_vlan_id = ""
    zone_public_vlan_id = ""
  }
]

zdb_shared = {
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

zdb_shared_zones = [
  {
    zone = "seo01"

    private_vlan_id = ""
    private_vlan_name = ""
    private_vlan_number = 0
    private_vlan_router_hostname = ""

    public_vlan_id = ""
    public_vlan_name = ""
    public_vlan_number = 0
    public_vlan_router_hostname = ""

    zone_private_vlan_id = ""
    zone_public_vlan_id = ""
  }
]