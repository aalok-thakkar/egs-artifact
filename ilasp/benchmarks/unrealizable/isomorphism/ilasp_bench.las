#modeb(3, edge(var(v), var(v)), (positive)).
#modeh(target(var(v))).
#maxv(6).

edge(v1,v0).
edge(v0,v1).


#pos(p1, {target(v0)}, {target(v1)}).
#neg(n1, {target(v1)}, {target(v0)}).


