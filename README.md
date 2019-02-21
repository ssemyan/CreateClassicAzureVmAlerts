# Create Classic Azure VM Alerts

**Note: Classic Style alerts are scheduled to be depricated June 30, 2019. Read more about this here: https://docs.microsoft.com/en-us/azure/azure-monitor/platform/monitoring-classic-retirement**

For an example on how to create the new-style of alerts in Azure Monitor, go here: https://github.com/ssemyan/CreateAzureMonitorVmAlerts

This PowerShell script and ARM templates will create classic-style Azure alerts that email specified addresses when:

1. The memory usage of the VM exceeds 80% for 5 minutes
1. The CPU usage of the VM exceeds 80% for 5 minutes
1. The network in of the VM falls below 15K for 5 minutes

The PowerShell script will set these alerts for every VM in the specified resource groups. This requires the VM Guest Diagnostics extension to be installed. Learn more about this here: 
* Windows - https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/diagnostics-windows
* Linux - https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/diagnostics-linux

To install the **Windows** VM Extension while creating the alerts, set the value of _$addExtension_ to _$TRUE_ and update the values for _$existingdiagnosticsStorageAccountName_ and _$existingdiagnosticsStorageResourceGroup_

To only install the extension and not create alerts, set the value of _$addAlerts_ to _$FALSE_

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
$sendToEmails = 'myemail@company.com,myemail2@company.com'
```

Finally, run the following command in PowerShell. Note: this requires the [Azure PowerShell Module](https://docs.microsoft.com/en-us/powershell/azure/overview?view=azps-1.3.0) and if using the new version, the script will set the AzureRm alias via _Enable-AzureRmAlias_.
```
.\CreateAlertsOnAllVmsInResourceGroups.ps1
```
