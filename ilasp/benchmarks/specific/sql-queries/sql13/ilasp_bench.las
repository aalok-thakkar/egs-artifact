#modeb(1, input_a(var(a),var(b)), (positive)).
#modeb(1, neg_input0(var(a),var(b)), (positive)).
#modeh(output_a(var(a),var(b))).
#maxv(2).

input_a(v5,v5).
input_a(v0,v1).
input_a(v2,v2).
input_a(v2,v3).
input_a(v4,v4).

neg_input0(v4,v3).
neg_input0(v0,v3).
neg_input0(v4,v2).
neg_input0(v2,v3).
neg_input0(v0,v2).
neg_input0(v5,v1).
neg_input0(v2,v4).
neg_input0(v0,v4).
neg_input0(v2,v5).
neg_input0(v4,v5).
neg_input0(v5,v2).
neg_input0(v0,v5).
neg_input0(v5,v3).
neg_input0(v5,v4).
neg_input0(v2,v1).
neg_input0(v4,v1).


#pos(p1, {output_a(v2,v3)}, {output_a(v4,v4),output_a(v0,v4),output_a(v5,v5),output_a(v2,v4),output_a(v5,v2),output_a(v4,v5),output_a(v0,v5),output_a(v5,v3),output_a(v4,v3),output_a(v0,v3),output_a(v5,v1),output_a(v4,v2),output_a(v0,v2),output_a(v2,v5),output_a(v4,v1),output_a(v0,v1),output_a(v2,v2),output_a(v5,v4),output_a(v2,v1)}).
#neg(n1, {output_a(v4,v4),output_a(v0,v4),output_a(v5,v5),output_a(v2,v4),output_a(v5,v2),output_a(v4,v5),output_a(v0,v5),output_a(v5,v3),output_a(v4,v3),output_a(v0,v3),output_a(v5,v1),output_a(v4,v2),output_a(v0,v2),output_a(v2,v5),output_a(v4,v1),output_a(v0,v1),output_a(v2,v2),output_a(v5,v4),output_a(v2,v1)}, {output_a(v2,v3)}).


