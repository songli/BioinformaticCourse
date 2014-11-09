#!/bin/bash 

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    echo "Usage: makeProj.sh [project name]"
    exit 1
fi

cd ~/Research
ProjDir=Project_$1
echo $ProjDir
mkdir $ProjDir
cd $ProjDir
mkdir data
mkdir rawdata
mkdir scripts
mkdir results
mkdir documents
mkdir figures
