#modeb(3, divexp(var(ID),var(V),var(V)), (positive)).
#modeb(3, intvar(var(V),var(I)), (positive)).
#modeb(3, ismaybezero(var(I)), (positive)).
#modeh(arithmeticerror(var(ID))).
#maxv(10).

divexp(3,4,5).
divexp(6,7,8).
divexp(9,10,11).
divexp(0,1,2).

intvar(13,14).
intvar(11,17).
intvar(2,12).
intvar(15,16).

ismaybezero(16).
ismaybezero(12).
ismaybezero(18).


#pos(p1, {arithmeticerror(0)}, {arithmeticerror(3),arithmeticerror(9),arithmeticerror(6)}).
#neg(n1, {arithmeticerror(3),arithmeticerror(9),arithmeticerror(6)}, {arithmeticerror(0)}).


