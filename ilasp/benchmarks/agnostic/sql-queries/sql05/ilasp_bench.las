#modeb(3, input_a(var(X),var(Y),var(NUM),var(A)), (positive)).
#modeh(output_a(var(NUM),var(A))).
#maxv(10).

input_a(0,1,2,3).
input_a(4,5,2,3).
input_a(6,7,8,9).
input_a(10,11,8,9).


#pos(p1, {output_a(2,3),output_a(8,9)}, {output_a(8,3),output_a(2,9)}).
#neg(n1, {output_a(8,3),output_a(2,9)}, {output_a(2,3),output_a(8,9)}).


