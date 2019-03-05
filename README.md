# Chilean Spanish front-end in Festival
Festival (scheme) scripts to run a front-end for Chilean Spanish, using Festival unit selection engine 

## Introduction
These files are part of the files required to define a new "voice" or front-end on the Festival software (http://www.cstr.ed.ac.uk/projects/festival/), which I developed for my MSc dissertation project (Oplustil, 2016) at the SLP master at the University of Edinburgh with supervisor Simon King. 

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
This first part is the human-readable part of the utterance structure, which is the way Festival creates a linguistic specification for the sentence. You can use this files to obtain linguistics specifications for any text to use in any king of TTS model based on text (not only Festival, you can use these as a start point to create an input for DNN-based models, such as Merlin http://www.cstr.ed.ac.uk/projects/merlin/)


## Description




## References
Clark, R. A., Richmond, K., & King, S. (2007). Multisyn: Open-domain unit selection for the Festival speech synthesis system. Speech Communication, 49(4), 317-330.

Oplustil, P. (2016). Multi-style Text-to-Speech using Recurrent Neural Networks for Chilean Spanish.

