# Set Up

<#
.SYNOPSIS
Safe installs a Powershell module.

.PARAMETER m
Module Name
#>
function Invoke-Custom-IPMO ($name) {

    # If module is imported say that and do nothing
    if (Get-Module | Where-Object { $_.Name -eq $name }) {
        write-host "Module $m is already imported."
    }
    else {

        # If module is not imported, but available on disk then import
        if (Get-Module -ListAvailable | Where-Object { $_.Name -eq $name }) {
            Import-Module $name -Verbose
        }
        else {

            # If module is not imported, not available on disk, but is in online gallery then install and import
            if (Find-Module -Name $name | Where-Object { $_.Name -eq $name }) {
                Install-Module -Name $name -Force -Verbose -Scope CurrentUser
                Import-Module $name -Verbose
            }
            else {

                # If the module is not imported, not available and not in the online gallery then abort
                write-host "Module $name not imported, not available and not in an online gallery, exiting."
                EXIT 1
            }
        }
    }
}

## Trust PSGallery
#Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

#Install MSAL
# Get-InstalledModule -Name "MSAL.PS"
# Install-Module -Name MSAL.PS
# if (Get-Module -ListAvailable -Name SomeModule) {
#     Write-Host "Module exists"
# } 
# else {
#     Write-Host "Module does not exist"
#}

Invoke-Custom-IPMO "MSAL.PS"

# Clean Up
## Trust PSGallery
#Set-PSRepository -Name "PSGallery" -InstallationPolicy Untrusted
