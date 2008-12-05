;;;; Created on 2008-12-05 00:51:12
(defvar test-wm '((MOVIE "Quantum of Solace" (ACTION 1) (COMEDY 0))
                  (MOVIE "The Fellowship of the Ring" (ACTION 0) (COMEDY 0))
                  (MOVIE "The Court Jester" (ACTION 0) (COMEDY 1))
                  (MOVIE "Sabrina" (ACTION 0) (COMEDY 0))
                  (DIRECTOR "The Fellowship of the Ring" "Jackson, Peter")
                  (DIRECTOR "The Court Jester" "Somebody Other than Peter Jackson")
                  (ACTOR "The Fellowship of the Ring" "Wood, Elijah")
                  (ACTOR "The Fellowship of the Ring" "Tyler, Liv")
                  (ACTOR "The Court Jester" "Kaye, Danny")
                  (ACTOR "The Court Jester" "Rathbone, Basil")
                  (ACTOR "The Court Jester" "Lansbury, Angela")
                  (ACTOR "Quantum of Solace" "Craig, Daniel")))


(setf test-rules-1 '((((movie =n (action 0) (comedy 0)))  ((REMOVE 1) (ADD (just-removed =n))))))



(setf test-rules-2 '((((movie =n (action 0) (comedy 0)))  ((REMOVE 1) (ADD (just-removed =n)))) 
                     ( (T)                                    ((ADD (test-fact property test))))
                     ( (T)                                    ((TERMINATE)))))
  
  
(setf test-rules-3 '((((movie =n (action 1) (comedy 0)))  ((ADD (just-macthed =n wohooo!))))))

(setf test-rules-4 '((((movie =n (action =a) (comedy =b)) (actor =n =actorname) )  ( (REMOVE 1) (ADD (did you know =actorname played in =n))))
                       (((movie =n (action =a) (comedy =b)))  ( (REMOVE 1)))
                       (((actor =n =b))  ((REMOVE 1)))
                       (((actor =n =b))  ((REMOVE 1)))
                       ((T) ((ADD (fact-testing-no-matched-add))))
                       (((director =n =b))  ((REMOVE 1)))
                       (((actor =n =b))  ((ADD (TERMINATED BY RULE 7)) (TERMINATE)))
                       (((director =n =b))  ((ADD (TERMINATED BY RULE 8)) (TERMINATE)))
                       (((did you know =actorname played in =n))  ((ADD (TERMINATED BY RULE 9)) (TERMINATE)))
                       ((T)  ((ADD (TERMINATED BY RULE 10)) (TERMINATE)))))


;TRY:
;
;(interpreter test-rules-1 test-wm)
;(interpreter test-rules-2 test-wm)
;(interpreter test-rules-3 test-wm)
;(interpreter test-rules-4 test-wm)