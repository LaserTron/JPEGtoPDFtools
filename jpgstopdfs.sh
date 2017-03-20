#!/bin/bash
outname=$1
if [ ! -z "$outname" ]
then
    outfile="`basename "$outname" .pdf`.pdf"
else
    outfile="Scan `date +"%Y-%m-%d %R"`.pdf"
fi

echo "Saving to $outfile"

#archive time
dt="`date +"%Y-%m-%d %H:%M:%S"`"

for i in ./imgtopdf/*
do
    extn="$i"|awk -F . '{print $NF}'
    convert "$i" -density 300 "./workbox/`basename $i .$extn`.pdf"
    echo "$i converted to pdf"
done

echo "concatenating... "
pdftk ./workbox/* cat output ./workbox/output.pdf
mv ./workbox/output.pdf ./outbox/"$outfile"
echo "cleaning up and archiving source files"
rm ./workbox/*
mkdir -v "./archive/$dt"
mv -v ./imgtopdf/* "./archive/$dt"
echo "$outfile produced."
