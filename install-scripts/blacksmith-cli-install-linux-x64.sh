#!/bin/bash

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

platform=linux-x64
localAppFolder=/usr/local
blacksmithAppBin=/usr/local/bin/blacksmith-cli
blacksmithAppFolder=/usr/local/blacksmith
blacksmithAppBinOldFolder=/usr/local/blacksmith-old
blacksmithInstallFolder=~/blacksmith-cli-download

url=https://github.com/blacksmithdata/blacksmith-cli/releases/download/$toInstallVersion/$toInstallVersion-$platform.tar.gz

echo ----- BEGIN INSTALLATION ....
echo

# ====================================
echo ----- STEP 1: CLEANUP INSTALL FOLDER
if [[ -d $blacksmithInstallFolder ]]; then
    echo "Directory already exists, do cleanup..."
    rm -fr $blacksmithInstallFolder
fi

mkdir $blacksmithInstallFolder
echo "Directory created"

cd $blacksmithInstallFolder
# ====================================

echo

# ====================================
echo ----- STEP 2: DOWNLOAD BLACKSMITH CLI
curl -L $url | tar xz
# ====================================

echo

# ====================================
echo ----- STEP 3: PROCESS FOLDER STRUCTURE
echo THE FOLDER $toInstallVersion
mv $toInstallVersion blacksmith
# ====================================

echo

# ====================================
echo ----- STEP 4: PREPARE CLI DESTINATION FOLDER
if [[ -d $blacksmithAppFolder ]]; then
  mv $blacksmithAppFolder $blacksmithAppBinOldFolder
fi
mv blacksmith $blacksmithAppFolder
# ====================================

echo

# ====================================
echo ----- STEP 5: DELETE CACHE FOLDER
rm -rf $blacksmithAppBinOldFolder
cd ~/
rm -rf $blacksmithInstallFolder
# ====================================

echo

# ====================================
echo ----- STEP 6: APPLY SYMLINK
rm $blacksmithAppBin
ln -s $blacksmithAppFolder"/"blacksmith-cli $blacksmithAppBin
# ====================================

echo
echo
echo Install completed. To get started, type blacksmith-cli