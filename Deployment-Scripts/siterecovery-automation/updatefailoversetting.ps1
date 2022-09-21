Login-AzAccount

$recoveryvaultName="srstestfailovertest"
$recovery_rg="east-us-rg"
$replicaredVMName="windvm"
$recoveryVMName="windvmtarget"
$recovery_nsgID="UpdateMe"

#Get the vault object by name and resource group and save it to the $vault PowerShell variable 
$vault = Get-AzRecoveryServicesVault -Name $recoveryvaultName -ResourceGroupName $recovery_rg


#set the vault context
Set-ASRVaultContext -Vault $vault

$ASRFabrics = Get-AzRecoveryServicesAsrFabric


$ProtectionContainer = Get-AzRecoveryServicesAsrProtectionContainer -Fabric $ASRFabrics[1]

$ReplicatedVM1 = Get-AzRecoveryServicesAsrReplicationProtectedItem -FriendlyName $replicaredVMName -ProtectionContainer $ProtectionContainer

#Set-AzRecoveryServicesAsrReplicationProtectedItem -InputObject $ReplicatedVM1 -Size "Standard_DS11" -UseManagedDisk True

#Set-AzRecoveryServicesAsrReplicationProtectedItem -InputObject $ReplicatedVM1 -RecoveryNetworkSecurityGroupId ""

Set-AzRecoveryServicesAsrReplicationProtectedItem -InputObject $ReplicatedVM1 -Name $recoveryVMName -RecoveryNetworkSecurityGroupId $recovery_nsgID