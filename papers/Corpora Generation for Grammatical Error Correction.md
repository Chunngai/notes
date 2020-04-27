# Corpora Generation for Grammatical Error Correction

## 1. Background
GEC lacks plentiful parallel data.

## 2. Contributions
2 approaches for generating data using Wikipedia edit histories.
  1. Mining real-world erorrs by extracting src-trg pairs from Wikipedia edit histories with minimal filtration heuristics.

  2. Introducing noise into Wikipedia sentences via round-trip translation.

## 3. Methods
### 3.1. Data Generation from Wikipedia Revision Histories
![method1](imgs/CorporaGenerationforGrammaticalErrorCorrection.jpg)

1. Discard large pages

2. Downsample
    + For preventing imbalance distribution

3. Extract texts

4. Align texts

5. Probabilistically cut aligned text, skipping over non-aligned seqs

6. Probabilistically introduce spelling errors by  
  (1) deletion  
  (2) insertion  
  (3) replacement  
  (4) transposition of adjacent chrs  
      + For training a model proficient at grammar and spelling correction
7. Throw out examples exceeding a max len of word-pieces
8. Downsample identity examples

#### 3.1.1. Details
Minimal filtering is for a large and noisy corpus.
  + Pros: A large number of real grammatical corrections.
  + Cons: Noise including
    + drastic semantic changes
    + imperfect corrections
    + ignored errors
    + Wikipedia spam.

#### 3.1.2. Limitation
The vast majority of the generated data are not grammatical errors.

### 3.2. Data Generation from Round-trip Translation
1. Round trip translation via a bridge language including
    + Fr
    + De
    + Ja
    + Ru

    using discarded identical examples in method 1.

2. Augmentation for more identity exampels

3. Probabilistically introduce spelling errors by  
  (1) deletion  
  (2) insertion  
  (3) replacement  
  (4) transposition of adjacent chrs  
    + For training a model proficient at grammar and spelling correction

4. Stochastically introducing common errors identified in Wikipedia by applying rules learned from extracted edits of up to 3 words whose src and trg phrases are close in edit distance, and which do not contain numbers or capitalization, with the probability computed by $P(original | revised) = \frac{C(original, revised)}{C(revised)}$.

#### 3.2.1. Details
By corrupting clean sentences  
  + Pros: Relatively clean errors  
  + Cons: Limited to the domain of errors that the translation models are prone to making.

Round trip translation introduce noise according to both the
  + weaknesses of the translation models
  + various inheritant ambiguous of translation

Reasons for the bridge languages:
  + high resource languages
  + dissimilar from each other

Target sentences in the generated corpora using this method are less likely to contain
  + poor grammar
  + misspellings
  + spam
than the targets of the revision data as trgs of this method are sentences that were left unchanged for at least one revision.

### 3.3. Comparison
Data Generation from Wikipedia Revision Histories  
  + Pros
    + Polluted by significant noise
    + The broad scope of topics in Wikipedia.

  + Cons
    + Has a good coverage of the domain of real-world ge.

Data Generation from Round-trip Translation
  + Pros
    + Relatively clean
    + The broad scope of topics in Wikipedia.

  + Cons
    + Represent only a subset of the domain of real-world errors.

## 4. Models
### 4.1. Round-trip Translation
+ The one proposed in Google's Neural Machine Translation System: Bridging the Gap between Human and Machine Translation

### 4.2. GEC
+ Transformer with iterative decoding (beam size = 4)

#### 4.2.1. Eval
+ $F_{0.5}$ with the $M^2$ Scorer on the CoNLL-2014 dev and test

+ GLEU+ on the JFLEG dev and test

## 5. Data
### 5.1. Datasets
1. Lang-8 (partial)
    + For for fine-tuning as a dev set.

2. CoNLL-2014 dev and test set

3. JFLEG dev and test set

### 5.2. Preprocessing
1. Spell-checking for the JFLEG

## 6. Experiments
### 6.1. Revisions
#### 6.1.1. Models
  + 4 GEC models trained with generated data of diff hyper-params of extraction from the revisions and one with all data
  + 1 Ensemble of 4 GEC trained on revisions with & without fine-tuning using Lang-8
  + 1 Ensemble with 8 GEC

### 6.2. Round-trip
#### 6.2.1. Models
  + 4 GEC models trained with generated data from fidd bridge langs and one with all data.
  + 1 Ensemble of 4 GEC trained on round-trip with & without fine-tuning using Lang-8
  + 1 Ensemble of 8 GEC

#### 6.2.2. Foundings
+ Japanese as the bridge lang: the best on the CoNLL-2014 - Similar error patterns

+ All data: the best in the JFLEG - diff error distribution with the CoNLL-2014

### 6.3. Foundings
+ Fine tuning the models trained on the pseudo data with Lang-8 corpus enhances the performance.

+ Ensembling the models trained on the pseudo data enhances the performance.

+ Iterative decoding improves more for noisy data.

### 6.4. Error Analysis
+ The revisions-trained: the changes often fall outsides the scope of GEC

+ Fine-tuning with Lang-8: Can be viewed as an adaptation technique that shift the model from the Wikipedia-editing to the GEC task.

+ Notable diffs on specific categories measured by $F_{0.5}$.

## 7. What next
### 7.1. Revisions
1. Generate corpora for langs from Wikipedia that have not GEC corpora

2. More complex filtration to reduce the noise.

### 7.2. Round trip translation
3. Round-trip translation for any of the many languages.

4. How the translation quality influence the result?

5. Extension:
    + Diversity
    + Domain specific

## 8. Notes
### 8.1. GEC
1. Loosely supervised nature of GEC -> iterative decoding.

2. It's difficult to correct multiple errors in a sentence in a single decoding pass and iterative decoding can address the problem.

### 8.2. MT
1. Machine translation problem: seq transduction problem.

### 8.3. Others
1. Lang-8 is the largest publicly available parallel corpus (until 2020).
