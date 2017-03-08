#!/bin/bash
outputname=$1
sourcedir="ENTER-REMOVABLE-MEDIA-DIRECTORY-HERE"
targetdir="./inbox"
echo "Moving images from media"
mv -v $sourcedir/* $targetdir
./jpgstopdfs.sh $outputname
echo "emptying inbox"
rm $targetdir/*
