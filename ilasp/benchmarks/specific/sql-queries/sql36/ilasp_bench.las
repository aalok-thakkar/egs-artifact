#modeb(1, input_a(var(i),var(r),var(d)), (positive)).
#modeb(1, c0(var(r),var(d)), (positive)).
#modeb(5, c1(var(d),var(d)), (positive)).
#modeh(output_a(var(i),var(r),var(d))).
#maxv(8).

input_a(v0,v3,v4).
input_a(v0,v15,v16).
input_a(v0,v5,v6).
input_a(v0,v7,v8).
input_a(v0,v11,v12).
input_a(v0,v13,v14).
input_a(v0,v1,v2).
input_a(v0,v9,v10).
input_a(v0,v17,v18).

c0(v19,v10).

c1(v16,v18).
c1(v14,v16).
c1(v2,v4).
c1(v10,v12).
c1(v12,v14).
c1(v4,v6).
c1(v8,v10).
c1(v6,v8).


#pos(p1, {output_a(v0,v11,v12),output_a(v0,v15,v16),output_a(v0,v17,v18),output_a(v0,v13,v14)}, {output_a(v0,v9,v8),output_a(v0,v5,v14),output_a(v0,v15,v18),output_a(v0,v1,v2),output_a(v0,v1,v16),output_a(v0,v15,v4),output_a(v0,v9,v10),output_a(v0,v19,v8),output_a(v0,v3,v16),output_a(v0,v3,v2),output_a(v0,v1,v14),output_a(v0,v19,v10),output_a(v0,v11,v6),output_a(v0,v15,v12),output_a(v0,v7,v12),output_a(v0,v17,v8),output_a(v0,v9,v4),output_a(v0,v5,v10),output_a(v0,v7,v6),output_a(v0,v17,v6),output_a(v0,v11,v18),output_a(v0,v13,v2),output_a(v0,v13,v16),output_a(v0,v11,v4),output_a(v0,v3,v8),output_a(v0,v9,v12),output_a(v0,v9,v6),output_a(v0,v3,v10),output_a(v0,v7,v18),output_a(v0,v7,v4),output_a(v0,v17,v4),output_a(v0,v19,v12),output_a(v0,v19,v6),output_a(v0,v5,v8),output_a(v0,v9,v18),output_a(v0,v17,v12),output_a(v0,v11,v14),output_a(v0,v15,v2),output_a(v0,v5,v6),output_a(v0,v13,v10),output_a(v0,v19,v18),output_a(v0,v1,v8),output_a(v0,v19,v4),output_a(v0,v15,v14),output_a(v0,v7,v14),output_a(v0,v1,v10),output_a(v0,v9,v2),output_a(v0,v3,v6),output_a(v0,v5,v4),output_a(v0,v9,v14),output_a(v0,v1,v4),output_a(v0,v11,v16),output_a(v0,v11,v2),output_a(v0,v15,v10),output_a(v0,v19,v14),output_a(v0,v5,v12),output_a(v0,v13,v8),output_a(v0,v3,v18),output_a(v0,v3,v4),output_a(v0,v13,v6),output_a(v0,v7,v16),output_a(v0,v7,v2),output_a(v0,v17,v16),output_a(v0,v17,v2),output_a(v0,v1,v12),output_a(v0,v17,v14),output_a(v0,v1,v6),output_a(v0,v3,v12),output_a(v0,v11,v8),output_a(v0,v5,v18),output_a(v0,v13,v18),output_a(v0,v9,v16),output_a(v0,v13,v4),output_a(v0,v11,v10),output_a(v0,v3,v14),output_a(v0,v15,v8),output_a(v0,v19,v16),output_a(v0,v19,v2),output_a(v0,v1,v18),output_a(v0,v7,v8),output_a(v0,v15,v6),output_a(v0,v7,v10),output_a(v0,v17,v10),output_a(v0,v13,v12),output_a(v0,v5,v16),output_a(v0,v5,v2)}).
#neg(n1, {output_a(v0,v9,v8),output_a(v0,v5,v14),output_a(v0,v15,v18),output_a(v0,v1,v2),output_a(v0,v1,v16),output_a(v0,v15,v4),output_a(v0,v9,v10),output_a(v0,v19,v8),output_a(v0,v3,v16),output_a(v0,v3,v2),output_a(v0,v1,v14),output_a(v0,v19,v10),output_a(v0,v11,v6),output_a(v0,v15,v12),output_a(v0,v7,v12),output_a(v0,v17,v8),output_a(v0,v9,v4),output_a(v0,v5,v10),output_a(v0,v7,v6),output_a(v0,v17,v6),output_a(v0,v11,v18),output_a(v0,v13,v2),output_a(v0,v13,v16),output_a(v0,v11,v4),output_a(v0,v3,v8),output_a(v0,v9,v12),output_a(v0,v9,v6),output_a(v0,v3,v10),output_a(v0,v7,v18),output_a(v0,v7,v4),output_a(v0,v17,v4),output_a(v0,v19,v12),output_a(v0,v19,v6),output_a(v0,v5,v8),output_a(v0,v9,v18),output_a(v0,v17,v12),output_a(v0,v11,v14),output_a(v0,v15,v2),output_a(v0,v5,v6),output_a(v0,v13,v10),output_a(v0,v19,v18),output_a(v0,v1,v8),output_a(v0,v19,v4),output_a(v0,v15,v14),output_a(v0,v7,v14),output_a(v0,v1,v10),output_a(v0,v9,v2),output_a(v0,v3,v6),output_a(v0,v5,v4),output_a(v0,v9,v14),output_a(v0,v1,v4),output_a(v0,v11,v16),output_a(v0,v11,v2),output_a(v0,v15,v10),output_a(v0,v19,v14),output_a(v0,v5,v12),output_a(v0,v13,v8),output_a(v0,v3,v18),output_a(v0,v3,v4),output_a(v0,v13,v6),output_a(v0,v7,v16),output_a(v0,v7,v2),output_a(v0,v17,v16),output_a(v0,v17,v2),output_a(v0,v1,v12),output_a(v0,v17,v14),output_a(v0,v1,v6),output_a(v0,v3,v12),output_a(v0,v11,v8),output_a(v0,v5,v18),output_a(v0,v13,v18),output_a(v0,v9,v16),output_a(v0,v13,v4),output_a(v0,v11,v10),output_a(v0,v3,v14),output_a(v0,v15,v8),output_a(v0,v19,v16),output_a(v0,v19,v2),output_a(v0,v1,v18),output_a(v0,v7,v8),output_a(v0,v15,v6),output_a(v0,v7,v10),output_a(v0,v17,v10),output_a(v0,v13,v12),output_a(v0,v5,v16),output_a(v0,v5,v2)}, {output_a(v0,v11,v12),output_a(v0,v15,v16),output_a(v0,v17,v18),output_a(v0,v13,v14)}).


