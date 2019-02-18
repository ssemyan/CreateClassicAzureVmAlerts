# Create array of resource groups we want to process 
$resourceGroupsToProcess = @('mygr', 'my_group_2')
$sendToEmails = 'myemail@company.com,myotheremail@company.com'

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
			Write-Host Creating alerts for VM: $vm.Name 

			# run ARM template against VM for memory alert
			New-AzureRMResourceGroupDeployment -Name mem_alert_$($vm.Name) -ResourceGroupName $rg.ResourceGroupName -TemplateFile .\alert_memory_template.json -virtualMachineName $vm.Name -sendToEmails $sendToEmails -Verbose

			# run ARM template against VM for CPU alert
			New-AzureRMResourceGroupDeployment -Name cpu_alert_$($vm.Name) -ResourceGroupName $rg.ResourceGroupName -TemplateFile .\alert_cpu_template.json -virtualMachineName $vm.Name -sendToEmails $sendToEmails -Verbose

			# run ARM template against VM for network alert
			New-AzureRMResourceGroupDeployment -Name net_alert_$($vm.Name) -ResourceGroupName $rg.ResourceGroupName -TemplateFile .\alert_network_template.json -virtualMachineName $vm.Name -sendToEmails $sendToEmails -Verbose
		}
	}
	else
	{
		Write-Host Ignoring resource group.
	}
}
 