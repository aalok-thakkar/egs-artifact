#modeb(3, assigned(var(D),var(S),var(C)), (positive)).
#modeb(3, neq(var(C),var(C)), (positive)).
#modeh(conflict(var(D))).
#maxv(10).

assigned(3,1,2).
assigned(4,6,2).
assigned(3,1,7).
assigned(0,1,2).
assigned(0,5,7).
assigned(4,5,2).

neq(2,7).
neq(7,2).


#pos(p1, {conflict(3)}, {conflict(0),conflict(4)}).
#neg(n1, {conflict(0),conflict(4)}, {conflict(3)}).


