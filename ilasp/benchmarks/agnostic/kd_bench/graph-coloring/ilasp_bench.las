#modeb(3, color(var(V),var(C)), (positive)).
#modeb(3, edge(var(V),var(V)), (positive)).
#modeh(target(var(V))).
#maxv(10).

color(2,3).
color(4,3).
color(11,3).
color(9,3).
color(8,1).
color(0,1).
color(5,1).
color(10,3).
color(6,1).
color(7,1).

edge(5,8).
edge(0,2).
edge(2,4).
edge(4,6).
edge(2,5).
edge(8,10).
edge(8,9).
edge(4,7).
edge(9,11).


#pos(p1, {target(9),target(5),target(2)}, {target(11),target(7),target(4),target(8),target(6),target(10),target(0)}).
#neg(n1, {target(11),target(7),target(4),target(8),target(6),target(10),target(0)}, {target(9),target(5),target(2)}).


