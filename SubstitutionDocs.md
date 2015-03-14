# Introduction #

The following explains how our substitution function works, and the functionality we support.  The substitution function is based on our assignment 3 resolution theorem prover. We show how  we  adapt and enhance it to work with our rule-based system.


# Details #



The  substitute function takes  as  input  a binding list and a list of rules. IT returns a list of actions "facts" that are bound based on the binding list given.
> The list of action facts  is the  list of facts produced by applying the  binding List  to each right-hand side of rule in ListOfRules. Note that the size and elements of the BindingsLists  is based on the information in the movie object. The number of rules in the list could be very small.  This is based  on how many rules we have pre-defined.

> Below an example of how our substitution  function works.



> Assume  the user has specified the following movies that she likes.


  1. (movie "Quantum of Solace" (action 1) (comedy 0))
> 2. (movie "The Court Jester" (action 0) (comedy 1))
> 3. (movie "The Fellowship of the Ring" (action 0) (comedy 0))
> 4. (director "The Fellowship of the Ring" "Jackson, Peter")
> 5. (actor "The Fellowship of the Ring" "Wood, Elijah")


> The list of unbound actions are


  1. (ADD (movie =mname (rank (+ =rank 19))))
> 2. (REMOVE (movie =mname (rank (- =rank 37))))

> The list of bindings is extracted from  the "car" of what match-rule returns.

  1. (=MNAME . "The Fellowship of the Ring")
> 2. (=A . 0)
> 3. (=C . 0)
> 4. (=DIRNAME . "Jackson, Peter")
> 5. (=RANK . 5))


> To run substitution, we  type  the following function into the interpreter:

> (substitute-action actions bindings)


> If you do this,  you can see that  the  result is a list of  bound actions,  where the bindings produced from the match-rule is appleid to the actions  specified.


> List of bound actions:

  1. (ADD (MOVIE "The Fellowship of the Ring" (RANK 10)))
> 2.(REMOVE (MOVIE "The Fellowship of the Ring" (RANK 2)))




> Note that we take care of numeric evaluation  (+ , - , **, / ) . For example, the object**

'(movie (name "Kill-Bill") (rank (+ 5 2)))

transforms to

'(movie (name "Kill-Bill") (rank 7 )   )




Add your content here.  Format your content with:
  * Text in **bold** or _italic_
  * Headings, paragraphs, and lists
  * Automatic links to other wiki pages