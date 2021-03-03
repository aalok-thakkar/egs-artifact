#modeb(3, edge(var(V),var(V)), (positive)).
#modeb(3, colour(var(V),var(C)), (positive)).
#modeb(3, red(var(C)), (positive)).
#modeb(3, green(var(C)), (positive)).
#modeh(target(var(V))).
#maxv(10).

edge(1,0).
edge(5,6).
edge(0,1).
edge(3,4).
edge(2,4).
edge(2,3).
edge(7,8).

colour(6,9).
colour(7,10).
colour(3,9).
colour(2,9).
colour(0,9).
colour(1,10).
colour(5,9).
colour(4,10).
colour(8,10).

red(9).

green(10).


#pos(p1, {target(6),target(3),target(1),target(4)}, {target(0),target(8),target(5),target(2),target(7)}).
#neg(n1, {target(0),target(8),target(5),target(2),target(7)}, {target(6),target(3),target(1),target(4)}).


