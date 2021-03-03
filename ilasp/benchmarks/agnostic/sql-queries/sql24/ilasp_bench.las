#modeb(3, input_a(var(S),var(P)), (positive)).
#modeb(3, input0(var(P),var(PN)), (positive)).
#modeh(output_a(var(PN))).
#maxv(10).

input_a(6,7).
input_a(0,1).
input_a(0,2).
input_a(3,5).
input_a(3,4).

input0(2,11).
input0(1,8).
input0(15,16).
input0(4,9).
input0(5,10).
input0(13,14).
input0(7,12).


#pos(p1, {output_a(10),output_a(9),output_a(12),output_a(11),output_a(8)}, {output_a(14),output_a(16)}).
#neg(n1, {output_a(14),output_a(16)}, {output_a(10),output_a(9),output_a(12),output_a(11),output_a(8)}).


