#modeb(1, input_a(var(b),var(date),var(date)), (positive)).
#modeb(1, end(var(date)), (positive)).
#modeb(1, start(var(date)), (positive)).
#modeh(output_a(var(b))).
#maxv(3).

input_a(v0,v8,v9).
input_a(v10,v11,v12).
input_a(v16,v17,v18).
input_a(v5,v6,v7).
input_a(v19,v20,v21).
input_a(v13,v14,v15).
input_a(v3,v1,v4).
input_a(v0,v1,v2).

end(v9).
end(v4).
end(v7).

start(v6).
start(v11).
start(v20).
start(v14).
start(v1).
start(v17).


#pos(p1, {output_a(v3),output_a(v5)}, {output_a(v19),output_a(v10),output_a(v16),output_a(v13),output_a(v0)}).
#neg(n1, {output_a(v19),output_a(v10),output_a(v16),output_a(v13),output_a(v0)}, {output_a(v3),output_a(v5)}).


