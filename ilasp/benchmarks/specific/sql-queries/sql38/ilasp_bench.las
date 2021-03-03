#modeb(1, input_a(var(s),var(p)), (positive)).
#modeb(1, input0(var(p),var(c)), (positive)).
#modeb(1, input1(var(s),var(sn)), (positive)).
#modeb(1, c0(var(c)), (positive)).
#modeb(1, c1(var(c)), (positive)).
#modeh(output_a(var(sn))).
#maxv(4).

input_a(v13,v3).
input_a(v0,v3).
input_a(v6,v7).
input_a(v0,v1).
input_a(v11,v2).
input_a(v4,v3).
input_a(v8,v9).
input_a(v12,v9).
input_a(v15,v9).
input_a(v10,v2).
input_a(v14,v3).
input_a(v10,v3).
input_a(v14,v9).
input_a(v13,v7).
input_a(v8,v5).
input_a(v0,v2).
input_a(v14,v1).
input_a().
input_a(v4,v5).

input0(v2,v16).
input0(v7,v17).
input0(v5,v18).
input0(v3,v17).
input0(v1,v16).
input0(v9,v19).

input1(v6,v22).
input1(v13,v27).
input1(v0,v20).
input1(v10,v24).
input1(v11,v25).
input1(v12,v26).
input1(v14,v28).
input1(v15,v29).
input1(v4,v21).
input1(v8,v23).

c0(v16).

c1(v17).


#pos(p1, {output_a(v20),output_a(v28),output_a(v24),output_a(v25),output_a(v21),output_a(v27),output_a(v22)}, {output_a(v23),output_a(v26),output_a(v29)}).
#neg(n1, {output_a(v23),output_a(v26),output_a(v29)}, {output_a(v20),output_a(v28),output_a(v24),output_a(v25),output_a(v21),output_a(v27),output_a(v22)}).


