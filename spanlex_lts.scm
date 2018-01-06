;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                       ;;
;;;                Centre for Speech Technology Research                  ;;
;;;                     University of Edinburgh, UK                       ;;
;;;                       Copyright (c) 1996,1997                         ;;
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
;;;  Authors: Alistair Conkie, Borja Etxebarria and Alan W Black
;;;
;;; letter to sounds rules and functions to produce stressed syllabified
;;; pronunciations for Spanish words
;;; There is some history in one set of the LTS rules back to
;;; Rob van Gerwen, University of Nijmegen.
;;;
;;; Modified for Chilean Spanish by Pilar Oplustil

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Down cases with accents
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this should be just doing some capitalization normalization

(lts.ruleset
 spanish_downcase
 ( )
 (
  ( [ a ] = a )
  ( [ e ] = e )
  ( [ i ] = i )
  ( [ o ] = o )
  ( [ u ] = u )
  ( [ � ] = � )
  ( [ � ] = � )
  ( [ � ] = � )
  ( [ � ] = � )
  ( [ � ] = � )
  ( [ � ] = � )
  ( [ b ] = b )
  ( [ c ] = c )
  ( [ "�" ] = s )
  ( [ d ] = d )
  ( [ f ] = f )
  ( [ g ] = g )
  ( [ h ] = h )
  ( [ j ] = j )
  ( [ k ] = k )
  ( [ l ] = l )
  ( [ m ] = m )
  ( [ n ] = n )
  ( [ � ] =  � )
  ( [ p ] = p )
  ( [ q ] = q )
  ( [ r ] = r )
  ( [ s ] = s )
  ( [ t ] = t )
  ( [ v ] = v )
  ( [ w ] = w )
  ( [ x ] = x )
  ( [ y ] = y )
  ( [ z ] = z )
  ( [ "\'" ] = "\'" )
  ( [ : ] = : )
  ( [ ~ ] = ~ )
  ( [ "\"" ] = "\"" )
  ( [ A ] = a )
  ( [ E ] = e )
  ( [ I ] = i )
  ( [ O ] = o )
  ( [ U ] = u )
  ( [ � ] = � )
  ( [ � ] = � )
  ( [ � ] = � )
  ( [ � ] = � )
  ( [ � ] = � )
  ( [ � ] = � )
  ( [ B ] = b )
  ( [ C ] = c )
  ( [ "�" ] = s )
  ( [ D ] = d )
  ( [ F ] = f )
  ( [ G ] = g )
  ( [ H ] = h )
  ( [ J ] = j )
  ( [ K ] = k )
  ( [ L ] = l )
  ( [ M ] = m )
  ( [ N ] = n )
  ( [ � ] =  � )
  ( [ P ] = p )
  ( [ Q ] = q )
  ( [ R ] = r )
  ( [ S ] = s )
  ( [ T ] = t )
  ( [ V ] = v )
  ( [ W ] = w )
  ( [ X ] = x )
  ( [ Y ] = y )
  ( [ Z ] = z )
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Main letter to sound rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; borja: some rules updated or deleted.
; Rules for directly accented vowels, are typed using
; the sun character set and codepage ISO 8859/1 Latin 1. This
; matches the one on Linux and Windows for our purposes, so
; almost everybody happy.
; Umlaut (dieresis) management. I have considered
; three diferent ways to include the umlaut for spanish in
; festival, using <:> or <">. example:  ping:uino  ping"uino,
; and of course, directly typing the weird thing (�).
; Accented vowels can be typed both directly (�) or as a
; quote preceding the plain vowel ('a). example: cami'on  cami�n

(lts.ruleset
;  Name of rule set
 spanish
;  Sets used in the rules
(
  (LNS l n s )
  (DNSR d n s r )
  (EI e i � �)  ; note that accented vowels are included in this set
  (AEIOUt  � � � � � )
  (V a e i o u )
  (C b c d f g h j k l m n � ~ p q r s t v w x y z )
  (noQ b c d f g h j k l m n � ~ p r s t v w x y z )
  (AV a e i o u � � � � � aS eS iS oS uS "'")
  (SN p t k n m � ~ )
  (LN l n )
  (LR l r )
)
;  Rules
(


; deal with "q" : no castillian word uses this, but it would be pronounced this way in greek and foreign words (aquarium, quo, etc)
 ( [ q u ] a = k u )
 ( [ q u ] = k )
 ( [ q ] = k ) ;; should't happend, but if you type it...


; rules for vowels
 ( [ a ] = a )
 ( [ e ] = e )
 ( [ i ] = i )
 ( [ o ] = o )


 ( [ "\'" a ] = aS )
 ( [ "\'" e ] = eS )
 ( [ "\'" i ] = iS )
 ( [ "\'" o ] = oS )
 ( [ "\'" u ] = uS )
 ( [ � ] = aS )
 ( [ � ] = eS )
 ( [ � ] = iS )
 ( [ � ] = oS )
 ( [ � ] = uS )

 ( g [ u ] i = )
 ( g [ u ] e = )
 ( g [ u ] "\'" i = )
 ( g [ u ] "\'" e = )

; rules to get the diphtongs
 ( [ u ] u = u )

 ( [ u ] AV = uSC )
 ( AV [ u ] = uSV )

 ( [ u ] = u )

 ( [ i ] AV = iSC )
 ( noQ AV [ i ] = iSV ) ; would not with words like "arquitecto"


; umlaut (u dieresis) (should not happen, only with g, and already removed)
 ( [ ":" u ] = u )
 ( [ "\"" u ] = u )
 ( [ � ] = u )

; deal with "y" as a vowel and "w"

 ( [ y ] # = i )
 ( [ y ] C = i )
 ( [ y ] "'" C = i )
 ( [ y ] ":" C = i )
 ( [ y ] "\"" C = i )

 ( [ w ] u = uSC )
 ( [ w ] = u )

; fricatives


 ( AV [ s ] C = h ) ; aspiration rule
 ( AV [ s ] # = h )

 ( AV [ z ] C = hz ) ; catch z for stress rules
 ( AV [ z ] # = hz )
 ( [ z ] = s )

 ( [ f ] = f )

 ( s [ c ] = ) ; example: "discipulos"
 ( [ c ] "'" EI = s )
 ( [ c ] EI = s )

 ( [ g ] "'" EI = x )
 ( [ g ] EI = x )
 ( [ j ] = x )

 ( [ s ] = s )

;; no necesarios
 ( # [ s ] C = e s )
 ( # [ s ] "'" C = e s )
 ( # [ s ] ":" C = e s )
 ( # [ s ] "\"" C = e s )

; affricates

 ( [ c h ] = ch )
 ( # [ l l ] = ll )
 ( LN [ y ] = ll )
 ( # [ y ] = ll )
 ( LN [ l l ] = ll )

; unvoiced stops

 ( [ p ] = p )
 ( [ p h ] = f )  ;; to speak a bit of greek.
 ( [ p s ] = s) ;; as in "psicologia"
 ( [ t ] = t )
 ( [ k ] = k )
 ( [ c ] = k )

; deal with "x"
 ( [ x ] = k s )

; voiced stops: only appear as such when they are after a stop, a nasal or a pause, or when its onset in a cluster

 ( # [ b ] = b )
 ( SN [ b ] = b )
 ( [ b ] LR = b )
 ( # [ v ] = b )
 ( SN [ v ] = b )
 ( [ v ] LR = b )
 ( # [ d ] = d )
 ( SN [ d ] = d )
 ( [ d ] LR = d )
 ( # [ g ] = g )
 ( [ g ] LR = g )
 ( SN [ g ] = g )

 ( [ g u ] "'" EI = g )
 ( [ g u ] EI = g )

 ( [ b ] # = b ) ; end of word the person would probably elide them
 ( [ d ] # = d )
 ( [ g ] # = g )


; otherwise, always approximants

 ( AV [ b ] AV = bA )
 ( [ b ] = bA )
 ( AV [ v ] AV = bA )
 ( [ v ] = bA )
 ( AV [ d ] AV = dA )
 ( [ d ] = dA )
 ( AV [ g ] AV = gA )
 ( [ g ] = gA )

;;; try this later
; ( [ g ":" u ] EI = g u )      ; umlaut (u dieresis)
; ( [ g ":" u ] "'" EI = g u )
; ( [ g "\"" u ] EI = g u )
; ( [ g "\"" u ] "'" EI = g u )
; ( [ g � ] EI = g u )
; ( [ g � ] "'" EI = g u )


; nasals

 ( [ m ] = m )
 ( [ "~" n ] = ny )
 ( [ � ] = ny )
 ( [ n ] = n )

 ; other approximants

 ( [ y ] = llA )

 ( AV [ r ] AV = rA ) ; approximant only between vowels, vibrant simple elsewhere


; lateral
 ( [ l l ] # = l )
 ( [ l l ] = llA ) ; elsewhere
 ( [ l ] = l )

; vibrants

 ( [ r r ] = rr )
 ( # [ r ] = rr )
 ( LNS [ r ] = rr )
 ( [ r ] = r )

; just orthography
 ( [ h ] =  )

  ; quotes are used for vowel accents in foreign keyboards (i.e. cami'on).
  ; remove those that were not before a vowel. same with other signs.
 ( [ "'" ] = )
 ( [ ":" ] = )
 ( [ "\"" ] = )
 ( [ "~" ] = )
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Spanish sylabification by rewrite rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(lts.ruleset
   spanish_syl
   (  (V aS iS uS eS oS a i u e o iSC uSC iSV uSV)
      (IUT iS uS )
      (C p t k b d g bA dA gA f s x h hz ch ll m n ny l llA rA r rr )
   )
   ;; Rules will add - at syllable boundary
   (
      ;; valid CC groups
      ( V C * [ b l ] V = - b l )
      ( V C * [ b r ] V = - b r )
      ( V C * [ k l ] V = - k l )
      ( V C * [ k r ] V = - k r )
      ( V C * [ k s ] V = - k s ) ; for words with "x"
      ( V C * [ d r ] V = - d r )
      ( V C * [ f l ] V = - f l )
      ( V C * [ f r ] V = - f r )
      ( V C * [ g l ] V = - g l )
      ( V C * [ g r ] V = - g r )
      ( V C * [ p l ] V = - p l )
      ( V C * [ p r ] V = - p r )
      ( V C * [ t l ] V = - t l )
      ( V C * [ t r ] V = - t r )

      ;; triptongs ;; checar!!! no me convence
      ( [ i a i ] = i a i )
      ( [ i a u ] = i a u )
      ( [ u a i ] = u a i )
      ( [ u a u ] = u a u )
      ( [ i e i ] = i e i )
      ( [ i e u ] = i e u )
      ( [ u e i ] = u e i )
      ( [ u e u ] = u e u )
      ( [ i o i ] = i o i )
      ( [ i o u ] = i o u )
      ( [ u o i ] = u o i )
      ( [ u o u ] = u o u )
      ( [ i aS i ] = i aS i )
      ( [ i aS u ] = i aS u )
      ( [ u aS i ] = u aS i )
      ( [ u aS u ] = u aS u )
      ( [ i eS i ] = i eS i )
      ( [ i eS u ] = i eS u )
      ( [ u eS i ] = u eS i )
      ( [ u eS u ] = u eS u )
      ( [ i oS i ] = i oS i )
      ( [ i oS u ] = i oS u )
      ( [ u oS i ] = u oS i )
      ( [ u oS u ] = u oS u )

      ;; break invalid triptongs;; checar tambien!!
      ( IUT [ i a ]  = - i a )
      ( IUT [ i e ]  = - i e )
      ( IUT [ i o ]  = - i o )
      ( IUT [ u a ]  = - u a )
      ( IUT [ u e ]  = - u e )
      ( IUT [ u o ]  = - u o )
      ( IUT [ a i ]  = - a i )
      ( IUT [ e i ]  = - e i )
      ( IUT [ o i ]  = - o i )
      ( IUT [ a u ]  = - a u )
      ( IUT [ e u ]  = - e u )
      ( IUT [ o u ]  = - o u )
      ( IUT [ i u ]  = - i u )
      ( IUT [ u i ]  = - u i )
      ( IUT [ i aS ]  = - i aS )
      ( IUT [ i eS ]  = - i eS )
      ( IUT [ i oS ]  = - i oS )
      ( IUT [ u aS ]  = - u aS )
      ( IUT [ u eS ]  = - u eS )
      ( IUT [ u oS ]  = - u oS )
      ( IUT [ aS i ]  = - aS i )
      ( IUT [ eS i ]  = - eS i )
      ( IUT [ oS i ]  = - oS i )
      ( IUT [ aS u ]  = - aS u )
      ( IUT [ eS u ]  = - eS u )
      ( IUT [ oS u ]  = - oS u )
      ( IUT [ i uS ]  = - i uS )
      ( IUT [ u iS ]  = - u iS )

      ;; diptongs
      ( [ iSC a ]  = iSC a )
      ( [ iSC e ]  = iSC e )
      ( [ iSC o ]  = iSC o )
      ( [ uSC a ]  = uSC a )
      ( [ uSC e ]  = uSC e )
      ( [ uSC o ]  = uSC o )
      ( [ a iSV ]  = a iSV )
      ( [ e iSV ]  = e iSV )
      ( [ o iSV ]  = o iSV )
      ( [ a uSV ]  = a uSV )
      ( [ e uSV ]  = e uSV )
      ( [ o uSV ]  = o uSV )
      ( [ i uSV ]  = i uSV ) ; who knows...
      ( [ u iSV ]  = u iSV ) ; revisar que predice en estos casos
      ( [ iSC uSV ]  = iSC uSV ) ;
      ( [ uSC iSV ]  = uSC iSV ) ;
      ( [ uSC iS ]  = uSC iS ) ;
      ( [ uSC u ]  = uSC u ) ;
      ( [ uSC i ]  = uSC i ) ;
      ( [ u uSV ]  = u uSV ) ;
      ( [ iSC aS ]  = iSC aS )
      ( [ iSC eS ]  = iSC eS )
      ( [ iSC oS ]  = iSC oS )
      ( [ uSC aS ]  = uSC aS )
      ( [ uSC eS ]  = uSC eS )
      ( [ uSC oS ]  = uSC oS )
      ( [ aS iSV ]  = aS iSV )
      ( [ eS iSV ]  = eS iSV )
      ( [ oS iSV ]  = oS iSV )
      ( [ aS uSV ]  = aS uSV )
      ( [ eS uSV ]  = eS uSV )
      ( [ oS uSV ]  = oS uSV )
      ( [ uS iSV ]  = uS iSV )
      ( [ iS uSV ]  = iS uSV )

      ;; Vowels preceeded by vowels are syllable breaks
      ;; triptongs and diptongs are dealt with above
      ( V [ a ]  = - a )
      ( V [ i ]  = - i )
      ( V [ u ]  = - u )
      ( V [ e ]  = - e )
      ( V [ o ]  = - o )
      ( V [ aS ]  = - aS )
      ( V [ eS ]  = - eS )
      ( V [ iS ]  = - iS )
      ( V [ oS ]  = - oS )
      ( V [ uS ]  = - uS )

      ;; If any consonant is followed by a vowel and there is a vowel
      ;; before it, its a syl break
      ;; the consonant cluster are dealt with above
      ( V C * [ p ] V = - p )
      ( V C * [ t ] V = - t )
      ( V C * [ k ] V = - k )
      ( V C * [ b ] V = - b )
      ( V C * [ d ] V = - d )
      ( V C * [ g ] V = - g )
      ( V C * [ bA ] V = - bA )
      ( V C * [ dA ] V = - dA )
      ( V C * [ gA ] V = - gA )
      ( V C * [ f ] V = - f )
      ( V C * [ s ] V = - s ) ; aspiration of s should never at this context
      ( V C * [ x ] V = - x )
      ( V C * [ ch ] V = - ch )
      ( V C * [ ll ] V = - ll )
      ( V C * [ m ] V = - m )
      ( V C * [ n ] V = - n )
      ( V C * [ ny ] V = - ny )
      ( V C * [ l ] V = - l )
      ( V C * [ llA ] V = - llA )
      ( V C * [ rA ] V = - rA )
      ( V C * [ r ] V = - r )
      ( V C * [ rr ] V = - rr )





      ;; Catch all consonants on their own (at end of word)
      ;; and vowels not preceded by vowels are just written as it

;; I don't understand these rules: it seems to be catching actually beginning of word consonants
      ( [ p ] = p )
      ( [ t ] = t )
      ( [ k ] = k )
      ( [ b ] = b )
      ( [ d ] = d )
      ( [ g ] = g )
      ( [ bA ] = bA )
      ( [ dA ] = dA )
      ( [ gA ] = gA )
      ( [ s ] = s )
      ( [ f ] = f )
      ( [ x ] = x )
      ( [ h ] = h )
      ( [ hz ] = hz )
      ( [ ch ] = ch ) ; palatal affricate should never be there
      ( [ ll ] = ll )
      ( [ m ] = m )
      ( [ n ] = n )
      ( [ ny ] = ny )
      ( [ l ] = l )
      ( [ r ] = r )
      ( [ rr ] = rr )

      ( [ a ]  =  a )
      ( [ i ]  =  i )
      ( [ u ]  =  u )
      ( [ e ]  =  e )
      ( [ o ]  =  o )
      ( [ aS ]  =  aS )
      ( [ iS ]  =  iS )
      ( [ uS ]  =  uS )
      ( [ eS ]  =  eS )
      ( [ oS ]  =  oS )
   )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Stress assignment in unstress words by rewrite rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(lts.ruleset
 ;; Assign stress to a vowel when non-exists
 spanish.stress
 (
  (UV a i u e o)
  (V aS iS uS eS oS  a i u e o)
  (V1 aS iS uS eS oS)
  (VNS n s h a i u e o)
  (C p t k b d g bA dA gA f s x h ch ll m n ny l llA rA r rr iSC iSV uSC uSV)
  (VC p t k b d g bA dA gA f s x h ch ll m n ny l llA rA r rr a i u e o)
  (ANY p t k b d g bA dA gA f s x h ch ll m n ny l llA rA r rr - aS iS uS eS oS a i u e o iSC iSV uSC uSV)
  (notNSV p t k b d g bA dA gA f x ch ll m ny l llA rA r rr hz )
  (iu i u )
  (aeo a e o)
  )
 (
  ;; consonants to themselves
  ( [ p ] = p )
  ( [ t ] = t )
  ( [ k ] = k )
  ( [ b ] = b )
  ( [ d ] = d )
  ( [ g ] = g )
  ( [ bA ] = bA )
  ( [ dA ] = dA )
  ( [ gA ] = gA )
  ( [ ch ] = ch )
  ( [ f ] = f )
  ( [ s ] = s )
  ( [ x ] = x )
  ( [ h ] = h )
  ( [ ch ] = ch )
  ( [ ll ] = ll )
  ( [ m ] = m )
  ( [ n ] = n )
  ( [ ny ] = ny )
  ( [ l ] = l )
  ( [ llA ] = llA )
  ( [ rA ] = rA )
  ( [ r ] = r )
  ( [ rr ] = rr )
  ( [ - ] = - )

  ;; stressed vowels to themselves
  ( [ aS ] = aS )
  ( [ iS ] = iS )
  ( [ uS ] = uS )
  ( [ eS ] = eS )
  ( [ oS ] = oS )

  ;; semiconsonants and semivowels to themselves
  ( [ iSC ] = iSC )
  ( [ uSC ] = uSC )
  ( [ iSV ] = iSV )
  ( [ uSV ] = uSV )


  ;; si ya hay una vocal acentuada en cualquier parte de la palabra, todas
  ;; quedan no estresadas


  ( [ a ] ANY * V1 ANY * = a )
  ( ANY * V1 ANY * [ a ] = a )
  ( [ e ] ANY * V1 ANY * = e )
  ( ANY * V1 ANY * [ e ] = e )
  ( [ i ] ANY * V1 ANY * = i )
  ( ANY * V1 ANY * [ i ] = i )
  ( [ o ] ANY * V1 ANY * = o )
  ( ANY * V1 ANY * [ o ] = o )
  ( [ u ] ANY * V1 ANY * = u )
  ( ANY * V1 ANY * [ u ] = u )

  ;; palabras agudas

  ( C * [ e ] notNSV # = eS )
  ( C * [ i ] notNSV # = iS )
  ( C * [ a ] notNSV # = aS )
  ( C * [ o ] notNSV # = oS )
  ( C * [ u ] notNSV # = uS )

  ;; palabras graves

  ( [ e ] C * - C * VNS + # = eS )
  ( [ i ] C * - C * VNS + # = iS )
  ( [ a ] C * - C * VNS + # = aS )
  ( [ o ] C * - C * VNS + # = oS )
  ( [ u ] C * - C * VNS + # = uS )

  ;; else

  ( [ u ] = u )
  ( [ i ] = i )
  ( [ e ] = e )
  ( [ a ] = a )
  ( [ o ] = o )

  ;; finally change all the hz into normal h

  ( [ hz ] = h )

))
