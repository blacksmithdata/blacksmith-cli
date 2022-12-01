#!/bin/sh

#if [ $# -eq 0 ]
#then
#  echo 
#  echo "Supply the Blacksmith CLI version to install"
#  echo
#  echo "e.g: ./blacksmith-cli-install.sh 0.1.0-alpha"
#  echo
#  echo	
#  exit 1
#fi

latestVersion=0.6.1-alpha
tag=0.x
localAppFolder=/usr/local
blacksmithAppBin=/usr/local/bin/blacksmith-cli
blacksmithAppFolder=/usr/local/blacksmith
urlTag=v$tag
url=https://github.com/blacksmithdata/blacksmith-cli/archive/refs/tags/$urlTag
platform=osx-x64
downloadFolder=~/Downloads
fullUrl=$url"/"v$latestVersion.tar.gz
blacksmithInstallFolder=$downloadFolder"/"blacksmith-cli-install-temp
downloadedRootFolder=$blacksmithInstallFolder"/"blacksmith-cli-$tag-v$latestVersion
platformFolder=$downloadedRootFolder"/"$platform
publicFolder=$downloadedRootFolder"/"$platform"/"$latestVersion"/"public


echo ----- BEGIN STEPS....

echo ----- STEP 1: CLEANUP INSTALL INSTALL FOLDER
rm -rf $blacksmithInstallFolder
mkdir $blacksmithInstallFolder
cd $blacksmithInstallFolder

echo ----- STEP 2: DOWNLOAD CLI FROM GITHUB
#https://github.com/blacksmithdata/blacksmith-cli/archive/refs/tags/v0.x/v0.5.0-alpha.tar.gz
curl -L $fullUrl | tar xz

echo ----- STEP 3: MAKE FLAT FOLDER
mv "/"$publicFolder"/"* $blacksmithInstallFolder"/"*

echo ----- STEP 4: DELETE TEMP FOLDERS AND FILES
rm -rf $platformFolder"/"
rm $downloadedRootFolder"/"*.md

echo ----- STEP 5: RENAME ROOT FOLDER
mv $downloadedRootFolder $blacksmithInstallFolder"/"blacksmith

echo ----- STEP 6: BACKUP '/usr/local/blacksmith-cli' to '/usr/local/blacksmith-cli-bak'
rm -rf $localAppFolder"/"blacksmith"-"bak"/"
mv $blacksmithAppFolder $localAppFolder"/"blacksmith"-"bak

echo ----- STEP 7: COPY 'blacksmith-cli' FOLDER TO '/usr/local/blacksmith-cli'
mv $blacksmithInstallFolder"/"blacksmith $blacksmithAppFolder

echo ----- STEP 8: REAPPLY SYMLINK
rm $blacksmithAppBin
ln -s $blacksmithAppFolder"/"blacksmith-cli $blacksmithAppBin

echo
echo Install competed
echo Close your terminal or create a new one to ensure the cli works
