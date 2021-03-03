#modeb(3, hasdefaultargs(var(F)), (positive)).
#modeb(3, params(var(F),var(I),var(V)), (positive)).
#modeb(3, mutable(var(V)), (positive)).
#modeh(pyfuncdefaultmutable(var(F))).
#maxv(10).

hasdefaultargs(0).
hasdefaultargs(1).
hasdefaultargs(2).
hasdefaultargs(3).

params(0,4,5).
params(2,6,16).
params(12,4,13).
params(1,10,11).
params(17,6,19).
params(17,4,18).
params(1,4,8).
params(0,6,7).
params(1,6,9).
params(12,6,14).
params(2,4,15).

mutable(7).
mutable(16).
mutable(19).
mutable(13).


#pos(p1, {pyfuncdefaultmutable(0),pyfuncdefaultmutable(2)}, {pyfuncdefaultmutable(1),pyfuncdefaultmutable(3),pyfuncdefaultmutable(17),pyfuncdefaultmutable(12)}).
#neg(n1, {pyfuncdefaultmutable(1),pyfuncdefaultmutable(3),pyfuncdefaultmutable(17),pyfuncdefaultmutable(12)}, {pyfuncdefaultmutable(0),pyfuncdefaultmutable(2)}).


