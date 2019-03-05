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
;;;  Tokenization rules for spanish
;;;
;;;  Particularly numbers and symbols.
;;;
;;; As the "el" database has no dipthongs, numbers sound much
;;; better removing the weak vowel ("ventiuno" instead of "veintiuno")
;;; Many speakers do this, so no problem with it.

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

(define (spanish_number name)
"(spanish_number name)
Convert a string of digits into a list of words saying the number."
  (if (string-matches name "0")
      (list "cero")
      (spanish_number_from_digits (symbolexplode name))))

(define (just_zeros digits)
"(just_zeros digits)
If this only contains 0s then we just do something different."
 (cond
  ((not digits) t)
  ((string-equal "0" (car digits))
   (just_zeros (cdr digits)))
  (t nil)))

(define (spanish_number_from_digits digits)
  "(spanish_number_from_digits digits)
Takes a list of digits and converts it to a list of words
saying the number."
  (let ((l (length digits)))
    (cond
     ((equal? l 0)
      nil)
     ((string-equal (car digits) "0")
      (spanish_number_from_digits (cdr digits)))
     ((equal? l 1);; single digit
      (cond
       ((string-equal (car digits) "0") (list "cero"))
       ((string-equal (car digits) "1") (list "un"))
       ((string-equal (car digits) "2") (list "dos"))
       ((string-equal (car digits) "3") (list "tres"))
       ((string-equal (car digits) "4") (list "cuatro"))
       ((string-equal (car digits) "5") (list "cinco"))
       ((string-equal (car digits) "6") (list "seis"))
       ((string-equal (car digits) "7") (list "siete"))
       ((string-equal (car digits) "8") (list "ocho"))
       ((string-equal (car digits) "9") (list "nueve"))
       ;; fill in the rest
       (t (list "equis"))));; $$$ what should say?
     ((equal? l 2);; less than 100
      (cond
       ((string-equal (car digits) "0");; 0x
	(spanish_number_from_digits (cdr digits)))

       ((string-equal (car digits) "1");; 1x
	(cond
	 ((string-equal (car (cdr digits)) "0") (list "diez"))
	 ((string-equal (car (cdr digits)) "1") (list "once"))
	 ((string-equal (car (cdr digits)) "2") (list "doce"))
	 ((string-equal (car (cdr digits)) "3") (list "trece"))
	 ((string-equal (car (cdr digits)) "4") (list "catorce"))
	 ((string-equal (car (cdr digits)) "5") (list "quince"))
	 (t
	  (cons "dieci" (spanish_number_from_digits (cdr digits))))))

       ((string-equal (car digits) "2");; 2x
	(if (string-equal (car (cdr digits)) "0")
	    (list "veinte")
	    (cons "venti" (spanish_number_from_digits (cdr digits)))))

       ((string-equal (car digits) "3");; 3x
	(if (string-equal (car (cdr digits)) "0")
	    (list "treinta")
	    (cons "trentai" (spanish_number_from_digits (cdr digits)))))

       ((string-equal (car digits) "4");; 4x
	(if (string-equal (car (cdr digits)) "0")
	    (list "cuarenta")
	    (cons "cuarentai" (spanish_number_from_digits (cdr digits)))))

       ((string-equal (car digits) "5");; 5x
	(if (string-equal (car (cdr digits)) "0")
	    (list "cincuenta")
	    (cons "cincuentai" (spanish_number_from_digits (cdr digits)))))

       ((string-equal (car digits) "6");; 6x
	(if (string-equal (car (cdr digits)) "0")
	    (list "sesenta")
	    (cons "sesentai" (spanish_number_from_digits (cdr digits)))))

       ((string-equal (car digits) "7");; 7x
	(if (string-equal (car (cdr digits)) "0")
	    (list "setenta")
	    (cons "setentai" (spanish_number_from_digits (cdr digits)))))

       ((string-equal (car digits) "8");; 8x
	(if (string-equal (car (cdr digits)) "0")
	    (list "ochenta")
	    (cons "ochentai" (spanish_number_from_digits (cdr digits)))))

       ((string-equal (car digits) "9");; 9x
	(if (string-equal (car (cdr digits)) "0")
	    (list "noventa")
	    (cons "noventai" (spanish_number_from_digits (cdr digits)))))

       ))

     ((equal? l 3);; in the hundreds
      (cond

       ((string-equal (car digits) "1");; 1xx
	(if (just_zeros (cdr digits)) (list "cien")
	    (cons "ciento" (spanish_number_from_digits (cdr digits)))))

       ((string-equal (car digits) "5");; 5xx
	(cons "quinientos" (spanish_number_from_digits (cdr digits))))

       ((string-equal (car digits) "7");; 7xx
	(cons "setecientos" (spanish_number_from_digits (cdr digits))))

       ((string-equal (car digits) "9");; 9xx
	(cons "novecientos" (spanish_number_from_digits (cdr digits))))

       (t;; ?xx
	(append (spanish_number_from_digits (list (car digits)))
		(list "cientos")
		(spanish_number_from_digits (cdr digits))))
       ))

     ((< l 7)
      (let ((sub_thousands
	     (list
	      (car (cdr (cdr (reverse digits))))
	      (car (cdr (reverse digits)))
	      (car (reverse digits))))
	    (thousands (reverse (cdr (cdr (cdr (reverse digits)))))))
	(set! x (spanish_number_from_digits thousands))
	(append
	 (if (string-equal (car x) "un") nil x)
	 (list "mil")
	 (spanish_number_from_digits sub_thousands))))

     ((< l 13)
      (let ((sub_million
	     (list
	      (car (cdr (cdr (cdr (cdr (cdr(reverse digits)))))))
	      (car (cdr (cdr (cdr (cdr (reverse digits))))))
	      (car (cdr (cdr (cdr (reverse digits)))))
	      (car (cdr (cdr (reverse digits))))
	      (car (cdr (reverse digits)))
	      (car (reverse digits))
	      ))
	    (millions (reverse (cdr (cdr (cdr (cdr (cdr (cdr (reverse digits))))))))))
	(set! x (spanish_number_from_digits millions))
	(append
	 (if (string-equal (car x) "un")
	     (list "un" "millon")
	     (append x (list "millones")))
	 (spanish_number_from_digits sub_million))))

     (t
      (list "un" "numero" "muy" "gr'aaaaaandee")))))


(define (spanish_token_to_words token name)
  "(spanish_token_to_words TOKEN NAME)
Returns a list of words for the NAME from TOKEN.  This primarily
allows the treatment of numbers, money etc."
  (cond
   ((string-matches name "[1-9][0-9]+")
    (spanish_number name))
   ((not (lts.in.alphabet name 'spanish_downcase))
    ;; It contains some other than the lts can deal with
    (let ((subwords))
      (item.set_feat token "pos" "nn")
      (mapcar
       (lambda (letter)
	 ;; might be symbols or digits
	 (set! subwords
	       (append
		subwords
		(cond
		 ((string-matches letter "[0-9]")
		  (spanish_number letter))
		 ((string-matches letter "[A-Z�������]")
		    (spanish_downcase letter))
		 (t
		  (list letter))))))
       (symbolexplode name))
      subwords))
   (t
    (list name))))

;;; Intonation
(list 'break_tags '(B NB))
(set! spanish_accent_cart_tree
  '
  (
   (R:SylStructure.parent.gpos is content)
    ( (stress is 1)
       ((Accented))
       ((NONE))
    )
  )
)


(provide 'sptoken)
