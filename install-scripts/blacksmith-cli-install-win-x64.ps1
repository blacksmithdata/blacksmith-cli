# Define the version to install as the first argument
if ($args.Length -eq 0) {
  Write-Host ""
  Write-Host "Supply the Blacksmith CLI version to install"
  Write-Host ""
  Write-Host "e.g: v0.6.5-alpha"
  Write-Host ""
  exit 1
}

$toInstallVersion = $args[0]
Write-Host "Installing $toInstallVersion..."

$platform = "win-x64"
$localAppFolder = "C:\Program Files\Blacksmith"
$blacksmithAppBin = Join-Path -Path $localAppFolder -ChildPath "blacksmith-cli"
$blacksmithAppFolder = Join-Path -Path $localAppFolder -ChildPath "blacksmith"

$url = "https://github.com/blacksmithdata/blacksmith-cli/releases/download/$toInstallVersion/$toInstallVersion-$platform.zip"
$blacksmithInstallFolder = Join-Path -Path $env:USERPROFILE -ChildPath "Downloads\blacksmith-cli-install-temp"

Write-Host "----- BEGIN INSTALLATION ...."

Write-Host ""
Write-Host "----- STEP 1: CLEANUP INSTALL FOLDER"
Remove-Item -Path $blacksmithInstallFolder -Force -Recurse
New-Item -Path $blacksmithInstallFolder -ItemType Directory | Out-Null
Set-Location -Path $blacksmithInstallFolder

Write-Host ""
Write-Host "----- STEP 2: DOWNLOAD BLACKSMITH CLI"
Invoke-WebRequest -Uri $url -OutFile "$toInstallVersion-$platform.zip"
Expand-Archive -Path "$toInstallVersion-$platform.zip"

Write-Host ""
Write-Host "----- STEP 3: PROCESS FOLDER STRUCTURE"
Write-Host "THE FOLDER $toInstallVersion"
Rename-Item -Path $toInstallVersion -NewName "blacksmith"

Write-Host ""
Write-Host "----- STEP 4: PREPARE CLI DESTINATION FOLDER"
Move-Item -Path $blacksmithAppFolder -Destination (Join-Path -Path $localAppFolder -ChildPath "blacksmith-old") -Force
Move-Item -Path "blacksmith" -Destination $blacksmithAppFolder -Force

Write-Host ""
Write-Host "----- STEP 5: DELETE CACHE FOLDER"
Remove-Item -Path (Join-Path -Path $localAppFolder -ChildPath "blacksmith-old") -Force -Recurse
Set-Location -Path $env:USERPROFILE
Remove-Item -Path $blacksmithInstallFolder -Force -Recurse

Write-Host ""
Write-Host "----- STEP 6: APPLY SYMLINK"
Remove-Item -Path $blacksmithAppBin -Force
New-Item -ItemType SymbolicLink -Path $blacksmithAppBin -Value (Join-Path -Path $blacksmithAppFolder -ChildPath "blacksmith-cli")

Write-Host ""
Write-Host ""
Write-Host "Install completed. To get started, type blacksmith-cli"
Write-Host ""
