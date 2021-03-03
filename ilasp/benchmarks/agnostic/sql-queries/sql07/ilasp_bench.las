#modeb(3, input_a(var(I),var(N),var(S)), (positive)).
#modeb(3, neq(var(I),var(I)), (positive)).
#modeb(3, c0(var(S)), (positive)).
#modeh(output_a(var(N))).
#maxv(10).

input_a(3,1,2).
input_a(4,1,5).
input_a(12,10,11).
input_a(6,7,5).
input_a(0,1,2).
input_a(8,7,5).
input_a(9,10,11).
input_a(1,10,13).

neq(3,8).
neq(4,3).
neq(1,3).
neq(3,4).
neq(4,12).
neq(12,8).
neq(1,12).
neq(12,4).
neq(4,1).
neq(6,8).
neq(0,3).
neq(4,6).
neq(8,3).
neq(8,12).
neq(6,4).
neq(1,6).
neq(4,9).
neq(9,3).
neq(0,12).
neq(4,0).
neq(1,9).
neq(1,0).
neq(8,1).
neq(9,12).
neq(9,8).
neq(0,1).
neq(9,1).
neq(3,12).
neq(0,6).
neq(12,3).
neq(8,6).
neq(3,1).
neq(8,0).
neq(0,9).
neq(9,6).
neq(8,9).
neq(4,8).
neq(9,0).
neq(1,8).
neq(6,3).
neq(12,1).
neq(3,6).
neq(3,0).
neq(1,4).
neq(3,9).
neq(6,12).
neq(12,6).
neq(12,9).
neq(6,1).
neq(12,0).
neq(0,8).
neq(0,4).
neq(8,4).
neq(6,9).
neq(9,4).
neq(6,0).

c0(5).


#pos(p1, {output_a(7)}, {output_a(1),output_a(10)}).
#neg(n1, {output_a(1),output_a(10)}, {output_a(7)}).


