;;;; Created on 2008-12-05 00:46:41

;;;;
;
(load "datastructures.lisp")
(load "match.lisp")
(load "substitute-action.lisp")

;;;
;ENGINE   rules  WM   &optional   rules-tried   rule   LHS   RHS   new-rules          [Function]
;
; Inputs:
;
;   1.rules: <list>, list of rules to be tried. First one has highest prioirty. If a rule in list can not fire any more, priority will be reduced.  
;   2.WM: <list>, list of facts defined within our RPS syntax
; 
;   optional:
;
;     1.rules-tried: <list>, default NIL, keeps the rules that could not fire consequvily.
;     3.rule: <List>, default first element of rules, first rule to be tried, (I assumes a list with 2 elements, first is LHS, second is RHS)
;     4.LHS: <List>, default first element (LHS) of first rule.
;     5.RHS: <List>, default second element (RHS) of first rule.
;     6.new-rules: <list>, default rules with first element removed, list of rules prioritized to be tried if first rule fails to fire. 
;
;
; Output:
;
;   1.WM: <list>, list of facts defined within our RPS syntax, processed by our rules.
;
;
; Processes rules in list rules on WM, returns when it can not fire any more rules, or when it fires a
; rule with terminate command in it.
;
;;;;




(defun Engine (rules WM &optional (rules-failed NIL))
  (let 	((rule (car rules)) 
	(RHS (get-RHS (car rules)))   ;create  RHS on the go, using this part as an intial let
	(new-rules (cdr rules))       ;ready the new-rules order in case rule can not fire
	(new-rules-failed (append rules-failed (list (car rules)))))   ;ready new-rules failed
  ;(print (car (candidate-list WM 'RECOMMEND-MOVIE)))  ;for debug purposes
  ;(print (length rules))  ;for debug purposes
  (if (null rules) WM                                       ;if rules list is empty (all rules failed conseq) just return WM
      (let ((match-result (match-rule rule WM)))
	(if (null match-result)                              ;if no match is found: 
	    (engine new-rules WM new-rules-failed)                   ;call engine again, add that rule to rules-failed
             (let ((action-result (Do-Actions RHS match-result WM)))
	       (if action-result 
		   (engine (append rules-failed rules) action-result) 
		   WM
		   )
	       )
	     )
))))  ;otherwise, call do-actions with rules-failed appended ro rules (to see if they have become usable)




;;;
;Do-Actions RHS match-result WM rules rules-failed &optional bindings facts command argument      [Function]
;
; Inputs:
;
;   1.RHS: <list>, list of actions to be done.  
;   2.match-result: <list>, return object of match-rule
;   3.WM: <list>, list of facts defined within our RPS syntax
;   4.rules: <list>, list of rules to be tried.used when calling engine (if no TERMINATE command is encountered)
;
;   optional:
;
;     1.bindings: <List>, default first element of match-results, bindings list from match
;     2.facts: <List>, default second element of match-results, facts that matched with the LHS of the rule.
;     3.command: <symbol>, default first element of firs action in RHS. 
;     4.argument: <list>, default second element of first action in RHS, argument for command (might be NIL) 
;
;
; Output:
;
;   1.WM: <list>, list of facts defined within our RPS syntax, processed by our rules.
;
;
; Do the actions in the given list, if no terminate is encountered call engine to continue rule firing. return WM otherwise
;
;;;;



(defun Do-Actions (RHS match-result WM &optional (bindings (car match-result))  (facts (cadr match-result))    ;initializations
                                                                   (command (caar RHS))           (argument (cadar RHS)))
  (cond ((null RHS) WM)   ;if RHS is null (all actions done), recall engine.
    ((eql command 'TERMINATE) NIL)                   ;TERMINATE - > stop execution
    ((eql command 'ADD) (Do-Actions (cdr RHS)        ;ADD - > substitue bindings, add to WM, recall do-actions
                                    match-result 
                                    (WMadd (car (substitute-action (list argument) bindings)) WM) 
                                    ))  
    ((eql command 'REMOVE) (Do-Actions (cdr RHS)     ;REMOVE - > delete from WM, recall do-actions
                                       match-result 
                                       (WMDelete (car (subseq facts (1- argument) argument)) WM) 
                                        ))            
    (T (error "Unrecognized Command"))))             ;undefined command error



;;Generalization functions;;
;  (now just shims over to generic methods in datastructures.lisp)
;
(defun get-LHS (rule)
  (if (null rule) NIL
      (pattern-list rule))
)

(defun get-RHS (rule)
  (if (null rule) NIL
      (action-list rule)
      )
)


(defun WMadd (fact WM)
   (add-fact wm fact)
)

(defun WMDelete (fact WM)
  (delete-fact wm fact)
)

;; Pasik's Quicksort


(defun select (f L key)
  (cond ((null L) L)
	((funcall f (caddr (car L)) (caddr key)) 
	 (cons (car L) (select f (cdr L) key)))
	(t (select f (cdr L) key))))


(defun quicksort (L &optional (test #'>))
  (if (or (null L) (null (cdr L))) 
    L
    (append (quicksort (select test (cdr L) (car L))
                       test)
            (cons (car L) nil)
            (quicksort
             (select #'(lambda (x y) 
                         (not (funcall test x y)))
                     (cdr L) (car L)) test))))


(defun get-top (n L)
  (subseq (quicksort L) 0 n))



;;;;
