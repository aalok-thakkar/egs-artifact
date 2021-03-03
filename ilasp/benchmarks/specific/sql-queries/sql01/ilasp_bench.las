#modeb(2, input_a(var(i),var(p),var(t)), (positive)).
#modeb(1, c0(var(t)), (positive)).
#modeb(1, c1(var(t)), (positive)).
#modeh(output_a(var(i),var(p),var(t))).
#maxv(5).

input_a(v7,v8,v2).
input_a(v3,v4,v5).
input_a(v0,v1,v2).
input_a(v6,v1,v5).

c0(v2).

c1(v5).


#pos(p1, {output_a(v0,v1,v2)}, {output_a(v7,v1,v5),output_a(v7,v1,v2),output_a(v6,v4,v5),output_a(v6,v4,v2),output_a(v3,v4,v5),output_a(v3,v4,v2),output_a(v7,v8,v5),output_a(v7,v8,v2),output_a(v0,v1,v5),output_a(v6,v1,v5),output_a(v6,v1,v2),output_a(v7,v4,v5),output_a(v3,v1,v5),output_a(v7,v4,v2),output_a(v3,v1,v2),output_a(v0,v8,v2),output_a(v0,v8,v5),output_a(v0,v4,v5),output_a(v6,v8,v5),output_a(v0,v4,v2),output_a(v6,v8,v2),output_a(v3,v8,v5),output_a(v3,v8,v2)}).
#neg(n1, {output_a(v7,v1,v5),output_a(v7,v1,v2),output_a(v6,v4,v5),output_a(v6,v4,v2),output_a(v3,v4,v5),output_a(v3,v4,v2),output_a(v7,v8,v5),output_a(v7,v8,v2),output_a(v0,v1,v5),output_a(v6,v1,v5),output_a(v6,v1,v2),output_a(v7,v4,v5),output_a(v3,v1,v5),output_a(v7,v4,v2),output_a(v3,v1,v2),output_a(v0,v8,v2),output_a(v0,v8,v5),output_a(v0,v4,v5),output_a(v6,v8,v5),output_a(v0,v4,v2),output_a(v6,v8,v2),output_a(v3,v8,v5),output_a(v3,v8,v2)}, {output_a(v0,v1,v2)}).


