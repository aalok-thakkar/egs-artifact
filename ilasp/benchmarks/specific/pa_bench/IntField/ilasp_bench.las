#modeb(1, intVar(var(s), var(i)), (positive)).
#modeb(1, store(var(s), var(s), var(s)), (positive)).
#modeb(1, varpointsto(var(s), var(h)), (positive)).
#modeh(intfield(var(h), var(s), var(i))).
#maxv(5).
store(v0,v1,v2).
store(v3,v4,v5).
store(v6,v7,v8).

varpointsto(v6,v12).
varpointsto(v10,v11).
varpointsto(v0,v9).

intVar(v5,v16).
intVar(v2,v13).
intVar(v14,v15).


#pos(p1, {intfield(v9,v1,v13)}, {intfield(v11,v3,v13),intfield(v9,v3,v15),intfield(v9,v5,v16),intfield(v12,v2,v15),intfield(v9,v0,v15),intfield(v9,v2,v16),intfield(v12,v14,v13),intfield(v9,v3,v16),intfield(v11,v6,v15),intfield(v12,v2,v16),intfield(v9,v0,v16),intfield(v9,v7,v16),intfield(v12,v3,v16),intfield(v11,v8,v13),intfield(v12,v1,v13),intfield(v11,v6,v16),intfield(v11,v4,v16),intfield(v9,v4,v13),intfield(v12,v5,v13),intfield(v11,v14,v15),intfield(v11,v10,v13),intfield(v9,v6,v15),intfield(v11,v14,v16),intfield(v11,v1,v15),intfield(v9,v8,v13),intfield(v12,v10,v15),intfield(v9,v6,v16),intfield(v11,v2,v13),intfield(v9,v14,v15),intfield(v12,v8,v13),intfield(v12,v10,v16),intfield(v9,v10,v13),intfield(v11,v5,v15),intfield(v11,v0,v13),intfield(v11,v7,v13),intfield(v11,v3,v15),intfield(v11,v5,v16),intfield(v9,v5,v13),intfield(v11,v3,v16),intfield(v9,v3,v13),intfield(v12,v2,v13),intfield(v9,v0,v13),intfield(v9,v7,v13),intfield(v12,v3,v13),intfield(v11,v8,v15),intfield(v11,v6,v13),intfield(v11,v4,v13),intfield(v12,v0,v13),intfield(v9,v4,v15),intfield(v12,v7,v13),intfield(v12,v6,v15),intfield(v12,v4,v15),intfield(v9,v4,v16),intfield(v11,v1,v16),intfield(v12,v6,v16),intfield(v12,v4,v16),intfield(v9,v6,v13),intfield(v9,v14,v16),intfield(v9,v1,v15),intfield(v12,v8,v15),intfield(v12,v10,v13),intfield(v9,v2,v13),intfield(v11,v0,v15),intfield(v9,v1,v16),intfield(v12,v14,v15),intfield(v11,v7,v15),intfield(v11,v5,v13),intfield(v9,v5,v15),intfield(v12,v14,v16),intfield(v12,v1,v15),intfield(v11,v7,v16),intfield(v12,v5,v15),intfield(v11,v8,v16),intfield(v12,v1,v16),intfield(v11,v10,v15),intfield(v9,v7,v15),intfield(v12,v3,v15),intfield(v12,v5,v16),intfield(v11,v4,v15),intfield(v12,v0,v15),intfield(v11,v14,v13),intfield(v9,v8,v15),intfield(v11,v10,v16),intfield(v12,v7,v15),intfield(v11,v2,v15),intfield(v12,v0,v16),intfield(v11,v1,v13),intfield(v9,v8,v16),intfield(v12,v7,v16),intfield(v9,v10,v15),intfield(v11,v2,v16),intfield(v12,v6,v13),intfield(v12,v4,v13),intfield(v12,v8,v16),intfield(v9,v14,v13),intfield(v9,v10,v16),intfield(v11,v0,v16),intfield(v9,v2,v15)}).
#neg(n1, {intfield(v11,v3,v13),intfield(v9,v3,v15),intfield(v9,v5,v16),intfield(v12,v2,v15),intfield(v9,v0,v15),intfield(v9,v2,v16),intfield(v12,v14,v13),intfield(v9,v3,v16),intfield(v11,v6,v15),intfield(v12,v2,v16),intfield(v9,v0,v16),intfield(v9,v7,v16),intfield(v12,v3,v16),intfield(v11,v8,v13),intfield(v12,v1,v13),intfield(v11,v6,v16),intfield(v11,v4,v16),intfield(v9,v4,v13),intfield(v12,v5,v13),intfield(v11,v14,v15),intfield(v11,v10,v13),intfield(v9,v6,v15),intfield(v11,v14,v16),intfield(v11,v1,v15),intfield(v9,v8,v13),intfield(v12,v10,v15),intfield(v9,v6,v16),intfield(v11,v2,v13),intfield(v9,v14,v15),intfield(v12,v8,v13),intfield(v12,v10,v16),intfield(v9,v10,v13),intfield(v11,v5,v15),intfield(v11,v0,v13),intfield(v11,v7,v13),intfield(v11,v3,v15),intfield(v11,v5,v16),intfield(v9,v5,v13),intfield(v11,v3,v16),intfield(v9,v3,v13),intfield(v12,v2,v13),intfield(v9,v0,v13),intfield(v9,v7,v13),intfield(v12,v3,v13),intfield(v11,v8,v15),intfield(v11,v6,v13),intfield(v11,v4,v13),intfield(v12,v0,v13),intfield(v9,v4,v15),intfield(v12,v7,v13),intfield(v12,v6,v15),intfield(v12,v4,v15),intfield(v9,v4,v16),intfield(v11,v1,v16),intfield(v12,v6,v16),intfield(v12,v4,v16),intfield(v9,v6,v13),intfield(v9,v14,v16),intfield(v9,v1,v15),intfield(v12,v8,v15),intfield(v12,v10,v13),intfield(v9,v2,v13),intfield(v11,v0,v15),intfield(v9,v1,v16),intfield(v12,v14,v15),intfield(v11,v7,v15),intfield(v11,v5,v13),intfield(v9,v5,v15),intfield(v12,v14,v16),intfield(v12,v1,v15),intfield(v11,v7,v16),intfield(v12,v5,v15),intfield(v11,v8,v16),intfield(v12,v1,v16),intfield(v11,v10,v15),intfield(v9,v7,v15),intfield(v12,v3,v15),intfield(v12,v5,v16),intfield(v11,v4,v15),intfield(v12,v0,v15),intfield(v11,v14,v13),intfield(v9,v8,v15),intfield(v11,v10,v16),intfield(v12,v7,v15),intfield(v11,v2,v15),intfield(v12,v0,v16),intfield(v11,v1,v13),intfield(v9,v8,v16),intfield(v12,v7,v16),intfield(v9,v10,v15),intfield(v11,v2,v16),intfield(v12,v6,v13),intfield(v12,v4,v13),intfield(v12,v8,v16),intfield(v9,v14,v13),intfield(v9,v10,v16),intfield(v11,v0,v16),intfield(v9,v2,v15)}, {intfield(v9,v1,v13)}).


