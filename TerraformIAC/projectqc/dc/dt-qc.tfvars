
vnets = {
  "vnet-01" = {
    vnet_name                       = "vnet-dc-dt-qc-001"
    location                        = "Qatar Central"
    resource_group_name             = "rg-dc-dt-qc-001"
    address_space                   = ["172.26.128.160/27"]
  }
}

subnets = {
  "snet-01" = {
    sn_name                         = "snet-dt-qc-domain-controller"
    address_prefixes                = ["172.26.128.160/27"]
    resource_group_name             = "rg-dc-dt-qc-001"
    virtual_network_name            = "vnet-dc-dt-qc-001"
    
  }
}
nsgs = {
   "nsg-01" = {
    nsg       = "nsg-dt-qc-domain-controller"
    resource_group_name   = "rg-dc-dt-qc-001"
    location              = "Qatar Central"

  }

}
routetables = {
   "routetable-01" = {
    route_table_name       = "route-table-dt-qc-domain-controller"
    resource_group_name   = "rg-dc-dt-qc-001"
    location              = "Qatar Central"

  }

}
routes = {
  "rt-01" = {
    routename           = "udr-azure-qatarcentral"
    resource_group_name = "rg-dc-dt-qc-001"
    route_table_name    = "route-table-dt-qc-domain-controller"
    address_prefix      = "172.24.0.0/13"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-02" = {
    routename           = "udr-fortiweb-dt"
    resource_group_name = "rg-dc-dt-qc-001"
    route_table_name    = "route-table-dt-qc-domain-controller"
    address_prefix      = "172.29.223.10/32"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-03" = {
    routename           = "udr-internet"
    resource_group_name = "rg-dc-dt-qc-001"
    route_table_name    = "route-table-dt-qc-domain-controller"
    address_prefix      = "0.0.0.0/0"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
  "rt-04" = {
    routename           = "udr-moci-onpremise-1"
    resource_group_name = "rg-dc-dt-qc-001"
    route_table_name    = "route-table-dt-qc-domain-controller"
    address_prefix      = "10.0.0.0/8"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-05" = {
    routename           = "udr-moci-onpremise-2"
    resource_group_name = "rg-dc-dt-qc-001"
    route_table_name    = "route-table-dt-qc-domain-controller"
    address_prefix      = "192.168.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
}

windowsvms = {
  "windowsvms-01" = {
    vm_name               = "MOCIAZInDCQ01"
    vmnic_name            = "nic-MOCIAZInDCQ01-eth0"
    resource_group_name   = "rg-dc-dt-qc-001"
    location              = "Qatar Central"
    vmsize            = "Standard_F2S_V2"
    subnet_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-dc-dt-qc-001/providers/Microsoft.Network/virtualNetworks/vnet-dc-dt-qc-001/subnets/snet-dt-qc-domain-controller"
    os_disk_st_type              = "Premium_LRS"
    image_SKU            = "2016-Datacenter"
    offer                = "WindowsServer"
    publisher            = "MicrosoftWindowsServer"
    datadisk_name        = "MOCIAZInDCQ01_DataDisk_01"
    data_disk_st_type    = "Premium_LRS"
    data_disk_size       = 100
  }
  
    "windowsvms-02" = {
	vm_name               = "MOCIAZInDCQ03"
    vmnic_name            = "nic-MOCIAZInDCQ03-eth0"
    resource_group_name   = "rg-dc-dt-qc-001"
    location              = "Qatar Central"
    vmsize            = "Standard_F2S_V2"
    subnet_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-dc-dt-qc-001/providers/Microsoft.Network/virtualNetworks/vnet-dc-dt-qc-001/subnets/snet-dt-qc-domain-controller"
    os_disk_st_type              = "Premium_LRS"
    image_SKU            = "2016-Datacenter"
    offer                = "WindowsServer"
    publisher            = "MicrosoftWindowsServer"
    datadisk_name        = "MOCIAZInDCQ03_DataDisk_1"
    data_disk_st_type    = "Premium_LRS"
    data_disk_size       = 100
  }

}

subnetnsgs = {
   "subnetnsg-01" = {
    subnet_id       = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-dc-dt-qc-001/providers/Microsoft.Network/virtualNetworks/vnet-dc-dt-qc-001/subnets/snet-dt-qc-domain-controller"
    nsg_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-dc-dt-qc-001/providers/Microsoft.Network/networkSecurityGroups/nsg-dt-qc-domain-controller"

  }

}
subnetroutes = {
   "subnetroute-01" = {
     subnet_id       = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-dc-dt-qc-001/providers/Microsoft.Network/virtualNetworks/vnet-dc-dt-qc-001/subnets/snet-dt-qc-domain-controller"
    route_table_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-dc-dt-qc-001/providers/Microsoft.Network/routeTables/route-table-dt-qc-domain-controller"

  }

}