#modeb(1, in(var(s),var(p)), (positive)).
#modeb(1, input0(var(p),var(pn)), (positive)).
#modeb(1, input1(var(s),var(a)), (positive)).
#modeb(1, c0(var(a)), (positive)).
#modeh(out(var(pn))).
#maxv(4).

in(v0,v1).
in(v0,v3).
in(v4,v12).
in(v2,v10).
in(v0,v9).
in(v4,v8).
in(v0,v6).
in(v2,v1).
in(v4,v5).
in(v4,v7).
in(v2,v7).
in(v11,v12).
in(v4,v3).
in(v2,v3).

input0(v10,v20).
input0(v7,v17).
input0(v8,v18).
input0(v6,v16).
input0(v5,v15).
input0(v1,v13).
input0(v3,v14).
input0(v9,v19).
input0(v12,v21).

input1(v0,v22).
input1(v2,v23).
input1(v4,v24).
input1(v11,v24).

c0(v24).


#pos(p1, {out(v18),out(v14),out(v21),out(v15),out(v17)}, {out(v16),out(v13),out(v19),out(v20)}).
#neg(n1, {out(v16),out(v13),out(v19),out(v20)}, {out(v18),out(v14),out(v21),out(v15),out(v17)}).


