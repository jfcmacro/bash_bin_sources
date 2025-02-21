#!/usr/bin/env bash

getFile() {
    for i in *$(date +%Y)*.tex; do
	file=$(basename $i .tex)
	break
    done
    echo $file
}

getCurrent() {
    next=01
    file=$(getFile)
    next=$(echo $file | awk -F '-' '{print $NF}')
    echo $next
}

getNext() {
    next=01
    file=$(getFile)
    next=$(echo $file | awk -F '-' '{print $NF}')
    next=$(expr $next + 1)
    printf '%02d' $next
}

currentFile=$(getFile)
currentSession=$(getCurrent)
nextSession=$(getNext)
newFile=$(echo $currentFile | sed "s/$currentSession/$nextSession/g")
cp $currentFile.tex ../sesion$nextSession/$newFile.tex
