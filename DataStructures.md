The generalized expert system processor underlying the Movie Expert uses two classes that were defined to make

# Rule #

The RULE class defines a set of conditions to search for (specifically, a set of patterns that must match against actual facts in the working memory), and a set of actions that should be taken when those conditions are met.  It also implements a number of bookkeeping features, some of which are automatic and some of which must be activated at object instantiation time.

## Initialization arguments ##


|   Init key         | required?  | content |  default |
|:-------------------|:-----------|:--------|:---------|
|  :pattern-list | Yes  | A list of patterns, as described below |
|  :action-list   | Yes  | A list of actions, as described in the top-level README  |
|  :match-length  |  | An integer between 1 and the length of the pattern list | `(length pattern-list)` |
|  :close-on-bindings |  |  A list of bind variable names (e.g. `=MOVIENAME`) | NIL |
|  :exhaustible  |  |  A T/NIL value | NIL |
|  :match-once |  |  A T/NIL value | NIL |
|  :pre-bindings |  | A binding list (suitable for `assoc`) | NIL |

So for example:
```
(defvar rule1 (make-instance 'RULE 
    :pattern-list '((movie =mname 2006 * * * * *)  (user-input =mname))
    :action-list   '((ADD (user-likes-new-movies)))
    :match-length 1
    :exhaustible T
))
```


In more detail:

### pattern-list (required) ###

This a list of "patterns" defined using the syntax described below.  When the working memory is searched for facts matching this rule, matches are sought for each pattern in this list in order, using a depth-first search: when a match for the first pattern is found, the match engine will begin to search for matches to the second pattern (if any) using the binding list produced by the first match.

### action-list (required) ###

A list of actions to be taken when the rule is successfully matched.  The valid actions are as described in the top-level documentation.


### match-length ###
```
      :match-length 3 ; defaults to the length of the pattern-list
```
All rules have a closed list of sets of facts on which they have already matched.  For some rules, not all of the facts matched may be significant (this is frequently the case in rules designed to increment counters, since there is no UPDATE action), and a simple closed-list would allow the rule to match again on facts that it should not have been to match on.

To address this issue, the `:match-length` parameter may be set during object instantiation.  If it is set to some value less than the length of the pattern-list, only that number of facts will be considered when checking the closed list.

### close-on-bindings ###

```

    :close-on-bindings '(=ACTORNAME =GENRE)
```

Yet another way in which a rule can be restricted from matching too many times: this argument tells the rule-processing engine that this rule should only match once per valid combination of values for the bind variables supplied.  So in the example above, we might have a rule that matched on actors, movies and genres, but should only be allowed to fire once per distinct (actor, genre) pair.  The variables listed in this argument must be bound
by the pattern-list for this rule.

### exhaustible ###

Certain rules (many, in the case of the movie recommendation system) act only on facts that are created by higher-priority rules.  This implies that if the rule ever begins to fire, all of the facts that it may ever match are already in the working memory.  This allows for several important optimizations.  Principally, however, it means that if a match on this rule is ever attempted and then fails, it means that all subsequent attempts to match the rule will fail: the rule is considered "exhausted".

Setting this flag at instantiation time represents a promise from the rule-writer to the engine that valid matches for this rule will never be added to the working memory by lower-priority rules: if it is set, match performance is dramatically improved in some cases, but facts added after the rule first fires may not be successfully matched.

### match-once ###

Certain rules may match multiple times but should fire at most one time.  If the `:match-once` parameter is set to a non-NIL value at instantiation, the rule will be marked as un-matchable after the first time it matches.

### pre-bindings ###

```
    :pre-bindings '(=MIN-COUNT . 3)
```

Since our match syntax does not allow for comparisons against fixed values, but only against bound variables, this facility is supplied to allow rule writers to pre-bind certain values.  The example above could be used in a pattern like `(user-likes-actor =actorname >min-count)`.

## Interface ##


### Accessors ###

  * pattern-list
  * closed-list
  * action-list
  * match-length
  * exhausted
  * close-on-bindings
  * match-once


### Methods ###


  * `(exhaust rule)`  Marks a rule as exhausted, if it is an exhaustible rule.  In any case, returns NIL.
  * `(add-to-closed rule result)` Add the fact list in this result (or a prefix of that list, if match-length is set to something less than the maximum)  to the closed list for this rule.
  * `(closedp rule fact-list)` Test if this list of facts is in the closed list (shortcuts quickly for lists of the wrong length).



## Matching Syntax ##

The syntax for patterns is derived from the syntax defined in assignment #1 of this course.  There are three important modifications:

  1. All patterns must be, at the top level, proper lists, with a symbol or string as their first element:
    * valid: `'(movie =name ...)`
    * valid: `'("moviescores" (1 2 3))`
    * INVALID: `'some-fact`
    * INVALID: `'((nested list) (other nested list))`
  1. The character `*` may be used within a pattern as a wild-card to match any fact (subject to the restriction above that patterns must be proper lists at the top level)
  1. As discussed on the first mid-term, sub-patterns with the structure `(\| p1 p2 p3)` may be used in the same manner as `(& p1 p2 p3)`: they match if any, rather than all, of the subpatterns successfully match.


# Expert-WM #

The working memory is an opaque collection of facts in the form `'(SYMBOL [arbitrary lisp data structure]* )`.  The "type" of a given fact is the first symbol: the movie recommender, for example, begins with facts of type "movie", "actor", "director" and "era"; its final product is facts of type "recommend-movie".

## Methods ##

  * `(add-fact wm fact)`  Add a new fact, prepending it to the existing list of facts of the same type.  This is effectively a constant-time operation (linear in the number of fact types currently in the memory).
  * `(delete-fact wm fact)`  Deletes a fact, if it is present in the working memory.  This takes time linear in the number of facts of the same type as the one being deleted.
  * `(candidate-list wm fact-type)`  Returns a list of facts that is guaranteed to include facts of the given type (e.g. all movies or all recommendations).