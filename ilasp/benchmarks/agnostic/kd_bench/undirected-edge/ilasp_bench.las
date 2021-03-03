#modeb(3, edge(var(V),var(V)), (positive)).
#modeh(target(var(V),var(V))).
#maxv(10).

edge(1,2).
edge(3,3).
edge(0,1).


#pos(p1, {target(1,2),target(2,1),target(3,3),target(0,1),target(1,0)}, {target(3,1),target(0,0),target(2,3),target(1,1),target(2,2),target(3,2),target(0,3),target(0,2),target(1,3),target(2,0),target(3,0)}).
#neg(n1, {target(3,1),target(0,0),target(2,3),target(1,1),target(2,2),target(3,2),target(0,3),target(0,2),target(1,3),target(2,0),target(3,0)}, {target(1,2),target(2,1),target(3,3),target(0,1),target(1,0)}).


