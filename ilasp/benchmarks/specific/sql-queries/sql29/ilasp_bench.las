#modeb(1, input_a(var(id),var(num),var(date)), (positive)).
#modeb(1, input0(var(id),var(num),var(date)), (positive)).
#modeb(1, c0(var(num)), (positive)).
#modeb(1, c1(var(num)), (positive)).
#modeh(output_a(var(id),var(num),var(date))).
#maxv(4).

input_a(v0,v3,v2).
input_a(v0,v1,v2).

input0(v4,v3,v5).

c0(v1).

c1(v3).


#pos(p1, {output_a(v4,v3,v5),output_a(v0,v1,v2)}, {output_a(v4,v1,v2),output_a(v0,v3,v5),output_a(v0,v1,v5),output_a(v4,v3,v2),output_a(v4,v1,v5),output_a(v0,v3,v2)}).
#neg(n1, {output_a(v4,v1,v2),output_a(v0,v3,v5),output_a(v0,v1,v5),output_a(v4,v3,v2),output_a(v4,v1,v5),output_a(v0,v3,v2)}, {output_a(v4,v3,v5),output_a(v0,v1,v2)}).


