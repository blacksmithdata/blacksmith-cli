# Set variables
$localAppFolder = "/usr/local"
$blacksmithAppBin = "/usr/local/bin/blacksmith-cli"
$blacksmithAppFolder = "/usr/local/blacksmith"

# Output beginning message
Write-Host "----- BEGIN STEPS...."

# Step 1: Delete symlink
Write-Host "----- STEP 1: DELETE SYMLINK"
Remove-Item -Path $blacksmithAppBin -Force

# Step 2: Delete local app folders
Write-Host "----- STEP 2: DELETE LOCAL APP FOLDER"
Remove-Item -Path "$localAppFolder/blacksmith-bak" -Recurse -Force
Remove-Item -Path "$localAppFolder/blacksmith" -Recurse -Force

# Output completion message
Write-Host ""
Write-Host "Uninstall completed."
Write-Host ""
