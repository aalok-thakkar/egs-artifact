#modeb(1, params(var(f), var(v)), (positive)).
#modeb(1, globaldecl(var(v), var(n)), (positive)).
#modeb(1, fun(var(f), var(l)), (positive)).
#modeh(modifiesglobal(var(f), var(l))).
#maxv(4).
fun(v2,v3).
fun(v4,v5).
fun(v0,v1).

params(v0,v6).
params(v2,v7).
params(v8,v9).

globaldecl(v9,v11).
globaldecl(v12,v13).
globaldecl(v6,v10).


#pos(p1, {modifiesglobal(v0,v1)}, {modifiesglobal(v2,v1),modifiesglobal(v0,v5),modifiesglobal(v4,v5),modifiesglobal(v2,v3),modifiesglobal(v8,v5),modifiesglobal(v4,v1),modifiesglobal(v0,v3),modifiesglobal(v8,v1),modifiesglobal(v4,v3),modifiesglobal(v2,v5),modifiesglobal(v8,v3)}).
#neg(n1, {modifiesglobal(v2,v1),modifiesglobal(v0,v5),modifiesglobal(v4,v5),modifiesglobal(v2,v3),modifiesglobal(v8,v5),modifiesglobal(v4,v1),modifiesglobal(v0,v3),modifiesglobal(v8,v1),modifiesglobal(v4,v3),modifiesglobal(v2,v5),modifiesglobal(v8,v3)}, {modifiesglobal(v0,v1)}).


