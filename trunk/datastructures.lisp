 (defclass RULE () 
  (
   (patterns :initarg :pattern-list 
	     :reader pattern-list
	     :initform (error "Patterns required for rule instantiation")
	     )
   (closed   :initform '()  :accessor closed-list)
   (match-length :initarg :match-length :initform -1 :reader match-length)
   (closed-bindings :initform '() :accessor closed-binding-list)
   (close-on-bindings :initarg :close-on-bindings :initform '() :reader close-on-bindings)
   (actions  :initform '();(error "Actions required for rule") 
	     :initarg :action-list
	     :reader  action-list
	     )
   (exhaustible :initarg :exhaustible :initform nil :reader exhaustible)
   (match-once  :initarg :match-once  :initform nil :reader match-once)
   (exhausted   :initform nil :accessor exhausted)
   (pre-bound   :initarg :pre-bindings :initform '() :reader pre-bindings)
  )
)
(defmethod initialize-instance :after ((rule RULE) &key)
  (and (= -1 (match-length rule))
       (setf (slot-value rule 'match-length) (length (pattern-list rule)))
  )
  (and (match-once rule) (setf (slot-value rule 'exhaustible) T))
)

(defgeneric add-to-closed (rule result))
(defmethod add-to-closed ((rule RULE) result)
  (let ((closure-prefix 
	 (if (< (match-length rule) (length (cadr result)))
	     (prefix (cadr result) (match-length rule))
	     (cadr result)
	     )
	  ))
    (setf (closed-list rule) (cons closure-prefix (closed-list rule)))
    (let ((bind-names (close-on-bindings rule)))
      (and bind-names
	   (setf (slot-value rule 'closed-bindings)
		 (cons
		  (extract-bound-values bind-names (car result))
		  (closed-binding-list rule)
		  )
    )))
    (and (match-once rule) (exhaust rule))
    result
))

(defgeneric closedp (rule factlist))
(defmethod closedp ((rule RULE) match-candidate)
  (let ((factlist       (cadr match-candidate))
	(match-bindings (car  match-candidate))
	(bind-names     (close-on-bindings rule))
	)
    (or 
     (if (= (length factlist) (match-length rule))
	 (member factlist (closed-list rule) :test #'memberp)
	 NIL
	 )
     (and bind-names
	  (let ((bound-values (extract-bound-values bind-names match-bindings)))
	    (and bound-values
		(member bound-values (closed-binding-list rule) :test #'equalp)
	     )
           )
     )
     )
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

(defgeneric delete-fact (wm fact &optional mw))
(defmethod delete-fact (wm fact &optional (mw '()))
  (let ((current (car wm)) (rest (cdr wm)))
    (if (or (eql fact current) (null wm)) 
	(append (reverse mw) rest)
	(delete-fact rest fact (cons current mw))
    )
  )
)
(defmethod delete-fact ((wm EXPERT-WM) fact &optional mw) 
  (declare (ignore mw))
  (let* ((type-list (fact-lists wm))
	 (found (assoc (car fact) type-list))
	 (fact-list (cdr found))
	 )
    (setf (cdr found) (delete-fact fact-list fact))
    wm
  )
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
    wm
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

(defun extract-bound-values (names bindings &optional (rev-values nil))
  (if (null names) (reverse rev-values)
      (and (listp bindings)
	   (let (
		 (found (assoc (car names) bindings))
		 (rest (cdr names))
		 )
	     (and 
	      found 
	      (extract-bound-values rest bindings (cons (cdr found) rev-values))
	      )
	   )
       )
  )
)