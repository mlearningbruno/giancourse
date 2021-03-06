#!/bin/bash
#
# Created for Gian course on MT (Varanasi dec 2016), bruno pouliquen
# 6/12/2016
# 
# Last updates
# 13/12/2016

VERSION=0.03

# src is the source language (first parameter)
src=hi
if test "$1" != ""; then
    src=$1
fi

# tgt is the target language (2nd parameter)
tgt=en
if test "$2" != ""; then
    tgt=$2
fi

cd ~/parallel-corpora/$src-en
mkdir trainMoses
cd trainMoses

#~/mosesdecoder/scripts/tokenizer/tokenizer.perl -penn -l $tgt < ../training.$tgt > ./trainset.$tgt

for lg in $src $tgt; do
    for set in training test dev; do
	if test -f  ../$set.$lg; then
	    ~/Icon2016/labs/tokenizer.perl -l $lg < ../$set.$lg | ~/mosesdecoder/scripts/tokenizer/lowercase.perl > ./$set.$lg
	else 
	    for f in ../$set.$lg.[0-9] ; do
		~/Icon2016/labs/tokenizer.perl -l $lg < $f | ~/mosesdecoder/scripts/tokenizer/lowercase.perl > ./${f/../}
	    done
	fi
    done
done


# This step reduces the sentence length to a max of 80 words
/home/smt/mosesdecoder/scripts/training/clean-corpus-n.perl  training $src $tgt trainset 1 40
/home/smt/mosesdecoder/bin/lmplz -o 3  -S 80% -T /tmp < ./trainset.$tgt >text.$tgt.arpa
~/mosesdecoder/scripts/training/train-model.perl --parallel 3 --external-bin-dir ~/joshua/bin -root-dir . --corpus ./trainset --f $src --e $tgt -lm 0:3:`pwd`/text.$tgt.arpa

echo "You can now use the trained model using following command:"
~/mosesdecoder/bin/moses -threads 3 -f model/moses.ini < test.$src > output.$tgt


/home/smt/mosesdecoder/scripts/generic/multi-bleu.perl ./test.$tgt.[0-3] < output.$tgt
