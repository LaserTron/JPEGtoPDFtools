#!/bin/bash
outputname=$1
sourcedir="ENTER-REMOVABLE-MEDIA-DIRECTORY-HERE"
dt="`date +"%Y-%m-%d %R"`"
targetdir="./inbox"
echo "Moving images from media"
mv -v $sourcedir/* $targetdir
./jpgstopdfs.sh $outputname
echo "emptying and archiving inbox"
mkdir "./archive/$dt"
mv $targetdir/* "./archive/$dt"
