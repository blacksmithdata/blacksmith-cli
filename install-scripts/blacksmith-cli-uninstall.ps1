# Define variables
$localAppFolder = "C:\Program Files\blacksmith" # You can change this to your desired installation folder
$blacksmithAppBin = "C:\Program Files\blacksmith\blacksmith-cli.exe" # You can change this to the actual path to the executable
$blacksmithAppFolder = "C:\Program Files\blacksmith" # You can change this to your desired installation folder

# Display the beginning of the steps
Write-Host "----- BEGIN STEPS...."

# STEP 1: DELETE SYMLINK
if (Test-Path $blacksmithAppBin) {
    Remove-Item $blacksmithAppBin -Force
    Write-Host "----- STEP 1: Deleted symlink"
} else {
    Write-Host "----- STEP 1: Symlink not found, skipping deletion"
}

# STEP 2: DELETE LOCAL APP FOLDER
if (Test-Path $localAppFolder) {
    Remove-Item $localAppFolder -Recurse -Force
    Write-Host "----- STEP 2: Deleted local app folder"
} else {
    Write-Host "----- STEP 2: Local app folder not found, skipping deletion"
}

# Display completion message
Write-Host ""
Write-Host "Uninstall completed."
Write-Host ""
