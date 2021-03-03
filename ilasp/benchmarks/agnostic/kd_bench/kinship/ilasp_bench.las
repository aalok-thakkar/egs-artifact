#modeb(3, father(var(P),var(P)), (positive)).
#modeb(3, mother(var(P),var(P)), (positive)).
#modeh(grandparent(var(P),var(P))).
#maxv(10).

father(0,2).
father(0,1).
father(3,4).
father(2,5).

mother(6,2).
mother(6,1).
mother(1,4).
mother(7,3).


#pos(p1, {grandparent(0,5),grandparent(6,5),grandparent(7,4),grandparent(0,4),grandparent(6,4)}, {grandparent(6,6),grandparent(4,1),grandparent(1,1),grandparent(6,0),grandparent(3,5),grandparent(0,7),grandparent(6,2),grandparent(0,3),grandparent(7,0),grandparent(0,1),grandparent(2,5),grandparent(7,6),grandparent(5,7),grandparent(2,7),grandparent(5,3),grandparent(4,6),grandparent(4,0),grandparent(5,1),grandparent(7,2),grandparent(3,7),grandparent(2,3),grandparent(1,6),grandparent(1,0),grandparent(2,1),grandparent(4,2),grandparent(3,3),grandparent(1,2),grandparent(3,1),grandparent(0,6),grandparent(3,4),grandparent(7,5),grandparent(0,0),grandparent(4,4),grandparent(1,4),grandparent(6,7),grandparent(4,5),grandparent(0,2),grandparent(5,6),grandparent(1,5),grandparent(6,3),grandparent(2,0),grandparent(5,0),grandparent(6,1),grandparent(2,6),grandparent(3,6),grandparent(5,2),grandparent(3,0),grandparent(7,7),grandparent(2,2),grandparent(3,2),grandparent(5,5),grandparent(7,3),grandparent(5,4),grandparent(2,4),grandparent(4,7),grandparent(7,1),grandparent(1,7),grandparent(4,3),grandparent(1,3)}).
#neg(n1, {grandparent(6,6),grandparent(4,1),grandparent(1,1),grandparent(6,0),grandparent(3,5),grandparent(0,7),grandparent(6,2),grandparent(0,3),grandparent(7,0),grandparent(0,1),grandparent(2,5),grandparent(7,6),grandparent(5,7),grandparent(2,7),grandparent(5,3),grandparent(4,6),grandparent(4,0),grandparent(5,1),grandparent(7,2),grandparent(3,7),grandparent(2,3),grandparent(1,6),grandparent(1,0),grandparent(2,1),grandparent(4,2),grandparent(3,3),grandparent(1,2),grandparent(3,1),grandparent(0,6),grandparent(3,4),grandparent(7,5),grandparent(0,0),grandparent(4,4),grandparent(1,4),grandparent(6,7),grandparent(4,5),grandparent(0,2),grandparent(5,6),grandparent(1,5),grandparent(6,3),grandparent(2,0),grandparent(5,0),grandparent(6,1),grandparent(2,6),grandparent(3,6),grandparent(5,2),grandparent(3,0),grandparent(7,7),grandparent(2,2),grandparent(3,2),grandparent(5,5),grandparent(7,3),grandparent(5,4),grandparent(2,4),grandparent(4,7),grandparent(7,1),grandparent(1,7),grandparent(4,3),grandparent(1,3)}, {grandparent(0,5),grandparent(6,5),grandparent(7,4),grandparent(0,4),grandparent(6,4)}).


