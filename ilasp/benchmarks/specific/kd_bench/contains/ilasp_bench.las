#modeb(1, allergens(var(i),var(a)), (positive)).
#modeb(1, ismadefrom(var(d),var(i)), (positive)).
#modeh(contains(var(d),var(a))).
#maxv(3).

allergens(v0,v1).
allergens(v2,v3).
allergens(v4,v3).

ismadefrom(v9,v10).
ismadefrom(v11,v12).
ismadefrom(v13,v2).
ismadefrom(v11,v10).
ismadefrom(v5,v6).
ismadefrom(v11,v2).
ismadefrom(v13,v12).
ismadefrom(v9,v4).
ismadefrom(v11,v6).
ismadefrom(v5,v7).
ismadefrom(v8,v0).


#pos(p1, {contains(v9,v3),contains(v13,v3),contains(v11,v3),contains(v8,v1)}, {contains(v13,v1),contains(v5,v3),contains(v9,v1),contains(v11,v1),contains(v8,v3),contains(v5,v1)}).
#neg(n1, {contains(v13,v1),contains(v5,v3),contains(v9,v1),contains(v11,v1),contains(v8,v3),contains(v5,v1)}, {contains(v9,v3),contains(v13,v3),contains(v11,v3),contains(v8,v1)}).


