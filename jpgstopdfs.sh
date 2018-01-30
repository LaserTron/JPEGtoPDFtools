#!/bin/bash
consumeDirectory=$1
outname=$2
workdir="`mktemp -d`"
curdir="`pwd`"
if [ ! -z "$outname" ]
then
    outfile="`basename "$outname" .pdf`.pdf"
else
    outfile="Scan `date +"%Y-%m-%d %R"`.pdf"
fi

echo "Saving to $outfile"

#archive time
dt="`date +"%Y-%m-%d %H:%M:%S"`"

for i in "$consumeDirectory/"*
do
    extn="$i"|awk -F . '{print $NF}'
    convert "$i" -density 300 "$workdir/`basename $i .$extn`.pdf"
    echo "$i converted to pdf"
done

echo "concatenating... "
cd "$workdir"
pdftk * cat output output.pdf
mv output.pdf "$curdir"/"$outfile"
cd "$curdir"
echo "cleaning up and archiving source files"
rm -R "$workdir"
mkdir -p "archive"
mkdir -p "archive/$dt"
mv -v "$consumeDirectory"/* "archive/$dt"
echo "$outfile produced."
