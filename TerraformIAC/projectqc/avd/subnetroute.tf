module "subnetroute" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/networking/subnetroute"
    for_each = var.subnetroutes
      subnet_id                  = each.value.subnet_id
      route_table_id = each.value.route_table_id
    
}
