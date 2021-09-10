#!/usr/bin/env bash

if [ -f ~/R/bin/Rscript ]; then
    R_PATH=~/R/bin/Rscript
else
    R_PATH=$(which Rscript)
fi

echo "$R_PATH --version"

echo -e "Using bash version $BASH_VERSION \n"
echo -e $(eval $R_PATH --version) "\n"

$R_PATH step-1_sequence_alignment.R
$R_PATH step-2_multiple_genome_alignment.R

if [ -d ./results ]; then
    echo Tarring up results directory to $HOME/results.tgz
    echo Use \`scp\` or another appropriate utility to recover the archive
    tar czf ~/results.tgz ./results
fi

echo Complete!
