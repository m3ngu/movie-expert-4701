#!/usr/local/bin/perl

use strict;

my @genres = qw(Action Adventure Animation Biography Comedy Crime 
    Drama Family Fantasy Film-Noir History Horror Musical Mystery 
    Romance Sci-Fi Sport Thriller War Western);
    
foreach my $idx (0 .. $#genres) {
    my $genre = $genres[$idx];
    my $prefix = "* " x $idx;
    my $suffix = "* " x ($#genres - $idx);
    my $matchfragment = "(movie =n * * $prefix($genre 1) $suffix)";
    print <<END_OF_EVERYTHING;
;; %%%%%%%%%%%%%%%%%%%%%%%  \U$genre\E  %%%%%%%%%%%%%%%%%%%%%%%

    ;; Add initial (user-likes-\L$genre\E ...) object
    (
     ((user-likes-movie =n)
      $matchfragment
      )
     
     ((ADD (user-likes-\L$genre\E 0)))
     -1
     T
    )
    ;; Increment (user-likes-\L$genre\E ...) object
    (
     ((user-likes-movie =n)
      $matchfragment
      (user-likes-\L$genre\E =w))
     ((REMOVE 3)
      (ADD (user-likes-\L$genre\E (+ =w 1))))
     2
     NIL
    )

    ;; Increment  (recommend-movie ...) object for each \L$genre\E movie if user likes \L$genre\E

    (
     ((user-likes-\L$genre\E =w)
       $matchfragment
      (recommend-movie =n =r)
      )
     ((REMOVE 3)
      (ADD (recommend-movie =n (+ (* 10 =w) =r)))
     )
     2
     NIL
    )


END_OF_EVERYTHING
}