;;;; Created on 2008-12-05 00:51:12

(defvar test-recommend-rule)
(setf test-recommend-rule
      '(

;; %%%%%%%%%%%%%%%%%%  RECOMMEND-MOVIE  %%%%%%%%%%%%%%%%%%

	;; Add initial (recommend-movie ...) object for each movie
	(
	 ((movie =n * =r * * * * * * * * * * * * * * * * * * * *)
	  )
	 
	 ((ADD (recommend-movie =n =r)))
	 
	 1
	 
	 NIL
	)

;; %%%%%%%%%%%%%%%%%%%%%%%  ACTION  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-action ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * (Action 1) * * * * * * * * * * * * * * * * * * * )
      )
     
     ((ADD (user-likes-action 0)))
     -1
     T
    )
    ;; Increment (user-likes-action ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * (Action 1) * * * * * * * * * * * * * * * * * * * )
      (user-likes-action =w))
     ((REMOVE 3)
      (ADD (user-likes-action (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each action movie if user likes action

    (
     ((user-likes-action =w)
       (movie =n * * (Action 1) * * * * * * * * * * * * * * * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  ADVENTURE  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-adventure ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * (Adventure 1) * * * * * * * * * * * * * * * * * * )
      )
     
     ((ADD (user-likes-adventure 0)))
     -1
     T
    )
    ;; Increment (user-likes-adventure ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * (Adventure 1) * * * * * * * * * * * * * * * * * * )
      (user-likes-adventure =w))
     ((REMOVE 3)
      (ADD (user-likes-adventure (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each adventure movie if user likes adventure

    (
     ((user-likes-adventure =w)
       (movie =n * * * (Adventure 1) * * * * * * * * * * * * * * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  ANIMATION  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-animation ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * (Animation 1) * * * * * * * * * * * * * * * * * )
      )
     
     ((ADD (user-likes-animation 0)))
     -1
     T
    )
    ;; Increment (user-likes-animation ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * (Animation 1) * * * * * * * * * * * * * * * * * )
      (user-likes-animation =w))
     ((REMOVE 3)
      (ADD (user-likes-animation (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each animation movie if user likes animation

    (
     ((user-likes-animation =w)
       (movie =n * * * * (Animation 1) * * * * * * * * * * * * * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  BIOGRAPHY  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-biography ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * (Biography 1) * * * * * * * * * * * * * * * * )
      )
     
     ((ADD (user-likes-biography 0)))
     -1
     T
    )
    ;; Increment (user-likes-biography ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * (Biography 1) * * * * * * * * * * * * * * * * )
      (user-likes-biography =w))
     ((REMOVE 3)
      (ADD (user-likes-biography (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each biography movie if user likes biography

    (
     ((user-likes-biography =w)
       (movie =n * * * * * (Biography 1) * * * * * * * * * * * * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  COMEDY  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-comedy ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * (Comedy 1) * * * * * * * * * * * * * * * )
      )
     
     ((ADD (user-likes-comedy 0)))
     -1
     T
    )
    ;; Increment (user-likes-comedy ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * (Comedy 1) * * * * * * * * * * * * * * * )
      (user-likes-comedy =w))
     ((REMOVE 3)
      (ADD (user-likes-comedy (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each comedy movie if user likes comedy

    (
     ((user-likes-comedy =w)
       (movie =n * * * * * * (Comedy 1) * * * * * * * * * * * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  CRIME  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-crime ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * (Crime 1) * * * * * * * * * * * * * * )
      )
     
     ((ADD (user-likes-crime 0)))
     -1
     T
    )
    ;; Increment (user-likes-crime ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * (Crime 1) * * * * * * * * * * * * * * )
      (user-likes-crime =w))
     ((REMOVE 3)
      (ADD (user-likes-crime (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each crime movie if user likes crime

    (
     ((user-likes-crime =w)
       (movie =n * * * * * * * (Crime 1) * * * * * * * * * * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  DRAMA  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-drama ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * (Drama 1) * * * * * * * * * * * * * )
      )
     
     ((ADD (user-likes-drama 0)))
     -1
     T
    )
    ;; Increment (user-likes-drama ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * (Drama 1) * * * * * * * * * * * * * )
      (user-likes-drama =w))
     ((REMOVE 3)
      (ADD (user-likes-drama (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each drama movie if user likes drama

    (
     ((user-likes-drama =w)
       (movie =n * * * * * * * * (Drama 1) * * * * * * * * * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  FAMILY  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-family ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * (Family 1) * * * * * * * * * * * * )
      )
     
     ((ADD (user-likes-family 0)))
     -1
     T
    )
    ;; Increment (user-likes-family ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * (Family 1) * * * * * * * * * * * * )
      (user-likes-family =w))
     ((REMOVE 3)
      (ADD (user-likes-family (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each family movie if user likes family

    (
     ((user-likes-family =w)
       (movie =n * * * * * * * * * (Family 1) * * * * * * * * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  FANTASY  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-fantasy ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * (Fantasy 1) * * * * * * * * * * * )
      )
     
     ((ADD (user-likes-fantasy 0)))
     -1
     T
    )
    ;; Increment (user-likes-fantasy ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * (Fantasy 1) * * * * * * * * * * * )
      (user-likes-fantasy =w))
     ((REMOVE 3)
      (ADD (user-likes-fantasy (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each fantasy movie if user likes fantasy

    (
     ((user-likes-fantasy =w)
       (movie =n * * * * * * * * * * (Fantasy 1) * * * * * * * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  FILM-NOIR  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-film-noir ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * (Film-Noir 1) * * * * * * * * * * )
      )
     
     ((ADD (user-likes-film-noir 0)))
     -1
     T
    )
    ;; Increment (user-likes-film-noir ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * (Film-Noir 1) * * * * * * * * * * )
      (user-likes-film-noir =w))
     ((REMOVE 3)
      (ADD (user-likes-film-noir (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each film-noir movie if user likes film-noir

    (
     ((user-likes-film-noir =w)
       (movie =n * * * * * * * * * * * (Film-Noir 1) * * * * * * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  HISTORY  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-history ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * (History 1) * * * * * * * * * )
      )
     
     ((ADD (user-likes-history 0)))
     -1
     T
    )
    ;; Increment (user-likes-history ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * (History 1) * * * * * * * * * )
      (user-likes-history =w))
     ((REMOVE 3)
      (ADD (user-likes-history (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each history movie if user likes history

    (
     ((user-likes-history =w)
       (movie =n * * * * * * * * * * * * (History 1) * * * * * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  HORROR  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-horror ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * (Horror 1) * * * * * * * * )
      )
     
     ((ADD (user-likes-horror 0)))
     -1
     T
    )
    ;; Increment (user-likes-horror ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * (Horror 1) * * * * * * * * )
      (user-likes-horror =w))
     ((REMOVE 3)
      (ADD (user-likes-horror (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each horror movie if user likes horror

    (
     ((user-likes-horror =w)
       (movie =n * * * * * * * * * * * * * (Horror 1) * * * * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  MUSICAL  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-musical ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * (Musical 1) * * * * * * * )
      )
     
     ((ADD (user-likes-musical 0)))
     -1
     T
    )
    ;; Increment (user-likes-musical ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * (Musical 1) * * * * * * * )
      (user-likes-musical =w))
     ((REMOVE 3)
      (ADD (user-likes-musical (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each musical movie if user likes musical

    (
     ((user-likes-musical =w)
       (movie =n * * * * * * * * * * * * * * (Musical 1) * * * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  MYSTERY  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-mystery ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * * (Mystery 1) * * * * * * )
      )
     
     ((ADD (user-likes-mystery 0)))
     -1
     T
    )
    ;; Increment (user-likes-mystery ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * * (Mystery 1) * * * * * * )
      (user-likes-mystery =w))
     ((REMOVE 3)
      (ADD (user-likes-mystery (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each mystery movie if user likes mystery

    (
     ((user-likes-mystery =w)
       (movie =n * * * * * * * * * * * * * * * (Mystery 1) * * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  ROMANCE  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-romance ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * * * (Romance 1) * * * * * )
      )
     
     ((ADD (user-likes-romance 0)))
     -1
     T
    )
    ;; Increment (user-likes-romance ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * * * (Romance 1) * * * * * )
      (user-likes-romance =w))
     ((REMOVE 3)
      (ADD (user-likes-romance (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each romance movie if user likes romance

    (
     ((user-likes-romance =w)
       (movie =n * * * * * * * * * * * * * * * * (Romance 1) * * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  SCI-FI  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-sci-fi ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * * * * (Sci-Fi 1) * * * * )
      )
     
     ((ADD (user-likes-sci-fi 0)))
     -1
     T
    )
    ;; Increment (user-likes-sci-fi ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * * * * (Sci-Fi 1) * * * * )
      (user-likes-sci-fi =w))
     ((REMOVE 3)
      (ADD (user-likes-sci-fi (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each sci-fi movie if user likes sci-fi

    (
     ((user-likes-sci-fi =w)
       (movie =n * * * * * * * * * * * * * * * * * (Sci-Fi 1) * * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  SPORT  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-sport ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * * * * * (Sport 1) * * * )
      )
     
     ((ADD (user-likes-sport 0)))
     -1
     T
    )
    ;; Increment (user-likes-sport ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * * * * * (Sport 1) * * * )
      (user-likes-sport =w))
     ((REMOVE 3)
      (ADD (user-likes-sport (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each sport movie if user likes sport

    (
     ((user-likes-sport =w)
       (movie =n * * * * * * * * * * * * * * * * * * (Sport 1) * * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  THRILLER  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-thriller ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * * * * * * (Thriller 1) * * )
      )
     
     ((ADD (user-likes-thriller 0)))
     -1
     T
    )
    ;; Increment (user-likes-thriller ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * * * * * * (Thriller 1) * * )
      (user-likes-thriller =w))
     ((REMOVE 3)
      (ADD (user-likes-thriller (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each thriller movie if user likes thriller

    (
     ((user-likes-thriller =w)
       (movie =n * * * * * * * * * * * * * * * * * * * (Thriller 1) * * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  WAR  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-war ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * * * * * * * (War 1) * )
      )
     
     ((ADD (user-likes-war 0)))
     -1
     T
    )
    ;; Increment (user-likes-war ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * * * * * * * (War 1) * )
      (user-likes-war =w))
     ((REMOVE 3)
      (ADD (user-likes-war (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each war movie if user likes war

    (
     ((user-likes-war =w)
       (movie =n * * * * * * * * * * * * * * * * * * * * (War 1) * )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


;; %%%%%%%%%%%%%%%%%%%%%%%  WESTERN  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-western ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * * * * * * * * (Western 1) )
      )
     
     ((ADD (user-likes-western 0)))
     -1
     T
    )
    ;; Increment (user-likes-western ...) object
    (
     ((user-likes-movie =n)
      (movie =n * * * * * * * * * * * * * * * * * * * * * (Western 1) )
      (user-likes-western =w))
     ((REMOVE 3)
      (ADD (user-likes-western (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each western movie if user likes western

    (
     ((user-likes-western =w)
       (movie =n * * * * * * * * * * * * * * * * * * * * * (Western 1) )
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )



(defvar new-actor-rule)
(defvar update-actor-rule)
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


(defvar new-director-rule)
(defvar update-director-rule)
(setf new-director-rule 
      (make-instance 'rule 
       :pattern-list '(
		       (user-likes-movie =moviename) 
		       (director  =directorname =moviename)
		      ) 
       :action-list '((ADD (user-likes-director =directorname 0)))
       :close-on-bindings '(=directorname)
       :exhaustible T
       )
)
(setf update-director-rule 
      (make-instance 'rule 
       :pattern-list '((user-likes-movie =moviename) 
		       (director  =directorname =moviename) 
		       (user-likes-director =directorname =w))
       :action-list '((ADD (user-likes-director =directorname (+ =w 1)))
		      (REMOVE 3))
       :match-length 2
       ; This is *also* true if and only if the rule above is exhausted first
       ;:exhaustible T 
       )
)

(defvar filter-actors)
(setf filter-actors
  (make-instance 'rule
   :pattern-list '((user-likes-actor * <cutoff))
   :action-list '((REMOVE 1))
   ; cute trick to avoid saving references to dead objects?  Or just stupid?
   ;:match-length 0
   :pre-bindings '((=CUTOFF . 3))
  )
)

(defvar new-era-rule)
(defvar update-era-rule)
;;;;; Note: era bounds are exclusive, not inclusive (startdate of 2000
;;;;; means movies from 2001 on)
(setf new-era-rule 
      (make-instance 'rule 
       :pattern-list '(
	 (user-likes-movie =moviename) 
	 (movie-era  =era-name =startdate =enddate) 
	 (movie =moviename (& >startdate <enddate)
	  * * * * * * * * * * * * * * * * * * * * *)
       ) 
       :action-list '((ADD (user-likes-era =era-name 0)))
       :close-on-bindings '(=era-name)
       :exhaustible T
       )
)
(setf update-era-rule 
      (make-instance 'rule 
       :pattern-list 
       '(
	 (user-likes-movie =moviename) 
	 (movie-era  =era-name =startdate =enddate) 
	 (movie =moviename (&  >startdate  <enddate)
	  * * * * * * * * * * * * * * * * * * * * *)
	 (user-likes-era =era-name =w)
        )
       :action-list '((ADD (user-likes-era =era-name (+ =w 1)))
		      (REMOVE 4))
       :match-length 3
       ; This is *also* true if and only if the rule above is exhausted first
       ;:exhaustible T 
       )
)

(defvar new-actor-rule)
(defvar update-actor-rule)
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


(defvar new-director-rule)
(defvar update-director-rule)
(setf new-director-rule 
      (make-instance 'rule 
       :pattern-list '(
		       (user-likes-movie =moviename) 
		       (director  =directorname =moviename)
		      ) 
       :action-list '((ADD (user-likes-director =directorname 0)))
       :close-on-bindings '(=directorname)
       :exhaustible T
       )
)
(setf update-director-rule 
      (make-instance 'rule 
       :pattern-list '((user-likes-movie =moviename) 
		       (director  =directorname =moviename) 
		       (user-likes-director =directorname =w))
       :action-list '((ADD (user-likes-director =directorname (+ =w 1)))
		      (REMOVE 3))
       :match-length 2
       ; This is *also* true if and only if the rule above is exhausted first
       ;:exhaustible T 
       )
)

(defvar filter-actors)
(setf filter-actors
  (make-instance 'rule
   :pattern-list '((user-likes-actor * <cutoff))
   :action-list '((REMOVE 1))
   ; cute trick to avoid saving references to dead objects?  Or just stupid?
   ;:match-length 0
   :pre-bindings '((=CUTOFF . 3))
  )
)

(defvar new-era-rule)
(defvar update-era-rule)
;;;;; Note: era bounds are exclusive, not inclusive (startdate of 2000
;;;;; means movies from 2001 on)
(setf new-era-rule 
      (make-instance 'rule 
       :pattern-list '(
	 (user-likes-movie =moviename) 
	 (movie-era  =era-name =startdate =enddate) 
	 (movie =moviename (& >startdate <enddate)
	  * * * * * * * * * * * * * * * * * * * * *)
       ) 
       :action-list '((ADD (user-likes-era =era-name 0)))
       :close-on-bindings '(=era-name)
       :exhaustible T
       )
)
(setf update-era-rule 
      (make-instance 'rule 
       :pattern-list 
       '(
	 (user-likes-movie =moviename) 
	 (movie-era  =era-name =startdate =enddate) 
	 (movie =moviename (&  >startdate  <enddate)
	  * * * * * * * * * * * * * * * * * * * * *)
	 (user-likes-era =era-name =w)
        )
       :action-list '((ADD (user-likes-era =era-name (+ =w 1)))
		      (REMOVE 4))
       :match-length 3
       ; This is *also* true if and only if the rule above is exhausted first
       ;:exhaustible T 
       )
)

;TRY:

;(defvar rules-object (initialize test-recommend-rule))

;(wmadd '(USER-LIKES-MOVIE "Forrest\ Gump\ \(1994\)") knowledge-base)
;(wmadd '(USER-LIKES-MOVIE "Monty\ Python\ and\ the\ Holy\ Grail\ \(1975\)") knowledge-base)
;(wmadd '(USER-LIKES-MOVIE "City\ Lights\ \(1931\)") knowledge-base)
;(wmadd '(USER-LIKES-MOVIE "Matrix\,\ The\ \(1999\)") knowledge-base)

;(candidate-list knowledge-base 'RECOMMEND-MOVIE)

;(engine rules-object knowledge-base)

;OR

;(interpreter test-recommend-rule knowledge-base)
