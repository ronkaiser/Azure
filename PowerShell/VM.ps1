# Create virtual machine
new-azvm
  -ResourceGroupName 'RESOURCE_GROUP_NAME' `
  -Name 'TestVM' `
  -VirtualNetworkName 'MyVNet' `
  -SubnetName 'MySubnet' `
  -SecurityGroupName 'MySecurityGroup' `
  -PublicIpAddressName 'myPubIP' `
  -OpenPorts 80, 3389
