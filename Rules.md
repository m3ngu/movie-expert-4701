# Rules #

  1. Create (user-likes-action =w) objects
  1. Create (user-likes-comedy =w) objects
  1. ...
  1. Create (user-likes-director =dname =w) objects
  1. Create (user-likes-era =ename =w) objects
  1. Create (user-likes-actor =aname =w) objects
  1. Filter (user-likes-actor =aname =w) objects for =w > 3
  1. Create (recommendation =mname =w) objects
  1. Remove (recommendation =mname =w) objects if =mname is in user input
  1. Sort (recommendation =mname =w) objects by descending =w
  1. Return first 10