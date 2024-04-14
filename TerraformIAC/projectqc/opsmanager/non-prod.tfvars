routes = {
  "rt-01" = {
    routename           = "udr-test"
    resource_group_name = "rg-automation-qc-devtest"
    route_table_name    = "rt-automation-test"
    address_prefix      = "0.0.0.0/0"
    next_hop_type       = "Internet"
  }
}