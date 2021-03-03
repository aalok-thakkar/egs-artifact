#modeb(3, father(var(P),var(P)), (positive)).
#modeb(3, brother(var(P),var(P)), (positive)).
#modeb(3, sister(var(P),var(P)), (positive)).
#modeh(target(var(P),var(P))).
#maxv(10).

father(6,7).
father(3,4).
father(3,5).
father(0,1).
father(6,8).
father(0,2).

brother(1,2).
brother(4,5).
brother(2,1).

sister(5,2).
sister(7,8).
sister(8,7).


#pos(p1, {target(4,3),target(2,0),target(1,0)}, {target(5,8),target(7,1),target(0,6),target(6,6),target(8,7),target(8,4),target(3,0),target(5,5),target(5,3),target(8,8),target(2,7),target(2,4),target(8,5),target(5,6),target(2,8),target(7,5),target(3,2),target(2,2),target(1,1),target(7,3),target(3,1),target(2,1),target(4,0),target(7,6),target(0,0),target(1,7),target(1,4),target(6,0),target(3,7),target(3,4),target(4,4),target(1,8),target(8,3),target(3,8),target(0,4),target(1,2),target(6,4),target(4,2),target(3,5),target(8,6),target(2,5),target(5,0),target(2,3),target(4,1),target(0,2),target(0,1),target(6,2),target(6,1),target(5,7),target(5,4),target(8,0),target(2,6),target(4,7),target(0,7),target(7,0),target(4,8),target(5,2),target(6,7),target(1,5),target(5,1),target(0,8),target(1,3),target(3,3),target(4,5),target(6,8),target(7,7),target(7,4),target(8,2),target(0,5),target(0,3),target(8,1),target(1,6),target(6,5),target(7,8),target(3,6),target(6,3),target(4,6),target(7,2)}).
#neg(n1, {target(5,8),target(7,1),target(0,6),target(6,6),target(8,7),target(8,4),target(3,0),target(5,5),target(5,3),target(8,8),target(2,7),target(2,4),target(8,5),target(5,6),target(2,8),target(7,5),target(3,2),target(2,2),target(1,1),target(7,3),target(3,1),target(2,1),target(4,0),target(7,6),target(0,0),target(1,7),target(1,4),target(6,0),target(3,7),target(3,4),target(4,4),target(1,8),target(8,3),target(3,8),target(0,4),target(1,2),target(6,4),target(4,2),target(3,5),target(8,6),target(2,5),target(5,0),target(2,3),target(4,1),target(0,2),target(0,1),target(6,2),target(6,1),target(5,7),target(5,4),target(8,0),target(2,6),target(4,7),target(0,7),target(7,0),target(4,8),target(5,2),target(6,7),target(1,5),target(5,1),target(0,8),target(1,3),target(3,3),target(4,5),target(6,8),target(7,7),target(7,4),target(8,2),target(0,5),target(0,3),target(8,1),target(1,6),target(6,5),target(7,8),target(3,6),target(6,3),target(4,6),target(7,2)}, {target(4,3),target(2,0),target(1,0)}).


