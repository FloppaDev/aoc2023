#!/bin/bash

sum=0

while read -r line; do
    line=$(
        echo $line | 
        grep --perl-regexp --only-matching '[^:]*:\s*\K.*' 
    ) 

    winning=$(
        echo $line | 
        rev |
        grep --perl-regexp --only-matching '\s*\|\s*\K.*' |
        rev |
        sed --regexp-extended 's/\s+/n\|/g' |
        sed --regexp-extended 's/\|/\|n/g' |
        sed --regexp-extended 's/^|$/n/g' 
    )

    numbers=$(
        echo $line | 
        grep --perl-regexp --only-matching '\s*\|\s*\K.*' |
        sed --regexp-extended 's/\s+/nn/g' |
        sed --regexp-extended 's/^|$/n/g' 
    )

    matches=$(
        echo $numbers | 
        sed --regexp-extended "s/$winning/X/g" |
        sed --regexp-extended "s/[^X]+//g"
    )

    count=${#matches}

    if [ $count -lt 2 ]; then
        result=$count
    else
        result=$(( 2 ** (count - 1) ))
    fi

    sum=$(( sum + result ))
done < <(cat input.txt)

echo $sum
