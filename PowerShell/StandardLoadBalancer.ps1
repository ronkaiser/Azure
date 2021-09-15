$resource='RESOURCE_GROUP_NAME'
$location='westus'

# Create the public IP address
$publicIP = New-AzPublicIpAddress `
  -ResourceGroupName $resource `
  -Name 'myPublicIp' `
  -Location $location `
  -AllocationMethod static `
  -Sku Standard

# Create the frontend IP configuration
$feip = New-AzLoadBalancerFrontendIpConfig -Name 'MyFrontEndPool' -PublicIPAddress $publicIP

# Create the backend address pool
$bepool = New-AzLoadBalancerBackEndAddressPoolConfig -Name 'myBackEndPool'

# Create the health probe
$probe = New-AzLoadBalancerProbeConfig `
-Name 'myHealthProbe' `
-Protocol Http `
-Port 80 `
-RequestPath / `
-IntervalInSeconds 360 `
-ProbeCount 5

# Create the Load Balancer rule
$rule = New-AzLoadBalancerRuleConfig `
-Name 'myLoadBalancerRuleWeb' `
-Protocol Tcp `
-Probe $probe `
-FrontendPort 80 `
-BackendPort 80 `
-FrontendIpConfiguration $feip `
-BackendAddressPool $bepool

# Create the necessary NAT rules
$natrule1 = New-AzLoadBalancerInboundNatRuleConfig `
-Name 'myLoadBalancerRDP1' `
-FrontendIpConfiguration $feip `
-Protocol tcp `
-FrontendPort 4221 `
-BackendPort 3389

$natrule2 = New-AzLoadBalancerInboundNatRuleConfig `
-Name 'myLoadBalancerRDP2' `
-FrontendIpConfiguration $feip `
-Protocol tcp `
-FrontendPort 4222 `
-BackendPort 3389

$natrule3 = New-AzLoadBalancerInboundNatRuleConfig `
-Name 'myLoadBalancerRDP3' `
-FrontendIpConfiguration $feip `
-Protocol tcp `
-FrontendPort 4223 `
-BackendPort 3389

# Create the Load Balancer
New-AzLoadBalancer `
-ResourceGroupName $resource `
-Name 'myLoaBalancer' `
-Sku Standard `
-Location $location `
-FrontendIpConfiguration $feip `
-BackendAddressPool $bepool `
-Probe $probe `
-LoadBalancingRule $rule `
-InboundNatRule $natrule1,$natrule2,$natrule3