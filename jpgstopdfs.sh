#!/bin/bash
outname=$1
if [ ! -z "$outname" ]
then
    outfile="`basename "$outname" .pdf`.pdf"
else
    outfile="Scan `date +"%Y-%m-%d %R"`.pdf"
fi

echo "Saving to $outfile"

#dateTime="Scan `date +"%Y-%m-%d %R"`"

for i in ./inbox/*
do
    extn="$i"|awk -F . '{print $NF}'
    convert $i -density 300 "./workbox/`basename $i .$extn`.pdf"
    echo "$i converted to pdf"
done

echo "concatenating... "
pdftk ./workbox/* cat output ./workbox/output.pdf
echo "inflating and deflating..."
pdf2ps ./workbox/output.pdf ./workbox/output.ps
ps2pdf ./workbox/output.ps ./workbox/output.pdf
mv ./workbox/output.pdf ./outbox/"$outfile"
echo "cleaning up"
rm ./workbox/*
echo "$outfile produced."
