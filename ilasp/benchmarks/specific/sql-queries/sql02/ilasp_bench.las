#modeb(2, input_a(var(id),var(name),var(num),var(id)), (positive)).
#modeh(output_a(var(id),var(name))).
#maxv(7).

input_a(v4,v5,v6,v0).
input_a(v0,v1,v2,v3).
input_a(v7,v8,v9,v0).


#pos(p1, {output_a(v0,v1)}, {output_a(v7,v1),output_a(v3,v1),output_a(v3,v5),output_a(v3,v8),output_a(v4,v1),output_a(v0,v5),output_a(v7,v5),output_a(v4,v5),output_a(v4,v8),output_a(v0,v8),output_a(v7,v8)}).
#neg(n1, {output_a(v7,v1),output_a(v3,v1),output_a(v3,v5),output_a(v3,v8),output_a(v4,v1),output_a(v0,v5),output_a(v7,v5),output_a(v4,v5),output_a(v4,v8),output_a(v0,v8),output_a(v7,v8)}, {output_a(v0,v1)}).


