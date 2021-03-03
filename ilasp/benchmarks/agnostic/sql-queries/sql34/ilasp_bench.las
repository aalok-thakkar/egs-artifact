#modeb(3, input_a(var(B),var(DATE),var(DATE)), (positive)).
#modeb(3, c0(var(DATE)), (positive)).
#modeb(3, c1(var(DATE)), (positive)).
#modeh(output_a(var(B))).
#maxv(10).

input_a(0,1,2).
input_a(3,4,5).
input_a(12,13,14).
input_a(6,7,8).
input_a(9,10,11).

c0(5).
c0(2).
c0(11).
c0(14).
c0(8).

c1(1).


#pos(p1, {output_a(0)}, {output_a(6),output_a(12),output_a(9),output_a(3)}).
#neg(n1, {output_a(6),output_a(12),output_a(9),output_a(3)}, {output_a(0)}).


