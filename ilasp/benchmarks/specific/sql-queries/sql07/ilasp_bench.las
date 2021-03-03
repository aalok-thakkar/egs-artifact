#modeb(2, input_a(var(i),var(n),var(s)), (positive)).
#modeb(1, neq(var(i),var(i)), (positive)).
#modeb(1, c0(var(s)), (positive)).
#modeh(output_a(var(n))).
#maxv(4).

input_a(v9,v10,v11).
input_a(v1,v10,v13).
input_a(v6,v7,v5).
input_a(v12,v10,v11).
input_a(v4,v1,v5).
input_a(v0,v1,v2).
input_a(v8,v7,v5).
input_a(v3,v1,v2).

neq(v4,v6).
neq(v12,v8).
neq(v9,v12).
neq(v6,v1).
neq(v1,v3).
neq(v9,v8).
neq(v12,v4).
neq(v8,v0).
neq(v1,v6).
neq(v9,v4).
neq(v12,v3).
neq(v3,v9).
neq(v3,v12).
neq(v8,v1).
neq(v3,v8).
neq(v6,v9).
neq(v4,v0).
neq(v6,v12).
neq(v12,v6).
neq(v6,v8).
neq(v9,v3).
neq(v3,v4).
neq(v9,v6).
neq(v1,v4).
neq(v0,v1).
neq(v6,v4).
neq(v4,v1).
neq(v1,v0).
neq(v8,v9).
neq(v8,v12).
neq(v6,v3).
neq(v3,v6).
neq(v12,v0).
neq(v0,v9).
neq(v0,v12).
neq(v4,v9).
neq(v4,v12).
neq(v0,v8).
neq(v8,v4).
neq(v4,v8).
neq(v9,v0).
neq(v12,v1).
neq(v8,v3).
neq(v0,v4).
neq(v9,v1).
neq(v1,v9).
neq(v1,v12).
neq(v8,v6).
neq(v1,v8).
neq(v3,v0).
neq(v0,v3).
neq(v6,v0).
neq(v4,v3).
neq(v12,v9).
neq(v0,v6).
neq(v3,v1).

c0(v5).


#pos(p1, {output_a(v7)}, {output_a(v10),output_a(v1)}).
#neg(n1, {output_a(v10),output_a(v1)}, {output_a(v7)}).


