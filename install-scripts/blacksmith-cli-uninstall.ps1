# Set variables
$localAppFolder = "C:\Program Files"                    # Adjust the path as needed
$blacksmithAppFolder = "$localAppFolder\Blacksmith"     # Adjust the path as needed

# Output beginning message
Write-Host "----- BEGIN STEPS...."

###########################
# STEP 1: DELETE PATH IN ENV VARIABLES FOR THE LOGGEDIN USER
Write-Host "----- STEP 1: DELETE PATH IN ENV VARIABLES FOR THE LOGGEDIN USER"
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
# Check if the folder exists in the Path variable
if ($currentPath -like "*$blacksmithAppFolder*") {    
    $newPath = $currentPath -replace [regex]::Escape($blacksmithAppFolder), ""
    $newPath = $newPath -replace ";;", ";"
    
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::User)
}
###########################

###########################
# Step 2: Delete local app folders
Write-Host "----- STEP 2: DELETE LOCAL APP FOLDER"
if (Test-Path "$localAppFolder\blacksmith-bak") {
    Remove-Item -Path "$localAppFolder\blacksmith-bak" -Recurse -Force
}

if (Test-Path $blacksmithAppFolder) {
    Remove-Item -Path $blacksmithAppFolder -Recurse -Force
}
###########################

# Output completion message
Write-Host ""
Write-Host "Uninstall completed."
Write-Host ""
