#!/bin/bash

#
# Makes symlinks of scripts to /usr/loca/bin
# should be run as root
#

ln -s "`pwd`"/imgScanCompress.sh /usr/local/bin/imgScanCompress
ln -s "`pwd`"/pdFlip.sh /usr/local/bin/pdFlip
ln -s "`pwd`"/imgScanOptimize.sh /usr/local/bin/imgScanOptimize
ln -s "`pwd`"/imgsToPdf.sh /usr/local/bin/imgsToPdf
ln -s "`pwd`"/pdfCompressAndContrast.sh /usr/local/bin/pdfCompressAndContrast
