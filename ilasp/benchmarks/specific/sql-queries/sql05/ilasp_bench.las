#modeb(1, input_a(var(x),var(y),var(num),var(a)), (positive)).
#modeh(output_a(var(num),var(a))).
#maxv(4).

input_a(v0,v1,v2,v3).
input_a(v6,v7,v8,v9).
input_a(v4,v5,v2,v3).
input_a(v10,v11,v8,v9).


#pos(p1, {output_a(v2,v3),output_a(v8,v9)}, {output_a(v8,v3),output_a(v2,v9)}).
#neg(n1, {output_a(v8,v3),output_a(v2,v9)}, {output_a(v2,v3),output_a(v8,v9)}).


