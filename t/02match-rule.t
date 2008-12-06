#!/sw/bin/clisp

(load "match.lisp")
(load "test-harness.lisp")

(defvar test-wm NIL)
(setf test-wm
  '(
    (movie "Quantum of Solace" (action 1) (comedy 0))
    (movie "The Fellowship of the Ring" (action 0) (comedy 0))
    (movie "The Court Jester" (action 0) (comedy 1))
    (movie "Sabrina" (action 0) (comedy 0))
    (director "The Fellowship of the Ring" "Jackson, Peter")
    (director "The Court Jester" "Somebody Other than Peter Jackson")
    (actor "The Fellowship of the Ring" "Wood, Elijah")
    (actor "The Fellowship of the Ring" "Tyler, Liv")
    (actor "The Court Jester" "Kaye, Danny")
    (actor "The Court Jester" "Rathbone, Basil")
    (actor "The Court Jester" "Lansbury, Angela")
    (actor "Quantum of Solace" "Craig, Daniel")
    )
)

(defvar fancy-wm NIL)
(setf fancy-wm (make-instance 'expert-wm :facts
  '(
    (movie
     (movie "Quantum of Solace" (action 1) (comedy 0))
     (movie "The Fellowship of the Ring" (action 0) (comedy 0))
     (movie "The Court Jester" (action 0) (comedy 1))
     (movie "Sabrina" (action 0) (comedy 0))
     )
    (director
     (director "The Fellowship of the Ring" "Jackson, Peter")
     (director "The Court Jester" "Somebody Other than Peter Jackson")
     )
    (actor
     (actor "The Fellowship of the Ring" "Wood, Elijah")
     (actor "The Fellowship of the Ring" "Tyler, Liv")
     (actor "The Court Jester" "Kaye, Danny")
     (actor "The Court Jester" "Rathbone, Basil")
     (actor "The Court Jester" "Lansbury, Angela")
     (actor "Quantum of Solace" "Craig, Daniel")
     )
   )
))
			      

(defvar find-peter-jackson NIL)
(setf find-peter-jackson 
      (make-instance 'rule :pattern-list
'(
  (movie =mname (action =a) (comedy =c))
  (director =mname =dirname)
 ))
)
(defvar find-bond-21 NIL)
(setf find-bond-21       
      (make-instance 'rule 
       :pattern-list  '((movie =mname (action 1) (comedy 0)))
))
(defvar find-bond-and-jackson NIL)
(setf find-bond-and-jackson 
      (make-instance 'rule :pattern-list
      '(    
	(movie "Quantum of Solace" (action 1) (comedy 0)) 
	(director =mname =dirname)
	)
      )
)
(defvar find-some-actor-once)
(setf find-some-actor-once
      (make-instance 
       'rule
       :pattern-list '((movie =mname * *) (actor =mname =aname))
       :match-length 1
       :action-list '()
       )
)

(defvar dumbest-possible-rule)
(setf  dumbest-possible-rule
       (make-instance 'rule :pattern-list '((actor  * *)) :match-once T
		      :action-list NIL
		      )
)

(defvar not-that-one!)
(setf not-that-one!
      (make-instance 'rule 
		     :pattern-list '((movie !nope * *))
		     :action-list NIL
		     :pre-bindings '(( =NOPE . "The Fellowship of the Ring"))
))

