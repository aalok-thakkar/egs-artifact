#modeb(3, input_a(var(A),var(B)), (positive)).
#modeb(3, neg_input0(var(A),var(B)), (positive)).
#modeh(output_a(var(A),var(B))).
#maxv(10).

input_a(4,4).
input_a(2,2).
input_a(5,5).
input_a(0,1).
input_a(2,3).

neg_input0(2,4).
neg_input0(4,3).
neg_input0(2,1).
neg_input0(4,2).
neg_input0(2,5).
neg_input0(0,3).
neg_input0(4,1).
neg_input0(4,5).
neg_input0(5,3).
neg_input0(0,2).
neg_input0(0,4).
neg_input0(5,4).
neg_input0(0,5).
neg_input0(5,1).
neg_input0(5,2).
neg_input0(2,3).


#pos(p1, {output_a(2,3)}, {output_a(2,1),output_a(4,2),output_a(4,4),output_a(5,1),output_a(0,1),output_a(2,4),output_a(4,3),output_a(2,2),output_a(4,5),output_a(0,4),output_a(0,2),output_a(5,4),output_a(5,2),output_a(2,5),output_a(0,3),output_a(5,3),output_a(0,5),output_a(5,5),output_a(4,1)}).
#neg(n1, {output_a(2,1),output_a(4,2),output_a(4,4),output_a(5,1),output_a(0,1),output_a(2,4),output_a(4,3),output_a(2,2),output_a(4,5),output_a(0,4),output_a(0,2),output_a(5,4),output_a(5,2),output_a(2,5),output_a(0,3),output_a(5,3),output_a(0,5),output_a(5,5),output_a(4,1)}, {output_a(2,3)}).


