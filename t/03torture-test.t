#!/sw/bin/clisp

(load "match.lisp")
(load "test-harness.lisp")
(load "knowledge_base.lisp")
(setf knowledge-base (make-instance 'expert-wm :facts (init-wm)))
; OK, time for some torture tests
(setf find-lotr 
      (make-instance 'rule 
       :pattern-list '(
	 (movie =mname *  * (Action *) (Adventure *) (Animation *) (Biography *) (Comedy *) (Crime *) (Drama *) (Family *) (Fantasy *) (Film-Noir *) (History *) (Horror *) (Musical *) (Mystery *) (Romance *) (Sci-Fi *) (Sport *) (Thriller *) (War *) (Western *))
	 (actor  "Wood\,\ Elijah" =mname * *)
	 (director "Jackson\,\ Peter\ \(I\)" =mname)
	 ) 
       :action-list NIL
       )
)

(run-tests 
 #'match-rule 
 (list
 (list (list find-lotr knowledge-base)
       '(((=MNAME . "Lord of the Rings: The Return of the King, The (2003)"))
	 ((MOVIE "Lord of the Rings: The Return of the King, The (2003)" 2003 8.8 (ACTION 1) (ADVENTURE 1) (ANIMATION 0) (BIOGRAPHY 0) (COMEDY 0) (CRIME 0) (DRAMA 0) (FAMILY 0) (FANTASY 1) (FILM-NOIR 0) (HISTORY 0) (HORROR 0) (MUSICAL 0) (MYSTERY 0) (ROMANCE 0) (SCI-FI 0) (SPORT 0) (THRILLER 0) (WAR 0) (WESTERN 0))
	  (ACTOR "Wood, Elijah" "Lord of the Rings: The Return of the King, The (2003)" "Frodo" "43")
	  (DIRECTOR "Jackson, Peter (I)" "Lord of the Rings: The Return of the King, The (2003)"))
	 )
       "Find a LOTR movie (Peter Jackson/Elijah Wood)"
 )
 (list (list find-lotr knowledge-base)
       '(((=MNAME . "Lord of the Rings: The Fellowship of the Ring, The (2001)"))
	 ((MOVIE "Lord of the Rings: The Fellowship of the Ring, The (2001)" 2001 8.7 (ACTION 1) (ADVENTURE 1) (ANIMATION 0)
	   (BIOGRAPHY 0) (COMEDY 0) (CRIME 0) (DRAMA 0) (FAMILY 0) (FANTASY 1) (FILM-NOIR 0) (HISTORY 0) (HORROR 0) (MUSICAL 0)
	   (MYSTERY 0) (ROMANCE 0) (SCI-FI 0) (SPORT 0) (THRILLER 0) (WAR 0) (WESTERN 0))
	  (ACTOR "Wood, Elijah" "Lord of the Rings: The Fellowship of the Ring, The (2001)" "Frodo Baggins" "32")
	  (DIRECTOR "Jackson, Peter (I)" "Lord of the Rings: The Fellowship of the Ring, The (2001)")))
       "Find another LOTR movie (Peter Jackson/Elijah Wood)"
 )
 (list (list find-lotr knowledge-base)
       
       '(((=MNAME . "Lord of the Rings: The Two Towers, The (2002)"))
	 ((MOVIE "Lord of the Rings: The Two Towers, The (2002)" 2002 8.6 (ACTION 1) (ADVENTURE 1) (ANIMATION 0) (BIOGRAPHY 0)
	   (COMEDY 0) (CRIME 0) (DRAMA 0) (FAMILY 0) (FANTASY 1) (FILM-NOIR 0) (HISTORY 0) (HORROR 0) (MUSICAL 0) (MYSTERY 0)
	   (ROMANCE 0) (SCI-FI 0) (SPORT 0) (THRILLER 0) (WAR 0) (WESTERN 0))
	  (ACTOR "Wood, Elijah" "Lord of the Rings: The Two Towers, The (2002)" "Frodo Baggins" "36")
	  (DIRECTOR "Jackson, Peter (I)" "Lord of the Rings: The Two Towers, The (2002)")))
       "Find a third LOTR movie (Peter Jackson/Elijah Wood)"
       )
 (list (list find-lotr knowledge-base) NIL "Alas, no more LOTR movies")
)
	"Torture tests on genuine data"
)