;;; ################################################
;;;
;;; COMS COMS W4701 ARTIFICIAL INTELLIGENCE
;;; Homework 4
;;; Dec 7, 2008
;;;
;;; Contributors (alphabetically):
;;; ------------------------------
;;; Ashish Gagneja  - ag2818
;;; Ben Warfield    - bbw2108
;;; Mehmet Can Isik - mci2109
;;; Mengu Sukan     - ms3774
;;; Snehit Prabhu   - sap2131
;;; Vivek Kale      - vk2217
;;;
;;;
;;; File 2 of 2: Test
;;;
;;; ################################################


;; Note: The escape sequences (i.e. backslashes) in the movie names
;; are not required (they are there in the raw data, so we included
;; them for safe-measure)

;; =================================================================
;; Test 1 - Ben's Favorites (7/10 correct, 1/10 incorrect, 2/10 unknown)
;; =================================================================

(recommend-movies 
 '(
   "Goodfellas\ \(1990\)"
   "Rear\ Window\ \(1954\)"
   "Raiders\ of\ the\ Lost\ Ark\ \(1981\)"
   "Psycho\ \(1960\)" 
   "Memento\ \(2000\)" 
   )
)

#|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OUTPUT
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"Hmm, so you say you have enjoyed watching those 5 movies. Let me think..." 
"OK, I'm done!  Based on your input, I recommend:" 
"
                              Bonnie and Clyde (1967)     148.0
                                       Vertigo (1958)     138.5
                   Witness for the Prosecution (1957)     138.1
                              Dark Knight, The (2008)     129.0
                           Usual Suspects, The (1995)     128.7
                              Some Like It Hot (1959)     128.3
                                       Yojimbo (1961)     128.2
                               Rosemary's Baby (1968)     128.0
                             Dial M for Murder (1954)     128.0
                                Reservoir Dogs (1992)     118.4
"
|#

;; =================================================================
;; Test 2 - If the user likes Spielberg movies, the expert system
;; other Spielberg movies
;; =================================================================

(recommend-movies 
 '(
   "Jaws\ \(1975\)"
   "Schindler\'s\ List\ \(1993\)"
   )
)

#|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OUTPUT
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"Hmm, so you say you have enjoyed watching those 2 movies. Let me think..." 
"OK, I'm done!  Based on your input, I recommend:" 
"
                                  Hotel Rwanda (2004)      68.3
                                Untergang, Der (2004)      58.4
                           Saving Private Ryan (1998)      58.4
                             Great Escape, The (1963)      58.3
                            Lawrence of Arabia (1962)      48.5
                                  Pianist, The (2002)      48.4
                             Elephant Man, The (1980)      48.3
                                    Braveheart (1995)      48.3
                              Deer Hunter, The (1978)      48.2
                                 Into the Wild (2007)      48.2
"
|#

;; =================================================================
;; Test 3 - If the user likes an animation movie, the expert system
;; recommends other animation movies
;; =================================================================
(recommend-movies 
 '(
   "Ratatouille\ \(2007\)"
   "Dark\ Knight\,\ The\ \(2008\)"
  )
)

#|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OUTPUT
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"Hmm, so you say you have enjoyed watching those 2 movies. Let me think..." 
"OK, I'm done!  Based on your input, I recommend:" 
"
                              Incredibles, The (2004)      78.1
                                       WALL·E (2008)      68.6
                                       Memento (2000)      68.6
                                 Batman Begins (2005)      68.3
                                     Toy Story (1995)      68.1
                                Lion King, The (1994)      68.1
                                  Finding Nemo (2003)      68.1
                           Usual Suspects, The (1995)      58.7
                                Reservoir Dogs (1992)      58.4
                 Sen to Chihiro no kamikakushi (2001)      58.4
"
|#

;; =================================================================
;; Test 4 - If the user likes Sam Harris (actor) movies, the expert system
;; recommends other Sam Harris movies
;; =================================================================

