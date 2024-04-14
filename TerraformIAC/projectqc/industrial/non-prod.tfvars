/*app_service_plans = {
  "asp-01" = {
    app_service_plan_name           = "aplan-industrialeservices-dt-01"
    location                        = "Qatar Central"
    os_type                         = "Windows"
    resource_group_name             = "0.0.0.0/0"
    sku_name                        = "Internet"
  }
}*/

vnets = {
  "vnet-01" = {
    vnet_name                       = "vnet-industrialeservices-dt-qc-01"
    location                        = "Qatar Central"
    resource_group_name             = "rg-industrialeservices-dt-qc-01"
    address_space                   = ["172.26.128.64/27","172.26.128.96/28"]
  }
}

subnets = {
  "snet-01" = {
    sn_name                         = "snet-industrialeservices-dt-qc-app"
    address_prefixes                = ["172.26.128.96/28"]
    resource_group_name             = "rg-industrialeservices-dt-qc-01"
    virtual_network_name            = "vnet-industrialeservices-dt-qc-01"
    
  }
  "snet-02" = {
    sn_name                         = "snet-industrialeservices-dt-qc-web"
    address_prefixes                = ["172.26.128.64/27"]
    resource_group_name             = "rg-industrialeservices-dt-qc-01"
    virtual_network_name            = "vnet-industrialeservices-dt-qc-01"
        delegations = {
      name     ="Microsoft.Web.hostingEnvironments"
      service_delegation ="Microsoft.Web/hostingEnvironments"
      actions =["Microsoft.Network/virtualNetworks/subnets/action"]


    }
    
  }
}

asev3 = {
  "asev3-01" = {
    asev3_name            = "ase-industrialeservices-dt-qc-01"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    subnet_id             = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-industrialeservices-dt-qc-01/subnets/snet-industrialeservices-dt-qc-web"
    ase_asp_name          = "aplan-industrialeservices-dt-qc-01"
    os_type               = "Windows"
    sku_name              = "I1v2"
    
  }
}

appservice = {
  "appservice-01" = {
    app_service_name      = "app-api-industrialeservices-dt-qc-01"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Web/serverfarms/aplan-industrialeservices-dt-qc-01" 
  }
    "appservice-02" = {
    app_service_name      = "app-apiportal-industrialeservices-dt-qc-01"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Web/serverfarms/aplan-industrialeservices-dt-qc-01" 
  }
    "appservice-03" = {
    app_service_name      = "app-auth-industrialeservices-dt-qc-01"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Web/serverfarms/aplan-industrialeservices-dt-qc-01" 
  }
    "appservice-04" = {
    app_service_name      = "app-pay-industrialeservices-dt-qc-01"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Web/serverfarms/aplan-industrialeservices-dt-qc-01" 
  }
    "appservice-05" = {
    app_service_name      = "app-portal-industrialeservices-dt-qc-01"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Web/serverfarms/aplan-industrialeservices-dt-qc-01" 
  }
}

staccounts = {
   "st-01" = {
    st_account_name       = "stindustsvcdtqc01"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    account_tier          = "Standard"
    account_replication_type = "LRS"

  }
     "st-02" = {
    st_account_name       = "rgindustservicacdtqc63"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    account_tier          = "Standard"
    account_replication_type = "LRS"

  }
     "st-03" = {
    st_account_name       = "stinduseservlogapdtqc01"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    account_tier          = "Standard"
    account_replication_type = "LRS"

  }
     "st-04" = {
    st_account_name       = "mocifunctionstoragedtqc"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    account_tier          = "Standard"
    account_replication_type = "LRS"

  }
       "st-05" = {
    st_account_name       = "functionappdtqcsa"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    account_tier          = "Standard"
    account_replication_type = "LRS"

  }

}

