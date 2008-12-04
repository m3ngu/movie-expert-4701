 (defclass RULE () 
  (
   (patterns :initarg :pattern-list 
	     :reader pattern-list
	     :initform (error "Patterns required for rule instantiation")
	     )
   (closed   :initform '()  :accessor closed-list)
   (match-length :initarg :match-length :initform -1 :reader match-length)
   (actions  :initform '();(error "Actions required for rule") 
	     :initarg :action-list
	     :reader  action-list
	     )
   (exhaustible :initarg :exhaustible :initform nil :reader exhaustible)
   (exhausted   :initform nil :accessor exhausted)
  )
)
(defmethod initialize-instance :after ((rule RULE) &key)
  (and (= -1 (match-length rule))
       (setf (slot-value rule 'match-length) (length (pattern-list rule)))
))

(defgeneric add-to-closed (rule result))
(defmethod add-to-closed ((rule RULE) result)
  (let ((closure-prefix 
	 (if (< (match-length rule) (length (cadr result)))
	     (prefix (cadr result) (match-length rule))
	     (cadr result)
	     )
	  ))
    (setf (closed-list rule) (cons closure-prefix (closed-list rule)))
    result
))

(defgeneric closedp (rule factlist))
(defmethod closedp ((rule RULE) factlist)
  (if (= (length factlist) (match-length rule))
      (member factlist (closed-list rule) :test #'memberp)
      NIL
      )
)

(defgeneric exhaust (rule))
(defmethod exhaust ((rule RULE))  ; always returns NIL
  (and (exhaustible rule) (setf (slot-value rule 'exhausted) T) NIL)
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

; Get a prefix of an arbitrary list (used for closed-lists with
; shorter-than-usual match lengths).
(defun prefix (somelist elem-count &optional xifrep) 
  (if (= 0 elem-count) (reverse xifrep) 
      (prefix (cdr somelist) (1- elem-count) (cons (car somelist) xifrep))
))

; Fact-list equality test: since facts are immutable, we just need to
; test for top-level equality of each member of the two lists we're
; comparing
(defun memberp (a b) 
  (if (null a) (null b)
      (and 
       (eql (car a) (car b))
       (memberp (cdr a) (cdr b))
      )
  )
)
