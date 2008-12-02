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

;; Handle any non-numeric pattern/fact combination, including specials.
(defun handle-it (p f a-list)
  (cond  
    ((string= p "=" :end1 1) (handle-any p f a-list #'equal T))
    ((string= p "!" :end1 1) (handle-any p f a-list (lambda (a b) (not (eql a b)))))
    ((string= p "<" :end1 1) (handle-any p f a-list #'trapping-< ))
    ((string= p ">" :end1 1) (handle-any p f a-list #'trapping-> ))
    ((eql p f) (or a-list T))
  )
)

;; Handle any pattern/fact combination.  This is the culmination of a series
;; of increasingly ill-advised function names, for which I apologize, and 
;; make a wholehearted promise to amend my behavior.
(defun handle-more (p f a-list)
  (cond 
    ((symbolp p) (handle-it p f a-list))
    ((= p f) (or a-list T))
  )
)

;; Test a single fact against a (& ...) pattern
(defun test-group (p f a-list)
  ( if (null (cdr p)) (handle-more (car p) f a-list)
       (let (( cdr-return  (test-group (cdr p) f a-list) )) 
	 (if cdr-return 
	     (handle-more (car p) f (if (consp cdr-return) cdr-return a-list))
	     NIL
	     )
	 )
   )
)

;; The final product.  Happily short, thanks to all the mess above.
(defun match (p f &optional (a-list '()))
  (cond
    ( (atom p) (handle-more p f a-list))
    ( (eql '& (car p)) (test-group (cdr p) f a-list) )
    ( (consp f) (let ( (car-resp (match (car p) (car f) a-list)))
        ( if (null car-resp) NIL 
	  (match (cdr p) (cdr f) (if (consp car-resp) car-resp '()))
        )
    )) 
  )
)
