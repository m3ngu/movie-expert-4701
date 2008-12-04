(defclass RULE () 
  (
   (patterns :initarg :pattern-list :reader pattern-list)
   (closed   :initform '()  :accessor closed-list)
  )
)

(defgeneric add-to-closed (rule result))
(defmethod add-to-closed ((rule RULE) result)
  (setf (closed-list rule) (cons (cadr result) (closed-list rule)))
  result
)