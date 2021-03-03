#modeb(1, input_a(var(n),var(s)), (positive)).
#modeb(1, neg_input0(var(n),var(s)), (positive)).
#modeb(1, c0(var(s)), (positive)).
#modeh(output_a(var(n),var(s))).
#maxv(3).

input_a(v4,v1).
input_a(v0,v2).
input_a(v3,v1).
input_a(v0,v1).

neg_input0(v4,v5).
neg_input0(v6,v7).
neg_input0(v8,v9).

c0(v1).


#pos(p1, {output_a(v4,v1)}, {output_a(v4,v7),output_a(v3,v7),output_a(v6,v9),output_a(v6,v5),output_a(v4,v9),output_a(v4,v5),output_a(v3,v9),output_a(v3,v5),output_a(v6,v2),output_a(v6,v1),output_a(v8,v7),output_a(v3,v1),output_a(v4,v2),output_a(v3,v2),output_a(v0,v7),output_a(v8,v5),output_a(v8,v9),output_a(v0,v9),output_a(v0,v5),output_a(v8,v1),output_a(v8,v2),output_a(v0,v1),output_a(v0,v2),output_a(v6,v7)}).
#neg(n1, {output_a(v4,v7),output_a(v3,v7),output_a(v6,v9),output_a(v6,v5),output_a(v4,v9),output_a(v4,v5),output_a(v3,v9),output_a(v3,v5),output_a(v6,v2),output_a(v6,v1),output_a(v8,v7),output_a(v3,v1),output_a(v4,v2),output_a(v3,v2),output_a(v0,v7),output_a(v8,v5),output_a(v8,v9),output_a(v0,v9),output_a(v0,v5),output_a(v8,v1),output_a(v8,v2),output_a(v0,v1),output_a(v0,v2),output_a(v6,v7)}, {output_a(v4,v1)}).


