vnets = {
  "vnet-01" = {
    vnet_name                       = "vnet-inspection-prod-qc-01"
    location                        = "Qatar Central"
    resource_group_name             = "rg-inspection-prod-qc-01"
    address_space                   = ["172.26.119.224/27","172.26.120.0/27","172.26.120.32/28"]
  }
}

subnets = {
  "snet-01" = {
    sn_name                         = "snet-inspection-prod-qc-app"
    address_prefixes                = ["172.26.119.224/27"]
    resource_group_name             = "rg-inspection-prod-qc-01"
    virtual_network_name            = "vnet-inspection-prod-qc-01"
    delegations = {

      name     ="Microsoft.Web.hostingEnvironments"
      service_delegation ="Microsoft.Web/hostingEnvironments"
      actions =["Microsoft.Network/virtualNetworks/subnets/action"]


    }
  }
    "snet-02" = {
    sn_name                         = "snet-inspection-prod-qc-ext-app"
    address_prefixes                = ["172.26.120.0/27"]
    resource_group_name             = "rg-inspection-prod-qc-01"
    virtual_network_name            = "vnet-inspection-prod-qc-01"
    delegations = {

      name     ="Microsoft.Web.hostingEnvironments"
      service_delegation ="Microsoft.Web/hostingEnvironments"
      actions =["Microsoft.Network/virtualNetworks/subnets/action"]


    }
  }
    "snet-03" = {
    sn_name                         = "snet-inspection-prod-qc-db"
    address_prefixes                = ["172.26.120.32/28"]
    resource_group_name             = "rg-inspection-prod-qc-01"
    virtual_network_name            = "vnet-inspection-prod-qc-01"
  }
}

asev3 = {
    "asev3-01" = {
    asev3_name            = "ase-inspection-prod-qc-01"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
    subnet_id             = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-inspection-prod-qc-01/subnets/snet-inspection-prod-qc-app"
    ase_asp_name          = "aplan-inspection-prod-qc-01"
    os_type               = "Windows"
    sku_name              = "I1v2"
    
  }
    "asev3-02" = {
    asev3_name            = "ase-inspection-prod-qc-02"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
    subnet_id             = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-inspection-prod-qc-01/subnets/snet-inspection-prod-qc-ext-app"
    ase_asp_name          = "aplan-inspection-prod-qc-02"
    os_type               = "Windows"
    sku_name              = "I1v2"
    
  }
}

appservice = {
  "appservice-01" = {
    app_service_name      = "app-api-inspection-prod-qc-01"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Web/serverfarms/aplan-inspection-prod-qc-01" 
  }
    "appservice-02" = {
    app_service_name      = "app-soap-inspection-prod-qc-01"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Web/serverfarms/aplan-inspection-prod-qc-01" 
  }
    "appservice-03" = {
    app_service_name      = "app-survey-inspection-prod-qc-01"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Web/serverfarms/aplan-inspection-prod-qc-01" 
  }
  "appservice-04" = {
    app_service_name      = "app-be-inspection-prod-qc-01"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Web/serverfarms/aplan-inspection-prod-qc-01" 
  }
  "appservice-05" = {
    app_service_name      = "app-fe-inspection-prod-qc-01"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Web/serverfarms/aplan-inspection-prod-qc-02" 
  }
}

staccounts = {
   "st-01" = {
    st_account_name       = "stfuninspprodqc01"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
    account_tier          = "Standard"
    account_replication_type = "LRS"

  }
     "st-02" = {
    st_account_name       = "stalappinspprodqc03"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
    account_tier          = "Standard"
    account_replication_type = "LRS"

  }
     "st-03" = {
    st_account_name       = "stalappinspprodqc04"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
    account_tier          = "Standard"
    account_replication_type = "LRS"

  }

}

nsgs = {
   "nsg-01" = {
    nsg       = "nsg-inspection-prod-qc-app"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"

  }
     "nsg-02" = {
    nsg       = "nsg-inspection-prod-qc-ext-app"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"

  }
     "nsg-03" = {
    nsg       = "nsg-inspection-prod-qc-db"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"

  }


}

