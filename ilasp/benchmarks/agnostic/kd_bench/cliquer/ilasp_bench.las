#modeb(3, edge(var(V),var(V)), (positive)).
#modeh(leg(var(V),var(V))).
#maxv(10).

edge(1,2).
edge(0,1).
edge(2,3).
edge(3,0).


#pos(p1, {leg(2,0),leg(3,1),leg(1,3),leg(0,2)}, {leg(0,1),leg(3,2),leg(1,1),leg(3,3),leg(2,1),leg(0,0),leg(3,0),leg(1,2),leg(0,3),leg(2,2),leg(2,3),leg(1,0)}).
#neg(n1, {leg(0,1),leg(3,2),leg(1,1),leg(3,3),leg(2,1),leg(0,0),leg(3,0),leg(1,2),leg(0,3),leg(2,2),leg(2,3),leg(1,0)}, {leg(2,0),leg(3,1),leg(1,3),leg(0,2)}).


