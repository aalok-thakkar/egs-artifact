#modeb(3, employee(var(S),var(S),var(S),var(S)), (positive)).
#modeb(3, lt(var(S),var(S)), (positive)).
#modeh(output_a(var(S))).
#maxv(10).

employee(0,1,2,3).
employee(7,11,12,10).
employee(4,5,6,7).
employee(3,8,9,10).

lt(9,6).
lt(9,2).
lt(2,6).
lt(9,12).
lt(6,12).
lt(2,12).


#pos(p1, {output_a(1)}, {output_a(7),output_a(0),output_a(3),output_a(4),output_a(9),output_a(8),output_a(6),output_a(11),output_a(10),output_a(2),output_a(12),output_a(5)}).
#neg(n1, {output_a(7),output_a(0),output_a(3),output_a(4),output_a(9),output_a(8),output_a(6),output_a(11),output_a(10),output_a(2),output_a(12),output_a(5)}, {output_a(1)}).


