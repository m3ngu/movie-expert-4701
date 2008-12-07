(require "movie-expert.lisp")

(recommend-movies 
 '(
   "Goodfellas\ \(1990\)"
   "Rear\ Window\ \(1954\)"
   "Raiders\ of\ the\ Lost\ Ark\ \(1981\)"
   "Psycho\ \(1960\)" 
   "Memento\ \(2000\)" 
   )
)

(recommend-movies 
 '(
   "Jaws\ \(1975\)"
   "Schindler\'s\ List\ \(1993\)"
   )
)

;Based on your input, we recommend:
;  Hotel Rwanda (2004)
;  Great Escape, The (1963)
;  Lawrence of Arabia (1962)
;  Saving Private Ryan (1998)
;  Untergang, Der (2004)
;  Spartacus (1960)
;  Raiders of the Lost Ark (1981)
;  Bridge on the River Kwai, The (1957)
;  Pianist, The (2002)
;  Indiana Jones and the Last Crusade (1989)


;Based on your input, we recommend:
;  Hotel Rwanda (2004)
;  Great Escape, The (1963)
;  Lawrence of Arabia (1962)
;  Untergang, Der (2004)
;  Spartacus (1960)
;  Bridge on the River Kwai, The (1957)
;  Pianist, The (2002)
;  Braveheart (1995)
;  Elephant Man, The (1980)
;  Deer Hunter, The (1978)

(recommend-movies 
 '(
"Ratatouille\ \(2007\)"
"Dark\ Knight\,\ The\ \(2008\)"
  )
)

(recommend-movies 
 '(
"Citizen\ Kane\ \(1941\)"
"Day\ the\ Earth\ Stood\ Still\,\ The\ \(1951\)"
"Dial\ M\ for\ Murder\ \(1954\)"
"Great\ Dictator\,\ The\ \(1940\)"
"Judgment\ at\ Nuremberg\ \(1961\)"
  )
)


;; Mengu's Favorites
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


;; Ashish's Favorites
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

;; Vivek's Favorites
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

;; Mehmet's Favorites
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
|#

;; Cound of movies by genre

#|
"ACTION 1" 57
"ADVENTURE 1" 51
"ANIMATION 1" 11
"BIOGRAPHY 1" 16
"COMEDY 1" 45
"CRIME 1" 71
"DRAMA 1" 164
"FAMILY 1" 14
"FANTASY 1" 28
"FILM-NOIR 1" 15
"HISTORY 1" 12
"HORROR 1" 15
"MUSICAL 1"  5
"MYSTERY 1" 37
"ROMANCE 1" 53
"SCI-FI 1" 27
"SPORT 1" 4
"THRILLER 1" 91
"WAR 1" 30
"WESTERN 1" 11
|#