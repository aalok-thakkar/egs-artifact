#modeb(1, input_a(var(b),var(date),var(date)), (positive)).
#modeb(1, c0(var(date)), (positive)).
#modeb(1, c1(var(date)), (positive)).
#modeh(output_a(var(b))).
#maxv(3).

input_a(v6,v7,v8).
input_a(v9,v10,v11).
input_a(v12,v13,v14).
input_a(v3,v4,v5).
input_a(v0,v1,v2).

c0(v5).
c0(v14).
c0(v8).
c0(v11).
c0(v2).

c1(v1).


#pos(p1, {output_a(v0)}, {output_a(v6),output_a(v9),output_a(v3),output_a(v12)}).
#neg(n1, {output_a(v6),output_a(v9),output_a(v3),output_a(v12)}, {output_a(v0)}).


