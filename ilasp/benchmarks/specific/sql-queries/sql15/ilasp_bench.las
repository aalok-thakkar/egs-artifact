#modeb(2, input_a(var(id),var(c)), (positive)).
#modeb(1, input0(var(id),var(c)), (positive)).
#modeb(1, neq(var(id),var(id)), (positive)).
#modeh(output_a(var(id),var(c),var(c),var(id))).
#maxv(4).

input_a(v2,v3).
input_a(v4,v5).
input_a(v0,v1).

input0(v2,v3).
input0(v0,v5).
input0(v4,v3).

neq(v4,v2).
neq(v4,v0).
neq(v2,v0).
neq(v0,v2).
neq(v0,v4).
neq(v2,v4).


#pos(p1, {output_a(v4,v5,v3,v2),output_a(v0,v1,v5,v4)}, {output_a(v0,v3,v3,v0),output_a(v2,v5,v5,v2),output_a(v4,v1,v5,v2),output_a(v0,v5,v5,v0),output_a(v0,v5,v1,v2),output_a(v0,v3,v3,v4),output_a(v2,v1,v3,v2),output_a(v2,v3,v1,v0),output_a(v4,v3,v5,v2),output_a(v4,v5,v1,v0),output_a(v0,v5,v5,v4),output_a(v2,v3,v1,v4),output_a(v4,v1,v1,v0),output_a(v2,v3,v5,v2),output_a(v2,v5,v1,v4),output_a(v4,v3,v3,v2),output_a(v2,v1,v1,v2),output_a(v4,v1,v1,v4),output_a(v0,v1,v5,v2),output_a(v2,v1,v5,v4),output_a(v0,v3,v3,v2),output_a(v2,v3,v3,v4),output_a(v4,v3,v1,v4),output_a(v4,v5,v3,v4),output_a(v0,v5,v5,v2),output_a(v2,v5,v1,v0),output_a(v2,v3,v1,v2),output_a(v0,v1,v1,v0),output_a(v4,v5,v1,v2),output_a(v0,v3,v5,v0),output_a(v2,v1,v5,v0),output_a(v4,v1,v1,v2),output_a(v0,v1,v1,v4),output_a(v4,v5,v5,v4),output_a(v2,v3,v3,v0),output_a(v4,v3,v1,v0),output_a(v0,v3,v5,v4),output_a(v4,v5,v3,v0),output_a(v2,v5,v3,v0),output_a(v0,v5,v1,v4),output_a(v4,v1,v3,v0),output_a(v0,v3,v1,v0),output_a(v0,v1,v3,v0),output_a(v2,v5,v3,v4),output_a(v0,v5,v3,v0),output_a(v4,v1,v3,v4),output_a(v0,v3,v1,v4),output_a(v0,v1,v3,v4),output_a(v4,v5,v5,v0),output_a(v2,v3,v5,v4),output_a(v0,v5,v3,v4),output_a(v2,v5,v5,v0),output_a(v2,v5,v1,v2),output_a(v0,v1,v1,v2),output_a(v4,v3,v3,v4),output_a(v4,v5,v5,v2),output_a(v2,v1,v1,v4),output_a(v4,v1,v5,v0),output_a(v0,v3,v5,v2),output_a(v0,v5,v1,v0),output_a(v2,v5,v5,v4),output_a(v2,v1,v3,v0),output_a(v2,v1,v5,v2),output_a(v4,v3,v5,v0),output_a(v2,v3,v3,v2),output_a(v4,v3,v1,v2),output_a(v4,v1,v5,v4),output_a(v2,v5,v3,v2),output_a(v2,v1,v3,v4),output_a(v2,v3,v5,v0),output_a(v4,v3,v5,v4),output_a(v4,v1,v3,v2),output_a(v0,v3,v1,v2),output_a(v0,v1,v3,v2),output_a(v4,v3,v3,v0),output_a(v2,v1,v1,v0),output_a(v0,v5,v3,v2),output_a(v4,v5,v1,v4),output_a(v0,v1,v5,v0)}).
#neg(n1, {output_a(v0,v3,v3,v0),output_a(v2,v5,v5,v2),output_a(v4,v1,v5,v2),output_a(v0,v5,v5,v0),output_a(v0,v5,v1,v2),output_a(v0,v3,v3,v4),output_a(v2,v1,v3,v2),output_a(v2,v3,v1,v0),output_a(v4,v3,v5,v2),output_a(v4,v5,v1,v0),output_a(v0,v5,v5,v4),output_a(v2,v3,v1,v4),output_a(v4,v1,v1,v0),output_a(v2,v3,v5,v2),output_a(v2,v5,v1,v4),output_a(v4,v3,v3,v2),output_a(v2,v1,v1,v2),output_a(v4,v1,v1,v4),output_a(v0,v1,v5,v2),output_a(v2,v1,v5,v4),output_a(v0,v3,v3,v2),output_a(v2,v3,v3,v4),output_a(v4,v3,v1,v4),output_a(v4,v5,v3,v4),output_a(v0,v5,v5,v2),output_a(v2,v5,v1,v0),output_a(v2,v3,v1,v2),output_a(v0,v1,v1,v0),output_a(v4,v5,v1,v2),output_a(v0,v3,v5,v0),output_a(v2,v1,v5,v0),output_a(v4,v1,v1,v2),output_a(v0,v1,v1,v4),output_a(v4,v5,v5,v4),output_a(v2,v3,v3,v0),output_a(v4,v3,v1,v0),output_a(v0,v3,v5,v4),output_a(v4,v5,v3,v0),output_a(v2,v5,v3,v0),output_a(v0,v5,v1,v4),output_a(v4,v1,v3,v0),output_a(v0,v3,v1,v0),output_a(v0,v1,v3,v0),output_a(v2,v5,v3,v4),output_a(v0,v5,v3,v0),output_a(v4,v1,v3,v4),output_a(v0,v3,v1,v4),output_a(v0,v1,v3,v4),output_a(v4,v5,v5,v0),output_a(v2,v3,v5,v4),output_a(v0,v5,v3,v4),output_a(v2,v5,v5,v0),output_a(v2,v5,v1,v2),output_a(v0,v1,v1,v2),output_a(v4,v3,v3,v4),output_a(v4,v5,v5,v2),output_a(v2,v1,v1,v4),output_a(v4,v1,v5,v0),output_a(v0,v3,v5,v2),output_a(v0,v5,v1,v0),output_a(v2,v5,v5,v4),output_a(v2,v1,v3,v0),output_a(v2,v1,v5,v2),output_a(v4,v3,v5,v0),output_a(v2,v3,v3,v2),output_a(v4,v3,v1,v2),output_a(v4,v1,v5,v4),output_a(v2,v5,v3,v2),output_a(v2,v1,v3,v4),output_a(v2,v3,v5,v0),output_a(v4,v3,v5,v4),output_a(v4,v1,v3,v2),output_a(v0,v3,v1,v2),output_a(v0,v1,v3,v2),output_a(v4,v3,v3,v0),output_a(v2,v1,v1,v0),output_a(v0,v5,v3,v2),output_a(v4,v5,v1,v4),output_a(v0,v1,v5,v0)}, {output_a(v4,v5,v3,v2),output_a(v0,v1,v5,v4)}).


