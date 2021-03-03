#modeb(1, input_a(var(s),var(s)), (positive)).
#modeb(1, c0(var(s)), (positive)).
#modeh(output_a(var(s))).
#maxv(2).

input_a(v1,v1).
input_a(v0,v2).
input_a(v2,v1).
input_a(v0,v1).

c0(v1).


#pos(p1, {output_a(v2),output_a(v1)}, {output_a(v0)}).
#neg(n1, {output_a(v0)}, {output_a(v2),output_a(v1)}).


