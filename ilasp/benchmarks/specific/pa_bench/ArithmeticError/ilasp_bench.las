#modeb(1, ismaybezero(var(i)), (positive)).
#modeb(1, intVar(var(v), var(i)), (positive)).
#modeb(1, divexp(var(id), var(v), var(v)), (positive)).
#modeh(arithmeticerror(var(id))).
#maxv(4).
divexp(v0,v1,v2).
divexp(v9,v10,v11).
divexp(v6,v7,v8).
divexp(v3,v4,v5).

intVar(v13,v14).
intVar(v15,v16).
intVar(v11,v17).
intVar(v2,v12).

ismaybezero(v16).
ismaybezero(v12).
ismaybezero(v18).


#pos(p1, {arithmeticerror(v0)}, {arithmeticerror(v3),arithmeticerror(v9),arithmeticerror(v6)}).
#neg(n1, {arithmeticerror(v3),arithmeticerror(v9),arithmeticerror(v6)}, {arithmeticerror(v0)}).


