vnets = {
  "vnet-01" = {
    vnet_name                       = "vnet-avd-prod-qc-01"
    location                        = "Qatar Central"
    resource_group_name             = "rg-avd-prod-qc-01"
    address_space                   = ["172.26.121.0/24"]
  }
}

subnets = {
  "snet-01" = {
    sn_name                         = "snet-avd-prod-qc-users"
    address_prefixes                = ["172.26.121.0/24"]
    resource_group_name             = "rg-avd-prod-qc-01"
    virtual_network_name            = "vnet-avd-prod-qc-01"

  }
}

staccounts = {
   "st-01" = {
    st_account_name       = "stavdprodqc001"
    resource_group_name   = "rg-avd-prod-qc-01"
    location              = "Qatar Central"
    account_tier          = "Standard"
    account_replication_type = "LRS"

  }

}

nsgs = {
   "nsg-01" = {
    nsg       = "nsg-avd-prod-qc-users"
    resource_group_name   = "rg-avd-prod-qc-01"
    location              = "Qatar Central"

  }

}

routetables = {
   "routetable-01" = {
    route_table_name       = "route-table-avd-prod-qc-users"
    resource_group_name   = "rg-avd-prod-qc-01"
    location              = "Qatar Central"

  }

}

routes = {
  "rt-01" = {
    routename           = "udr-azure-qatarcentral"
    resource_group_name = "rg-avd-prod-qc-01"
    route_table_name    = "route-table-avd-prod-qc-users"
    address_prefix      = "172.24.0.0/13"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
 "rt-02" = {
    routename           = "udr-azure-westeurope"
    resource_group_name = "rg-avd-prod-qc-01"
    route_table_name    = "route-table-avd-prod-qc-users"
    address_prefix      = "172.16.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-03" = {
    routename           = "udr-fortiweb-prod"
    resource_group_name = "rg-avd-prod-qc-01"
    route_table_name    = "route-table-avd-prod-qc-users"
    address_prefix      = "172.29.223.10/32"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-04" = {
    routename           = "udr-internet"
    resource_group_name = "rg-avd-prod-qc-01"
    route_table_name    = "route-table-avd-prod-qc-users"
    address_prefix      = "0.0.0.0/0"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
  "rt-05" = {
    routename           = "udr-moci-onpremise-1"
    resource_group_name = "rg-avd-prod-qc-01"
    route_table_name    = "route-table-avd-prod-qc-users"
    address_prefix      = "10.0.0.0/8"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-06" = {
    routename           = "udr-moci-onpremise-2"
    resource_group_name = "rg-avd-prod-qc-01"
    route_table_name    = "route-table-avd-prod-qc-users"
    address_prefix      = "192.168.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }

}


subnetroutes = {
   "subnetroute-01" = {
    subnet_id       = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-avd-prod-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-avd-prod-qc-01/subnets/snet-avd-prod-qc-users"
    route_table_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-avd-prod-qc-01/providers/Microsoft.Network/routeTables/route-table-avd-prod-qc-users"

  }

}

subnetnsgs = {
   "subnetnsg-01" = {
    subnet_id       = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-avd-prod-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-avd-prod-qc-01/subnets/snet-avd-prod-qc-users"
    nsg_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-avd-prod-qc-01/providers/Microsoft.Network/networkSecurityGroups/nsg-avd-prod-qc-users"

  }

}
avds = {
   "avd-01" = {
    workspace_name            = "desktopworkspace"
    resource_group_name   = "rg-avd-prod-qc-01"
    location              = "Qatar Central"
    hostpoollocation      = "West Europe"
    hostpool_name         = "hp-avd-prod-qc-001"
    desktop_app_group_name = "hp-avd-prod-qc-001-DAG"
  }

}