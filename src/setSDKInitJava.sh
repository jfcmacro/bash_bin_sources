#!/usr/bin/bash

if [ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]
then
    . $HOME/.sdkman/bin/sdkman-init.sh

    if [ -f "pom.xml" ]
    then
        java_version=$(cat pom.xml | grep "<java.version>.*</java.version>" | sed 's/<java\.version>//g' | sed 's/<\/java\.version>//g' | sed 's/ *//g')
        java_tem_version=$(sdk list java | egrep " $java_version.*-tem" | awk -F '|' '{print $6;}' | sed 's/ *//g' | head -1)
        if [ ! -f ".sdkmanrc" ]
        then
            sdk use java $java_tem_version
            sdk env init
        fi
    fi
fi
