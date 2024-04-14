module "subnetnsg" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/networking/subnetnsg"
    for_each = var.subnetnsgs
      subnet_id                  = each.value.subnet_id
      nsg_id = each.value.nsg_id
  
  depends_on = [module.subnet.azure_sn,module.nsg.nsg]
    
}