(recommend-movies 
 '(
   "Citizen\ Kane\ \(1941\)"
   "Day\ the\ Earth\ Stood\ Still\,\ The\ \(1951\)"
   "Dial\ M\ for\ Murder\ \(1954\)"
   "Great\ Dictator\,\ The\ \(1940\)"
   "Judgment\ at\ Nuremberg\ \(1961\)"
  )
)
#|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OUTPUT
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"Hmm, so you say you have enjoyed watching those 5 movies. Let me think..." 
"OK, I'm done!  Based on your input, I recommend:" 
"
                     Manchurian Candidate, The (1962)     148.3
                                   Rear Window (1954)     138.7
                                       Vertigo (1958)     128.5
                   Witness for the Prosecution (1957)     128.1
             Man Who Shot Liberty Valance, The (1962)     128.0
                             Great Escape, The (1963)     118.3
                              Some Like It Hot (1959)     118.3
                                       Yojimbo (1961)     118.2
                               Rosemary's Baby (1968)     118.0
                                         Laura (1944)     117.9
|#

;; =================================================================
;; Test 5 - Mengu's Favorites - 8/10 correctly identified, 2/10 unknown
;; =================================================================
(recommend-movies 
 '(
   "Dark\ Knight\,\ The\ \(2008\)"
   "Lord\ of\ the\ Rings\:\ The\ Return\ of\ the\ King\,\ The\ \(2003\)"
   "Goodfellas\ \(1990\)"
   "Usual\ Suspects\,\ The\ \(1995\)"
   "Memento\ \(2000\)"
   "Matrix\,\ The\ \(1999\)"
   "Se7en\ \(1995\)"
   "Departed\,\ The\ \(2006\)"
   "Braveheart\ \(1995\)"
   "Sixth\ Sense\,\ The\ \(1999\)"
   "Pirates\ of\ the\ Caribbean\:\ The\ Curse\ of\ the\ Black\ Pearl\ \(2003\)"
)
)

#|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OUTPUT
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                Reservoir Dogs (1992)     338.4
                                 Batman Begins (2005)     328.3
                                 Prestige, The (2006)     328.3
                                      Iron Man (2008)     328.0
                                        Casino (1995)     308.0
                       Laberinto del fauno, El (2006)     298.4
                         Bourne Ultimatum, The (2007)     298.2
                                    Fight Club (1999)     288.7
                                         Léon (1994)     288.5
                        No Country for Old Men (2007)     288.3
|#

;; =================================================================
;; Test 6 - Ashish's Favorites (3/10 correct, 7/10 unknown)
;; =================================================================
(recommend-movies 
 '(
   "Godfather\,\ The\ \(1972\)"
   "Lawrence\ of\ Arabia\ \(1962\)"
   "American\ Beauty\ \(1999\)"
   "Vertigo\ \(1958\)"
   "To\ Kill\ a\ Mockingbird\ \(1962\)"
   "Fargo\ \(1996\)"
   "Gandhi\ \(1982\)"
   "Scarface\ \(1983\)"
  )
)

#|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OUTPUT
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                   Rear Window (1954)     208.7
                              Bonnie and Clyde (1967)     208.0
                              Some Like It Hot (1959)     188.3
                   Witness for the Prosecution (1957)     188.1
                           Usual Suspects, The (1995)     178.7
                                       Memento (2000)     178.6
                             Great Escape, The (1963)     178.3
                                  Hotel Rwanda (2004)     178.3
                        No Country for Old Men (2007)     178.3
                                       Yojimbo (1961)     178.2

|#
;; =================================================================
;; Test 7 - Vivek's Favorites (5/10 correct, 5/10 unknown)
;; =================================================================
(recommend-movies 
 '(
   "Batman\ Begins\ \(2005\)"
   "Schindler\'s\ List\ \(1993\)" 
   "Matrix\,\ The\ \(1999\)"
   "Fight\ Club\ \(1999\)"
   "Godfather\,\ The\ \(1972\)"
   "Terminator\ 2\:\ Judgment\ Day\ \(1991\)"
   "Sixth\ Sense\,\ The\ \(1999\)" 
   "Batman\ Begins\ \(2005\)" 
   "Forrest\ Gump\ \(1994\)"
   "Usual\ Suspects\,\ The\ \(1995\)"
   "Pulp\ Fiction\ \(1994\)" 
   "Star\ Wars\:\ Episode\ V\ \-\ The\ Empire\ Strikes\ Back\ \(1980\)"
   "Die\ Hard\ \(1988\)"
  )
)

