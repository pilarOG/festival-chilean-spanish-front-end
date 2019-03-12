# Chilean Spanish front-end based on Festival
Festival (scheme) scripts to run a front-end for Chilean Spanish to obtain linguistic specifications from text

## Introduction
These files are part of the files required to define a new "voice" or front-end on the Festival software (http://www.cstr.ed.ac.uk/projects/festival/), which I developed for my MSc dissertation project (Oplustil, 2016) at the SLP master at the University of Edinburgh with supervisor Simon King. They can also be used to create linguistic specifications fro any text and use for any TTS model (concatenative, HMM, DNN, etc.)

Although "spanlex" stands for Spanish Lexicon, this front-end only describes the phonetic-phonological system of Chilean Spanish, and therefore, some of the descriptions that outputs are not suited for other dialects of Spanish. 

To see more about how Festival unit selection engine works, see Clark et al. (2007).

**Important**: This **not** a full unit selection voice, it does not include an audio-text database, it only converts raw text to the linguistic specification Festival uses to run a unit selection voice.

## Installation
To install Festival you can follow the instructions in the file mac_install_festival.sh, although it only provides commands that have been tested in a Mac (not tested on Linux). Note: If the make commans fail, just run them again!

After going through the installation, or if you already had Festival installed, to use this front-end you need to put the files provided in the right places to make it work: 

- Both spanlex_lts.scm, spanlex.scm and spanlex.out should go in: festival > lib > dicts > spanlex

- The file spanlex_phones.scm, spanint.scm, sptoken.scm and postlex.scm should go in: festival > lib

- The file front_end.scm should go in: festival > lib > voices-multisyn > spanish

If any of the folders doesn't exist, just make them to fill the paths. Festival already comes with a postlex.scm file, you have to replace it with this (it should contain everything that was in there plus the postlex rules for spanlex).

## Usage

Once you have all the files in right place, 

Run Festival from the main folder:
```
./bin/festival
```
Once inside Festival, to test that everything is correct, run this command:
```
(load "lib/voices-multisyn/spanish/front_end.scm")
```
If the output is "nil" it means everything is in the right place! If you get an error, make sure you are running Festival from the folder right befire "lib", so that path makes sense for Festival.

To get the linguistic specification of a sentence, run a command such as:
```
(set! utt (utt.synth_toSegment_text (Utterance Text "hola")))
(utt.save utt "utt1.utt")
```
The file "utt1.utt" should be in the main folder, and you can open it with a text editor, and you'll see that it starts with something like this:
```
EST_File utterance
DataType ascii
version 2
EST_Header_End
Features max_id 10 ; type Text ; iform "\"hola\"" ; 
Stream_Items
1 id _1 ; name hola ; whitespace "" ; prepunctuation "" ; 
2 id _2 ; name hola ; pbreak BB ; pos nil ; 
3 id _3 ; name BB ; 
4 id _4 ; name syl ; stress 0 ; 
5 id _6 ; name syl ; stress 0 ; 
6 id _9 ; name # ; 
7 id _5 ; name oS ; 
8 id _7 ; name l ; 
9 id _8 ; name a ; 
10 id _10 ; name # ; 
End_of_Stream_Items
```
This first part is the human-readable part of the utterance structure, which is the way Festival creates a linguistic specification for the sentence. You can use this files to obtain linguistics specifications for any text to use in any king of TTS model based on text, not only Festival, you can use these as a start point to create an input for DNN-based models, such as Merlin http://www.cstr.ed.ac.uk/projects/merlin/

## Description

In this section I will detail what each script is doing. Although I did extensive modification to the files, all of them were based on a previous voice that existed for Castillian Spanish, and defined to do diphone synthesis, by Alistair Conkie, Borja Etxebarria, Alan W Black and Eduardo Lopez on 1992. The files sptoken, spanint were almost left intact, and I wont describe them in detail.

The main files are spanlex.scm, spanlex_lts.scm and spanlex_phones.scm. You will see that most of these files work by defining sets, which apparantly was the best way to do this using Scheme (while I would definetly prefer to do this in Python! and I have actually tried here: https://github.com/pilarOG/unit_selection_tts/blob/master/spanish_transcriber.py)

1) spanlex_phones contains the definition of every phone that will be later used to do the automatic transcription. This fragment:
```
(defPhoneSet
  spanlex
  ;;;  Phone Features
  (;; vowel or consonant
   (vc + -)  
   ;; vowel: nuclear or semivowel/consonant (diphtongs) why? because the transitions will be going to the opposite side.
   (vlng n d1 d2 0)
   ;; vowel height: high mid low
   (vheight 1 2 3 -)
   ;; vowel frontness: front mid back
   (vfront 1 2 3 -)
   ;; lip rounding
   (vrnd + -)
   ;; consonant type: stop fricative affricative nasal lateral approximant vibrant-simple/multiple aspirated
   (ctype s f a n l p v1 v2 h 0)
   ;; place of articulation: labial labio-dental alveolar palatal velar
   (cplace l b a p v 0)
   ;; stress
   (stress + - 0)
   ;; voicing
   (vox + -)
   )
```
Is pre-defining the features each phone will have, all of them will be defined by 9 features y that same order, and each of those features can take the values defined in these sets. For example, the first feature is binary, and defines if the phone is a vowel (+) or a consonant (-). Other features have more values, for example, place of articulation can take the values: labial, labio-dental, alveolar, palatal, velar and 0 for vowels, where that specific feature doesn't apply. Therefore, here is the definition of a vowel and a consonant:
```
(a  + n 3 2 - 0 0 - +)
(p  - 0 - - - s l 0 -)
```
It is important to say that this definition can be totally arbitrary. In this case I defined this specific features given the knowledge I acquired studying phonetics and my Linguistics bachellor in Chile.

2) spanlex_lts contains the letter-to-sound rules to transcribe graphemes to phonemes. Luckly, in Spanish the relation between letters and sounds is a lot more linear than in English, and even if we'll have some errors, we can obtain a decent phonetic transcription base donly in rules. The rules are also mainly defined by using sets, replacing rules and regular expression counters. This file contains a pipeline of rules, where the first chunk corresponds to letter-to-sound rules (from line 48 to 348); syllabification rules (from line 348 to 551) and finally, stress asignment rules.

