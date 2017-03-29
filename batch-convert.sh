#!/bin/bash

for i in ./batch/*
do
    doc=`basename "$i"`
    echo "Creating $doc..."
    echo "consuming directory"
    mv "$i"/* ./imgtopdf/
    rm -d "$i"
    sh jpgstopdfs.sh "$doc"
done
