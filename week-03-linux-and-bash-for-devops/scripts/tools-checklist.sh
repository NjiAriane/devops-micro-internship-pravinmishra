#!/bin/bash

tools=("Linux" "Bash" "Git" "Docker" "AWS")

echo "DevOps Tools Checklist:"

for tool in "${tools[@]}"
do
    echo "- $tool"
done
