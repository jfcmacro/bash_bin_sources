#!/usr/bin/bash

dir=$HOME/Workbench/eafit-st0257/parciales
outputDir=/tmp
outputPDF=$outputDir/ST0257-Parciales.pdf

if [ -f $outputPDF ]
then
    rm -f $outputPDF
fi

pushd $dir
for testN in $(seq 1 3)
do
    testName=parcial$testN
    if [ -d $testName ]
    then
	pushd $testName
	for year in $(seq 2010 2020)
	do
	    for term in $(seq 1 2)
	    do
		for test in [sS][tT]0257-$year-$term-*.tex
		do
		    if [ -f $test ]
		    then
			echo $test
			pdfFile=$(basename $test .tex).pdf
			pdflatex $test
			pdflatex $test
			if [ -f $pdfFile ]
			then
			    if [ ! -f $outputPDF ]
			    then
				cp $pdfFile $outputPDF
			    else
				tmp="/tmp/tmpPDF.$RANDOM.pdf"
				pdfunite $outputPDF $pdfFile $tmp
				mv $tmp $outputPDF
				rm -f $tmp
			    fi
			fi
		    fi
		done
	    done
	done
	popd
    fi
done

popd