(run-tests 
 #'match-rule 
 (
  list
  (list (list find-peter-jackson test-wm) '(((=MNAME . "The Fellowship of the Ring") (=A . 0) (=C . 0)
  (=DIRNAME . "Jackson, Peter"))
 ((MOVIE "The Fellowship of the Ring" (ACTION 0) (COMEDY 0))
  (DIRECTOR "The Fellowship of the Ring" "Jackson, Peter")))
	"Find a movie with a director"
	)
  (list (list find-bond-21 test-wm) '(((=MNAME . "Quantum of Solace"))
 ((MOVIE "Quantum of Solace" (ACTION 1) (COMEDY 0)))) 
	"Find an action movie") 
  (list (list find-bond-and-jackson test-wm) '(((=MNAME . "The Fellowship of the Ring") (=DIRNAME . "Jackson, Peter"))
 ((MOVIE "Quantum of Solace" (ACTION 1) (COMEDY 0))
  (DIRECTOR "The Fellowship of the Ring" "Jackson, Peter")))
	"Find a movie with no bindings, then find and bind a director"
	)
  (list (list find-peter-jackson fancy-wm) '(((=MNAME . "The Fellowship of the Ring") (=A . 0) (=C . 0)
  (=DIRNAME . "Jackson, Peter"))
 ((MOVIE "The Fellowship of the Ring" (ACTION 0) (COMEDY 0))
  (DIRECTOR "The Fellowship of the Ring" "Jackson, Peter")))
	"Find a movie with a director in the new WM structure"
	)
  (list (list find-bond-21 fancy-wm) '(((=MNAME . "Quantum of Solace"))
 ((MOVIE "Quantum of Solace" (ACTION 1) (COMEDY 0))))
	"Find an action movie in the new WM structure"
	)
  (list (list find-bond-and-jackson fancy-wm) '(((=MNAME . "The Fellowship of the Ring") (=DIRNAME . "Jackson, Peter"))
 ((MOVIE "Quantum of Solace" (ACTION 1) (COMEDY 0))
  (DIRECTOR "The Fellowship of the Ring" "Jackson, Peter")))
	"Find an unbound movie an a bound director in the new WM")
  (list (list find-bond-and-jackson fancy-wm )
	'(((=MNAME . "The Court Jester") (=DIRNAME .  "Somebody Other than Peter Jackson"))
	  ((MOVIE "Quantum of Solace" (ACTION 1) (COMEDY 0))
	   (DIRECTOR "The Court Jester" "Somebody Other than Peter Jackson")
	   )
	  )
	"Find an action and a *different* unbound director in the new WM"
	)
  (list (list find-some-actor-once fancy-wm)
	'(((=MNAME . "Quantum of Solace") (=ANAME . "Craig, Daniel"))
	 ((MOVIE "Quantum of Solace" (ACTION 1) (COMEDY 0)) (ACTOR "Quantum of Solace" "Craig, Daniel")))
	"Find a movie with an actor, finding the same movie only once"
  )
  (list (list find-some-actor-once fancy-wm)
	'(((=MNAME . "The Fellowship of the Ring") (=ANAME . "Wood, Elijah"))
	 ((MOVIE "The Fellowship of the Ring" (ACTION 0) (COMEDY 0)) (ACTOR "The Fellowship of the Ring" "Wood, Elijah")))
	"Find a 2nd movie with an actor, finding the same movie only once"
  )
  (list (list find-some-actor-once fancy-wm)
	'(((=MNAME . "The Court Jester") (=ANAME . "Kaye, Danny"))
	 ((MOVIE "The Court Jester" (ACTION 0) (COMEDY 1)) (ACTOR "The Court Jester" "Kaye, Danny")))
  "Find a 3rd movie with an actor, finding the same movie only once"
  )
  (list (list find-some-actor-once fancy-wm) NIL "No more movies with actors")
  (list (list dumbest-possible-rule fancy-wm) 
	'(T ((ACTOR "The Fellowship of the Ring" "Wood, Elijah")))
	"Match stupidly once")
  (list (list dumbest-possible-rule fancy-wm) NIL "Don't match stupidly twice")
  (list (list not-that-one! fancy-wm)
	'(((=NOPE . "The Fellowship of the Ring"))
	 ((MOVIE "Quantum of Solace" (ACTION 1) (COMEDY 0))))
	"Pre-bound non-match")
   (list (list not-that-one! fancy-wm)
	 '(((=NOPE . "The Fellowship of the Ring"))
	   ((MOVIE "The Court Jester" (ACTION 0) (COMEDY 1))))
	 "Second pre-bound non-match"
	 )
  (list (list not-that-one! fancy-wm)
	'(((=NOPE . "The Fellowship of the Ring"))
	 ((MOVIE "Sabrina" (ACTION 0) (COMEDY 0))))
	"Third pre-bound non-match"
	)
  (list (list not-that-one! fancy-wm) NIL  "Final (actual) non-match")

)
	"Tests for the match-rule function, using dummy data"
)
