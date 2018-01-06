;;; Spanlex scheme definition. Spanish (chilean) normalization, addenda and back-off rules


(defvar spanlexdir (path-append lexdir "spanlex"))

;;(require 'pos)

(set! spanish_guess_pos
'((fn
    el la los las
    un una unos unas
;;
    mi tu su mis tus sus
    nuestra nuestras nuestro nuestros
    me te le lo nos les se
    al del
;;

    que como cuando donde

;;
    a ante bajo cabe con contra de desde en entre
    hacia hasta para por sin sobre tras mediante
    versus via despues
;;
    y e ni mas o u pero aunque si
    porque que quien cuando como donde cual cuan
    cuanto quienes aun pues tan mientras sino )

  (pp
    yo tu el ella ellos ellas nosotros ustedes)

  (no
   dieci venti trentai cuarentai cincuentai sesentai ochentai noventai
   uno dos tres cuatro cinco seis siete ocho nueve once doce trece catorce quince cero cientos)

  (at
    es esta )


  )
)

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
	    (cons "veinti" (spanish_number_from_digits (cdr digits)))))

       ((string-equal (car digits) "3");; 3x
	(if (string-equal (car (cdr digits)) "0")
	    (list "treinta")
	    (cons "treintai" (spanish_number_from_digits (cdr digits)))))

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


