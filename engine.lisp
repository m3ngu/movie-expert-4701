;;;; Created on 2008-12-05 00:46:41

;;;;
;
(load "match.lisp")
(load "datastructures.lisp")
(load "substitute-action.lisp")
;
;;;; 
;interpreter function
;get rules in syntax fromat, initializes them to RULE type defined in datastructures.lisp, calls engine
;
(defun interpreter (rules WM)
  (engine (initialize rules) WM))

;;;;;
;
;initialize a list of rules recusivly:
;
(defun initialize (rules &optional (so-far NIL) (LHS (caar rules)) (RHS (cadar rules)) )
  (if (null rules) 
      so-far
    (initialize (cdr rules) (append so-far (list (make-instance 'RULE :pattern-list LHS ::action-list RHS ))))))


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
;     1.rules-tried: <positive integer>, default 0, keeps how many rules could not fire consequvily. (terminate if tries all the rules)
;     3.rule: <List>, default first element of rules, first rule to be tried, (I assumes a list with 2 elements, first is LHS, second is RHS)
;     4.LHS: <List>, default first element (LHS) of first rule.
;     5.RHS: <List>, default second element (RHS) of first rule.
;     6.new-rules: <list>, default rules with first element last, list of rules prioritized to be tried if first rule fails to fire. 
;
;
; Output:
;
;   1.WM: <list>, list of facts defined within our RPS syntax, processed by our rules.
;
;
; Processes rules in list rules on WM, returns when it can not fire any more rules, or when it fires a
; rule with terminate command in it. o
;
;;;;



;(defvar rule-test (make-instance 'RULE :pattern-list '((MOVIE "Quantum of Solace" (ACTION 1) (COMEDY 0)) (DIRECTOR =MNAME =DIRNAME)) ::action-list '((TERMINATE))))




(defun Engine (rules WM &optional (rules-tried 0) (rule (car rules)) 
                                  (LHS (get-LHS (car rules))) (RHS (get-RHS (car rules)))  ;create LHS and RHS on the go, using this part as an intial let
                                  (new-rules (append (cdr rules) (list (car rules)))))     ;ready the new-rules order in case rule can not fire (put it at the end)
  ;(print WM)  ;for debug purposes
  (cond ((null rules) WM)                                             ;if rules list is empty just return WM
    ((>= rules-tried (length rules)) WM)                              ;if tried all the rules without any action result, return WM
    ((equal LHS '(T)) (Do-Actions RHS '(T NIL) WM new-rules (1+ rules-tried)))  ;special case: if LHS is T do actions without match, lower priority to avoid looping on that rule
    (T (let* ((match-result (match-rule rule WM)))
         (if (null match-result)                                      ;if no match is found: 
             (engine new-rules WM (1+ rules-tried))                   ;call engine again, but lower priority of the rule to lowest, increase rules-tried by 1.
             (Do-Actions RHS match-result WM (append (list rule) (cdr rules)) 0))))))            ;otherwise, call do-actions to decide how to continue (set rules tried to zero)






;;;
;Do-Actions RHS match-result WM rules rules-tried &optional bindings facts command argument      [Function]
;
; Inputs:
;
;   1.RHS: <list>, list of actions to be done.  
;   2.match-result: <list>, return object of match-rule
;   3.WM: <list>, list of facts defined within our RPS syntax
;   4.rules: <list>, list of rules to be tried.used when calling engine (if no TERMINATE command is encountered)
;   5.rules-tried: <positive integer> keeps how many rules could not fire
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



(defun Do-Actions (RHS match-result WM rules rules-tried &optional (bindings (car match-result))  (facts (cadr match-result))    ;initializations
                                                                   (command (caar RHS))           (argument (cadar RHS)))
  (cond ((null RHS) (Engine rules WM rules-tried))   ;if RHS is null (all actions done), recall engine.
    ((eql command 'TERMINATE) WM)                    ;TERMINATE - > stop execution,return WM
    ((eql command 'ADD) (Do-Actions (cdr RHS)        ;ADD - > substitue bindings, add to WM, recall do-actions
                                    match-result 
                                    (WMadd (car (substitute-action (list argument) bindings)) WM) 
                                    rules 
                                    rules-tried))  
    ((eql command 'REMOVE) (Do-Actions (cdr RHS)     ;REMOVE - > delete from WM, recall do-actions
                                       match-result 
                                       (WMDelete (car (subseq facts (1- argument) argument)) WM) 
                                       rules 
                                       rules-tried))            
    (T (error "Unrecognized Command"))))             ;undefined command error




;;Generelization functions;;
;
;
(defun get-LHS (rule)
  (pattern-list rule))

(defun get-RHS (rule)
  (action-list rule))


(defun WMadd (fact WM)
    (append (list fact) WM))

(defun WMDelete (fact WM)
  (let* ((suffix (member fact WM :test #'Equal))
         (prefix (subseq WM 0 (- (length WM) (length suffix)))))
   (if (not (eq suffix nil))
       (append prefix (cdr suffix))
       WM)))


;;;;