routetables = {
   "routetable-01" = {
    route_table_name       = "route-table-inspection-prod-qc-app"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"

  }
     "routetable-02" = {
    route_table_name       = "route-table-inspection-prod-qc-ext-app"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"

  }
     "routetable-03" = {
    route_table_name       = "route-table-inspection-prod-qc-db"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"

  }

}

routes = {
  "rt-01" = {
    routename           = "udr-azure-qatarcentral"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-app"
    address_prefix      = "172.24.0.0/13"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
 "rt-02" = {
    routename           = "udr-azure-westeurope"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-app"
    address_prefix      = "172.16.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-03" = {
    routename           = "udr-fortiweb-prod"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-app"
    address_prefix      = "172.29.223.10/32"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-04" = {
    routename           = "udr-internet"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-app"
    address_prefix      = "0.0.0.0/0"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
  "rt-05" = {
    routename           = "udr-moci-onpremise-1"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-app"
    address_prefix      = "10.0.0.0/8"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-06" = {
    routename           = "udr-moci-onpremise-2"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-ext-app"
    address_prefix      = "192.168.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
    "rt-07" = {
    routename           = "udr-azure-qatarcentral"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-ext-app"
    address_prefix      = "172.24.0.0/13"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
 "rt-08" = {
    routename           = "udr-azure-westeurope"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-ext-app"
    address_prefix      = "172.16.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-09" = {
    routename           = "udr-fortiweb-prod"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-ext-app"
    address_prefix      = "172.29.223.10/32"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-10" = {
    routename           = "udr-internet"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-ext-app"
    address_prefix      = "0.0.0.0/0"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
  "rt-11" = {
    routename           = "udr-moci-onpremise-1"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-ext-app"
    address_prefix      = "10.0.0.0/8"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-12" = {
    routename           = "udr-moci-onpremise-2"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-app"
    address_prefix      = "192.168.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
    "rt-14" = {
    routename           = "udr-azure-qatarcentral"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-db"
    address_prefix      = "172.24.0.0/13"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
 "rt-15" = {
    routename           = "udr-azure-westeurope"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-db"
    address_prefix      = "172.16.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-16" = {
    routename           = "udr-fortiweb-prod"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-db"
    address_prefix      = "172.29.223.10/32"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-17" = {
    routename           = "udr-internet"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-db"
    address_prefix      = "0.0.0.0/0"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
  "rt-18" = {
    routename           = "udr-moci-onpremise-1"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-db"
    address_prefix      = "10.0.0.0/8"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   /*"rt-19" = {
    routename           = "udr-moci-onpremise-2"
    resource_group_name = "rg-inspection-prod-qc-01"
    route_table_name    = "route-table-inspection-prod-qc-db"
    address_prefix      = "192.168.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }*/
}

appinsights = {
   "appinsight-01" = {
    app_insight_name       = "apinsinspectionprodqc01"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
    workspace_id          = "/subscriptions/ee57c679-017f-4125-ad71-eb009c99c8f0/resourceGroups/rg-monitoring-hub-001/providers/Microsoft.OperationalInsights/workspaces/log-monitor-hub-001"

  }
   "appinsight-02" = {
    app_insight_name       = "app-survey-inspection-prod-qc-01"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
    workspace_id          = "/subscriptions/ee57c679-017f-4125-ad71-eb009c99c8f0/resourceGroups/rg-monitoring-hub-001/providers/Microsoft.OperationalInsights/workspaces/log-monitor-hub-001"

  }

}

actiongroups = {
   "actiongroup-01" = {
    action_group_name       = "Application Insights Smart Detection"
    resource_group_name   = "rg-inspection-prod-qc-01"
    short_name            = "appinsight"


  }
}

smartalerts = {
   "smartalert-01" = {
    smart_detector_alert_rule       = "Failure Anomalies - apinsinspectionprodqc01"
    resource_group_name   = "rg-inspection-prod-qc-01"
    application_insights_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-inspection-prod-qc-01/providers/microsoft.insights/components/apinsinspectionprodqc01"
    monitor_action_group_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-inspection-prod-qc-01/providers/microsoft.insights/actionGroups/Application Insights Smart Detection"

  }
    "smartalert-02" = {
    smart_detector_alert_rule       = "Failure Anomalies - app-survey-inspection-prod-qc-01"
    resource_group_name   = "rg-inspection-prod-qc-01"
    application_insights_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-inspection-prod-qc-01/providers/microsoft.insights/components/app-survey-inspection-prod-qc-01"
    monitor_action_group_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-inspection-prod-qc-01/providers/microsoft.insights/actionGroups/Application Insights Smart Detection"

  }


}

subnetroutes = {
   "subnetroute-01" = {
    subnet_id       = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-inspection-prod-qc-01/subnets/snet-inspection-prod-qc-app"
    route_table_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/routeTables/route-table-inspection-prod-qc-app"

  }
     "subnetroute-02" = {
    subnet_id       = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-inspection-prod-qc-01/subnets/snet-inspection-prod-qc-ext-app"
    route_table_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/routeTables/route-table-inspection-prod-qc-ext-app"

  }
     "subnetroute-03" = {
    subnet_id       = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-inspection-prod-qc-01/subnets/snet-inspection-prod-qc-db"
    route_table_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/routeTables/route-table-inspection-prod-qc-db"

  }

}

subnetnsgs = {
   "subnetnsg-01" = {
    subnet_id       = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-inspection-prod-qc-01/subnets/snet-inspection-prod-qc-app"
    nsg_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/networkSecurityGroups/nsg-inspection-prod-qc-app"

  }
   "subnetnsg-02" = {
    subnet_id       = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-inspection-prod-qc-01/subnets/snet-inspection-prod-qc-ext-app"
    nsg_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/networkSecurityGroups/nsg-inspection-prod-qc-ext-app"

  }
   "subnetnsg-03" = {
    subnet_id       = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-inspection-prod-qc-01/subnets/snet-inspection-prod-qc-db"
    nsg_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/networkSecurityGroups/nsg-inspection-prod-qc-db"

  }

}

functionapps = {
  "funcationapp-01" ={
    fn_app_name                = "func-inspection-prod-qc-02"
    storage_account_name       = "stfuninspprodqc01"
    resource_group_name   =  "rg-inspection-prod-qc-01"
    location              =  "Qatar Central"
    service_plan_id             = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Web/serverfarms/aplan-inspection-prod-qc-01"
  }
}

windowsvms = {
  "windowsvms-01" = {
    vm_name               = "MAInINETLPQ01"
    vmnic_name            = "nic-MAInINETLPQ01-eth0"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
    vmsize            = "Standard_D2s_v3"
    subnet_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-inspection-prod-qc-01/subnets/snet-inspection-prod-qc-db"
    os_disk_st_type              = "Standard_LRS"
    image_SKU            = "2019-Datacenter"
    offer                = "WindowsServer"
    publisher            = "MicrosoftWindowsServer"
    datadisk_name        = "MAInINETLPQ01_datadisk_01"
    data_disk_st_type    = "Premium_LRS"
    data_disk_size       = 200
  }
}

sqlservers = {
  "sqlserver-01" ={
    sqlserver_name                = "sqlsrv-inspection-prod-qc-01"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
  }
}

logicapps = {
  "logicapp-01" ={
   logic_app_name = "lapp-inspection-prod-qc-03"
   st_account_name               = "stalappinspprodqc03"
    resource_group_name   = "rg-inspection-prod-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Web/serverfarms/aplan-inspection-prod-qc-01" 
  }
    "logicapp-02" ={
   logic_app_name = "lapp-inspection-prod-qc-04"
    resource_group_name   = "rg-inspection-prod-qc-01"
    st_account_name               = "stalappinspprodqc04"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/3191d93b-36bf-4a46-bb40-f88267f1a1e7/resourceGroups/rg-inspection-prod-qc-01/providers/Microsoft.Web/serverfarms/aplan-inspection-prod-qc-01" 
  }
}