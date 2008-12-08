;;;  The RULE class, as discussed in the technical appendix to the readme.
(defclass RULE () 
  (
   (patterns :initarg :pattern-list 
	     :reader pattern-list
	     :initform (error "Patterns required for rule instantiation")
	     )
   (closed   :initform '()  :accessor closed-list)
   (match-length :initarg :match-length :initform -1 :reader match-length)
   (closed-bindings :initform '() :accessor closed-binding-list) ; internal use only
   (close-on-bindings :initarg :close-on-bindings :initform '() :reader close-on-bindings)
   ; Actions aren't *actually* required, because our test scripts all break if they are
   (actions  :initform '(); '(error "Actions required for rule instantiation") 
	     :initarg :action-list
	     :reader  action-list
	     )
   (pre-bound   :initarg :pre-bindings :initform '() :reader pre-bindings)
   (exhaustible :initarg :exhaustible :initform nil :reader exhaustible)
   (match-once  :initarg :match-once  :initform nil :reader match-once)
   ; for internal use only:
   (exhausted   :initform nil :accessor exhausted)
   (resume-point :initform NIL :accessor resume-point)
  )
)

;; Initialization clean-up: set "exhaustible" if "match-once" is set, and 
;; set match-length if it was not set already.

(defmethod initialize-instance :after ((rule RULE) &key)
  (and (= -1 (match-length rule))
       (setf (slot-value rule 'match-length) (length (pattern-list rule)))
  )
  (and (match-once rule) (setf (slot-value rule 'exhaustible) T))
)

;; Add-to-closed: given a result of the form (bindings facts resume-point), 
;; store the relevant information in the rule.  Specifically,
;;   * in any case, add the matched facts to the closed-list of the rule
;;   * if the rule has close-on-bindings attribute, add the bound values to
;;     the list of closed bindings
;;   * if the is a match-once rule, mark it as exhausted
;;   * if it is an exhaustible rule, save the current position of the search
;;     through working memory, to allow resumption from that point on the
;;      next match

(defgeneric add-to-closed (rule result))
(defmethod add-to-closed ((rule RULE) result)
  (let ((result-bindings (car result))
	(bound-facts (cadr result))
	(resume-point (caddr result))
	(bind-names (close-on-bindings rule))
       )
    ; add facts to closed-list:
    (let
	((closure-prefix 
	  (if (< (match-length rule) (length bound-facts))
	     (prefix bound-facts (match-length rule))
	     bound-facts
	     )
	  ))
      (setf (closed-list rule) (cons closure-prefix (closed-list rule))))
    ; if applicable, add bound values to closed-bindings list:
    (and bind-names
	 (setf (slot-value rule 'closed-bindings)
	       (cons
		(extract-bound-values bind-names result-bindings)
		(closed-binding-list rule)
		)
    ))
    ; set exhaustion-related fields:
    (and (exhaustible rule) (setf (resume-point rule) resume-point))
    (and (match-once rule) (exhaust rule))
    ; we don't actually want to return the resume-point to the caller, so just
    ; return the bindings and facts:
    (list result-bindings bound-facts)
))


(defgeneric get-resume-point (rule))
;; This is a destructive method!  If it is called, it returns the resume-point
;; set by add-to-closed-list, and clears that field (so as to not break the
;; recursive search in horrible ways).
(defmethod get-resume-point ((rule RULE))
  (let ((fact-list (resume-point rule)))
    (setf (resume-point rule) NIL)
    fact-list
))

(defgeneric closedp (rule factlist))
;; Given a rule and a partial match (bindings and facts), return T if
;; the partial match has been made before (and appears in one of the
;; closed lists for this rule), NIL otherwise.
(defmethod closedp ((rule RULE) match-candidate)
  (let ((factlist       (cadr match-candidate))
	(match-bindings (car  match-candidate))
	(bind-names     (close-on-bindings rule))
	)
    (or 
     ; First check if the facts appear in the closed-list:
     (if (= (length factlist) (match-length rule))
	 (member factlist (closed-list rule) :test #'memberp)
	 NIL
	 )
     ; Then check if the bound values are in the closed-bindings list (if any)
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
;; If the rule is exhaustible, set the the "exhausted" flag;
;; otherwise, do nothing.  In any case, return NIL.
(defmethod exhaust ((rule RULE)) 
  (and (exhaustible rule) (setf (slot-value rule 'exhausted) T) NIL)
)

; The EXPERT-WM class is much simpler: it simply partitions the fact
; list into sublists based on the type of the fact.  The fact-list
; will take the form 
; '((foo (foo (1 2 3)) (foo (4 5 6))) (bar (bar A) (bar B)))

(defclass expert-wm ()
  (
   (fact-lists 
    :initarg :facts
    :initform '() 
    :accessor fact-lists)
  )
)

; Extract the a list of facts that includes all facts of the given type:
(defgeneric candidate-list (wm fact-type))
; If the working memory is of the expected class, extract the sublist
; that is stored under the provided fact type.
(defmethod candidate-list ((wm EXPERT-WM) fact-type)
   (let ((assoc-cell (assoc fact-type (fact-lists wm))))
     (cdr assoc-cell)
   )
)
; As a fallback, if the working memory is a flat list, rather than a real
; expert-wm object, just return the whole list
(defmethod candidate-list (wm fact-type) (declare (ignore fact-type)) wm)


;;; Methods to manipulate the contents of working memory:
(defgeneric add-fact (wm fact))
(defgeneric add-fact-type (wm type-name))
(defgeneric clear-fact-type (wm type-name))
(defgeneric delete-fact (wm fact &optional mw))

;;; For a simple list, add-fact simply prepends the new fact onto the list
(defmethod add-fact (wm fact)
  (cons fact wm)
)

;;; For a simple list, delete-fact walks the list until it finds the fact,
;;; building up a reverse list of the elements seen so far.  If the fact
;;; is found, rebuild the original list from the elements before and after it.
;;; If it is not found, return the original list (somewhat expensively)
(defmethod delete-fact (wm fact &optional (mw '()))
  (let ((current (car wm)) (rest (cdr wm)))
    (if (or (eql fact current) (null wm)) 
	(append (reverse mw) rest)
	(delete-fact rest fact (cons current mw))
    )
  )
)

;;; For an EXPERT-WM object, delete-fact finds the sub-list for the correct
;;; fact type, deletes the fact from it (using the simple-list method above)
;;; and replaces the original fact-list with the newly created one.

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

;;; Add-fact-type simply prepends a new CONS cell onto the list of
;;; lists that makes up the internal data structure of the EXPERT-WM
;;; object (checking first to see if it is not already present).

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

;;; Clear-fact-type finds the CONS cell containing the list of facts
;;; of the given type, and deletes the CDR of it.

(defmethod clear-fact-type ((wm EXPERT-WM) type-name)
  (let* ((type-list (fact-lists wm))
	 (found (assoc type-name type-list))
	 )
    (and found (setf (cdr found) NIL))
))

;;; If called on an EXPERT-WM object, add-fact calls add-fact-type to
;;; make sure that there is a fact-list in which the new fact could be
;;; stored, then calls the simple-list versin of add-fact on that sub-list

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

; Given a list of names and a binding list, return the values that
; were bound to the names, in the order they appear in the name list

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