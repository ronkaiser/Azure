# Create SQL server
New-AzSqlServer `
  -ResourceGroupName $resource `
  -Location $location `
  -ServerName $name `
  -ServerVersion '12.0' `
  -SqlAdministratorCredentials (Get-Credential)

 # Create SQL database
 New-AzSqlDatabase -ResourceGroupName $resource -ServerName $name -DatabaseName 'Database01'