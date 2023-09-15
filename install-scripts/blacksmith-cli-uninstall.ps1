# Set variables
$localAppFolder = "C:\Program Files"  # Adjust the path as needed
$blacksmithAppBin = "C:\Program Files\blacksmith-cli"  # Adjust the path as needed
$blacksmithAppFolder = "C:\Program Files\blacksmith"  # Adjust the path as needed

# Output beginning message
Write-Host "----- BEGIN STEPS...."

# Step 1: Delete symlink (if it exists)
Write-Host "----- STEP 1: DELETE SYMLINK" DOES NOT APPLY TO WINDOWS OS
# if (Test-Path $blacksmithAppBin -PathType SymbolicLink) {
#     Remove-Item -Path $blacksmithAppBin -Force
# }

# Step 2: Delete local app folders
Write-Host "----- STEP 2: DELETE LOCAL APP FOLDER"
if (Test-Path "$localAppFolder\blacksmith-bak") {
    Remove-Item -Path "$localAppFolder\blacksmith-bak" -Recurse -Force
}

if (Test-Path "$localAppFolder\blacksmith") {
    Remove-Item -Path "$localAppFolder\blacksmith" -Recurse -Force
}

# Output completion message
Write-Host ""
Write-Host "Uninstall completed."
Write-Host ""
