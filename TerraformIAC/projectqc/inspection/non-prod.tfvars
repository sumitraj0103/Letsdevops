/*app_service_plans = {
  "asp-01" = {
    app_service_plan_name           = "aplan-inspection-stage-01"
    location                        = "Qatar Central"
    os_type                         = "Windows"
    resource_group_name             = "0.0.0.0/0"
    sku_name                        = "Internet"
  }
}*/

vnets = {
  "vnet-01" = {
    vnet_name                       = "vnet-inspection-stage-qc-01"
    location                        = "Qatar Central"
    resource_group_name             = "rg-inspection-stage-qc-01"
    address_space                   = ["172.26.122.112/28"]
  }
}

subnets = {
  "snet-01" = {
    sn_name                         = "snet-inspection-stage-qc-app"
    address_prefixes                = ["172.26.122.112/28"]
    resource_group_name             = "rg-inspection-stage-qc-01"
    virtual_network_name            = "vnet-inspection-stage-qc-01"
    delegations = {

      name     ="Microsoft.Web.hostingEnvironments"
      service_delegation ="Microsoft.Web/hostingEnvironments"
      actions =["Microsoft.Network/virtualNetworks/subnets/action"]


    }
  }
}

asev3 = {
  "asev3-01" = {
    asev3_name            = "ase-inspection-stage-qc-01"
    resource_group_name   = "rg-inspection-stage-qc-01"
    location              = "Qatar Central"
    subnet_id             = "/subscriptions/f8f7ece3-ea74-43b3-a433-e54f3787a27e/resourceGroups/rg-inspection-stage-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-inspection-stage-qc-01/subnets/snet-inspection-stage-qc-app"
    ase_asp_name          = "aplan-inspection-stage-qc-01"
    os_type               = "Windows"
    sku_name              = "I1v2"
    
  }
}

appservice = {
  "appservice-01" = {
    app_service_name      = "app-api-inspection-stage-qc-01"
    resource_group_name   = "rg-inspection-stage-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/f8f7ece3-ea74-43b3-a433-e54f3787a27e/resourceGroups/rg-inspection-stage-qc-01/providers/Microsoft.Web/serverfarms/aplan-inspection-stage-qc-01" 
  }
    "appservice-02" = {
    app_service_name      = "app-soap-inspection-stage-qc-01"
    resource_group_name   = "rg-inspection-stage-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/f8f7ece3-ea74-43b3-a433-e54f3787a27e/resourceGroups/rg-inspection-stage-qc-01/providers/Microsoft.Web/serverfarms/aplan-inspection-stage-qc-01" 
  }
    "appservice-03" = {
    app_service_name      = "app-survey-inspection-stage-qc-01"
    resource_group_name   = "rg-inspection-stage-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/f8f7ece3-ea74-43b3-a433-e54f3787a27e/resourceGroups/rg-inspection-stage-qc-01/providers/Microsoft.Web/serverfarms/aplan-inspection-stage-qc-01" 
  }
}

staccounts = {
   "st-01" = {
    st_account_name       = "staeinspectionstageqc01"
    resource_group_name   = "rg-inspection-stage-qc-01"
    location              = "Qatar Central"
    account_tier          = "Standard"
    account_replication_type = "LRS"

  }

}
nsgs = {
   "nsg-01" = {
    nsg       = "nsg-inspection-stage-qc-app"
    resource_group_name   = "rg-inspection-stage-qc-01"
    location              = "Qatar Central"

  }

}

routetables = {
   "routetable-01" = {
    route_table_name       = "route-table-inspection-stage-qc-app"
    resource_group_name   = "rg-inspection-stage-qc-01"
    location              = "Qatar Central"

  }

}

routes = {
  "rt-01" = {
    routename           = "udr-azure-qatarcentral"
    resource_group_name = "rg-inspection-stage-qc-01"
    route_table_name    = "route-table-inspection-stage-qc-app"
    address_prefix      = "172.24.0.0/13"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
 "rt-02" = {
    routename           = "udr-azure-westeurope"
    resource_group_name = "rg-inspection-stage-qc-01"
    route_table_name    = "route-table-inspection-stage-qc-app"
    address_prefix      = "172.16.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-03" = {
    routename           = "udr-fortiweb-stage"
    resource_group_name = "rg-inspection-stage-qc-01"
    route_table_name    = "route-table-inspection-stage-qc-app"
    address_prefix      = "172.29.223.10/32"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-04" = {
    routename           = "udr-internet"
    resource_group_name = "rg-inspection-stage-qc-01"
    route_table_name    = "route-table-inspection-stage-qc-app"
    address_prefix      = "0.0.0.0/0"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
  "rt-04" = {
    routename           = "udr-moci-onpremise-1"
    resource_group_name = "rg-inspection-stage-qc-01"
    route_table_name    = "route-table-inspection-stage-qc-app"
    address_prefix      = "10.0.0.0/8"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
   "rt-05" = {
    routename           = "udr-moci-onpremise-2"
    resource_group_name = "rg-inspection-stage-qc-01"
    route_table_name    = "route-table-inspection-stage-qc-app"
    address_prefix      = "192.168.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "172.29.220.230"  
  }
}

appinsights = {
   "appinsight-01" = {
    app_insight_name       = "apinsinspectionstageqc01"
    resource_group_name   = "rg-inspection-stage-qc-01"
    location              = "Qatar Central"
    workspace_id          = "/subscriptions/ee57c679-017f-4125-ad71-eb009c99c8f0/resourceGroups/rg-monitoring-hub-001/providers/Microsoft.OperationalInsights/workspaces/log-monitor-hub-001"

  }

}

actiongroups = {
   "actiongroup-01" = {
    action_group_name       = "Application Insights Smart Detection"
    resource_group_name   = "rg-inspection-stage-qc-01"
    short_name            = "appinsight"


  }
}

smartalerts = {
   "smartalert-01" = {
    smart_detector_alert_rule       = "Failure Anomalies - apinsinspectionstageqc01"
    resource_group_name   = "rg-inspection-stage-qc-01"
    application_insights_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-inspection-stage-qc-01/providers/microsoft.insights/components/apinsinspectionstageqc01"
    monitor_action_group_id   = "/subscriptions/2c7fea45-cc1d-4e4c-90cf-5744cf2e15ae/resourceGroups/rg-inspection-stage-qc-01/providers/microsoft.insights/actionGroups/Application Insights Smart Detection"

  }

}

subnetroutes = {
   "subnetroute-01" = {
    subnet_id       = "/subscriptions/f8f7ece3-ea74-43b3-a433-e54f3787a27e/resourceGroups/rg-inspection-stage-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-inspection-stage-qc-01/subnets/snet-inspection-stage-qc-app"
    route_table_id   = "/subscriptions/f8f7ece3-ea74-43b3-a433-e54f3787a27e/resourceGroups/rg-inspection-stage-qc-01/providers/Microsoft.Network/routeTables/route-table-inspection-stage-qc-app"

  }

}

subnetnsgs = {
   "subnetnsg-01" = {
    subnet_id       = "/subscriptions/f8f7ece3-ea74-43b3-a433-e54f3787a27e/resourceGroups/rg-inspection-stage-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-inspection-stage-qc-01/subnets/snet-inspection-stage-qc-app"
    nsg_id   = "/subscriptions/f8f7ece3-ea74-43b3-a433-e54f3787a27e/resourceGroups/rg-inspection-stage-qc-01/providers/Microsoft.Network/networkSecurityGroups/nsg-inspection-stage-qc-app"

  }

}