#modeb(3, input_a(var(I),var(N),var(S)), (positive)).
#modeh(output_a(var(I),var(N))).
#maxv(10).

input_a(6,7,2).
input_a(3,4,5).
input_a(8,9,10).
input_a(11,12,5).
input_a(0,1,2).


#pos(p1, {output_a(3,4),output_a(0,1),output_a(11,12),output_a(8,9),output_a(6,7)}, {output_a(0,12),output_a(0,4),output_a(6,9),output_a(8,12),output_a(11,4),output_a(3,9),output_a(3,7),output_a(0,9),output_a(8,4),output_a(6,1),output_a(0,7),output_a(3,1),output_a(11,9),output_a(11,7),output_a(8,7),output_a(8,1),output_a(11,1),output_a(6,12),output_a(3,12),output_a(6,4)}).
#neg(n1, {output_a(0,12),output_a(0,4),output_a(6,9),output_a(8,12),output_a(11,4),output_a(3,9),output_a(3,7),output_a(0,9),output_a(8,4),output_a(6,1),output_a(0,7),output_a(3,1),output_a(11,9),output_a(11,7),output_a(8,7),output_a(8,1),output_a(11,1),output_a(6,12),output_a(3,12),output_a(6,4)}, {output_a(3,4),output_a(0,1),output_a(11,12),output_a(8,9),output_a(6,7)}).


