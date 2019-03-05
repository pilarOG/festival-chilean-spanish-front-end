;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                       ;;
;;;                Centre for Speech Technology Research                  ;;
;;;                     University of Edinburgh, UK                       ;;
;;;                       Copyright (c) 2003, 2004                        ;;
;;;                        All Rights Reserved.                           ;;
;;;                                                                       ;;
;;;  Permission is hereby granted, free of charge, to use and distribute  ;;
;;;  this software and its documentation without restriction, including   ;;
;;;  without limitation the rights to use, copy, modify, merge, publish,  ;;
;;;  distribute, sublicense, and/or sell copies of this work, and to      ;;
;;;  permit persons to whom this work is furnished to do so, subject to   ;;
;;;  the following conditions:                                            ;;
;;;   1. The code must retain the above copyright notice, this list of    ;;
;;;      conditions and the following disclaimer.                         ;;
;;;   2. Any modifications must be clearly marked as such.                ;;
;;;   3. Original authors' names are not deleted.                         ;;
;;;   4. The authors' names are not used to endorse or promote products   ;;
;;;      derived from this software without specific prior written        ;;
;;;      permission.                                                      ;;
;;;                                                                       ;;
;;;  THE UNIVERSITY OF EDINBURGH AND THE CONTRIBUTORS TO THIS WORK        ;;
;;;  DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING      ;;
;;;  ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT   ;;
;;;  SHALL THE UNIVERSITY OF EDINBURGH NOR THE CONTRIBUTORS BE LIABLE     ;;
;;;  FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES    ;;
;;;  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN   ;;
;;;  AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,          ;;
;;;  ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF       ;;
;;;  THIS SOFTWARE.                                                       ;;
;;;                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; spanlex phoneset
;;;


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

   ;; added phones: approximants bdg, 
   ;; modified phones: weak vowels changed to semiconsonants and semivowels 
  (
   (#  - 0 - - - 0 0 0 -) ;; silence phone
	(SIL  - 0 - - - 0 0 0 -)  ;; slience ... 
   (B_10  - 0 - - - 0 0 0 -)  ;; Pauses
   (B_20 - 0 - - - 0 0 0 -)  ;; Pauses
   (B_30 - 0 - - - 0 0 0 -)  ;; Pauses
   (B_40 - 0 - - - 0 0 0 -)  ;; Pauses
   (B_50 - 0 - - - 0 0 0 -)  ;; Pauses
   (B_100 - 0 - - - 0 0 0 -)  ;; Pauses
   (B_150 - 0 - - - 0 0 0 -)  ;; Pauses
   (B_200 - 0 - - - 0 0 0 -)  ;; Pauses
   (B_250 - 0 - - - 0 0 0 -)  ;; Pauses
   (B_300 - 0 - - - 0 0 0 -)  ;; Pauses
   (B_400 - 0 - - - 0 0 0 -)  ;; Pauses
   (IGNORE - 0 - - - 0 0 0 -)  ;; Pauses


   (a  + n 3 2 - 0 0 - +) ;; nuclear vowels at unstressed syllables
   (e  + n 2 1 - 0 0 - +)
   (i  + n 1 1 - 0 0 - +)
   (o  + n 2 3 + 0 0 - +)
   (u  + n 1 3 + 0 0 - +)

   (iSC  + d1 1 1 - 0 0 - +)  ;; semiconsonant in dipthongs
   (uSC  + d1 1 3 + 0 0 - +)  ;; semiconsonant in dipthongs
   (iSV  + d2 1 1 - 0 0 - +)  ;; semivowel in dipthongs
   (uSV  + d2 1 3 + 0 0 - +)  ;; semivowel in dipthongs

   (aS + n 3 2 - 0 0 + +) ;; stressed nuclear vowels
   (eS + n 2 1 - 0 0 + +)
   (iS + n 1 1 - 0 0 + +)
   (oS + n 2 3 + 0 0 + +)
   (uS + n 1 3 + 0 0 + +)

   (p  - 0 - - - s l 0 -) ;; unvoiced stops
   (t  - 0 - - - s a 0 -)
   (k  - 0 - - - s v 0 -)

   (b  - 0 - - - s l 0 +) ;; voiced stops
   (d  - 0 - - - s a 0 +)
   (g  - 0 - - - s v 0 +)

   (bA  - 0 - - - p l 0 +) ;; approximant allophones of the voiced stops between vowels
   (dA  - 0 - - - p a 0 +)
   (gA  - 0 - - - p v 0 +)

   (f  - 0 - - - f b 0 -) ;; fricatives
   (s  - 0 - - - f a 0 -)
   (x  - 0 - - - f v 0 -)

   (h  - 0 - - - h v 0 -) ;; /s/ coda aspirated

   (ch - 0 - - - a a 0 -)
   (ll - 0 - - - a p 0 +) ;; "ll" or "y" at the beginning of sentence or after a stop

   (m  - 0 - - - n l 0 +) ;; nasals
   (n  - 0 - - - n a 0 +)
   (ny - 0 - - - n p 0 +)

   (l - 0 - - - l a 0 +) ;; lateral

   (llA - 0 - - - p p 0 +) ;; approximant palatal "ll" or "y" between vowels
   (rA - 0 - - - p a 0 +) ;; vibrant approximant between vowels

   (r  - 0 - - - v1 a 0 +) ;; vibrant simple
   (rr - 0 - - - v2 a 0 +) ;; vibrant multiple
  )
)
(PhoneSet.silences '(#))

(define (spanlex::select_phoneset)
  "(spanlex::select_phoneset)
Set up phone set for spanlex"
  (Parameter.set 'PhoneSet 'spanlex)
  (PhoneSet.select 'spanlex)
)

(define (spanlex::reset_phoneset)
  "(spanlex::reset_phoneset)
Reset phone set for spanlex."
  t
)

(provide 'spanlex_phones)
