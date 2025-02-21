#!/usr/bin/bash

if [ "$#" -ne 1 ]; then
    script=$(basename $0)
    echo "usage: $script <filename>"
    exit 1
fi

IN=$1

if [ ! -f $IN ]
then
    echo "$IN doesn't exists"
    exit 1
fi

for i in $(grep "C:\\\\" $IN | sed 's/.*(\(.*\)).*/\1/g' | sed '/<img/d' )
do
    filePath=$(wslpath $i)
    filename=$(basename $filePath)
    dstFile="./images/$filename"
    if [ -f $filePath ]
    then
        echo "mv $filePath $dstFile"
    else
        echo "File doesn't exists: $filePath"
    fi
done

# OUT=$(mktemp)
# sed 's/\(.*\)(C:.*\(image-[0-9]*\.png\))\(.*\)/\1(\.\/images\/\2)\3/g' $IN > $OUT
# mv $OUT $IN
# rm -f $OUT
