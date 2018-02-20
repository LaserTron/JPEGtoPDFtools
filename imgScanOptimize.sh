#!/bin/bash

#
# This script makes scanned pages look better following:
# http://dikant.de/2013/05/01/optimizing-scanned-documents-with-imagemagick/
#

input="$1"
output="$2"

if [ -z "$output" ]
then
    mogrify -normalize -level 20%,80% -sharpen 0x1 "$input"
else
    convert "$input" -normalize -level 20%,80% -sharpen 0x1 "$output"
fi
