#!/usr/bin/env bash

get_java_version() {
    javac -version | sed 's/javac //g' | sed 's/\./ /g' | awk '{ print $1; }'
}

usage() {
    echo "usage: $0 [-a] [-g <group>] [-p <package-name] [-m] [-h] [-v <version>] [-s] <artifact_id>"
    exit 1
}

help() {
    echo "$0 [OPTIONS] <artifact-id>"
    echo "OPTIONS:"
    echo "         [-a]                - package append <group>.<package>.<artifact-id>"
    echo "         [-g <group>]        - set project group default org.jfcmc"
    echo "         [-p <package-name>] - set <package-name>"
    echo "         [-m]                - set mode interactive"
    echo "         [-h]                - show this help"
    echo "         [-s]                - show command without executing"
    echo "         [-v]                - version"
    exit 0
}

# package_append=
dflt_group=org.jfcmc
dflt_java_version=$(get_java_version)
dflt_archetype_artifact_id=maven-archetype-quickstart
dflt_archetype_version=1.5
dflt_interactive_mode=false
dflt_version=1.0.1
opt_string="ag:hj:mp:v:s"

while getopts ${opt_string} opt; do
    case ${opt} in
	a)
	    package_append="1"
	    ;;
	g)
	    group=${OPTARG}
	    ;;
	h)
	    help
	    ;;
	j)
	    java_version=${OPTARG}
	    ;;
	m)
	    interactive_mode=true
	    ;;
	p)
	    package=${OPTARG}
	    ;;
	v)
	    version=${OPTARG}
	    ;;
	s)
	    show=true
	    ;;
	?)
	    usage
	    ;;
    esac
done

shift $(($OPTIND - 1))

artifact_id=$1
dflt_package=$dflt_group\.$(echo $artifact_id | tr [A-Z] [a-z])
group=${group:-${dflt_group}}
java_version=${java_version:-${dflt_java_version}}

if [ $package_append ]; then
    package=${group}\.${package}\.${artifact_id}
else
    package=${package:-${dflt_package}}
fi

interactive_mode=${interactive_mode:-${dflt_interactive_mode}}
version=${version:-${dflt_version}}

if [ ! $artifact_id ]; then
    usage
else
    package=${package}\.$(echo $artifact_id | tr [A-Z] [a-z])
fi


cmd="mvn archetype:generate -DgroupId=$group -DartifactId=$artifact_id -Dpackage=$package -Dversion=$version -DjavaCompilerVersion=$java_version -DarchetypeArtifactId=$dflt_archetype_artifact_id -DarchetypeVersion=$dflt_archetype_version -DinteractiveMode=$interactive_mode"

if [ $show ]; then
    echo "$cmd"
else
    $cmd
fi
