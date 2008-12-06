;;;; Created on 2008-12-05 00:51:12

(setf test-rule-user-likes-action
      '(
	(
	 ((user-likes-movie =n)
	  (movie =n * * (action 1) * * * * * * * * * * * * * * * * * * *)
	  (user-likes-action =w))
	 
	 ((REMOVE 3)
	  (ADD (user-likes-action (+ =w 1))))
	 
	 2

	 NIL
	)
       )
)

(setf test-rule-user-likes-comedy
      '(
	(
	 ((user-likes-movie =n)
	  (movie =n * * * * * * (comedy 1) * * * * * * * * * * * * * * *)
	  (user-likes-comedy =w))
	 
	 ((REMOVE 3)
	  (ADD (user-likes-comedy (+ =w 1))))
	 
	 2
	 
	 NIL
	)
       )
)

(setf new-actor-rule 
      (make-instance 'rule 
       :pattern-list '(
		       (user-likes-movie =moviename) 
		       (actor  =actorname =moviename * *)
		      ) 
       :action-list '((ADD (user-likes-actor =actorname 0)))
       :close-on-bindings '(=actorname)
       :exhaustible T
       )
)
(setf update-actor-rule 
      (make-instance 'rule 
       :pattern-list '((user-likes-movie =moviename) 
		       (actor  =actorname =moviename * *) 
		       (user-likes-actor =actorname =w))
       :action-list '((ADD (user-likes-actor =actorname (+ =w 1)))
		      (REMOVE 3))
       :match-length 2
       ; This is true if and only if the rule above is exhausted first
       ;:exhaustible T 

       )
)
;TRY:

;(defvar rules-object (initialize test-rule-user-likes-comedy))

;(wmadd '(USER-LIKES-COMEDY 0) knowledge-base)
;(wmadd '(USER-LIKES-MOVIE "Forrest\ Gump\ \(1994\)") knowledge-base)
;(wmadd '(USER-LIKES-MOVIE "Monty\ Python\ and\ the\ Holy\ Grail\ \(1975\)") knowledge-base)
;(wmadd '(USER-LIKES-MOVIE "City\ Lights\ \(1931\)") knowledge-base)

;(engine rules-object knowledge-base)

;OR

;(interpreter test-rule-user-likes-comedy knowledge-base)
