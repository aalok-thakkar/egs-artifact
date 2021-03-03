#modeb(3, input_a(var(ID),var(NUM),var(DATE)), (positive)).
#modeb(3, input0(var(ID),var(NUM),var(DATE)), (positive)).
#modeb(3, c0(var(NUM)), (positive)).
#modeb(3, c1(var(NUM)), (positive)).
#modeh(output_a(var(ID),var(NUM),var(DATE))).
#maxv(10).

input_a(0,1,2).
input_a(0,3,2).

input0(4,3,5).

c0(1).

c1(3).


#pos(p1, {output_a(0,1,2),output_a(4,3,5)}, {output_a(0,3,2),output_a(0,1,5),output_a(4,1,5),output_a(0,3,5),output_a(4,3,2),output_a(4,1,2)}).
#neg(n1, {output_a(0,3,2),output_a(0,1,5),output_a(4,1,5),output_a(0,3,5),output_a(4,3,2),output_a(4,1,2)}, {output_a(0,1,2),output_a(4,3,5)}).


