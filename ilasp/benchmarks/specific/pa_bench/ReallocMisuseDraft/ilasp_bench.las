#modeb(1, reallocexp(var(fid)), (positive)).
#modeb(1, assign(var(s),var(fid)), (positive)).
#modeb(1, params(var(fid),var(i),var(s)), (positive)).
#modeh(reallocmisuse(var(fid),var(s))).
#maxv(4).
reallocexp(v2).
reallocexp(v0).
reallocexp(v1).

assign(v4,v5).
assign(v3,v8).
assign(v7,v2).
assign(v6,v1).
assign(v3,v0).

params(v5,v9,v4).
params(v2,v10,v15).
params(v8,v10,v17).
params(v8,v9,v16).
params(v1,v10,v13).
params(v2,v9,v14).
params(v0,v10,v11).
params(v0,v9,v3).
params(v8,v18,v19).
params(v1,v9,v12).


#pos(p1, {reallocmisuse(v0,v3)}, {reallocmisuse(v5,v14),reallocmisuse(v1,v4),reallocmisuse(v8,v3),reallocmisuse(v5,v3),reallocmisuse(v1,v6),reallocmisuse(v2,v17),reallocmisuse(v2,v4),reallocmisuse(v1,v15),reallocmisuse(v0,v17),reallocmisuse(v1,v14),reallocmisuse(v2,v6),reallocmisuse(v8,v7),reallocmisuse(v8,v19),reallocmisuse(v5,v7),reallocmisuse(v0,v4),reallocmisuse(v1,v3),reallocmisuse(v5,v19),reallocmisuse(v2,v15),reallocmisuse(v0,v6),reallocmisuse(v2,v14),reallocmisuse(v8,v12),reallocmisuse(v5,v12),reallocmisuse(v2,v3),reallocmisuse(v0,v15),reallocmisuse(v8,v13),reallocmisuse(v5,v13),reallocmisuse(v1,v19),reallocmisuse(v0,v14),reallocmisuse(v1,v7),reallocmisuse(v8,v11),reallocmisuse(v5,v11),reallocmisuse(v8,v16),reallocmisuse(v0,v16),reallocmisuse(v1,v12),reallocmisuse(v5,v16),reallocmisuse(v2,v19),reallocmisuse(v2,v7),reallocmisuse(v1,v13),reallocmisuse(v0,v7),reallocmisuse(v0,v19),reallocmisuse(v8,v17),reallocmisuse(v2,v12),reallocmisuse(v1,v11),reallocmisuse(v8,v4),reallocmisuse(v5,v17),reallocmisuse(v1,v16),reallocmisuse(v2,v13),reallocmisuse(v0,v12),reallocmisuse(v5,v4),reallocmisuse(v8,v6),reallocmisuse(v5,v6),reallocmisuse(v2,v11),reallocmisuse(v0,v13),reallocmisuse(v2,v16),reallocmisuse(v8,v15),reallocmisuse(v1,v17),reallocmisuse(v0,v11),reallocmisuse(v5,v15),reallocmisuse(v8,v14)}).
#neg(n1, {reallocmisuse(v5,v14),reallocmisuse(v1,v4),reallocmisuse(v8,v3),reallocmisuse(v5,v3),reallocmisuse(v1,v6),reallocmisuse(v2,v17),reallocmisuse(v2,v4),reallocmisuse(v1,v15),reallocmisuse(v0,v17),reallocmisuse(v1,v14),reallocmisuse(v2,v6),reallocmisuse(v8,v7),reallocmisuse(v8,v19),reallocmisuse(v5,v7),reallocmisuse(v0,v4),reallocmisuse(v1,v3),reallocmisuse(v5,v19),reallocmisuse(v2,v15),reallocmisuse(v0,v6),reallocmisuse(v2,v14),reallocmisuse(v8,v12),reallocmisuse(v5,v12),reallocmisuse(v2,v3),reallocmisuse(v0,v15),reallocmisuse(v8,v13),reallocmisuse(v5,v13),reallocmisuse(v1,v19),reallocmisuse(v0,v14),reallocmisuse(v1,v7),reallocmisuse(v8,v11),reallocmisuse(v5,v11),reallocmisuse(v8,v16),reallocmisuse(v0,v16),reallocmisuse(v1,v12),reallocmisuse(v5,v16),reallocmisuse(v2,v19),reallocmisuse(v2,v7),reallocmisuse(v1,v13),reallocmisuse(v0,v7),reallocmisuse(v0,v19),reallocmisuse(v8,v17),reallocmisuse(v2,v12),reallocmisuse(v1,v11),reallocmisuse(v8,v4),reallocmisuse(v5,v17),reallocmisuse(v1,v16),reallocmisuse(v2,v13),reallocmisuse(v0,v12),reallocmisuse(v5,v4),reallocmisuse(v8,v6),reallocmisuse(v5,v6),reallocmisuse(v2,v11),reallocmisuse(v0,v13),reallocmisuse(v2,v16),reallocmisuse(v8,v15),reallocmisuse(v1,v17),reallocmisuse(v0,v11),reallocmisuse(v5,v15),reallocmisuse(v8,v14)}, {reallocmisuse(v0,v3)}).


