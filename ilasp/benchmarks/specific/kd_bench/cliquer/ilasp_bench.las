#modeb(2, edge(var(v),var(v)), (positive)).
#modeh(leg(var(v),var(v))).
#maxv(3).

edge(v1,v2).
edge(v3,v0).
edge(v2,v3).
edge(v0,v1).


#pos(p1, {leg(v2,v0),leg(v0,v2),leg(v3,v1),leg(v1,v3)}, {leg(v3,v3),leg(v3,v0),leg(v0,v3),leg(v2,v1),leg(v2,v2),leg(v0,v0),leg(v3,v2),leg(v1,v0),leg(v0,v1),leg(v2,v3),leg(v1,v1),leg(v1,v2)}).
#neg(n1, {leg(v3,v3),leg(v3,v0),leg(v0,v3),leg(v2,v1),leg(v2,v2),leg(v0,v0),leg(v3,v2),leg(v1,v0),leg(v0,v1),leg(v2,v3),leg(v1,v1),leg(v1,v2)}, {leg(v2,v0),leg(v0,v2),leg(v3,v1),leg(v1,v3)}).


