
vnets = {
  "vnet-01" = {
    vnet_name                       = "vnet-gis-dt-qc-001"
    location                        = "Qatar Central"
    resource_group_name             = "rg-gis-dt-qc-001"
    address_space                   = ["172.26.128.112/28","172.26.128.128/28"]
  }
}

subnets = {
  "snet-01" = {
    sn_name                         = "snet-gis-dt-qc-db"
    address_prefixes                = ["172.26.128.112/28"]
    resource_group_name             = "rg-gis-dt-qc-001"
    virtual_network_name            = "vnet-gis-dt-qc-001"
    
  }
  "snet-02" = {
    sn_name                         = "snet-gis-dt-qc-app"
    address_prefixes                = ["172.26.128.128/28"]
    resource_group_name             = "rg-gis-dt-qc-001"
    virtual_network_name            = "vnet-gis-dt-qc-001"  
  }
}
nsgs = {
   "nsg-01" = {
    nsg       = "nsg-snet-dt-qc-gis-db"
    resource_group_name   = "rg-gis-dt-qc-001"
    location              = "Qatar Central"

  }
    "nsg-02" = {
    nsg       = "nsg-snet-dt-qc-gis-app"
    resource_group_name   = "rg-gis-dt-qc-001"
    location              = "Qatar Central"

  }

}
routetables = {
   "routetable-01" = {
    route_table_name       = "route-table-dt-qc-gis-db"
    resource_group_name   = "rg-gis-dt-qc-001"
    location              = "Qatar Central"

  }
    "routetable-02" = {
    route_table_name       = "route-table-dt-qc-gis-app"
    resource_group_name   = "rg-gis-dt-qc-001"
    location              = "Qatar Central"

  }

}
routes = {
  "rt-01" = {
    routename           = "udr-azure-qatarcentral"
    resource_group_name = "rg-gis-dt-qc-001"
    route_table_name    = "route-table-dt-qc-gis-app"
    address_prefix      = "172.24.0.0/13"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-02" = {
    routename           = "udr-fortiweb-dt"
    resource_group_name = "rg-gis-dt-qc-001"
    route_table_name    = "route-table-dt-qc-gis-app"
    address_prefix      = "172.29.223.10/32"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-03" = {
    routename           = "udr-internet"
    resource_group_name = "rg-gis-dt-qc-001"
    route_table_name    = "route-table-dt-qc-gis-app"
    address_prefix      = "0.0.0.0/0"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
  "rt-04" = {
    routename           = "udr-moci-onpremise-1"
    resource_group_name = "rg-gis-dt-qc-001"
    route_table_name    = "route-table-dt-qc-gis-app"
    address_prefix      = "10.0.0.0/8"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-05" = {
    routename           = "udr-moci-onpremise-2"
    resource_group_name = "rg-gis-dt-qc-001"
    route_table_name    = "route-table-dt-qc-gis-app"
    address_prefix      = "192.168.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
    "rt-06" = {
    routename           = "udr-azure-qatarcentral"
    resource_group_name = "rg-gis-dt-qc-001"
    route_table_name    = "route-table-dt-qc-gis-db"
    address_prefix      = "172.24.0.0/13"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-07" = {
    routename           = "udr-fortiweb-dt"
    resource_group_name = "rg-gis-dt-qc-001"
    route_table_name    = "route-table-dt-qc-gis-db"
    address_prefix      = "172.29.223.10/32"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-08" = {
    routename           = "udr-internet"
    resource_group_name = "rg-gis-dt-qc-001"
    route_table_name    = "route-table-dt-qc-gis-db"
    address_prefix      = "0.0.0.0/0"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
  "rt-09" = {
    routename           = "udr-moci-onpremise-1"
    resource_group_name = "rg-gis-dt-qc-001"
    route_table_name    = "route-table-dt-qc-gis-db"
    address_prefix      = "10.0.0.0/8"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-10" = {
    routename           = "udr-moci-onpremise-2"
    resource_group_name = "rg-gis-dt-qc-001"
    route_table_name    = "route-table-dt-qc-gis-db"
    address_prefix      = "192.168.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
}

windowsvms = {
  "windowsvms-01" = {
    vm_name               = "MOCIAZInGIAPQ01"
    vmnic_name            = "nic-MOCIAZInGIAPQ01-eth0"
    resource_group_name   = "rg-gis-dt-qc-001"
    location              = "Qatar Central"
    vmsize            = "Standard_E2S_V3"
    subnet_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-gis-dt-qc-001/providers/Microsoft.Network/virtualNetworks/vnet-gis-dt-qc-001/subnets/snet-gis-dt-qc-app"
    os_disk_st_type              = "Premium_LRS"
    image_SKU            = "2016-Datacenter"
    offer                = "WindowsServer"
    publisher            = "MicrosoftWindowsServer"
    datadisk_name        = "mociazingiapq01_datadisk_01"
    data_disk_st_type    = "Premium_LRS"
    data_disk_size       = 250
  }
  

    "windowsvms-02" = {
    vm_name               = "MOCIAZInGIDBQ01"
    vmnic_name            = "nic-MOCIAZInGIDBQ01-eth0"
    resource_group_name   = "rg-gis-dt-qc-001"
    location              = "Qatar Central"
    vmsize            = "Standard_B2s_v2"
    subnet_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-gis-dt-qc-001/providers/Microsoft.Network/virtualNetworks/vnet-gis-dt-qc-001/subnets/snet-gis-dt-qc-db"
    os_disk_st_type              = "Premium_LRS"
    image_SKU            = "enterprise"
    offer                = "sql2019-ws2019"
    publisher            = "microsoftsqlserver"
    datadisk_name        = "MOCIAZInGIDBQ01_DataDisk_0"
    data_disk_st_type    = "Premium_LRS"
    data_disk_size       = 512

  }

  "windowsvms-03" = {
    vm_name               = "MOCIAZInGIDBQ02"
    vmnic_name            = "nic-MOCIAZInGIDBQ02-eth0"
    resource_group_name   = "rg-gis-dt-qc-001"
    location              = "Qatar Central"
    vmsize            = "Standard_D2S_V3"
    subnet_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-gis-dt-qc-001/providers/Microsoft.Network/virtualNetworks/vnet-gis-dt-qc-001/subnets/snet-gis-dt-qc-db"
    os_disk_st_type      = "Premium_LRS"
    image_SKU            = "enterprise"
    offer                = "sql2019-ws2019"
    publisher            = "microsoftsqlserver"
    datadisk_name                = "mociazingidbQ02_datadisk_01"
    data_disk_st_type    = "Premium_LRS"
    data_disk_size       = 250

  }

}
mssqlvms ={
 "mssqlvm-01" ={
   vm_name               = "MOCIAZInGIDBQ01"
   resource_group_name   = "rg-gis-dt-qc-001"
 }


}
subnetnsgs = {
   "subnetnsg-01" = {
    subnet_id       = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-gis-dt-qc-001/providers/Microsoft.Network/virtualNetworks/vnet-gis-dt-qc-001/subnets/snet-gis-dt-qc-db"
    nsg_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-gis-dt-qc-001/providers/Microsoft.Network/networkSecurityGroups/nsg-snet-dt-qc-gis-db"

  }
     "subnetnsg-02" = {
    subnet_id       = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-gis-dt-qc-001/providers/Microsoft.Network/virtualNetworks/vnet-gis-dt-qc-001/subnets/snet-gis-dt-qc-app"
    nsg_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-gis-dt-qc-001/providers/Microsoft.Network/networkSecurityGroups/nsg-snet-dt-qc-gis-app"

  }

}
subnetroutes = {
   "subnetroute-01" = {
    subnet_id       = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-gis-dt-qc-001/providers/Microsoft.Network/virtualNetworks/vnet-gis-dt-qc-001/subnets/snet-gis-dt-qc-db"
    route_table_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-gis-dt-qc-001/providers/Microsoft.Network/routeTables/route-table-dt-qc-gis-db"

  }
    "subnetroute-02" = {
    subnet_id       = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-gis-dt-qc-001/providers/Microsoft.Network/virtualNetworks/vnet-gis-dt-qc-001/subnets/snet-gis-dt-qc-app"
    route_table_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-gis-dt-qc-001/providers/Microsoft.Network/routeTables/route-table-dt-qc-gis-app"

  }

}