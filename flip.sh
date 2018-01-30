#!/bin/bash
filename=$1
curdir=`pwd`
tmpdir=`mktemp -d`
tmpfile="$tmpdir/$filename"
pdftk "$filename" cat 1-endsouth output "$tmpfile"
mv "$tmpfile" "$curdir/$filename"
rm -R "$tmpdir"