nsgs = {
   "nsg-01" = {
    nsg       = "nsg-industrialeservices-dt-qc-app"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"

  }
    "nsg-02" = {
    nsg       = "nsg-industrialeservices-dt-qc-web"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"

  }

}
routetables = {
   "routetable-01" = {
    route_table_name       = "route-table-industrialeservices-dt-qc-app"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"

  }
    "routetable-02" = {
    route_table_name       = "route-table-industrialeservices-dt-qc-web"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"

  }

}
routes = {
  "rt-01" = {
    routename           = "udr-azure-qatarcentral"
    resource_group_name = "rg-industrialeservices-dt-qc-01"
    route_table_name    = "route-table-industrialeservices-dt-qc-app"
    address_prefix      = "172.24.0.0/13"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-02" = {
    routename           = "udr-fortiweb-dt"
    resource_group_name = "rg-industrialeservices-dt-qc-01"
    route_table_name    = "route-table-industrialeservices-dt-qc-app"
    address_prefix      = "172.29.223.10/32"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-03" = {
    routename           = "udr-internet"
    resource_group_name = "rg-industrialeservices-dt-qc-01"
    route_table_name    = "route-table-industrialeservices-dt-qc-app"
    address_prefix      = "0.0.0.0/0"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
  "rt-04" = {
    routename           = "udr-moci-onpremise-1"
    resource_group_name = "rg-industrialeservices-dt-qc-01"
    route_table_name    = "route-table-industrialeservices-dt-qc-app"
    address_prefix      = "10.0.0.0/8"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-05" = {
    routename           = "udr-moci-onpremise-2"
    resource_group_name = "rg-industrialeservices-dt-qc-01"
    route_table_name    = "route-table-industrialeservices-dt-qc-app"
    address_prefix      = "192.168.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
    "rt-06" = {
    routename           = "udr-azure-qatarcentral"
    resource_group_name = "rg-industrialeservices-dt-qc-01"
    route_table_name    = "route-table-industrialeservices-dt-qc-web"
    address_prefix      = "172.24.0.0/13"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-07" = {
    routename           = "udr-fortiweb-dt"
    resource_group_name = "rg-industrialeservices-dt-qc-01"
    route_table_name    = "route-table-industrialeservices-dt-qc-web"
    address_prefix      = "172.29.223.10/32"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-08" = {
    routename           = "udr-internet"
    resource_group_name = "rg-industrialeservices-dt-qc-01"
    route_table_name    = "route-table-industrialeservices-dt-qc-web"
    address_prefix      = "0.0.0.0/0"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
  "rt-09" = {
    routename           = "udr-moci-onpremise-1"
    resource_group_name = "rg-industrialeservices-dt-qc-01"
    route_table_name    = "route-table-industrialeservices-dt-qc-web"
    address_prefix      = "10.0.0.0/8"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-10" = {
    routename           = "udr-moci-onpremise-2"
    resource_group_name = "rg-industrialeservices-dt-qc-01"
    route_table_name    = "route-table-industrialeservices-dt-qc-web"
    address_prefix      = "192.168.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
}

appinsights = {
   "appinsight-01" = {
    app_insight_name       = "apinsndustrialeservicesdtqc01"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    workspace_id          = "/subscriptions/ee57c679-017f-4125-ad71-eb009c99c8f0/resourceGroups/rg-monitoring-hub-001/providers/Microsoft.OperationalInsights/workspaces/log-monitor-hub-001"

  }
   "appinsight-02" = {
    app_insight_name       = "lapp-industrialeservices-dt-qc-01"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    workspace_id          = "/subscriptions/ee57c679-017f-4125-ad71-eb009c99c8f0/resourceGroups/rg-monitoring-hub-001/providers/Microsoft.OperationalInsights/workspaces/log-monitor-hub-001"
  }

}

actiongroups = {
   "actiongroup-01" = {
    action_group_name       = "Application Insights Smart Detection"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    short_name            = "appinsight"


  }
}

smartalerts = {
   "smartalert-01" = {
    smart_detector_alert_rule       = "Failure Anomalies - apinsndustrialeservicesdtqc01"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    application_insights_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/microsoft.insights/components/apinsindustrialeservicesdtqc01"
    monitor_action_group_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/microsoft.insights/actionGroups/Application Insights Smart Detection"

  }
    "smartalert-02" = {
    smart_detector_alert_rule       = "Failure Anomalies - lapp-industrialeservices-dt-qc-01"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    application_insights_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/microsoft.insights/components/lapp-industrialeservices-dt-qc-01"
    monitor_action_group_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/microsoft.insights/actionGroups/Application Insights Smart Detection"

  }

}


subnetroutes = {
   "subnetroute-01" = {
    subnet_id       = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-industrialeservices-dt-qc-01/subnets/snet-industrialeservices-dt-qc-app"
    route_table_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Network/routeTables/route-table-industrialeservices-dt-qc-app"

  }
    "subnetroute-02" = {
    subnet_id       = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-industrialeservices-dt-qc-01/subnets/snet-industrialeservices-dt-qc-web"
    route_table_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Network/routeTables/route-table-industrialeservices-dt-qc-web"

  }

}

subnetnsgs = {
   "subnetnsg-01" = {
    subnet_id       = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-industrialeservices-dt-qc-01/subnets/snet-industrialeservices-dt-qc-app"
    nsg_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Network/networkSecurityGroups/nsg-industrialeservices-dt-qc-app"

  }
     "subnetnsg-02" = {
    subnet_id       = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-industrialeservices-dt-qc-01/subnets/snet-industrialeservices-dt-qc-web"
    nsg_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Network/networkSecurityGroups/nsg-industrialeservices-dt-qc-web"

  }

}

servicebuses = {

   "servicebus-01" = {
    servicebus_nms       = "sb-industrialeservices-dt-qc-01"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    sku                   = "Standard"
  }

}

cosmosdbs = {
   "cosmosdb-01" = {
    cosmosdb_name       = "cosmosdb-industrialeservices-dt-qc-01"
    resource_group_name   = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
  }

}

appserviceplans ={
  "asp-01" = {
    app_service_plan_name = "aplan-induseservilogapp-dt-qc-01"
    resource_group_name     = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    sku_name              = "WS1"
    os_type               = "Windows"
  }
    "asp-02" = {
    app_service_plan_name = "ASP-rgindustrialeservicesdtqc01-ba68"
    resource_group_name     = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    sku_name              = "B1"
    os_type               = "Windows"
  }

}
functionapps = {
  "funcationapp-01" ={
    fn_app_name                = "Testingdtqc"
    storage_account_name       = "functionappdtqcsa"
    resource_group_name     = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    service_plan_id             = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Web/serverfarms/ASP-rgindustrialeservicesdtqc01-ba68"
  }
    "funcationapp-02" ={
    fn_app_name                = "func-industrialeservices-dt-qc-01"
    storage_account_name       = "functionappdtqcsa"
    resource_group_name     = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    service_plan_id             = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Web/serverfarms/aplan-industrialeservices-dt-qc-01"
  }
  "funcationapp-03" ={
    fn_app_name                = "func-industrialeservices-dt-qc-02"
    storage_account_name       = "functionappdtqcsa"
    resource_group_name     = "rg-industrialeservices-dt-qc-01"
    location              = "Qatar Central"
    service_plan_id             = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Web/serverfarms/aplan-industrialeservices-dt-qc-01"
  }
}
logicapps = {
  "logicapp-01" ={
   logic_app_name = "lapp-industrialeservices-dt-qc-01"
    resource_group_name     = "rg-industrialeservices-dt-qc-01"
    st_account_name          = "functionappdtqcsa"
    location              = "Qatar Central"
    app_service_plan_id             = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-industrialeservices-dt-qc-01/providers/Microsoft.Web/serverFarms/aplan-induseservilogapp-dt-qc-01"
  }
}