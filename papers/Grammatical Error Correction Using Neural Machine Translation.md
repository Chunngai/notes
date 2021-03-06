# Grammatical Error Correction Using Neural Machine Translation

## 1. Background
### 1.1 Pros of NMT for GEC:
1. ML classifiers for GEC: specific error types  
  MT for GEC: all error types  

2. SMT: a translation model + a language model, trained separately and combined during decoding  
  NMT: one single model  

3. NMT for GEC: is able to correct wrong sentences that have not been seen in the training set more effectively.  #? Luong et al., (2015)  

### 1.2 Cons of NMT for GEC:  
1. Limited vocab size in NMT: does not perform well on rare words and OOVs. More serious for NMT for GEC due to misspelling errors, etc..

## 2. What's Done
1. The first study using NMT for GEC.  

2. Proposed a two-step approach to handle the rare word problem.  

    (1) Applied unsupervised alignment models to find src of unk trg.  
    (2) Used a word-level translation model to translate src.  

## 3. Methods
  1. erroneous sentence $\xrightarrow {NMT}$ correction with \<unk>s  

  2.1. correction with \<unk>s $\xrightarrow{\mbox{unsupervised aligner}}$ src words of \<unk>s in the src sentence

  2.2. src words $\xrightarrow [\mbox{replace <unk>s with their translations}]{\mbox{word-level translator for <unk>s}}$ correction

  (2.1 & 2.2 are implemented in a post-processing step)

## 4. Models
### 4.1. Neural Machine Translation  
  + Attn model by Bahdanau.

#### 4.1.1. Training Details
  + Training procedure & hyper-params are similar to those used by Bahdanau et al. (2014).

  + `max_len` = 100

  + `trg_vocab_size` = 30K

  + `src_vocab_size` = {30, 50, 80}K   
  (prelim exp shows increasing src_vocab_size is more useful than target side.)

### 4.2. Handling Rare Words.
  1. Unsupervised word alignment model: GIZA++ & METEOR.  
      + Output sentences from NMT are aligned with src using GIZA++.  
      + Alignment info learnt by METEOR is used by GIZA++.

  2. Word-level translation model is learnt from IBM Model 4.

#### 4.2.1. Training Details
  1. Similar to Luong et al. (2015).  #?

  2. Outputs of the NMT model are used for aligning with the src instead of re-annotating as proposed by Luong et al. 2015.  #?  

      Pros:  
      (1) Avoids re-annotating any data  
      (2) Trains only one NMT model.  

      Practicibility of the Unsupervised word-alignment model:  
      (1) Nature of GEC.

  3. METEOR is helpful as it identifies not only words with exact matches but also words with identical stems, word choice corrections with synonyms or unigram paragraghs.

### 4.3. Evaluation
1. I-measure

2. $M^2$ Scorer

3. GLEU

## 5. Data
### 5.1. Datasets
1. FCE

2. CLC

3. NUCLE (for testing generalization)

### 5.2. Data Preprocessing
1. RASP for both training and test data

## 6. Notes:
### 6.1. Notes of GEC
1. Src vocab size in GEC is much larger than trg vocab size due to incorrect words.

2. Nature of GEC: src, trg are from the same lang. thus:  
    (1) Most words are translated as thenselves.  
    (2) Errors are often similar to correct forms.

3. Increasing the src vocab size can improve the rare word problem.

4. Phrase-based SMT: trained on surface form, unaware of syntactic structure. Has to have seen the exact correction rule.  
  NMT: Does not rely on any correction rules. Should be able to make corrections as long as it has seen the words in the training data.

### 6.2. Notes of the Paper
1. Intro of GIZA++ and METEOR.

2. Consistent tokenization of multiple datasets may help improve results.

3. Future work: explore other ways for rare word problem, such as:

    (1) incorporating the soft-alignment info generated by attn-based decoder  
    (2) character-based model instead of word-based
