
(load "match.lisp")
(load "substitute-action.lisp")

;; These are from Ben's match-test
(defvar test-wm NIL)
(setf test-wm
  '(
    (movie "Quantum of Solace" (action 1) (comedy 0))
    (movie "The Court Jester" (action 0) (comedy 1))
    (movie "The Fellowship of the Ring" (action 0) (comedy 0))
    (director "The Fellowship of the Ring" "Jackson, Peter")
    (actor "The Fellowship of the Ring" "Wood, Elijah")
    )
)
(defvar find-peter-jackson NIL)
(setf find-peter-jackson '(
  (movie =mname (action =a) (comedy =c))
  (director =mname =dirname)
 )
)

;; Bindings is the first part of what match-rule returns
;; NOTE: We're manually adding a binding (=rank . 5) to test the evaluation
;; of arithmetic operators with variables inside them
(defvar bindings NIL)
(setf bindings (append (car (match-rule find-peter-jackson test-wm))
		       (list (cons '=rank 5)))
)

;; List of actions, not very meaningful (add and delete the same movie)
;; Just for testing
(defvar actions NIL)
(setf actions '((add (movie =mname (rank (+ =rank 5))))
		(remove (movie =mname (rank (- =rank 3))))
		)
)

;; CALL THIS FUNCTION TO SEE TEST OUTPUT
;; We should probably put this into the same framework Ben was using
;; (i.e. compare it to the known output)

;(substitute-action actions bindings)