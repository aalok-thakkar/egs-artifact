#modeb(1, neg_input(var(s),var(s)), (positive)).
#modeb(1, c0(var(s)), (positive)).
#modeh(output_a(var(s))).
#maxv(2).

neg_input(v0,v0).
neg_input(v5,v6).
neg_input(v8,v5).
neg_input(v1,v4).
neg_input(v8,v6).
neg_input(v5,v7).
neg_input(v8,v7).
neg_input(v8,v1).
neg_input(v5,v4).
neg_input(v0,v2).
neg_input(v1,v0).
neg_input(v5,v3).
neg_input(v8,v3).
neg_input(v0,v1).
neg_input(v0,v4).
neg_input(v8,v0).
neg_input(v1,v5).
neg_input(v5,v2).
neg_input(v0,v3).
neg_input(v8,v2).
neg_input(v1,v7).
neg_input(v1,v1).
neg_input(v5,v5).

c0(v6).


#pos(p1, {output_a(v5),output_a(v8)}, {output_a(v6),output_a(v7),output_a(v1),output_a(v2),output_a(v0),output_a(v3),output_a(v4)}).
#neg(n1, {output_a(v6),output_a(v7),output_a(v1),output_a(v2),output_a(v0),output_a(v3),output_a(v4)}, {output_a(v5),output_a(v8)}).


