#!/bin/bash

name="Nji Menyonga Ariane Ruth"

tools=("Linux" "Bash" "Git" "AWS")

show_name(){
echo "Engineer: $name"
}

show_tools(){
echo "Tools:"
for tool in "${tools[@]}"
do
echo "- $tool"
done
}

check_status(){
score=90

if [ $score -ge 70 ]
then
echo "Status: Ready"
else
echo "Status: Retry"
fi
}

show_name
show_tools
check_status
