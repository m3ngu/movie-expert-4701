;; This handles any (hence the name) of the special patterns (!=<>), if passed
;; the appropriate function as an argument.  Should only be passed the 
;; auto-vivify argument if the pattern was "=..."
(defun handle-any (p f a-list testp &optional auto-vivify)
  (let* (
	(assoc-key (intern (concatenate 'string "=" (subseq (string p) 1))))
	(found (assoc assoc-key a-list))
	)
    (if found
	(and (funcall testp f (cdr found)) a-list)
	(and auto-vivify (append a-list (cons (cons p f) NIL)))
    )
  )
)

;; Functions to test <pat and >pat without blowing up in case of incompatible 
;; arguments.  For laughs, I test symbols with string<
(defun trapping-< (x y) 
  (if (numberp x)
      (if (numberp y) (< x y) NIL          )
      (if (numberp y) NIL     (string< x y))
   )
)

(defun trapping-> (x y) (trapping-< y x))

;; Handle any pattern/fact combination, including specials.
(defun handle-more (p f a-list)
  (cond  
    ((numberp p) (and (numberp f) (= p f) (or a-list T)))
    ((string= p "=" :end1 1) (handle-any p f a-list #'equal T))
    ((string= p "!" :end1 1) (handle-any p f a-list (lambda (a b) (not (equal a b)))))
    ((string= p "<" :end1 1) (handle-any p f a-list #'trapping-< ))
    ((string= p ">" :end1 1) (handle-any p f a-list #'trapping-> ))
    ((string= p "*") (or a-list T)) ;wildcard: match anything, but don't capture
    ((equal p f) (or a-list T))
  )
)

;; Test a single fact against a (& ...) pattern
(defun test-group-and (p f a-list)
  ( if (null (cdr p)) (handle-more (car p) f a-list)
       (let (( cdr-return  (test-group-and (cdr p) f a-list) )) 
	 (if cdr-return 
	     (handle-more (car p) f (if (consp cdr-return) cdr-return a-list))
	     NIL
	     )
	 )
   )
)
(defun test-group-or (p f a-list)
  (and p
       (let ((car-return (handle-more (car p) f a-list)))
	 (or car-return   (test-group-or (cdr p) f a-list)))
))

;; The match function.  Happily short, thanks to all the mess above.
(defun match (p f &optional (a-list '()))
  (cond
    ( (atom p) (handle-more p f a-list))
    ( (eql '& (car p)) (test-group-and (cdr p) f a-list) )
    ( (equal "|" (car p)) (test-group-or (cdr p) f a-list) )
    ( (consp f) (let ( (car-resp (match (car p) (car f) a-list)))
        ( if (null car-resp) NIL 
	  (match (cdr p) (cdr f) (if (consp car-resp) car-resp '()))
        )
    )) 
  )
)

;; Match-rule: do a depth-first search through the working memory, searching
;; for combinations of facts that match the list of patterns given.
;;
;; Arguments:
;;    pattern-list: a proper list of patterns that may match a fact in the WM
;;    WM          : the working memory object (currently a flat list of facts)
;;    partial-match-list: an optional two-element list.
;;      item 1: the bindings from any parent matches in the search tree
;;      item 2: the actual facts that were successfully matched in the parent
;;              matches

;; Notes:
;;  * Both WM and partial-match-list are excellent candidates for refactoring
;;    into structures/objects
;;  * Have to check to see if T as a parent binding return will cause problems

(defun match-rule (pattern-list WM &optional (partial-match-list NIL)) 
  (if (null pattern-list) partial-match-list
      (let 
	  ((pattern (car pattern-list))
	   (input-bindings (car partial-match-list))  ; any bindings from parent calls
	   (previous-facts (cadr partial-match-list)) ; facts bound in parent calls
	   )
	; Loop over elements in WM, finding matches for the current pattern
	(do ((current-list WM (cdr current-list))
	     (return-value NIL return-value)
	     )
	    ((or return-value (null current-list)) return-value)
	  (let* 
	      ((fact (car current-list))  
	       (new-bindings (match pattern fact input-bindings))
	       )
; Comment out for debug trace:
; (format T "Trying fact ~a against pattern ~a with binding list ~a... ~%" fact pattern input-bindings)
	    ; If a match is found, recurse with a depth-first search, looking 
	    ; for matches on the remaining patterns with the updated bindings
	    (if new-bindings
		(let ((answer (match-rule 
			       (cdr pattern-list)
			       WM
			       (list 
				new-bindings 
				(append previous-facts (list fact) )
				)
			       )
			))
		  (if answer (setf return-value answer) NIL)
		)
		NIL ; proceed to next element
	  ))) ; end (do...)
)))
