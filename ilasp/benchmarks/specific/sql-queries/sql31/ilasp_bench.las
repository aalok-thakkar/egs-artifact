#modeb(2, input_a(var(s),var(ac),var(num)), (positive)).
#modeb(1, c0(var(ac)), (positive)).
#modeb(1, c1(var(ac)), (positive)).
#modeh(output_a(var(s),var(num),var(num))).
#maxv(5).

input_a(v0,v3,v4).
input_a(v0,v1,v2).
input_a(v5,v3,v7).
input_a(v5,v1,v6).

c0(v1).

c1(v3).


#pos(p1, {output_a(v0,v2,v4),output_a(v5,v6,v7)}, {output_a(v5,v2,v7),output_a(v0,v7,v7),output_a(v0,v6,v2),output_a(v5,v2,v6),output_a(v0,v4,v7),output_a(v0,v7,v6),output_a(v0,v6,v4),output_a(v0,v4,v6),output_a(v5,v2,v2),output_a(v0,v7,v2),output_a(v5,v7,v7),output_a(v5,v6,v6),output_a(v5,v2,v4),output_a(v0,v4,v2),output_a(v5,v4,v7),output_a(v0,v2,v7),output_a(v0,v7,v4),output_a(v5,v7,v6),output_a(v5,v6,v2),output_a(v0,v4,v4),output_a(v5,v4,v6),output_a(v0,v2,v6),output_a(v5,v7,v2),output_a(v5,v6,v4),output_a(v0,v6,v7),output_a(v5,v4,v2),output_a(v0,v2,v2),output_a(v5,v7,v4),output_a(v0,v6,v6),output_a(v5,v4,v4)}).
#neg(n1, {output_a(v5,v2,v7),output_a(v0,v7,v7),output_a(v0,v6,v2),output_a(v5,v2,v6),output_a(v0,v4,v7),output_a(v0,v7,v6),output_a(v0,v6,v4),output_a(v0,v4,v6),output_a(v5,v2,v2),output_a(v0,v7,v2),output_a(v5,v7,v7),output_a(v5,v6,v6),output_a(v5,v2,v4),output_a(v0,v4,v2),output_a(v5,v4,v7),output_a(v0,v2,v7),output_a(v0,v7,v4),output_a(v5,v7,v6),output_a(v5,v6,v2),output_a(v0,v4,v4),output_a(v5,v4,v6),output_a(v0,v2,v6),output_a(v5,v7,v2),output_a(v5,v6,v4),output_a(v0,v6,v7),output_a(v5,v4,v2),output_a(v0,v2,v2),output_a(v5,v7,v4),output_a(v0,v6,v6),output_a(v5,v4,v4)}, {output_a(v0,v2,v4),output_a(v5,v6,v7)}).


