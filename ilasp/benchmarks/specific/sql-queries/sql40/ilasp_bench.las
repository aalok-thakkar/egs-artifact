#modeb(2, employee(var(s),var(s),var(s),var(s)), (positive)).
#modeb(1, lt(var(s),var(s)), (positive)).
#modeh(output_a(var(s))).
#maxv(8).

employee(v4,v5,v6,v7).
employee(v3,v8,v9,v10).
employee(v7,v11,v12,v10).
employee(v0,v1,v2,v3).

lt(v2,v12).
lt(v9,v6).
lt(v9,v12).
lt(v2,v6).
lt(v6,v12).
lt(v9,v2).


#pos(p1, {output_a(v1)}, {output_a(v10),output_a(v5),output_a(v7),output_a(v11),output_a(v9),output_a(v2),output_a(v3),output_a(v0),output_a(v12),output_a(v6),output_a(v8),output_a(v4)}).
#neg(n1, {output_a(v10),output_a(v5),output_a(v7),output_a(v11),output_a(v9),output_a(v2),output_a(v3),output_a(v0),output_a(v12),output_a(v6),output_a(v8),output_a(v4)}, {output_a(v1)}).


