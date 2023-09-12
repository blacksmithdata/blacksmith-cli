# Specify the Blacksmith CLI version to install
if ($args.Length -eq 0) {
  Write-Host "Supply the Blacksmith CLI version to install"
  Write-Host "e.g: v0.6.5-alpha"
  exit 1
}

$toInstallVersion = $args[0]
Write-Host "Installing $toInstallVersion..."

$localAppFolder = "C:\Program Files\Blacksmith"
$blacksmithAppBin = "C:\Program Files\Blacksmith\blacksmith-cli.exe"
$blacksmithAppFolder = "C:\Program Files\Blacksmith"

$url = "https://github.com/blacksmithdata/blacksmith-cli/releases/download/$toInstallVersion/$toInstallVersion.zip"
$blacksmithInstallFolder = "C:\Users\$env:USERNAME\Downloads\blacksmith-cli-install-temp"

Write-Host "----- BEGIN INSTALLATION ...."

Write-Host ""
Write-Host "----- STEP 1: CLEANUP INSTALL FOLDER"
Remove-Item -Path $blacksmithInstallFolder -Force -Recurse
New-Item -Path $blacksmithInstallFolder -ItemType Directory | Out-Null
Set-Location -Path $blacksmithInstallFolder

Write-Host ""
Write-Host "----- STEP 2: DOWNLOAD BLACKSMITH CLI"
Invoke-WebRequest -Uri $url -OutFile "$toInstallVersion.zip"
Expand-Archive -Path "$toInstallVersion.zip" -DestinationPath . -Force

Write-Host ""
Write-Host "----- STEP 3: PROCESS FOLDER STRUCTURE"
Rename-Item -Path $toInstallVersion -NewName "blacksmith"

Write-Host ""
Write-Host "----- STEP 4: PREPARE CLI DESTINATION FOLDER"
Rename-Item -Path $blacksmithAppFolder -NewName "blacksmith-old" -Force
Rename-Item -Path "blacksmith" -NewName $blacksmithAppFolder -Force

Write-Host ""
Write-Host "----- STEP 5: DELETE CACHE FOLDER"
Remove-Item -Path "blacksmith-old" -Force -Recurse

Write-Host ""
Write-Host "----- STEP 6: APPLY SYMLINK"
Remove-Item -Path $blacksmithAppBin
New-Item -Path $blacksmithAppBin -ItemType SymbolicLink -Value "$blacksmithAppFolder\blacksmith-cli.exe"

Write-Host ""
Write-Host ""
Write-Host "Install completed. To get started, type blacksmith-cli"
