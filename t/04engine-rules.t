#!/sw/bin/clisp

(load "test-harness.lisp")
(load "engine.lisp")
(load "knowledge_base.lisp")

(load "rule-test.lisp")


(defun likes-lotr (kb) 
  (mapcar (lambda (f) (add-fact kb f)) 
	  '(
	    (USER-LIKES-MOVIE "Lord of the Rings: The Return of the King, The (2003)")
	    (USER-LIKES-MOVIE "Lord of the Rings: The Fellowship of the Ring, The (2001)")
	    (USER-LIKES-MOVIE "Lord of the Rings: The Two Towers, The (2002)") 
	    )

))

(likes-lotr knowledge-base)

(format T "1..2~%")
;; Test 1: did we get the candidates in?
(tap-output #'candidate-list  
	    (list
	     (list
	      (list knowledge-base 'user-likes-movie)
	      '(
		(USER-LIKES-MOVIE "Lord of the Rings: The Two Towers, The (2002)") 
		(USER-LIKES-MOVIE "Lord of the Rings: The Fellowship of the Ring, The (2001)")
		(USER-LIKES-MOVIE "Lord of the Rings: The Return of the King, The (2003)")
		)
	      "Candidates into DB" 
	    ))
	    1
)


(defvar actors-output)
(setf actors-output '((USER-LIKES-ACTOR "Tyler, Liv" 3) (USER-LIKES-ACTOR "Otto, Miranda" 2) (USER-LIKES-ACTOR "McLeod, Sarah (II)" 2) (USER-LIKES-ACTOR "Jackson, Katie (I)" 3)
 (USER-LIKES-ACTOR "Blanchett, Cate" 3) (USER-LIKES-ACTOR "Wood, Elijah" 3) (USER-LIKES-ACTOR "Wenham, David" 2) (USER-LIKES-ACTOR "Weaving, Hugo" 3)
 (USER-LIKES-ACTOR "Ure, Stephen" 2) (USER-LIKES-ACTOR "Urban, Karl" 2) (USER-LIKES-ACTOR "Stanton, Stephen" 1) (USER-LIKES-ACTOR "Spence, Bruce (I)" 1)
 (USER-LIKES-ACTOR "Sinclair, Harry (II)" 2) (USER-LIKES-ACTOR "Serkis, Andy" 3) (USER-LIKES-ACTOR "Rhys-Davies, John" 3) (USER-LIKES-ACTOR "Rangi, Shane" 2)
 (USER-LIKES-ACTOR "Pollock, Robert (I)" 2) (USER-LIKES-ACTOR "Phillips, Bruce (I)" 2) (USER-LIKES-ACTOR "Noble, John (I)" 2) (USER-LIKES-ACTOR "Mortensen, Viggo" 3)
 (USER-LIKES-ACTOR "Monaghan, Dominic" 3) (USER-LIKES-ACTOR "McKenzie, Bret" 2) (USER-LIKES-ACTOR "McKellen, Ian" 3) (USER-LIKES-ACTOR "Makoare, Lawrence" 2)
 (USER-LIKES-ACTOR "Lee, Christopher (I)" 3) (USER-LIKES-ACTOR "Jackson, Peter (I)" 3) (USER-LIKES-ACTOR "Jackson, Billy (III)" 3)
 (USER-LIKES-ACTOR "Howard, Alan (I)" 2) (USER-LIKES-ACTOR "Hopkins, Bruce" 2) (USER-LIKES-ACTOR "Holm, Ian" 2) (USER-LIKES-ACTOR "Hill, Bernard" 2)
 (USER-LIKES-ACTOR "Hartley, Lee" 3) (USER-LIKES-ACTOR "Edgerly, Chris" 1) (USER-LIKES-ACTOR "Dourif, Brad" 2) (USER-LIKES-ACTOR "Csokas, Marton" 2)
 (USER-LIKES-ACTOR "Chaikin, Andrew (I)" 1) (USER-LIKES-ACTOR "Brophy, Jed" 2) (USER-LIKES-ACTOR "Boyd, Billy (I)" 3) (USER-LIKES-ACTOR "Blum, Steve (IX)" 2)
 (USER-LIKES-ACTOR "Bloom, Orlando" 3) (USER-LIKES-ACTOR "Bean, Sean" 3) (USER-LIKES-ACTOR "Baker, Sala" 3) (USER-LIKES-ACTOR "Bach, John (I)" 2)
 (USER-LIKES-ACTOR "Aston, David (I)" 1) (USER-LIKES-ACTOR "Astin, Sean" 3) (USER-LIKES-ACTOR "Appleby, Noel" 2) (USER-LIKES-ACTOR "Beynon-Cole, Victoria" 2)
 (USER-LIKES-ACTOR "Parker, Craig (I)" 2) (USER-LIKES-ACTOR "Lee, Alan (II)" 2) (USER-LIKES-ACTOR "Grieve, Philip" 2) (USER-LIKES-ACTOR "Benzon, Jørn" 2)
 (USER-LIKES-ACTOR "Ward, Jim (I)" 1) (USER-LIKES-ACTOR "Trickett, Ray" 1)))

(engine (list new-actor-rule update-actor-rule) knowledge-base)

(tap-output #'candidate-list  
	    (list
	     (list
	      (list knowledge-base 'user-likes-actor)
	      actors-output
	      "Actor rules succeeded" 
	    ))
	    2
)
