#modeb(1, input_a(var(c),var(fid)), (positive)).
#modeb(1, input0(var(sid),var(c)), (positive)).
#modeb(1, input1(var(fid),var(f)), (positive)).
#modeb(1, input2(var(sid),var(s),var(y)), (positive)).
#modeb(1, c0(var(y)), (positive)).
#modeb(1, c1(var(f)), (positive)).
#modeh(output_a(var(s))).
#maxv(6).

input_a(v5,v6).
input_a(v0,v1).
input_a(v4,v1).
input_a(v7,v8).
input_a(v2,v3).

input0(v14,v4).
input0(v9,v0).
input0(v14,v2).
input0(v15,v7).
input0(v12,v2).
input0(v12,v5).
input0(v10,v0).
input0(v11,v7).
input0(v11,v2).
input0(v16,v5).
input0(v13,v4).

input1(v3,v18).
input1(v1,v17).
input1(v6,v19).
input1(v8,v20).

input2(v10,v23,v24).
input2(v16,v30,v22).
input2(v9,v21,v22).
input2(v12,v26,v24).
input2(v15,v29,v22).
input2(v14,v28,v24).
input2(v13,v27,v22).
input2(v11,v25,v22).

c0(v22).

c1(v17).


#pos(p1, {output_a(v27),output_a(v21)}, {output_a(v30),output_a(v28),output_a(v25),output_a(v29),output_a(v23),output_a(v26)}).
#neg(n1, {output_a(v30),output_a(v28),output_a(v25),output_a(v29),output_a(v23),output_a(v26)}, {output_a(v27),output_a(v21)}).


