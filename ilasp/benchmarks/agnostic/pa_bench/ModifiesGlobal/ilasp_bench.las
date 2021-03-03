#modeb(3, fun(var(F),var(L)), (positive)).
#modeb(3, params(var(F),var(V)), (positive)).
#modeb(3, globaldecl(var(V),var(N)), (positive)).
#modeh(modifiesglobal(var(F),var(L))).
#maxv(10).

fun(2,3).
fun(4,5).
fun(0,1).

params(8,9).
params(2,7).
params(0,6).

globaldecl(12,13).
globaldecl(6,10).
globaldecl(9,11).


#pos(p1, {modifiesglobal(0,1)}, {modifiesglobal(8,5),modifiesglobal(2,1),modifiesglobal(8,1),modifiesglobal(0,3),modifiesglobal(2,5),modifiesglobal(4,5),modifiesglobal(8,3),modifiesglobal(4,1),modifiesglobal(2,3),modifiesglobal(4,3),modifiesglobal(0,5)}).
#neg(n1, {modifiesglobal(8,5),modifiesglobal(2,1),modifiesglobal(8,1),modifiesglobal(0,3),modifiesglobal(2,5),modifiesglobal(4,5),modifiesglobal(8,3),modifiesglobal(4,1),modifiesglobal(2,3),modifiesglobal(4,3),modifiesglobal(0,5)}, {modifiesglobal(0,1)}).


