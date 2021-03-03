#modeb(3, input_a(var(ID),var(NAME),var(NUM),var(ID)), (positive)).
#modeh(output_a(var(ID),var(NAME))).
#maxv(10).

input_a(4,5,6,0).
input_a(7,8,9,0).
input_a(0,1,2,3).


#pos(p1, {output_a(0,1)}, {output_a(7,8),output_a(4,1),output_a(7,5),output_a(3,1),output_a(4,8),output_a(4,5),output_a(7,1),output_a(0,8),output_a(0,5),output_a(3,8),output_a(3,5)}).
#neg(n1, {output_a(7,8),output_a(4,1),output_a(7,5),output_a(3,1),output_a(4,8),output_a(4,5),output_a(7,1),output_a(0,8),output_a(0,5),output_a(3,8),output_a(3,5)}, {output_a(0,1)}).