(require 'spanlex_phones)

(define (spanlex_lts_function word features)
  "(spanish_lts WORD FEATURES)
Using various letter to sound rules build a Spanish pronunciation of
WORD."
  (require 'lts)
  (if (not (boundp 'spanlex_lts))
      (load (path-append spanlexdir "spanlex_lts.scm")))
  (let (phones syl stresssyl dword)
    (if (lts.in.alphabet word 'spanish_downcase)
	(set! dword (spanish_downcase word))
	(set! dword (spanish_downcase "equis")))
    (set! phones (lts.apply dword 'spanish))
    (set! syl (lts.apply phones 'spanish_syl))
    (if (spanish_is_a_content_word
	 (apply string-append dword)
	 spanish_guess_pos)
	(set! stresssyl (lts.apply syl 'spanish.stress))
	(set! stresssyl syl))  ;; function words leave as is
    (list word
	  nil
	  (spanish_tosyl_brackets stresssyl))))

(define (spanish_is_a_content_word word poslist)
  "(spanish_is_a_content_word WORD POSLIST)
Check explicit list of function words and return t if this is not
listed."
  (cond
   ((null poslist)
    t)
   ((member_string word (cdr (car poslist)))
    nil)
   (t
    (spanish_is_a_content_word word (cdr poslist)))))

(define (spanish_downcase word)
  "(spanish_downcase WORD)
Downs case word by letter to sound rules becuase or accented form
this can't use the builtin downcase function."
  (lts.apply word 'spanish_downcase))

(define (spanish_tosyl_brackets phones)
   "(spanish_tosyl_brackets phones)
Takes a list of phones containing - as syllable boundary.  Construct the
Festival bracket structure."
 (let ((syl nil) (syls nil) (p phones) (stress 0))
    (while p
     (set! syl nil)
     (set! stress 0)
     (while (and p (not (eq? '- (car p))))
       (set! syl (cons (car p) syl))
       (if (string-matches (car p) ".*1")
           (set! stress 1))
       (set! p (cdr p)))
     (set! p (cdr p))  ;; skip the syllable separator
     (set! syls (cons (list (reverse syl) stress) syls)))
    (reverse syls)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Addenda

(define (spanlex_addenda)
	(lex.add.entry
	 '("i" nn ((( p r i ) 0 ) (( m eS ) 1) (( r o ) 0))))
	(lex.add.entry
	 '("ii" nn ((( s e ) 0 ) (( g uS n ) 1) (( d o ) 0))))
  (lex.add.entry
 	 '("iii" nn ((( t e r ) 0 ) (( s eS ) 1) (( rA o ) 0))))
  (lex.add.entry
   '("iv" nn ((( k uSC aS r ) 1 ) (( t o ) 0))))
  (lex.add.entry
   '("v" nn ((( k iS n ) 1 ) (( t o ) 0))))
  (lex.add.entry
   '("vi" nn ((( s eS k s ) 1 ) (( t o ) 0))))
  (lex.add.entry
   '("vii" nn ((( s eS p ) 1 ) (( t i ) 0) (( m o ) 0))))
  (lex.add.entry
   '("viii" nn ((( o k ) 0 ) (( t aS ) 1) (( bA o ) 0))))
  (lex.add.entry
   '("ix" nn ((( n o ) 0 ) (( bA eS ) 1) (( n o ) 0))))
  (lex.add.entry
   '("x" nn ((( d eS ) 1 ) (( s i ) 0) (( m o ) 0))))
  (lex.add.entry
   '("xix" nn ((( d iSC e ) 0 ) (( s i ) 0) (( n uSC eS ) 1) (( bA e ) 0))))
  (lex.add.entry
   '("xviii" nn ((( d iSC e ) 0 ) (( s i ) 0) (( oS ) 1) (( ch o ) 0))))
  (lex.add.entry
   '("xx" nn ((( b eS iSV ) 1 ) (( t e ) 0))))
  (lex.add.entry
   '("xxi" nn ((( b eS iSV ) 1 ) (( t i ) 0) (( uS ) 1) (( n o ) 0))))
  (lex.add.entry
  '("bmg" nn ((( b eS ) 0 ) (( eS m e ) 0) (( x eS ) 0))))
  (lex.add.entry
   '("rp" nn ((( eS rr e ) 0 ) (( p eS ) 0))))
  (lex.add.entry
   '("rn" nn ((( eS rr e ) 0 ) (( eS n e ) 0))))
  (lex.add.entry
   '("dvd" nn ((( d eS ) 0 ) (( bA eS ) 0) (( dA eS ) 0))))
  (lex.add.entry
   '("psg" nn ((( p eS ) 0 ) (( eS s e ) 0) (( x eS ) 0))))
  (lex.add.entry
   '("pgsd" nn ((( p eS ) 0 ) (( x eS ) 0) (( eS s e ) 0) (( dA eS ) 0))))
  (lex.add.entry
   '("ptv" nn ((( p eS ) 0 ) (( t eS ) 0) (( bA eS ) 0))))
  (lex.add.entry
   '("lp" nn ((( eS l e ) 0 ) (( p eS ) 0))))
  (lex.add.entry
   '("cd" nn ((( s eS ) 0 ) (( dA eS ) 0))))
  (lex.add.entry
   '("dsp" nn ((( d eS ) 0 ) (( eS s e ) 0) (( p eS ) 0))))
  (lex.add.entry
   '("bnpg" nn ((( b eS ) 0 ) (( eS n e ) 0) (( p eS ) 0) (( x eS ) 0))))
  (lex.add.entry
   '("trf" nn ((( t eS ) 0 ) (( eS rr e ) 0) (( eS f e ) 0))))
  (lex.add.entry
   '("tsr" nn ((( t eS ) 0 ) (( eS s e ) 0) (( eS rr e ) 0))))
  (lex.add.entry
   '("atp" nn ((( aS ) 0 ) (( t eS ) 0) (( p eS ) 0))))
  (lex.add.entry
   '("omm" nn ((( oS ) 0 ) (( eS m e ) 0) (( eS m e ) 0))))
  (lex.add.entry
   '("usd" nn ((( uS ) 0 ) (( eS s e ) 0) (( dA eS ) 0))))
  (lex.add.entry
   '("m\'exico" nn ((( m eS ) 1 ) (( x i ) 0) (( k o ) 0))))
  (lex.add.entry
   '("uf" nn ((( uS ) 0 ) (( eS f e ) 0))))
  (lex.add.entry
   '("serviu" nn ((( s e r ) 0 ) (( bA iSC uS ) 1))))
  (lex.add.entry
   '("ppd" nn ((( p eS ) 0 ) (( p eS ) 0) (( dA eS ) 0))))
  (lex.add.entry
   '("michelle" nn ((( m i ) 0 ) (( ch eS l ) 1))))
  (lex.add.entry
   '("km" nn ((( k i ) 0 ) (( l oS ) 1) (( m e ) 0) (( t r o h ) 0))))
   (lex.add.entry
    '("ximena" nn ((( x i ) 0 ) (( m eS ) 1) (( n a ) 0))))
  (lex.add.entry
    '("allamand" nn ((( a ) 0 ) (( l a ) 1) (( m aS n d ) 0))))
	 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Back-off rules

(set! spanlex-backoff_rules
'(
(aS a)
(eS e)
(iS i)
(oS o)
(uS u)
(uSV u)
(uSC u)
(iSV i)
(iSC i)
(bA b)
(dA d)
(gA g)
(b bA)
(d dA)
(g gA)
(p  #)
(t  #)
(k  #)
(h  s)
(ll llA)
(llA ll)
(rA r)
(r  rA)
(rr r)
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Final Settings

(lex.create "spanlex")
(lex.set.compile.file (path-append spanlexdir "spanlex.out"))
(lex.set.phoneset "spanlex")
(lex.set.lts.method 'spanlex_lts_function)
(spanlex_addenda)

(provide 'spanlex)
