
#|=================================
 substitute-action
 Takes a list of actions and a bindings list,
 returns a list of bound/evaluated actions
 
 Example:
=================================|#

(defun substitute-action (actionList bindingList)
  (eval-action (ruleSubst actionList bindingList))
)

#|=================================
 eval-action
 Takes a list of actions and returns the same list
 with arithmetic expressions evaluated
 
 Example:
=================================|#
(defun eval-action (actionList) 
  (cond 
    ((null actionList)  nil)
    ((atom actionList) actionList)
    ((isArithmeticExpr actionList) (eval actionList))
    (t (mapcar #'eval-action actionList))
   )
)

#|=================================
 ruleSubst
 Takes a list of rules and applies substitution to each of them
 
 Example:
=================================|#
(defun ruleSubst ( ListOfRules  bindingList  )  
  (mapcar #'(lambda (x)  (mysubst x bindingList)) ListOfRules)
)

#|=================================
 ruleSubst-multibindings
 NEEDS WORK IF WE NEED THIS
 
 Example:
=================================|#
(defun ruleSubst-multibindings (ListOfRules ListofBindingLists)
    (mapcar #'(lambda (x) (ruleSubst ListOfRules x))
             ListofBindingLists
     )
)

#|=================================
 mysubst
 Takes a given expression and a bindings list, returns new expression
 with variables substituted with their bindings
 
 Example: (mysubst '(a =x b) ((=x.c))) => (a c b)
=================================|#
(defun mysubst (x theta)  
; (print (list "mysubst" x theta))
  (cond 
    ((null theta) nil)
    ((equal theta '((dummy dummy)) ) x )
    ((and (isVariable x) (assoc x theta))
     (mysubst (lookup x theta) theta)
     )  ;  what if  you have (=x nil)  ?
    ((atom x) x)
   ; How do we deal with lists? And do we even need to deal with them?
   ((listp x); shoould be consp
      (cons (mysubst (car x) theta ) (mysubst (cdr x) theta ))
    )   
   (t nil)
  )
)

#|=================================
 isArithmeticExpr
 Takes a given expression and returns T if the first item is +,-,*, or /
 
 Example: (isArithmeticExpr '(+ 4 5)) => T
=================================|#

(defun isArithmeticExpr ( expr)

   (cond
     ((null expr) nil)
     ((not (symbolp (car expr))) nil) 
     ((equal (symbol-name (car expr)) "+") t)
     ((equal (symbol-name (car expr)) "-") t)
     ((equal (symbol-name (car expr)) "*") t)
     ((equal (symbol-name (car expr)) "/") t)  
     (t nil)
     )
   )

#|=================================
 isVariable
 As the name implies ;-)  (i.e. checks if first char of symbol is "=")
 
 Example:
=================================|#
(defun isVariable (x)      
  (when (symbolp x )
    (if ( equal  (subseq (symbol-name x ) 0 1  ) "=" ) x nil )
    )
  )



(defun lookup (x L)
  (cdr (assoc x L))
)