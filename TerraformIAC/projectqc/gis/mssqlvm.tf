module "mssqlvm" {
    #source = "git::https://github.com/myorg/terraform-azure-storage-account.git"
    source = "../common/modules/compute/mssqlvm"
    for_each = var.mssqlvms
    vm_name               = each.value.vm_name # name of the VM and SSQL will be created with the same name 
    resource_group_name   = each.value.resource_group_name

    depends_on = [module.virtualmachine.vm]
} 
