#modeb(2, color(var(v),var(c)), (positive)).
#modeb(1, edge(var(v),var(v)), (positive)).
#modeh(target(var(v))).
#maxv(3).

color(v7,v1).
color(v6,v1).
color(v0,v1).
color(v5,v1).
color(v10,v3).
color(v11,v3).
color(v4,v3).
color(v8,v1).
color(v2,v3).
color(v9,v3).

edge(v8,v9).
edge(v9,v11).
edge(v0,v2).
edge(v5,v8).
edge(v4,v6).
edge(v2,v4).
edge(v4,v7).
edge(v2,v5).
edge(v8,v10).


#pos(p1, {target(v5),target(v9),target(v2)}, {target(v7),target(v10),target(v8),target(v0),target(v11),target(v6),target(v4)}).
#neg(n1, {target(v7),target(v10),target(v8),target(v0),target(v11),target(v6),target(v4)}, {target(v5),target(v9),target(v2)}).


