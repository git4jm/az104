$location = "westeurope"
$resourceGroup = "RG-AZ104-VM-Demo"

New-AzResourceGroup -Name $resourceGroup -Location $location

#vnet
$myVNet2 = New-AzVirtualNetwork -ResourceGroupName $resourceGroup -Location $location -Name myVNet2 -AddressPrefix 10.11.0.0/16
$mySubnet2 = Add-AzVirtualNetworkSubnetConfig -Name mySubnet2 -AddressPrefix 10.11.0.0/24 -VirtualNetwork $myVNet2
$mySubnet2 | Set-AzVirtualNetwork


$nic = New-AzNetworkInterface -ResourceGroupName $resourceGroup -Location $location -Name psvmnic01 -SubnetID $($myVNet2.id + '/subnets/mySubnet2')


$cred = Get-Credential
$vm = New-AzVMConfig -VMName VM01ps -VMSize Standard_B2ms
$vm = Set-AzVMOperatingSystem -VM $vm -Windows -ComputerName  VM01ps -Credential $cred -ProvisionVMAgent -EnableAutoUpdate
$vm = Set-AzVMSourceImage -VM $vm -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2016-Datacenter -Version latest
$vm = Set-AzVMOSDisk -VM $vm -Name myOsDisk -DiskSizeInGB 128 -CreateOption FromImage -Caching ReadWrite
$vm = Add-AzVMNetworkInterface -VM $vm -Id $nic.Id

New-AzVM -ResourceGroupName $resourceGroup -Location westeurope -VM $vm
