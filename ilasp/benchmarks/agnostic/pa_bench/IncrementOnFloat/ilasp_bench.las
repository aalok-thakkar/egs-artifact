#modeb(3, forstmt(var(I),var(N),var(C),var(U)), (positive)).
#modeb(3, initexpr(var(N),var(V)), (positive)).
#modeb(3, var1(var(V),var(S),var(T)), (positive)).
#modeb(3, floattypes(var(T)), (positive)).
#modeh(incrementonfloat(var(I))).
#maxv(10).

forstmt(0,1,2,3).
forstmt(4,5,6,7).
forstmt(8,9,10,11).
forstmt(12,13,14,15).

initexpr(19,20).
initexpr(9,18).
initexpr(1,16).
initexpr(5,17).

var1(20,25,26).
var1(16,21,22).
var1(27,28,29).
var1(17,23,24).

floattypes(30).
floattypes(26).
floattypes(29).
floattypes(22).


#pos(p1, {incrementonfloat(0)}, {incrementonfloat(12),incrementonfloat(8),incrementonfloat(4)}).
#neg(n1, {incrementonfloat(12),incrementonfloat(8),incrementonfloat(4)}, {incrementonfloat(0)}).


