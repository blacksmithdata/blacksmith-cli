#!/bin/sh

localAppFolder=/usr/local
blacksmithAppBin=/usr/local/bin/blacksmith-cli
blacksmithAppFolder=/usr/local/blacksmith

echo ----- BEGIN STEPS....

echo ----- STEP 1: DELETE SYMLINK
rm $blacksmithAppBin

echo ----- STEP 2: DELETE LOCAL APP FOLDER
rm -rf $localAppFolder"/"blacksmith"-"bak"/"
rm -rf $localAppFolder"/"blacksmith"/"

echo
echo Uninstall completed.
echo
