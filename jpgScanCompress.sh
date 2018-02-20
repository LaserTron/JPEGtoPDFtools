#!/bin/bash

#
# This script makes scanned pages look better following the answer of Felipe Buccioni:
# https://stackoverflow.com/questions/7261855/recommendation-for-compressing-jpg-files-with-imagemagick
#

input="$1"
output="$2"
quality="$3"

if [ -z "$quality" ]
then
    quality="20%"
fi

if [ -z "$output" ]
then
    mogrify -strip -interlace Plane -gaussian-blur 0.05 -quality "$quality" "$input"
else
    convert -strip -interlace Plane -gaussian-blur 0.05 -quality "$quality" "$input" "$output"
fi
