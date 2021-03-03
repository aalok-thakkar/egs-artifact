#modeb(3, input_a(var(S),var(S)), (positive)).
#modeb(3, c0(var(S)), (positive)).
#modeh(output_a(var(S))).
#maxv(10).

input_a(2,1).
input_a(0,2).
input_a(0,1).
input_a(1,1).

c0(1).


#pos(p1, {output_a(1),output_a(2)}, {output_a(0)}).
#neg(n1, {output_a(0)}, {output_a(1),output_a(2)}).


