asev3 = {
  "asev3-01" = {
    asev3_name            = "ase-updateme-dt-qc-01"
    resource_group_name   = "rg-updateme-dt-qc-01"
    location              = "Qatar Central"
    subnet_id             = "/subscriptions/xxxxx/resourceGroups/rg-updateme-dt-qc-01/providers/Microsoft.Network/virtualNetworks/vnet-updateme-dt-qc-01/subnets/snet-updateme-dt-qc-web"
    ase_asp_name          = "aplan-updateme-dt-qc-01"
    os_type               = "Windows"
    sku_name              = "I1v2"
    
  }
}

appservice = {
  "appservice-01" = {
    app_service_name      = "app-api-updateme-dt-qc-01"
    resource_group_name   = "rg-updateme-dt-qc-01"
    location              = "Qatar Central"
    app_service_plan_id   = "/subscriptions/xxxxxx/resourceGroups/rg-updateme-dt-qc-01/providers/Microsoft.Web/serverfarms/aplan-updateme-dt-qc-01" 
  }
  
}

appgw = {
  "appgw-01" = {
    pubip_name            = ""
    resource_group_name   = ""
    location              = ""
    appgw_name             = ""
    pubip_name            = ""
    gateway_ip_configuration_name   = ""
    backend_address_pool_name              = ""
    http_setting_name             = ""
    listener_name            = ""
    frontend_ip_configuration_name   = ""
    frontend_port_name              = ""
    user_assigned_identity_id             = ""
    cert_secret_id            = ""
    request_routing_rule_name   = ""
    http_setting_name              = ""
  }
  
}

