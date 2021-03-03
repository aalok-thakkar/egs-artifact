#modeb(3, input_a(var(S),var(P)), (positive)).
#modeb(3, input0(var(P),var(C)), (positive)).
#modeb(3, c0(var(C)), (positive)).
#modeh(output_a(var(S))).
#maxv(10).

input_a(0,2).
input_a(9,10).
input_a(5,1).
input_a(6,2).
input_a(0,1).
input_a(7,8).
input_a(3,1).
input_a(11,12).
input_a(13,2).
input_a(7,2).
input_a(3,4).

input0(4,16).
input0(2,14).
input0(8,15).
input0(10,15).
input0(1,14).
input0(12,16).

c0(14).


#pos(p1, {output_a(7),output_a(0),output_a(5),output_a(3),output_a(6),output_a(13)}, {output_a(9),output_a(11)}).
#neg(n1, {output_a(9),output_a(11)}, {output_a(7),output_a(0),output_a(5),output_a(3),output_a(6),output_a(13)}).


