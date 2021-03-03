#modeb(3, input_a(var(ID),var(N),var(S)), (positive)).
#modeb(3, input0(var(ID),var(C),var(P)), (positive)).
#modeb(3, c0(var(P)), (positive)).
#modeb(3, c1(var(N)), (positive)).
#modeh(output_a(var(ID),var(N),var(S))).
#maxv(10).

input_a(0,1,2).
input_a(0,4,5).
input_a(3,1,2).

input0(3,8,9).
input0(0,6,7).

c0(7).

c1(4).


#pos(p1, {output_a(0,4,5)}, {output_a(3,1,2),output_a(3,1,5),output_a(3,4,2),output_a(3,4,5),output_a(0,4,2),output_a(0,1,5),output_a(0,1,2)}).
#neg(n1, {output_a(3,1,2),output_a(3,1,5),output_a(3,4,2),output_a(3,4,5),output_a(0,4,2),output_a(0,1,5),output_a(0,1,2)}, {output_a(0,4,5)}).


