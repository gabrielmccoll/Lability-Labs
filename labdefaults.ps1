# This only has to be done once as the settings will be saved to disk, as
# C:\ProgramData\Lability\Config\CustomMedia.json and C:\ProgramData\Lability\Config\VmDefaults.json
# (Some of these are the default values already)

# General Lability settings.
$LabHostDefaults = @{
    # You may have to manually create these directories ahead of time

    # Where our .MOF files willbe taken from
    ConfigurationPath       = 'C:\Lability\Configurations'
    # Where to create our differencing disks and snapshots are stored
    DifferencingVhdPath     = 'C:\Lability\VMVirtualHardDisks'
    # Any hotfixes we wish to cache and install on our VMs
    HotfixPath              = 'C:\Lability\Hotfixes'
    # Where the ISOs for our media are stored/taken from
    IsoPath                 = 'C:\Lability\ISOs'
    # Where we store the 'master' VHDs
    ParentVhdPath           = 'C:\Lability\MasterVirtualHardDisks'
    # Where we store any resources we want to inject into our VHDs
    ResourcePath            = 'C:\Lability\Resources'

    ResourceShareName       = 'Resources'
    DisableLocalFileCaching = 'False'
    EnableCallStackLogging  = 'False'
}

# Default settings for VMs, if not explicitly specified.
$LabVMDefaults = @{
    # The amount of memory allocated on VM startup
    StartupMemory            = 2gb
    # Minimum memory (Using dynamic memory)
    MinimumMemory            = 2gb
    # Max memory (Using dynamic memory)
    MaximumMemory            = 3.5gb
    # Amount of virtual processor cores to allocate
    ProcessorCount           = 2
    # Which Hyper-V switch(es) to assign
    SwitchName               = 'LAB-External'
    # The default media to create the VM from
    Media                    = '2016_x64_Datacenter_EN_Eval'
    # Settings to inject into the VM's autounattend.xml file, which
    # will be use to configure the base OS
    TimeZone                 = 'UTC'
    UILanguage               = 'en-US'
    SystemLocale             = 'en-GB'
    InputLocale              = '0809:00000809'
    UserLocale               = 'en-GB'
    RegisteredOwner          = 'Lability'
    RegisteredOrganization   = 'Virtual Engine'
    # Certificate to use for DSC communication.
    # Lability comes with default certificates, but obviously this makes it insecure...
    # however, this is a **LAB** environment so security is of much less importance,
    # as we shouldn't be using production systems & credentials
    ClientCertificatePath    = 'C:\ProgramData\Lability\Certificates\LabClient.pfx'
    RootCertificatePath      = 'C:\ProgramData\Lability\Certificates\LabRoot.cer'
    # Boot delay in seconds
    BootDelay                = '0'
    # Custom boot order
    CustomBootstrapOrder     = 'MediaFirst'
    # Toggle secure boot
    SecureBoot               = $true
    # Install Hyper-V guest integration services
    GuestIntegrationServices = $true
}

#Set-LabHostDefault @LabHostDefaults
Set-LabVMDefault @LabVMDefaults