For example, an LTS rule would be:
```
(AV a e i o u á é í ú ó aS eS iS oS uS "'")

( AV [ b ] AV = bA )
```
This rules is read as: replace what is inside the squeare brackets, in this case the letter "b", with the phone "bA" (which according to our phone definition is an approximant), if that letter is in between one of the elements of set AV, which is the set of vowels. This is the rule for approximants in Spanish, that says than any voiced plosive is turned into approximant at the intervocalic context.

The syllabification rules introduce the '-' symbol to indicate syllable boundary. For example, the first group of rules is allowing complex onset, which means that the syllable can start with two consonants before the vowel, however this only happens with specific consonant combinations in Spanish:
```
( V C * [ b l ] V = - b l )
( V C * [ p l ] V = - p l )
```
Syllabification rules introduce regular expressions counters, where "\*" means 0 or more of the previous set and "+" 1 or more. In this case, the rule is read as: replace "bl" by "- bl" (insert "-"), if "bl" if followed by a vowel and if is preceded by another vowel, or by the combination of a vowel and a consonant. Therefore, the word "Pablo" would be syllabified as "Pa-blo", because C \* is optional. This form of rule would allow, for example in the case of "pl", that words such as "templo" are correctly syllabified as "tem-plo".

Finally, the stress rules are applied to find stress only in word that don't have written stressed. If the word has the symbol á, é, í, ó, ú, then, by the LTS rules is transformed to aS, eS, iS, oS, uS (where S means stressed). However, not all the words in Spanish have written stress. This final set of rules is for those words, and use as base the reverse form of the rules we are taught at school to know when a word should have the stress mark, which are based in the syllable count (and that's why we find syllables first).

Words that are stressed on the syllable before the last to the last syllable ("esdrújulas") are always marked with written stressed in Spanish, so we only need to worry about those that have stress at the last one and the one before that. For example, for words that should be stressed at the last syllable:
```
(notNSV p t k b d g bA dA gA f x ch ll m ny l llA rA r rr hz )

( C * [ e ] notNSV # = eS )
( C * [ i ] notNSV # = iS )
( C * [ a ] notNSV # = aS )
( C * [ o ] notNSV # = oS )
( C * [ u ] notNSV # = uS )
```
Here "#" means silence, or end of the word. If we know that words that are stressed at the last syllable in Spanish, should have the written stress if they end in the letters, "n", "s" or vowel, then we can assume that the word doesn't end in any of those letters, which is represented by the set notNSV, then it should be stressed at the last syllable. For example, the word "comer" is stressed at the last syllable, and as it ends with "r" this is not written but the rule would add the stress there.

3) The spanlex.scm file it's a general definition of the full lexicon used at the moment of transcribing. It incorporates a very simple "guess_pos" (where pos is part-of-speech), that separates functional words from content words (stress is only assigned to content words). It has a very simple number normalization, inhereted from the old Castillian front-end. Back-off rules in case of missing diphones, and lastly and addenda that includes specific transcriptions of proper names and other difficult words present on the corpus I was working with during my dissertation.

4) Lastly, the front_end.scm file is the "voice definition". This is basically a file that sets all the paths and the functions that Festival needs to use a voice. This particular definition is not connected to a database, and therefore can't synthesize audio from it, but it can get the linguistic definitions. That is why the first command run is "load", loading that file. The utterance we get is constructed by Festival following this definitions and using the methods set there, which are calling to the scripts mentioned before in the right order.

This a very simple implementation of a front-end in Festival. Festival has many complex voices, specially in English, that makes use of more complex mechanisms such as CART to predict out of lexicon transcriptions.

If you use any of these code please cite: Oplustil, P. (2016). Multi-style Text-to-Speech using Recurrent Neural Networks for Chilean Spanish. Master dissertation. University of Edinburgh.

## References
Clark, R. A., Richmond, K., & King, S. (2007). Multisyn: Open-domain unit selection for the Festival speech synthesis system. Speech Communication, 49(4), 317-330.

Oplustil, P. (2016). Multi-style Text-to-Speech using Recurrent Neural Networks for Chilean Spanish.

