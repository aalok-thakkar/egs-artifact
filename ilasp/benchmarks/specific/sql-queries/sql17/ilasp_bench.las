#modeb(1, input_a(var(id),var(n),var(s)), (positive)).
#modeb(1, input0(var(id),var(c),var(p)), (positive)).
#modeb(1, c0(var(p)), (positive)).
#modeb(1, c1(var(n)), (positive)).
#modeh(output_a(var(id),var(n),var(s))).
#maxv(3).

input_a(v0,v4,v5).
input_a(v0,v1,v2).
input_a(v3,v1,v2).

input0(v3,v8,v9).
input0(v0,v6,v7).

c0(v7).

c1(v4).


#pos(p1, {output_a(v0,v4,v5)}, {output_a(v0,v1,v2),output_a(v3,v1,v2),output_a(v3,v4,v5),output_a(v0,v4,v2),output_a(v3,v1,v5),output_a(v0,v1,v5),output_a(v3,v4,v2)}).
#neg(n1, {output_a(v0,v1,v2),output_a(v3,v1,v2),output_a(v3,v4,v5),output_a(v0,v4,v2),output_a(v3,v1,v5),output_a(v0,v1,v5),output_a(v3,v4,v2)}, {output_a(v0,v4,v5)}).


