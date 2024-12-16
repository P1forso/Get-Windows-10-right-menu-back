# PowerShell Script to Enable the Old Context Menu in Windows 11

# Function to create a registry key and set a default value to blank
function Set-RegistryKey {
    param (
        [string]$Path,
        [string]$KeyName
    )

    # Create the registry key if it does not exist
    if (-not (Test-Path "$Path\$KeyName")) {
        New-Item -Path $Path -Name $KeyName -Force | Out-Null
    }

    # Set the default value to blank
    Set-ItemProperty -Path "$Path\$KeyName" -Name "(Default)" -Value "" -Force
}

# Registry base path
$RegistryBasePath = "HKCU:\SOFTWARE\CLASSES\CLSID"

# Key to be created
$KeyName1 = "{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"
$KeyName2 = "InprocServer32"

# Full path for the first key
$FullKeyPath1 = "$RegistryBasePath\$KeyName1"

# Create the first key
if (-not (Test-Path $FullKeyPath1)) {
    New-Item -Path $RegistryBasePath -Name $KeyName1 -Force | Out-Null
}

# Create the second key and set the default value to blank
Set-RegistryKey -Path $FullKeyPath1 -KeyName $KeyName2

# Inform the user
Write-Host "Registry changes applied. Please restart your computer for the changes to take effect." -ForegroundColor Green
