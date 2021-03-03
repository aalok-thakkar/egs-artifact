#modeb(3, input_a(var(I),var(N),var(S)), (positive)).
#modeh(output_a(var(N),var(S))).
#maxv(10).

input_a(7,2,8).
input_a(4,0,1).
input_a(5,2,6).
input_a(2,0,3).
input_a(0,0,1).
input_a(9,4,1).


#pos(p1, {output_a(4,1),output_a(2,6),output_a(2,8),output_a(0,1),output_a(0,3)}, {output_a(4,3),output_a(2,3),output_a(2,1),output_a(4,6),output_a(4,8),output_a(0,6),output_a(0,8)}).
#neg(n1, {output_a(4,3),output_a(2,3),output_a(2,1),output_a(4,6),output_a(4,8),output_a(0,6),output_a(0,8)}, {output_a(4,1),output_a(2,6),output_a(2,8),output_a(0,1),output_a(0,3)}).


