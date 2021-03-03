#modeb(2, edge(var(v),var(v)), (positive)).
#modeh(target(var(v),var(v))).
#maxv(3).

edge(v3,v3).
edge(v1,v2).
edge(v0,v1).


#pos(p1, {target(v3,v3),target(v1,v0),target(v1,v2),target(v0,v1),target(v2,v1)}, {target(v1,v3),target(v3,v1),target(v2,v3),target(v3,v2),target(v0,v2),target(v2,v2),target(v0,v3),target(v2,v0),target(v3,v0),target(v0,v0),target(v1,v1)}).
#neg(n1, {target(v1,v3),target(v3,v1),target(v2,v3),target(v3,v2),target(v0,v2),target(v2,v2),target(v0,v3),target(v2,v0),target(v3,v0),target(v0,v0),target(v1,v1)}, {target(v3,v3),target(v1,v0),target(v1,v2),target(v0,v1),target(v2,v1)}).


