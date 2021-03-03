#modeb(3, input_a(var(S),var(AC),var(NUM)), (positive)).
#modeb(3, c0(var(AC)), (positive)).
#modeb(3, c1(var(AC)), (positive)).
#modeh(output_a(var(S),var(NUM),var(NUM))).
#maxv(10).

input_a(0,3,4).
input_a(0,1,2).
input_a(5,3,7).
input_a(5,1,6).

c0(1).

c1(3).


#pos(p1, {output_a(5,6,7),output_a(0,2,4)}, {output_a(5,6,6),output_a(0,4,6),output_a(0,6,7),output_a(0,6,4),output_a(0,7,2),output_a(5,4,6),output_a(5,2,2),output_a(0,4,7),output_a(5,6,4),output_a(5,7,2),output_a(0,4,4),output_a(0,2,6),output_a(5,4,7),output_a(5,4,4),output_a(0,6,2),output_a(0,7,6),output_a(0,2,7),output_a(5,2,6),output_a(5,6,2),output_a(5,7,6),output_a(0,4,2),output_a(0,7,7),output_a(0,7,4),output_a(5,4,2),output_a(5,2,7),output_a(5,2,4),output_a(0,6,6),output_a(5,7,7),output_a(5,7,4),output_a(0,2,2)}).
#neg(n1, {output_a(5,6,6),output_a(0,4,6),output_a(0,6,7),output_a(0,6,4),output_a(0,7,2),output_a(5,4,6),output_a(5,2,2),output_a(0,4,7),output_a(5,6,4),output_a(5,7,2),output_a(0,4,4),output_a(0,2,6),output_a(5,4,7),output_a(5,4,4),output_a(0,6,2),output_a(0,7,6),output_a(0,2,7),output_a(5,2,6),output_a(5,6,2),output_a(5,7,6),output_a(0,4,2),output_a(0,7,7),output_a(0,7,4),output_a(5,4,2),output_a(5,2,7),output_a(5,2,4),output_a(0,6,6),output_a(5,7,7),output_a(5,7,4),output_a(0,2,2)}, {output_a(5,6,7),output_a(0,2,4)}).


