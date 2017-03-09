#!/bin/bash

file="$1"
filename="`basename "$1"`"
echo "Polishing $filename"
dt="`date +"%Y-%m-%d %R"`"
mkdir "./archive/$dt"
cp "$file" "./archive/$dt"
mv "$file" "./workbox"
cd workbox
echo "Bursting .pdf"
pdftk "$filename" burst
echo "Polishing pages..."
echo "Converting to .jpg"
for i in pg*.pdf
do
    echo "Converting $i"
    convert -density 300 $i -quality 80 `basename $i .pdf`.jpg
done
echo "Polishing"
for i in pg*.jpg
do
    echo "Polishing $i ..."
    mogrify -density 300 -normalize -level 10%,90% $i
done
rm "$filename"
echo "Rebuilding pdf"
cd ..
mv ./workbox/*.jpg ./inbox
rm ./workbox/*
sh jpgstopdfs.sh "$filename"
