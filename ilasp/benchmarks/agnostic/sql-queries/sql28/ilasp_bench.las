#modeb(3, input_a(var(N),var(S)), (positive)).
#modeb(3, neg_input0(var(N),var(S)), (positive)).
#modeb(3, c0(var(S)), (positive)).
#modeh(output_a(var(N),var(S))).
#maxv(10).

input_a(0,2).
input_a(0,1).
input_a(4,1).
input_a(3,1).

neg_input0(4,5).
neg_input0(6,7).
neg_input0(8,9).

c0(1).


#pos(p1, {output_a(4,1)}, {output_a(6,1),output_a(8,5),output_a(3,2),output_a(0,5),output_a(4,5),output_a(6,7),output_a(8,1),output_a(3,9),output_a(0,1),output_a(6,2),output_a(8,7),output_a(0,7),output_a(6,9),output_a(3,5),output_a(4,7),output_a(8,2),output_a(0,2),output_a(3,1),output_a(4,2),output_a(6,5),output_a(8,9),output_a(0,9),output_a(3,7),output_a(4,9)}).
#neg(n1, {output_a(6,1),output_a(8,5),output_a(3,2),output_a(0,5),output_a(4,5),output_a(6,7),output_a(8,1),output_a(3,9),output_a(0,1),output_a(6,2),output_a(8,7),output_a(0,7),output_a(6,9),output_a(3,5),output_a(4,7),output_a(8,2),output_a(0,2),output_a(3,1),output_a(4,2),output_a(6,5),output_a(8,9),output_a(0,9),output_a(3,7),output_a(4,9)}, {output_a(4,1)}).


