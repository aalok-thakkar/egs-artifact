#modeb(3, input_a(var(I),var(P)), (positive)).
#modeb(3, neg_input0(var(I),var(P)), (positive)).
#modeh(output_a(var(I),var(P))).
#maxv(10).

input_a(4,5).
input_a(0,1).
input_a(3,5).
input_a(3,1).
input_a(2,1).

neg_input0(4,5).
neg_input0(4,1).
neg_input0(2,5).
neg_input0(3,1).
neg_input0(0,5).


#pos(p1, {output_a(4,5),output_a(3,1)}, {output_a(4,1),output_a(0,1),output_a(2,5),output_a(3,5),output_a(2,1),output_a(0,5)}).
#neg(n1, {output_a(4,1),output_a(0,1),output_a(2,5),output_a(3,5),output_a(2,1),output_a(0,5)}, {output_a(4,5),output_a(3,1)}).


