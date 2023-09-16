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
$blacksmithAppFolder = "C:\Program Files\Blacksmith"
$blacksmithAppFolderOld = "C:\Program Files\Blacksmith-Old"
$url = "https://github.com/blacksmithdata/blacksmith-cli/releases/download/$toInstallVersion/$toInstallVersion-$platform.zip"
$blacksmithInstallFolder = Join-Path $env:USERPROFILE "Downloads\blacksmith-cli-install-temp"

Write-Host "----- BEGIN INSTALLATION ...."

# STEP 1: CLEANUP INSTALL FOLDER
Write-Host ""
Write-Host "----- STEP 1: CLEANUP INSTALL FOLDER"
if (Test-Path $blacksmithInstallFolder) {
  Remove-Item -Path $blacksmithInstallFolder -Recurse -Force
}

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
if (Test-Path $blacksmithAppFolder) {
  Move-Item -Path $blacksmithAppFolder -Destination $blacksmithAppFolderOld -Force
}

Move-Item -Path "blacksmith" -Destination $blacksmithAppFolder -Force
# New-Item -Path $blacksmithAppFolder -ItemType Directory | Out-Null
###########################

###########################
# STEP 5: DELETE CACHE FOLDER
Write-Host ""
Write-Host "----- STEP 5: DELETE CACHE FOLDER"
if (Test-Path $blacksmithAppFolderOld) {
  Remove-Item -Path $blacksmithAppFolderOld -Recurse -Force
}

Set-Location -Path $env:USERPROFILE\"Downloads"
Remove-Item -Path $blacksmithInstallFolder -Recurse -Force
###########################

###########################
# STEP 6: APPLY PATH IN ENV VARIABLES FOR THE LOGGEDIN USER
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)

# Check if the folder exists in the Path variable
if ($currentPath -like "*$blacksmithAppFolder*") {    
    Write-Host "Path $blacksmithAppFolder already exists."
} else {
    Write-Host "Path $blacksmithAppFolder does not exists, adding it..."
    $newPath = "$currentPath;$blacksmithAppFolder"
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::User)
    Write-Host "Path $blacksmithAppFolder added to user's path..."
}
###########################

Write-Host ""
Write-Host "Install completed. Close all your terminal and launch again."
Write-Host "To get started, type blacksmith-cli or blacksmith-cli.exe"
Write-Host ""