#modeb(3, input_a(var(I),var(P),var(T)), (positive)).
#modeb(3, c0(var(T)), (positive)).
#modeb(3, c1(var(T)), (positive)).
#modeh(output_a(var(I),var(P),var(T))).
#maxv(10).

input_a(3,4,5).
input_a(7,8,2).
input_a(6,1,5).
input_a(0,1,2).

c0(2).

c1(5).


#pos(p1, {output_a(0,1,2)}, {output_a(7,8,5),output_a(3,4,2),output_a(0,4,2),output_a(6,8,2),output_a(6,4,5),output_a(7,1,2),output_a(3,8,2),output_a(0,4,5),output_a(0,8,2),output_a(3,4,5),output_a(6,8,5),output_a(3,8,5),output_a(0,8,5),output_a(7,1,5),output_a(6,1,2),output_a(3,1,2),output_a(6,1,5),output_a(7,4,2),output_a(0,1,5),output_a(3,1,5),output_a(7,4,5),output_a(7,8,2),output_a(6,4,2)}).
#neg(n1, {output_a(7,8,5),output_a(3,4,2),output_a(0,4,2),output_a(6,8,2),output_a(6,4,5),output_a(7,1,2),output_a(3,8,2),output_a(0,4,5),output_a(0,8,2),output_a(3,4,5),output_a(6,8,5),output_a(3,8,5),output_a(0,8,5),output_a(7,1,5),output_a(6,1,2),output_a(3,1,2),output_a(6,1,5),output_a(7,4,2),output_a(0,1,5),output_a(3,1,5),output_a(7,4,5),output_a(7,8,2),output_a(6,4,2)}, {output_a(0,1,2)}).