#|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OUTPUT
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                                      Iron Man (2008)     418.0
                                Reservoir Dogs (1992)     398.4
                              Dark Knight, The (2008)     369.0
                                       Memento (2000)     358.6
                                 Prestige, The (2006)     358.3
                                      Sin City (2005)     348.3
                         Bourne Ultimatum, The (2007)     338.2
                             Kill Bill: Vol. 1 (2003)     328.2
                                  Mou gaan dou (2002)     328.0
                             Kill Bill: Vol. 2 (2004)     328.0
|#

;; =================================================================
;; Test 8 - Mehmet's Favorites (9/10 Correct, 1/10 incorrect)
;; =================================================================
(recommend-movies 
 '(
   "Shawshank\ Redemption\,\ The\ \(1994\)"
   "Star\ Wars\ \(1977\)"
   "Fight\ Club\ \(1999\)"
   "Dr\.\ Strangelove\ or\:\ How\ I\ Learned\ to\ Stop\ Worrying\ and\ Love\ the\ Bomb\ \(1964\)"
   "Matrix\,\ The\ \(1999\)"
   "Prestige\,\ The\ \(2006\)"
   "Snatch\.\ \(2000\)"
   "Incredibles\,\ The\ \(2004\)"
   "Lock\,\ Stock\ and\ Two\ Smoking\ Barrels\ \(1998\)"
   "Big\ Fish\ \(2003\)"
   "Sin\ City\ \(2005\)"
   )
)

#|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OUTPUT
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"Hmm, so you say you have enjoyed watching those 11 movies. Let me think..." 
"OK, I'm done!  Based on your input, I recommend:" 
"
                                      Iron Man (2008)     328.0
                                 Batman Begins (2005)     288.3
                              Dark Knight, The (2008)     279.0
                                Reservoir Dogs (1992)     278.4
                         Bourne Ultimatum, The (2007)     258.2
                               Wo hu cang long (2000)     258.0
                                       WALL·E (2008)     248.6
                                       Memento (2000)     248.6
                    Terminator 2: Judgment Day (1991)     248.4
                               Children of Men (2006)     248.1
"
|#

;; =================================================================
;; Test 9 - Tara's Favorites (7/10 correct, 1/10 incorrect, 2/10 unknown) 
;; =================================================================
(recommend-movies 
 '(
   "Dark\ Knight\,\ The\ \(2008\)"
   "Lord\ of\ the\ Rings\:\ The\ Return\ of\ the\ King\,\ The\ \(2003\)"
   "Gone\ with\ the\ Wind\ \(1939\)"
   "Wizard\ of\ Oz\,\ The\ \(1939\)"
   "Star\ Wars\ \(1977\)"
   "Singin\'\ in\ the\ Rain\ \(1952\)"
   "Some\ Like\ It\ Hot\ \(1959\)"
   "Gladiator\ \(2000\)"
   "Incredibles\,\ The\ \(2004\)"
   "Roman\ Holiday\ \(1953\)"
   )
)

#|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OUTPUT
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"Hmm, so you say you have enjoyed watching those 10 movies. Let me think..." 
"OK, I'm done!  Based on your input, I recommend:" 
"
                                Lion King, The (1994)     258.1
                                       Ben-Hur (1959)     248.2
                                       WALL·E (2008)     238.6
                                      Iron Man (2008)     238.0
                               Wo hu cang long (2000)     238.0
                                     Spartacus (1960)     238.0
                             Great Escape, The (1963)     228.3
                                      Big Fish (2003)     218.0
                            Planet of the Apes (1968)     218.0
                        Salaire de la peur, Le (1953)     208.2
|#