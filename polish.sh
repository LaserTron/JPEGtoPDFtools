#!/bin/bash

file="$1"
filename="`basename "$1"`"
echo "Polishing $filename"
dt="`date +"%Y-%m-%d %H:%M:%S"`"
mkdir "./archive/$dt"
echo "Archiving $file to:"
echo "archive/$dt"
cp "$file" "./archive/$dt"
mv "$file" "./workbox"
cd workbox
echo "Bursting .pdf"
pdftk "$filename" burst
echo "Converting to .jpg"
for i in pg*.pdf
do
    echo "Converting $i"
    convert -density 300 $i -quality 90 `basename $i .pdf`.jpg
done

for i in pg*.jpg
do
    echo "Filling black borders and polishing $i ..."
    mogrify -density 300 -normalize -level 15%,85% $i
    mogrify -border 8 -bordercolor black $i
    mogrify -fuzz 20% -fill white -floodfill +0+0 black $i
    mogrify -shave 8 $i
done
rm "$filename"
echo "Rebuilding pdf"
cd ..
mv ./workbox/*.jpg ./imgtopdf
rm ./workbox/*
sh jpgstopdfs.sh "$filename"
