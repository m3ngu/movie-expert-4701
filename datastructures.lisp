(defclass RULE () 
  (
   (patterns :initarg :pattern-list :reader pattern-list)
   (closed   :initform '()  :accessor closed-list)
   
   (actions  :initform '();(error "Actions required for rule") 
	     :initarg :action-list
	     :reader  action-list
	     )
  )
)

(defgeneric add-to-closed (rule result))
(defmethod add-to-closed ((rule RULE) result)
  (setf (closed-list rule) (cons (cadr result) (closed-list rule)))
  result
)

(defclass expert-wm ()
  (
   (fact-lists 
    :initarg :facts
    :initform '() 
    :accessor fact-lists)
  )
)
(defgeneric candidate-list (wm fact-type))
(defmethod candidate-list ((wm EXPERT-WM) fact-type)
   (let ((assoc-cell (assoc fact-type (fact-lists wm))))
     (cdr assoc-cell)
   )
)
(defmethod candidate-list (wm fact-type) (declare (ignore fact-type)) wm)

(defgeneric add-fact (wm fact))
(defgeneric add-fact-type (wm type-name))
(defmethod add-fact (wm fact)
  (cons fact wm)
)

(defmethod add-fact-type ((wm EXPERT-WM) type-name)
  (let* ((type-list (fact-lists wm))
	 (found (assoc type-name type-list))
	 )
    (or found
	(let ((new-cell (cons type-name '())))
	  (setf (slot-value wm 'fact-lists) (cons new-cell type-list))
	  new-cell
	)
    )
  )
)
(defmethod add-fact ((wm EXPERT-WM) fact)
  (let* ((assoc-cell (add-fact-type wm (car fact)))
	 (current-list (cdr assoc-cell))
	 )
    (setf (cdr assoc-cell) (cons fact current-list))
  )
)

  

;;;;;;;;
;; Utility functions
;;;;;;;;
; This might be useful, or it might not.  Right now, I'm inclined to say
; not, but it's cute, so whatever...
(defun prefix (somelist elem-count &optional xifrep) 
  (if (= 0 elem-count) (reverse xifrep) 
      (prefix (cdr somelist) (1- elem-count) (cons (car somelist) xifrep))
))