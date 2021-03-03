#modeb(1, input_a(var(s),var(p)), (positive)).
#modeb(1, input0(var(p),var(pn)), (positive)).
#modeh(output_a(var(pn))).
#maxv(3).

input_a(v3,v4).
input_a(v0,v1).
input_a(v0,v2).
input_a(v6,v7).
input_a(v3,v5).

input0(v5,v10).
input0(v4,v9).
input0(v1,v8).
input0(v13,v14).
input0(v15,v16).
input0(v7,v12).
input0(v2,v11).


#pos(p1, {output_a(v9),output_a(v12),output_a(v8),output_a(v10),output_a(v11)}, {output_a(v16),output_a(v14)}).
#neg(n1, {output_a(v16),output_a(v14)}, {output_a(v9),output_a(v12),output_a(v8),output_a(v10),output_a(v11)}).


