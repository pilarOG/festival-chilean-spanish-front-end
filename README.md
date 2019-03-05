# Chilean Spanish front-end in Festival
Festival (scheme) scripts to run a front-end for Chilean Spanish, using Festival unit selection engine 

## Introduction
These files are part of the files required to define a new "voice" or front-end on the Festival software (http://www.cstr.ed.ac.uk/projects/festival/), which I developed for my MSc dissertation project (Oplustil, 2016) at the SLP master at the University of Edinburgh with supervisor Simon King. 

Although "spanlex" stands for Spanish Lexicon, this front-end only describes the phonetic-phonological system of Chilean Spanish, and therefore, some of the descriptions that outputs are not suited for other dialects of Spanish. 

To see more about how Festival unit selection engine works, see Clark et al. (2007).

**Important**: This **not** a full unit selection voice, it does not include an audio-text database, it only converts raw text to the linguistic specification Festival uses to run a unit selection voice.

## Description


## Installation
To install Festival you can follow the instructions in here http://www.festvox.org/docs/manual-2.4.0/festival_6.html#Installation

To use the front-end files you need to put them in the right places to make it work. Both spanlex_lts.scm and spanlex.scm should go in: festival > lib > dicts > spanlex

The file spanlex_phones.scm and postlex.scm should go in: festival > lib

The file front_end.scm should go in: festival > lib > voices-multisyn > spanish > front_end.scm


## Usage


## References
Clark, R. A., Richmond, K., & King, S. (2007). Multisyn: Open-domain unit selection for the Festival speech synthesis system. Speech Communication, 49(4), 317-330.

Oplustil, P. (2016). Multi-style Text-to-Speech using Recurrent Neural Networks for Chilean Spanish.

