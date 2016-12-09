#!/bin/bash
src=hi
tgt=en
if test "$1" != ""; then
    src=$1
fi
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
	    python ~/indic_nlp_library/src/indicnlp/tokenize/indic_tokenize.py ../$set.$lg ./$set.tok.$lg $lg; ~/mosesdecoder/scripts/tokenizer/lowercase.perl < $set.tok.$lg > ./$set.$lg
	else 
	    for f in ../$set.$lg.[0-9] ; do
		python ~/indic_nlp_library/src/indicnlp/tokenize/indic_tokenize.py $f ./${f/../}.tok $lg; ~/mosesdecoder/scripts/tokenizer/lowercase.perl < ./${f/../}.tok > ./${f/../}
	    done
	fi
    done
done



/home/smt/mosesdecoder/scripts/training/clean-corpus-n.perl  training $src $tgt trainset 1 40
/home/smt/mosesdecoder/bin/lmplz -o 3  -S 80% -T /tmp < ./trainset.$tgt >text.$tgt.arpa
~/mosesdecoder/scripts/training/train-model.perl --external-bin-dir ~/joshua/bin -root-dir . --corpus ./trainset --f $src --e $tgt -lm 0:3:`pwd`/text.$tgt.arpa

echo "You can now use the trained model using following command:"
~/mosesdecoder/bin/moses -f model/moses.ini < test.$src > output.$tgt


/home/smt/mosesdecoder/scripts/generic/multi-bleu.perl ../test.$tgt.[0-3] < output.$tgt
