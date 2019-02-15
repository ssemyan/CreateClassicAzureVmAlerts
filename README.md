# Create Classic Azure VM Alerts
This PowerShell script and ARM template will create a classic sytle Azure alert that emails a specified address when the memory usage of the VM exceeds 80%. The PowerShell script will set this alert for every VM in the specified resource groups. This requires the VM Guest Diagnostics extension needs to be installed. Learn more about this here: 
* Windows - https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/diagnostics-windows
* Linux - https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/diagnostics-linux

**Note: Classic Style alerts are scheduled to be depricated June 30, 2019. Read more about this here: https://docs.microsoft.com/en-us/azure/azure-monitor/platform/monitoring-classic-retirement**

To use this script edit the details in _CreateAlertsOnAllVmsInResourceGroups.ps1_:

First update the list of resource groups to search:
```
$resourceGroupsToProcess = @('my_group', 'my_group_2')
```

Alternatively, if you want to run against **all resource groups** uncomment out this line:
```
#$resourceGroupsToProcess = @()
```

Then update the email(s) to send alerts to (comma-separated if more than one):
```
$sendToEmail = 'myemail@company.com,myemail2@company.com'
```

Finally, run the following command in PowerShell. Note: this requires the [Azure PowerShell Module](https://docs.microsoft.com/en-us/powershell/azure/overview?view=azps-1.3.0) and if using the new version, requires the _Enable-AzureRmAlias_ to be set.
```
.\CreateAlertsOnAllVmsInResourceGroups.ps1
```
