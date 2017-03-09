#!/bin/bash

filename=$1
dt="`date +"%Y-%m-%d %R"`"
mkdir "./archive/$dt"
cp $filename "./archive/$dt"
mv $filename "./workbox"
cd workbox
echo "Bursting .pdf"
pdftk $filename burst
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
rm $filename
#echo "Concatenating pages"
#pdftk pg*.pdf cat output $filename
#cd ..
#mv "./workbox/$filename" "./outbox"
echo "Rebuilding pdf"
cd ..
mv ./workbox/*.jpg ./inbox
#echo "Cleaning up"
rm ./workbox/*
sh jpgstopdfs.sh $filename
