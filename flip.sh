#!/bin/bash
filename=$1
pdftk "$filename" cat 1-endsouth output ./workbox/bob.pdf
mv ./workbox/bob.pdf "$filename"
