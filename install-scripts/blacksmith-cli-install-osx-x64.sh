#!/bin/sh

#  sudo curl -s https://raw.githubusercontent.com/blacksmithdata/blacksmith-cli/master/install-scripts/blacksmith-cli-install.sh | sudo bash -s 0.6.1-alpha
#  sudo curl -s https://raw.githubusercontent.com/blacksmithdata/blacksmith-cli/master/install-scripts/blacksmith-cli-uninstall.sh | sudo bash

if [ $# -eq 0 ]
then
  echo 
  echo "Supply the Blacksmith CLI version to install"
  echo
  echo "e.g: v0.6.5-alpha"
  echo
  exit 1	
fi

toInstallVersion=$1
echo Installing $toInstallVersion...

platform=osx-x64
localAppFolder=/usr/local
blacksmithAppBin=/usr/local/bin/blacksmith-cli
blacksmithAppFolder=/usr/local/blacksmith

url=https://github.com/blacksmithdata/blacksmith-cli/releases/download/$toInstallVersion/$toInstallVersion-$platform.tar.gz
blacksmithInstallFolder=~/Downloads//blacksmith-cli-install-temp

echo ----- BEGIN INSTALLATION ....

echo
echo ----- STEP 1: CLEANUP INSTALL FOLDER
rm -rf $blacksmithInstallFolder
mkdir $blacksmithInstallFolder
cd $blacksmithInstallFolder-$platform

echo
echo ----- STEP 2: DOWNLOAD BLACKSMITH CLI
curl -L $url | tar xz

echo
echo ----- STEP 3: PROCESS FOLDER STRUCTURE
echo THE FOLDER $toInstallVersion-$platform
mv $toInstallVersion-$platform blacksmith

echo
echo ----- STEP 4: PREPARE CLI DESTINATION FOLDER
mv $blacksmithAppFolder /usr/local/blacksmith-old
mv blacksmith $blacksmithAppFolder

echo
echo ----- STEP 5: DELETE CACHE FOLDER
rm -rf /usr/local/blacksmith-old
cd ~/
rm -rf blacksmithInstallFolder/

echo
echo ----- STEP 6: APPLY SYMLINK
rm $blacksmithAppBin
ln -s $blacksmithAppFolder"/"blacksmith-cli $blacksmithAppBin

echo
echo
echo Install completed. To get started, type blacksmith-cli
echo
