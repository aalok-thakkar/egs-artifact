#modeb(3, reachingdefexit(var(ID),var(S),var(V)), (positive)).
#modeb(3, flow(var(ID),var(ID)), (positive)).
#modeh(reachingdefentry(var(ID),var(S),var(V))).
#maxv(10).

reachingdefexit(3,4,5).
reachingdefexit(6,7,8).
reachingdefexit(0,1,2).

flow(12,6).
flow(10,11).
flow(0,9).


#pos(p1, {reachingdefentry(9,1,2)}, {reachingdefentry(11,7,5),reachingdefentry(6,7,8),reachingdefentry(0,4,2),reachingdefentry(9,7,5),reachingdefentry(6,4,8),reachingdefentry(6,1,2),reachingdefentry(10,7,8),reachingdefentry(10,4,5),reachingdefentry(11,7,8),reachingdefentry(11,4,5),reachingdefentry(3,1,5),reachingdefentry(9,7,8),reachingdefentry(11,4,8),reachingdefentry(0,1,5),reachingdefentry(9,4,5),reachingdefentry(10,4,8),reachingdefentry(12,7,2),reachingdefentry(3,1,8),reachingdefentry(0,1,8),reachingdefentry(9,4,8),reachingdefentry(3,7,5),reachingdefentry(12,1,5),reachingdefentry(10,1,2),reachingdefentry(11,1,2),reachingdefentry(0,7,5),reachingdefentry(12,4,2),reachingdefentry(10,7,5),reachingdefentry(3,7,8),reachingdefentry(12,1,8),reachingdefentry(3,4,5),reachingdefentry(6,7,2),reachingdefentry(0,7,8),reachingdefentry(0,4,5),reachingdefentry(6,4,2),reachingdefentry(0,4,8),reachingdefentry(6,1,5),reachingdefentry(3,4,8),reachingdefentry(10,7,2),reachingdefentry(11,7,2),reachingdefentry(6,1,8),reachingdefentry(10,4,2),reachingdefentry(9,7,2),reachingdefentry(11,4,2),reachingdefentry(3,1,2),reachingdefentry(12,7,5),reachingdefentry(0,1,2),reachingdefentry(9,4,2),reachingdefentry(6,4,5),reachingdefentry(9,1,5),reachingdefentry(12,4,5),reachingdefentry(12,7,8),reachingdefentry(10,1,5),reachingdefentry(11,1,5),reachingdefentry(9,1,8),reachingdefentry(12,4,8),reachingdefentry(6,7,5),reachingdefentry(10,1,8),reachingdefentry(12,1,2),reachingdefentry(3,7,2),reachingdefentry(11,1,8),reachingdefentry(0,7,2),reachingdefentry(3,4,2)}).
#neg(n1, {reachingdefentry(11,7,5),reachingdefentry(6,7,8),reachingdefentry(0,4,2),reachingdefentry(9,7,5),reachingdefentry(6,4,8),reachingdefentry(6,1,2),reachingdefentry(10,7,8),reachingdefentry(10,4,5),reachingdefentry(11,7,8),reachingdefentry(11,4,5),reachingdefentry(3,1,5),reachingdefentry(9,7,8),reachingdefentry(11,4,8),reachingdefentry(0,1,5),reachingdefentry(9,4,5),reachingdefentry(10,4,8),reachingdefentry(12,7,2),reachingdefentry(3,1,8),reachingdefentry(0,1,8),reachingdefentry(9,4,8),reachingdefentry(3,7,5),reachingdefentry(12,1,5),reachingdefentry(10,1,2),reachingdefentry(11,1,2),reachingdefentry(0,7,5),reachingdefentry(12,4,2),reachingdefentry(10,7,5),reachingdefentry(3,7,8),reachingdefentry(12,1,8),reachingdefentry(3,4,5),reachingdefentry(6,7,2),reachingdefentry(0,7,8),reachingdefentry(0,4,5),reachingdefentry(6,4,2),reachingdefentry(0,4,8),reachingdefentry(6,1,5),reachingdefentry(3,4,8),reachingdefentry(10,7,2),reachingdefentry(11,7,2),reachingdefentry(6,1,8),reachingdefentry(10,4,2),reachingdefentry(9,7,2),reachingdefentry(11,4,2),reachingdefentry(3,1,2),reachingdefentry(12,7,5),reachingdefentry(0,1,2),reachingdefentry(9,4,2),reachingdefentry(6,4,5),reachingdefentry(9,1,5),reachingdefentry(12,4,5),reachingdefentry(12,7,8),reachingdefentry(10,1,5),reachingdefentry(11,1,5),reachingdefentry(9,1,8),reachingdefentry(12,4,8),reachingdefentry(6,7,5),reachingdefentry(10,1,8),reachingdefentry(12,1,2),reachingdefentry(3,7,2),reachingdefentry(11,1,8),reachingdefentry(0,7,2),reachingdefentry(3,4,2)}, {reachingdefentry(9,1,2)}).


