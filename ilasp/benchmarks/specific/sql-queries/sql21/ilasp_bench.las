#modeb(1, input_a(var(i),var(p)), (positive)).
#modeb(1, neg_input0(var(i),var(p)), (positive)).
#modeh(output_a(var(i),var(p))).
#maxv(2).

input_a(v4,v5).
input_a(v3,v1).
input_a(v0,v1).
input_a(v2,v1).
input_a(v3,v5).

neg_input0(v0,v5).
neg_input0(v2,v5).
neg_input0(v4,v5).
neg_input0(v3,v1).
neg_input0(v4,v1).


#pos(p1, {output_a(v4,v5),output_a(v3,v1)}, {output_a(v0,v5),output_a(v2,v5),output_a(v0,v1),output_a(v4,v1),output_a(v2,v1),output_a(v3,v5)}).
#neg(n1, {output_a(v0,v5),output_a(v2,v5),output_a(v0,v1),output_a(v4,v1),output_a(v2,v1),output_a(v3,v5)}, {output_a(v4,v5),output_a(v3,v1)}).


