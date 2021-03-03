#modeb(3, neg_input(var(ID),var(NUM)), (positive)).
#modeb(3, input0(var(ID),var(DATE),var(NUM)), (positive)).
#modeh(output_a(var(ID),var(DATE),var(NUM))).
#maxv(10).

neg_input(0,2).
neg_input(0,1).
neg_input(5,2).
neg_input(5,4).
neg_input(3,2).
neg_input(5,1).
neg_input(3,4).

input0(3,7,1).
input0(5,8,2).
input0(0,6,4).


#pos(p1, {output_a(5,8,2)}, {output_a(0,6,2),output_a(5,7,4),output_a(0,8,4),output_a(3,7,4),output_a(5,8,1),output_a(3,8,2),output_a(0,7,2),output_a(0,6,1),output_a(5,6,2),output_a(3,6,2),output_a(5,8,4),output_a(3,8,1),output_a(0,7,1),output_a(5,7,2),output_a(0,6,4),output_a(3,7,2),output_a(5,6,1),output_a(0,8,2),output_a(3,6,1),output_a(3,8,4),output_a(0,7,4),output_a(5,7,1),output_a(5,6,4),output_a(0,8,1),output_a(3,7,1),output_a(3,6,4)}).
#neg(n1, {output_a(0,6,2),output_a(5,7,4),output_a(0,8,4),output_a(3,7,4),output_a(5,8,1),output_a(3,8,2),output_a(0,7,2),output_a(0,6,1),output_a(5,6,2),output_a(3,6,2),output_a(5,8,4),output_a(3,8,1),output_a(0,7,1),output_a(5,7,2),output_a(0,6,4),output_a(3,7,2),output_a(5,6,1),output_a(0,8,2),output_a(3,6,1),output_a(3,8,4),output_a(0,7,4),output_a(5,7,1),output_a(5,6,4),output_a(0,8,1),output_a(3,7,1),output_a(3,6,4)}, {output_a(5,8,2)}).


