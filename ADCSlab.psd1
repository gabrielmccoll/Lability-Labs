#http://www.absolutejam.co.uk/blog/lability-ultimate-hyperv-lab-tool/
@{
  AllNodes = @(
      # All nodes
      @{
          NodeName                  = '*'
          DomainName                = 'Lab.local'

          # Networking
          Lability_SwitchName       = 'LAB-Private'
          DefaultGateway            = '10.0.0.254'
          SubnetMask                = 24
          AddressFamily             = 'IPv4'
          DnsServerAddress          = '10.0.0.1'
          DnsConnectionSuffix       = 'Lab.local'

          # DSC related
          PSDscAllowPlainTextPassword = $true
          PSDscAllowDomainUser      = $true            # Removes 'It is not recommended to use domain credential for node X' messages

      }

      # DC01
      @{
          # Basic details
          NodeName                  = 'DC01'
          Lability_ProcessorCount   = 2
          Role                      = 'DC'
          Lability_Media            = '2012R2_x64_Standard_EN_V5_Eval'

          # Networking
          IPAddress                 = '10.0.0.1'
          DnsServerAddress          = '127.0.0.1'

          # Lability extras
          Lability_CustomBootstrap  = @'

'@
      }

      # CLIENT01
      @{
          # Basic details
          NodeName                  = 'CLIENT01'
          Lability_StartupMemory    = 2gb
          Role                      = 'Client'
          Media                     = 'WIN81_x64_Enterprise_EN_V5_Eval'

          # Lability extras
          Lability_CustomBootStrap = @'
              net user Administrator /active:yes     ## Enable local administrator account
              Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine -Force
              Enable-PSRemoting -SkipNetworkProfileCheck -Force
'@
      }
  )

  NonNodeData = @{
      OrganisationName = 'Lab'

      Lability = @{
          # Prefix all of our VMs with 'LAB-' in Hyper-V
          EnvironmentPrefix         = 'LAB-'

          Network = @(
              @{
                  Name              = 'LAB-External'
                  Type              = 'External'
                  NetadapterName    = 'Ethernet'
                  AllowManagementOS = $true
              }
          )

          DSCResource = @(
              @{ Name = 'xComputerManagement'; MinimumVersion = '1.3.0.0'; Provider = 'PSGallery' }
              @{ Name = 'xNetworking'; MinimumVersion = '2.7.0.0' }
              @{ Name = 'xActiveDirectory'; MinimumVersion = '2.9.0.0' }
              @{ Name = 'xDnsServer'; MinimumVersion = '1.5.0.0' }
              @{ Name = 'xDhcpServer'; MinimumVersion = '1.3.0.0' }
          )

          Media = @()

      }
  }
}