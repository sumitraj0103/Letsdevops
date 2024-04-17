
   
   pes = {
  "pe-01" = {
    pe_name            = "st-pe"
    resource_group_name   = "SRS-RG"
    location              = "West Europe"
    resource_id = "/subscriptions/c482f1f4-1b52-4c5b-ab1f-69b154e783af/resourcegroups/SRS-RG/providers/Microsoft.Storage/storageAccounts/testpe0103"
    subnet_id      = "/subscriptions/c482f1f4-1b52-4c5b-ab1f-69b154e783af/resourceGroups/SRS-RG/providers/Microsoft.Network/virtualNetworks/srstest01023/subnets/default"
    service_connection= "st-sc-1"
    subresource_type = "blob"
    dns_zone_group = "privatelink.blob.core.windows.net"
    private_dns_zone_id = "/subscriptions/c482f1f4-1b52-4c5b-ab1f-69b154e783af/resourceGroups/SRS-RG/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
  }
}
