#modeb(2, assigned(var(d),var(s),var(c)), (positive)).
#modeb(1, neq(var(c),var(c)), (positive)).
#modeh(conflict(var(d))).
#maxv(4).

assigned(v4,v5,v2).
assigned(v0,v1,v2).
assigned(v0,v5,v7).
assigned(v4,v6,v2).
assigned(v3,v1,v7).
assigned(v3,v1,v2).

neq(v7,v2).
neq(v2,v7).


#pos(p1, {conflict(v3)}, {conflict(v4),conflict(v0)}).
#neg(n1, {conflict(v4),conflict(v0)}, {conflict(v3)}).


