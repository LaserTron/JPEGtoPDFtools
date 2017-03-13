infile=$1
outfile="`basename $infile .pdf`-fixed"
cp "$infile" ./workbox/pdftmp.pdf
cd workbox
echo "Bursting pdf to ppm"
pdfimages pdftmp.pdf tmp
for i in tmp*
do
    echo "Polishing $i"
    mogrify -normalize -level 10%,90% "$i"
done
for i in tmp*
do
    echo "Unpaperizing $i"
    unpaper -v --deskew-scan-deviation 3.0 --deskew-scan-depth 1.5 --deskew-scan-range 10 --deskew-scan-size 100 --blackfilter-scan-direction v,h "$i" "`basename $i .ppm`-post".ppm
    mv "`basename $i .ppm`-post".ppm "$i"
    echo "Reconverting to jpg..."
    convert "$i" -quality 90 "`basename $i .ppm`".jpg
    echo "Converting to pdf..."
    convert "`basename $i .ppm`".jpg -density 300 "`basename $i .ppm`".pdf
done

echo "Concatenating"
pdftk tmp*.pdf cat output "$outfile".pdf
rm tmp* #careful
cd ..
mv ./workbox/"$outfile".pdf ./outbox
rm ./workbox/*
