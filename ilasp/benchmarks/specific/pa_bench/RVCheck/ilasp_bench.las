#modeb(1, certificate(var(x), var(l)), (positive)).
#modeb(2, check(var(x), var(l)), (positive)).
#modeb(1, verify(var(x), var(l)), (positive)).
#modeb(2, opsucc(var(l), var(l)), (positive)).
#modeh(correct(var(l))).
#maxv(5).
certificate(v0,v2).
certificate(v0,v1).
certificate(v0,v4).
certificate(v0,v3).

verify(v5,v6).
verify(v5,v9).
verify(v5,v7).
verify(v5,v8).

check(v5,v13).
check(v0,v15).
check(v0,v14).
check(v5,v11).
check(v0,v10).
check(v5,v12).

opsucc(v23,v6).
opsucc(v14,v25).
opsucc(v21,v11).
opsucc(v16,v22).
opsucc(v8,v11).
opsucc(v4,v18).
opsucc(v21,v19).
opsucc(v1,v25).
opsucc(v6,v25).
opsucc(v20,v18).
opsucc(v16,v17).
opsucc(v8,v19).
opsucc(v20,v9).
opsucc(v24,v18).
opsucc(v12,v4).
opsucc(v11,v15).
opsucc(v10,v22).
opsucc(v3,v15).
opsucc(v11,v3).
opsucc(v1,v6).
opsucc(v10,v17).
opsucc(v23,v13).
opsucc(v9,v24).
opsucc(v21,v8).
opsucc(v23,v14).
opsucc(v14,v13).
opsucc(v9,v4).
opsucc(v6,v13).
opsucc(v15,v19).
opsucc(v2,v7).
opsucc(v23,v1).
opsucc(v12,v18).
opsucc(v1,v13).
opsucc(v20,v24).
opsucc(v13,v25).
opsucc(v11,v19).
opsucc(v9,v12).
opsucc(v2,v10).
opsucc(v3,v19).
opsucc(v1,v14).
opsucc(v7,v22).
opsucc(v6,v14).
opsucc(v20,v4).
opsucc(v16,v7).
opsucc(v21,v15).
opsucc(v7,v17).
opsucc(v22,v17).
opsucc(v24,v4).
opsucc(v8,v15).
opsucc(v21,v3).
opsucc(v23,v25).
opsucc(v9,v18).
opsucc(v16,v2).
opsucc(v20,v12).
opsucc(v8,v3).
opsucc(v2,v22).
opsucc(v16,v10).
opsucc(v10,v7).
opsucc(v2,v17).
opsucc(v24,v12).


#pos(p1, {correct(v19),correct(v25)}, {correct(v21),correct(v14),correct(v24),correct(v1),correct(v15),correct(v4),correct(v3),correct(v23),correct(v12),correct(v11),correct(v7),correct(v10),correct(v2),correct(v6),correct(v9),correct(v18),correct(v20),correct(v22),correct(v8),correct(v13),correct(v17),correct(v16)}).
#neg(n1, {correct(v21),correct(v14),correct(v24),correct(v1),correct(v15),correct(v4),correct(v3),correct(v23),correct(v12),correct(v11),correct(v7),correct(v10),correct(v2),correct(v6),correct(v9),correct(v18),correct(v20),correct(v22),correct(v8),correct(v13),correct(v17),correct(v16)}, {correct(v19),correct(v25)}).


