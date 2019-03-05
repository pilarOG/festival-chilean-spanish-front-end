
(defvar multisyn_lib_dir (path-append libdir "multisyn/"))

(if (not (member_string multisyn_lib_dir libdir))
    (set! load-path (cons multisyn_lib_dir load-path)))
(if (not (member_string 'spanlex (lex.list)))
    (load (path-append lexdir "spanlex/" (string-append 'spanlex ".scm"))))

(require 'spanlex_phones)
(require 'multisyn)
(require 'sptoken)
(require 'spanlex)
(require 'spanint)

(define (token_pre_punc word)
    (if (item.relation.next word "Token")
         "0"
        (item.feat word "R:Token.parent.prepunctuation")))

(list 'break_tags '(B eQ sQ BB NB))
(set! spanish_phrase_cart_tree
    '
    ((lisp_token_end_punc in ("." ":"))
      ((BB))
      ((lisp_token_end_punc in ("\"" "," ";"))
        ((B))
        ((lisp_token_pre_punc in ("¿"))
          ((sQ))
          ((lisp_token_end_punc in ("?"))
            ((eQ))
            ((n.name is 0)  ;; end of utterance
              ((BB))
              ((NB))))))))

(Parameter.set 'Token_Method 'Token_Any)
(set! token_to_words spanish_token_to_words)
(set! spanish_previous_tok_prepunc token.prepunctuation)
(set! token.prepunctuation "\"`¿")

(set! pos_lex_name nil)
(set! guess_pos spanish_guess_pos)

(lex.select 'spanlex)
(set! postlex_rules_hooks (list postlex_cw_semivowels postlex_cw_semiconsonants postlex_cw_aproximants))

(Parameter.set 'Word_Method Classic_Word)

(Parameter.set 'Phrase_Method 'cart_tree)
(set! phrase_cart_tree spanish_phrase_cart_tree)

(Parameter.set 'Pause_Method MultiSyn_Pauses) ;;
(Parameter.set 'Int_Method nil) ;;
(Parameter.set 'Int_Target_Method nil) ;;
(Parameter.set 'Duration_Method nil) ;;
