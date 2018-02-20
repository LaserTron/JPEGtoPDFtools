#!/bin/bash

infile="$1"
workdir="`mktemp -d`"
outfile="$2"
curdir="`pwd`"

if [ -z "$outfile" ]
then
    outfile=`basename "$infile" .pdf`-cc.pdf
fi

cp "$infile" "$workdir"/bob.pdf
cd "$workdir"
pdftk bob.pdf burst #assumes pdftk works as advertised
echo "Converting pages to jpg..."
for i in pg*.pdf; do convert -density 300 $i `basename $i .pdf`.jpg; done
rm *.pdf
rm *.txt
echo "Normalizing and compressing..."
for i in pg*.jpg; do imgScanOptimize $i; imgScanCompress $i; done
echo "Reassembling"
cd "$curdir"
imgsToPdf "$workdir" "$outfile" #removes workdir
