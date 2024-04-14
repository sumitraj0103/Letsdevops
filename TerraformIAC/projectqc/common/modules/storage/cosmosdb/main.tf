resource "azurerm_cosmosdb_account" "db" {
        name                = var.cosmosdb_name
        location            = var.location
        resource_group_name = var.resource_group_name
        offer_type          = "Standard"

        enable_automatic_failover = true

        capabilities {
            name = "EnableAggregationPipeline"
        }

        consistency_policy {
            consistency_level       = "BoundedStaleness"
            max_interval_in_seconds = 300
            max_staleness_prefix    = 100000
        }
       
        geo_location {
            location          = "westeurope"
            failover_priority = 0
        }

        
        
}