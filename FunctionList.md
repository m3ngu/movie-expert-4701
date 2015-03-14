A brief list of function signatures.  As things actually get implemented, pages should be added describing them slightly more formally.

  1. `match(fact, pattern, &optional previous-bindings)` ; returns T/NIL/({new-bindings})
  1. `match-rule(patterns(LHS of rules), WM(list of facts), &optional partial-matches) ;` returns T/NIL/(((bindings) (facts)) ...)
  1. `Delete({match-rule}, WM)` ; returns new-WM
  1. `Add(fact, WM)` ; returns new-WM
  1. `Do-Action(action-pattern(RHS of rules), <match-rule>, WM)`
  1. `Substitute(binding-list, pattern)` ; returns fact . Also handles list elements like (+ 5 7).
  1. `engine(rules, WM)` ; returns WM


Current task allocation:

  * match, match-rule:  Ben and Ashish (done: see MatchDocs)
  * Do-action, Delete, Add, Engine : Mehmet, Snehit
  * Substitute : Vivek, Mengu