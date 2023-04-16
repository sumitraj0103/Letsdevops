#Azure ResourceGroup
$resourceGroupName = "sttest"
#templateFile Path 
$templateFile = "C:\Users\sraj14\Documents\DevOps\Gay\MultipleJob\ExportedTemplate-srstest\storageaccount\template.json"
#Param File
$deploytoParamFile = "C:\Users\sraj14\Documents\DevOps\Gay\MultipleJob\ExportedTemplate-srstest\storageaccount\parameters.json"
#Param location to create param File during run time 
$ParameterFileBase = "C:\Users\sraj14\Documents\DevOps\Gay\MultipleJob\ExportedTemplate-srstest\storageaccount"
$itemcount=5

for($i=1; $i -le $itemcount; $i++){
      $suffix = Get-Random -Maximum 1000
      $deploymentName = "ARMDeployment" + $suffix
      $content = Get-Content -Path $deploytoParamFile
      write-host "Content is $content"
      write-host "Parameter file = $deploytoParamFile"
      #Updating the Tokenize Param File 
      $updatebatchcount = $content -replace '#{stnumber}#', $i
      #Create New param file with
      $newjsonPath=$ParameterFileBase+"/$i"+"_param.json"
      if(Test-Path -Path $newjsonPath){

          write-host "File Already exist No Need to Create"
      }
      else{

        New-Item -Path $newjsonPath -ItemType File
      }
      #updating the Content 
      $updatebatchcount | Set-Content -Path $newjsonPath
    
      # Creating Job wth ARM deployment
      $job = Start-Job -ScriptBlock {
        New-AzResourceGroupDeployment -Name $args[0] -ResourceGroupName $args[1] -TemplateFile $args[2] -TemplateParameterFile $args[3] -Mode Incremental -Force
      } -ArgumentList $deploymentName, $resourceGroupName, $templateFile, $newjsonPath

      # Get the job's status
      Get-Job -Id $job.Id | Select-Object -Property Name, Status, HasMoreData, Location, Command | Format-Table -AutoSize

}
Get-Job | Wait-Job
#Display the Result
Get-Job | Receive-Job

