#!/sw/bin/clisp
(load "test-harness.lisp")
(load "match.lisp")

(run-tests #'match '(
  ( (a a) T "basic equality")
  ( (a b) NIL "basic inequality")  ; basic false
  ( (a 42) NIL "number-string equality test")
  ( (42 42) T) ; numeric equality test
  ( (42 a) NIL) ; string-number equality test
  ( ((a b =c (& =d >c))  (a b c c))  NIL)
  ( ((a b =c (& =d !c))  (a b c d))  ((=C . C) (=D . D)))
  ( ((a b =c (& =d <c))  (a b c d)) NIL)
  ( ((a b =c ("|" =c <c))  (a b c c)) ((=C . C)))
  ( ((a b =c ("|" =c <c))  (a b c b)) ((=C . C)))
  ( ((a b =c ("|" =c <c))  (a b c d)) NIL )
  ( ((elephants (sally (color =c) (size =s) (mood =m)) (rose (color =c) (size <s) (mood !m))) 
    (elephants (sally (color red) (size 12) (mood chipper)) (rose (color red) (size 10) (mood weird)))) 
    ((=C . RED) (=S . 12) (=M . CHIPPER))
  )
  ( ((elephants (sally (color =c) (size =s) (mood =m)) (rose (color =c) (size <s) (mood !m))) 
   (elephants (sally (color red) (size 12) (mood chipper)) (rose color red) (size 10) (mood weird))) 
   NIL
  )
  ( ((elephant (color =c) (size =s)) (elephant (color grey) (size 12))) ((=C . GREY) (=S . 12))  )
  (  ((=a (& b !a)) (42 b)) ((=A . 42))) ; just a simple multiple-match test
  (  ((=a (& b >a)) (42 b)) NIL ) ; must not blow up
  (  ((=a (& b <a)) (42 b)) NIL ) ; must not blow up
  (  ((=a (& b >a =b b)) (a b)) ((=A . A) (=B . B)) ) ; slightly more complicated
  (  ((=a (& b <a =b b)) (a b)) NIL ) ; an obvious failure case
  (  ((a =b *) (a c e)) ( (=B . C)))  ; wildcard test	      
  (  ((a * !b) (a c e)) NIL )  ; wildcard test (negative)	      
))