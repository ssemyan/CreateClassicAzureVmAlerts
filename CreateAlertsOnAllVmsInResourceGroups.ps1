# Create array of resource groups we want to process 
$resourceGroupsToProcess = @('my_group', 'my_group_2')
$sendToEmail = 'myemail@company.com'

# To process all resource groups uncomment out the next line - NOTE: THIS WILL CREATE AN ALERT FOR EVERY VM IN YOUR SUBSCRIPTION
#$resourceGroupsToProcess = @()

$allresgroup = Get-AzureRmResourceGroup
  
foreach ($rg in $allresgroup)
{
    Write-Host Processing resource group: $rg.ResourceGroupName
    
	if (($resourceGroupsToProcess.Length -eq 0) -or ($rg.ResourceGroupName -in $resourceGroupsToProcess))
	{
		# Get List of VMs in current resource group
		$vms = Get-AzureRmVM -ResourceGroupName $rg.ResourceGroupName
		foreach ($vm in $vms)
		{
			Write-Host Creating alert for VM: $vm.Name 

			# run ARM template against VM
			New-AzResourceGroupDeployment -Name mem_alert_$($vm.Name) -ResourceGroupName $rg.ResourceGroupName -TemplateFile .\alert_template.json -virtualMachineName $vm.Name -sendToEmail $sendToEmail -Verbose
		}
	}
	else
	{
		Write-Host Ignoring resource group.
	}
}
 