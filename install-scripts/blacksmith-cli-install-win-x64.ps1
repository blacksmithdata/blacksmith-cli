# Specify the Blacksmith CLI version to install
if ($args.Count -eq 0) {
  Write-Host "Supply the Blacksmith CLI version to install"
  Write-Host "e.g: v0.6.5-alpha"
  exit 1
}

$toInstallVersion = $args[0]
Write-Host "Installing $toInstallVersion..."

# Define variables
$platform = "win-x64"
# $localAppFolder = "C:\Program Files\Blacksmith"
$blacksmithAppFolder = "C:\Program Files\Blacksmith"
#$blacksmithCliApp = "$blacksmithAppFolder\blacksmith-cli.exe"


$url = "https://github.com/blacksmithdata/blacksmith-cli/releases/download/$toInstallVersion/$toInstallVersion-$platform.zip"
$blacksmithInstallFolder = Join-Path $env:USERPROFILE "Downloads\blacksmith-cli-install-temp"

Write-Host "----- BEGIN INSTALLATION ...."

# STEP 1: CLEANUP INSTALL FOLDER
Write-Host ""
Write-Host "----- STEP 1: CLEANUP INSTALL FOLDER"
Remove-Item -Path $blacksmithInstallFolder -Recurse -Force
New-Item -Path $blacksmithInstallFolder -ItemType Directory | Out-Null
Set-Location -Path $blacksmithInstallFolder

# STEP 2: DOWNLOAD BLACKSMITH CLI
Write-Host ""
Write-Host "----- STEP 2: DOWNLOAD BLACKSMITH CLI"
Invoke-WebRequest -Uri $url -OutFile "$toInstallVersion-$platform.zip"
Expand-Archive -Path "$toInstallVersion-$platform.zip" -DestinationPath $toInstallVersion

# STEP 3: PROCESS FOLDER STRUCTURE
Write-Host ""
Write-Host "----- STEP 3: PROCESS FOLDER STRUCTURE"
Write-Host "THE FOLDER $toInstallVersion"
Rename-Item -Path $toInstallVersion -NewName "blacksmith"

###########################
# STEP 4: PREPARE CLI DESTINATION FOLDER
Write-Host ""
Write-Host "----- STEP 4: PREPARE CLI DESTINATION FOLDER"
Move-Item -Path $blacksmithAppFolder -Destination "C:\Program Files\blacksmith-old" -Force
Move-Item -Path "blacksmith" -Destination $blacksmithAppFolder -Force
New-Item -Path $blacksmithAppFolder -ItemType Directory | Out-Null
###########################

###########################
# STEP 5: DELETE CACHE FOLDER
Write-Host ""
Write-Host "----- STEP 5: DELETE CACHE FOLDER"
Remove-Item -Path "C:\Program Files\blacksmith-old" -Recurse -Force
Set-Location -Path $env:USERPROFILE
Remove-Item -Path $blacksmithInstallFolder -Recurse -Force
###########################

###########################
# STEP 6: APPLY SYMLINK (NOT APPLICABLE FOR WINDOWS OS)
# Write-Host ""
# Write-Host "----- STEP 6: APPLY SYMLINK"
# Remove-Item -Path $blacksmithAppBin -Force
# New-Item -ItemType SymbolicLink -Path $blacksmithAppBin -Target "$blacksmithAppFolder\blacksmith-cli.exe"
###########################

Write-Host ""
Write-Host "Install completed. To get started, type blacksmith-cli"
Write-Host ""
