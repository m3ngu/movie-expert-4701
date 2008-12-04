;;  Test Harness to output genuine, valid TAP for simple tests in CLISP


(defun run-tests (function-tested tests &optional header)
  (progn
   (and header (format T "#~a~%" header))
   (format T "1..~d~%" (length tests))
   (tap-output function-tested tests 1)
  )
)


(defun tap-output (function-tested tests &optional (test-number 1)) 
  (if (null tests) NIL
    (let* (
	   (current (car tests)) 
	   (current-args   (car current))
	   (current-result (cadr current))
	   (label          (caddr current))
	   (result (equal current-result (apply function-tested current-args)))
	  )
      (or (format T "~[not ok~;ok~] ~d ~s~%" 
		  (if result 1 0) 
		  test-number 
		  (let ((formatted (or label (format NIL "~61a" current))))
		    (if (< (length formatted) 60) 
			   formatted (subseq formatted 0 60))))
	  (tap-output function-tested (cdr tests) (1+ test-number)))
      )
   )
)
