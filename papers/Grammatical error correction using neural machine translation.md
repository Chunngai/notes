# Grammatical error correction using neural machine translation

## 1. Background
### 1.1 Pros of NMT for GEC:
1. ML classifiers for GEC: specific error types  
  MT for GEC: all error types  

2. SMT: a translation model + a language model, trained separately and combined during decoding  
  NMT: one single model  

3. NMT for GEC: able to correct wrong sentences that have not been seen in the training set more effectively.  #? Luong et al., (2015)  

### 1.2 Cons of NMT for GEC:  
1. Limited vocab size in NMT: does not perform well on rare words and OOVs. More serious for NMT for GEC due to mispelling errors, etc..

## 2. What's done
1. The first study using NMT for GEC.  

2. Proposed a two-step approach to handle the rare word problem.  
  (1) Applied unsupervised alignment models to find src of unk trg.  
  (2) Used a word-level translation model is used to translate src.  

## 3. Models and Methods
### 3.1. Neural machine translation  
  + (Model) Attn model by Bahdanau.

### 3.2. Handling rare words.
  + (Model) GIZA++ & METEOR for word alignment.

  + (Methods)
    1. unks in trg sentence $\xrightarrow{\mbox{unsupervised aligner}}$ src words in src sentebnce.

    2. Src words $\xrightarrow{\mbox{word level translator}}$ translations of unks (in a post-processing step).

#### 3.2.1. Details
  + Similar to Luong et al. (2015).  #?

  + Outputs of the NMT model are used for aligning with the src instead of re-annotating as proposed by Luong et al. 2015.  #?  

    Pros:  
    1. Avoids re-annotating any data  
    2. Trains only one NMT model.  

    Reason:  
    1. Nature of GEC.

  + METEOR is helpful as it identifies not only words with exact matches but also words with identical stems, word choice corrections with synonyms or unigram paragraghs.


## Notes:
1. Src vocab size in GEC is much larger than trg vocab size due to incorrect words.

2. Nature of GEC: src, trg are from the same lang. thus:  
  (1) Most words are translated as thenselves.  
  (2) Errors are often similar to correct forms.

3. Intro of GIZA++ and METEOR.
