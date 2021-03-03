#modeb(1, edge(var(v),var(v)), (positive)).
#modeb(1, colour(var(v),var(c)), (positive)).
#modeb(1, red(var(c)), (positive)).
#modeb(1, green(var(c)), (positive)).
#modeh(target(var(v))).
#maxv(4).

edge(v3,v4).
edge(v2,v4).
edge(v5,v6).
edge(v0,v1).
edge(v2,v3).
edge(v1,v0).
edge(v7,v8).

colour(v6,v9).
colour(v4,v10).
colour(v1,v10).
colour(v7,v10).
colour(v3,v9).
colour(v2,v9).
colour(v8,v10).
colour(v5,v9).
colour(v0,v9).

red(v9).

green(v10).


#pos(p1, {target(v3),target(v6),target(v1),target(v4)}, {target(v2),target(v8),target(v5),target(v7),target(v0)}).
#neg(n1, {target(v2),target(v8),target(v5),target(v7),target(v0)}, {target(v3),target(v6),target(v1),target(v4)}).


