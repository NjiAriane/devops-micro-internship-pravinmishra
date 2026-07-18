#!/bin/bash

folder="../test-folder"
file="../test-folder/test.txt"

if [ -d "$folder" ]
then
    echo "Directory exists"
else
    echo "Directory missing"
fi

if [ -f "$file" ]
then
    echo "File exists"
else
    echo "File missing"
fi
