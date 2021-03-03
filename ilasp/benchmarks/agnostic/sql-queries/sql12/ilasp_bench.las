#modeb(3, input_a(var(N),var(J),var(D)), (positive)).
#modeb(3, input0(var(ID),var(N),var(J),var(D),var(D),var(D)), (positive)).
#modeb(3, neg_input0(var(N),var(J)), (positive)).
#modeh(output_a(var(N),var(J),var(D))).
#maxv(10).

input_a(3,4,5).
input_a(6,7,8).
input_a(0,1,2).

input0(9,0,1,10,2,11).
input0(12,3,4,13,5,14).

neg_input0(6,4).
neg_input0(0,7).
neg_input0(3,7).
neg_input0(6,7).
neg_input0(3,1).
neg_input0(0,4).
neg_input0(6,1).


#pos(p1, {output_a(6,7,8)}, {output_a(6,4,13),output_a(6,1,11),output_a(3,7,5),output_a(0,4,13),output_a(0,1,11),output_a(3,4,13),output_a(0,7,5),output_a(3,1,11),output_a(3,7,8),output_a(0,7,8),output_a(6,7,10),output_a(0,7,10),output_a(3,7,10),output_a(6,7,2),output_a(6,1,13),output_a(3,7,2),output_a(0,1,13),output_a(6,7,11),output_a(6,4,14),output_a(3,1,13),output_a(0,7,2),output_a(3,4,14),output_a(3,7,11),output_a(0,4,14),output_a(0,7,11),output_a(6,4,5),output_a(0,4,5),output_a(6,4,8),output_a(3,4,5),output_a(6,7,13),output_a(6,1,14),output_a(3,4,8),output_a(3,7,13),output_a(3,1,14),output_a(0,4,8),output_a(6,4,10),output_a(0,7,13),output_a(0,1,14),output_a(3,4,10),output_a(6,4,2),output_a(0,4,10),output_a(3,4,2),output_a(6,1,5),output_a(0,1,5),output_a(0,4,2),output_a(6,1,8),output_a(3,1,5),output_a(6,4,11),output_a(3,1,8),output_a(0,4,11),output_a(3,4,11),output_a(0,1,8),output_a(6,1,10),output_a(6,7,14),output_a(0,7,14),output_a(3,1,10),output_a(3,7,14),output_a(6,1,2),output_a(0,1,10),output_a(3,1,2),output_a(6,7,5),output_a(0,1,2)}).
#neg(n1, {output_a(6,4,13),output_a(6,1,11),output_a(3,7,5),output_a(0,4,13),output_a(0,1,11),output_a(3,4,13),output_a(0,7,5),output_a(3,1,11),output_a(3,7,8),output_a(0,7,8),output_a(6,7,10),output_a(0,7,10),output_a(3,7,10),output_a(6,7,2),output_a(6,1,13),output_a(3,7,2),output_a(0,1,13),output_a(6,7,11),output_a(6,4,14),output_a(3,1,13),output_a(0,7,2),output_a(3,4,14),output_a(3,7,11),output_a(0,4,14),output_a(0,7,11),output_a(6,4,5),output_a(0,4,5),output_a(6,4,8),output_a(3,4,5),output_a(6,7,13),output_a(6,1,14),output_a(3,4,8),output_a(3,7,13),output_a(3,1,14),output_a(0,4,8),output_a(6,4,10),output_a(0,7,13),output_a(0,1,14),output_a(3,4,10),output_a(6,4,2),output_a(0,4,10),output_a(3,4,2),output_a(6,1,5),output_a(0,1,5),output_a(0,4,2),output_a(6,1,8),output_a(3,1,5),output_a(6,4,11),output_a(3,1,8),output_a(0,4,11),output_a(3,4,11),output_a(0,1,8),output_a(6,1,10),output_a(6,7,14),output_a(0,7,14),output_a(3,1,10),output_a(3,7,14),output_a(6,1,2),output_a(0,1,10),output_a(3,1,2),output_a(6,7,5),output_a(0,1,2)}, {output_a(6,7,8)}).


