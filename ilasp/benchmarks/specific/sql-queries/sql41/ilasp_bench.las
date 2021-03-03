#modeb(1, weather(var(s),var(s),var(s)), (positive)).
#modeb(1, hightemp(var(s)), (positive)).
#modeh(output_a(var(s))).
#maxv(3).

weather(v9,v10,v11).
weather(v6,v7,v8).
weather(v0,v1,v2).
weather(v3,v4,v5).

hightemp(v15).
hightemp(v14).
hightemp(v18).
hightemp(v5).
hightemp(v16).
hightemp(v12).
hightemp(v13).
hightemp(v17).
hightemp(v19).
hightemp(v11).


#pos(p1, {output_a(v3),output_a(v9)}, {output_a(v18),output_a(v14),output_a(v15),output_a(v16),output_a(v10),output_a(v4),output_a(v5),output_a(v6),output_a(v12),output_a(v8),output_a(v13),output_a(v7),output_a(v17),output_a(v0),output_a(v2),output_a(v19),output_a(v11),output_a(v1)}).
#neg(n1, {output_a(v18),output_a(v14),output_a(v15),output_a(v16),output_a(v10),output_a(v4),output_a(v5),output_a(v6),output_a(v12),output_a(v8),output_a(v13),output_a(v7),output_a(v17),output_a(v0),output_a(v2),output_a(v19),output_a(v11),output_a(v1)}, {output_a(v3),output_a(v9)}).


