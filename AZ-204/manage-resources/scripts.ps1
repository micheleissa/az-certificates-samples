# Check ps version
$PSVersionTable.PSVersion

#Example of how to read help content for a cmdlet
Get-Help Get-ChildItem -detailed

# A PowerShell Module is a DLL that includes the code to process each available cmdlet
Get-Module

# Install AZ-Module
Install-Module -Name Az -AllowClobber -SkipPublisherCheck

# Load module
Import-Module Az

# Connnect to Azure
Connect-AzAccount

# Work with a specific subscription
Select-AzSubscription -SubscriptionId '53dde41e-916f-49f8-8108-558036f826ae'

# Get a list of all Resource Groups
Get-AzResourceGroup

#Formatting results via pipe
Get-AzResourceGroup | Format-Table

# Create an RG
New-AzResourceGroup -Name $name -Location $loc

#Verify the RG
Get-AzResource | Format-Table

# Provision/Create a VM
New-AzVm 
       -ResourceGroupName $rg-name
       -Name $vm-name 
       -Credential $cred
       -Location $loc 
       -Image $imge-name

# Get VM info
$vm = Get-AzVM  -Name MyVM -ResourceGroupName $rg-name

#More elaborate example
$ResourceGroupName = "ExerciseResources"
$vm = Get-AzVM  -Name MyVM -ResourceGroupName $ResourceGroupName
$vm.HardwareProfile.vmSize = "Standard_DS3_v2"

Update-AzVM -ResourceGroupName $ResourceGroupName  -VM $vm

# Creare a Linxu VM via PS script at centralus location
New-AzVm -ResourceGroupName learn-53d8f04b-72c1-476e-93a8-428dee6f3545 -Name "testvm-eus-01" -Credential (Get-Credential) -Location "centralus" -Image UbuntuLTS -OpenPorts 22

# Get info of newely created VM
$vm = (Get-AzVM -Name "testvm-eus-01" -ResourceGroupName learn-53d8f04b-72c1-476e-93a8-428dee6f3545)

# reach inside the $vm object to get more info
$vm.StorageProfile.OsDisk

# Get vm IP address
$vm | Get-AzPublicIpAddress

# Stop the VM
Stop-AzVM -Name $vm.Name -ResourceGroup $vm.ResourceGroupName

# Remove the VM
Remove-AzVM -Name $vm.Name -ResourceGroup $vm.ResourceGroupName

# List of left over resources after the deletion of the VM
Get-AzResource -ResourceGroupName $vm.ResourceGroupName | ft


# Delete the NIC
$vm | Remove-AzNetworkInterface –Force

# Delete the managed OS Disk and storage account
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force

# Delete the VNet associated with the VM
Get-AzVirtualNetwork -ResourceGroup $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force

# Delete the NSG: network security group associated with the VM to control traffic mostly inbound
Get-AzNetworkSecurityGroup -ResourceGroup $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force

# Delete the publis IP associated with the VM
Get-AzPublicIpAddress -ResourceGroup $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force