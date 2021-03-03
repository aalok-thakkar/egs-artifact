#modeb(1, input_a(var(s),var(p)), (positive)).
#modeb(1, input0(var(p),var(c)), (positive)).
#modeb(1, c0(var(c)), (positive)).
#modeh(output_a(var(s))).
#maxv(3).

input_a(v11,v12).
input_a(v5,v1).
input_a(v7,v2).
input_a(v0,v2).
input_a(v7,v8).
input_a(v13,v2).
input_a(v0,v1).
input_a(v3,v4).
input_a(v3,v1).
input_a(v6,v2).
input_a(v9,v10).

input0(v12,v16).
input0(v2,v14).
input0(v1,v14).
input0(v8,v15).
input0(v10,v15).
input0(v4,v16).

c0(v14).


#pos(p1, {output_a(v0),output_a(v3),output_a(v6),output_a(v7),output_a(v5),output_a(v13)}, {output_a(v11),output_a(v9)}).
#neg(n1, {output_a(v11),output_a(v9)}, {output_a(v0),output_a(v3),output_a(v6),output_a(v7),output_a(v5),output_a(v13)}).


