# Neural Machine Translation of Rare Words with Subword Units

## 1. Background
The OOV (Out of Vocabulary, which includes words that are rare, and words that have not been seen in the training data) is a common problem of machine translation, and decreases the performance of models a lot.

## 2. Motivation
The translation of word categories:
1. Named entities  
2. Cognates and loanwords  
3. Morphologically complex words (compounding, affixation, inflection ...)

is translatable based on a translation of known subword units such as
1. morphemes  
2. phonemes

## 3. MT with BPE
Take the de -> en task for an example.
+ The original input sentence:  
$$
\mbox{Das ist Zweihundertdreiunddreiβig.}
$$
+ Processed with BPE (then become the INPUT of the MT model):
  $$
  \mbox{Das ist Zwei@@ hundert@@ drei@@ und@@ dreiβig.}
  $$  
  Note that "@@" means the subword unit is not the end of the word.

+ The subsequent training process has nothing difference with normal MT training. Note that some outputs may also contain "@@" (for example, one output may be "Are you ready for CET@@ -@@ 4?"), which depends on the MT model and the input sentences. Replacing all "@@" with "" to make those sentences readable.
