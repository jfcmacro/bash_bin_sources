#!/usr/bin/bash

for i in *; do
    if [ -d $i ]; then
        pushd $i
        echo $i
        if [ -d ".init" ]; then
            git status
        else
            svn status
        fi
        popd
    fi
done
