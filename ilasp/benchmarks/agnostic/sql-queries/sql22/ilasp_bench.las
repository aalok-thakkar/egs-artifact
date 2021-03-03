#modeb(3, input_a(var(C),var(FID)), (positive)).
#modeb(3, input0(var(SID),var(C)), (positive)).
#modeb(3, input1(var(FID),var(F)), (positive)).
#modeb(3, input2(var(SID),var(S),var(Y)), (positive)).
#modeb(3, c0(var(Y)), (positive)).
#modeb(3, c1(var(F)), (positive)).
#modeh(output_a(var(S))).
#maxv(10).

input_a(0,1).
input_a(2,3).
input_a(5,6).
input_a(4,1).
input_a(7,8).

input0(12,2).
input0(14,4).
input0(12,5).
input0(9,0).
input0(14,2).
input0(15,7).
input0(16,5).
input0(11,7).
input0(10,0).
input0(13,4).
input0(11,2).

input1(1,17).
input1(8,20).
input1(6,19).
input1(3,18).

input2(9,21,22).
input2(13,27,22).
input2(10,23,24).
input2(14,28,24).
input2(11,25,22).
input2(15,29,22).
input2(12,26,24).
input2(16,30,22).

c0(22).

c1(17).


#pos(p1, {output_a(27),output_a(21)}, {output_a(30),output_a(28),output_a(26),output_a(25),output_a(23),output_a(29)}).
#neg(n1, {output_a(30),output_a(28),output_a(26),output_a(25),output_a(23),output_a(29)}, {output_a(27),output_a(21)}).


