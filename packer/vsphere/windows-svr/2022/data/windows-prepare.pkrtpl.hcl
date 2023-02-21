<#
    .DESCRIPTION
    Prepares a Windows guest operating system.
#>

param(
    [string] $BUILD_USERNAME = $env:BUILD_USERNAME
)

$ErrorActionPreference = "silentlycontinue"

# Optional: Import the Root CA certificate to the Trusted Root Certification Authorities.
# This option will require the use of a file provisioner to copy the certificate to the guest.
# Write-Output "Importing the Root CA certificate to the Trusted Root Certification Authorities..."
# Import-Certificate -FilePath C:\windows\temp\root-ca.cer -CertStoreLocation 'Cert:\LocalMachine\Root' | Out-Null
# Remove-Item C:\windows\temp\root-ca.cer -Confirm:$false

# Optional: Import the Issuing CA certificate to the Trusted Root Certification Authoriries.
# This option will require the use of a file provisioner to copy the certificate to the guest.
# Write-Output "Importing the Issuing CA certificate to the Trusted Root Certification Authoriries..."
# Import-Certificate -FilePath C:\windows\temp\issuing-ca.cer -CertStoreLocation 'Cert:\LocalMachine\CA' | Out-Null
# Remove-Item C:\windows\temp\issuing-ca.cer -Confirm:$false

# Set the Windows Explorer options.
Write-Output "Setting the Windows Explorer options..."
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 | Out-Null
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 | Out-Null
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideDrivesWithNoMedia" -Value 0 | Out-Null
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Value 0 | Out-Null

# Disable system hibernation.
Write-Output "Disabling system hibernation..."
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Power\" -Name "HiberFileSizePercent" -Value 0 | Out-Null
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Power\" -Name "HibernateEnabled" -Value 0 | Out-Null

# Disable TLS 1.0.s
Write-Output "Disabling TLS 1.0..."
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols" -Name "TLS 1.0" | Out-Null
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0" -Name "Server" | Out-Null
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0" -Name "Client" | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "Enabled" -Value 0 | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "DisabledByDefault" -Value 1 | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "Enabled" -Value 0 | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "DisabledByDefault" -Value 1 | Out-Null

# Disable TLS 1.1.
Write-Output "Disabling TLS 1.1..."
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols" -Name "TLS 1.1" | Out-Null
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1" -Name "Server" | Out-Null
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1" -Name "Client" | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "Enabled" -Value 0 | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "DisabledByDefault" -Value 1 | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "Enabled" -Value 0 | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "DisabledByDefault" -Value 1 | Out-Null

# Disable Password Expiration for the Administrator Accounts - (Administrator and Build)
Write-Output "Disabling password expiration for the local Administrator accounts..."
$localAdministrator = (Get-LocalUser | Where-Object { $_.sid -like '*-500' }).name
Set-LocalUser -Name $localAdministrator -PasswordNeverExpires $true
Set-LocalUser -Name $BUILD_USERNAME -PasswordNeverExpires $true

# Enable Remote Desktop.
Write-Output "Enabling Remote Desktop..."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0 | Out-Null
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 0
Enable-NetFirewallRule -Group '@FirewallAPI.dll,-28752'

#Eanble openssh
Write-Output "Enabling Openssh"
Add-WindowsCapability -Online -Name OpenSSH.Server
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
Set-Content -Path c:\ProgramData\ssh\sshd_config -Value (get-content -Path c:\ProgramData\ssh\sshd_config | Select-String -Pattern 'Match Group administrators' -NotMatch | Select-String -Pattern "__PROGRAMDATA__/ssh/administrators_authorized_keys" -NotMatch)
New-Item -ItemType Directory -Path "C:\Users\ansible\.ssh"
New-Item -ItemType File "C:\Users\ansible\.ssh\authorized_keys"
Add-Content C:\Users\ansible\.ssh\authorized_keys "${build_key}"
Icacls C:\Users\ansible\.ssh\authorized_keys /remove "NT SERVICE\sshd"
