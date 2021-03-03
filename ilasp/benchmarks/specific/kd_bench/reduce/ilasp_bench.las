#modeb(1, reduces(var(d),var(s)), (positive)).
#modeb(1, knowngenericallyas(var(b),var(d)), (positive)).
#modeh(reduce(var(b),var(s))).
#maxv(3).

reduces(v4,v5).
reduces(v0,v2).
reduces(v6,v7).
reduces(v4,v1).
reduces(v3,v2).
reduces(v0,v1).

knowngenericallyas(v10,v4).
knowngenericallyas(v9,v0).
knowngenericallyas(v11,v6).
knowngenericallyas(v8,v3).


#pos(p1, {reduce(v8,v2),reduce(v9,v2),reduce(v10,v5),reduce(v9,v1),reduce(v10,v1),reduce(v11,v7)}, {reduce(v10,v7),reduce(v8,v5),reduce(v11,v5),reduce(v8,v1),reduce(v11,v1),reduce(v9,v5),reduce(v11,v2),reduce(v10,v2),reduce(v8,v7),reduce(v9,v7)}).
#neg(n1, {reduce(v10,v7),reduce(v8,v5),reduce(v11,v5),reduce(v8,v1),reduce(v11,v1),reduce(v9,v5),reduce(v11,v2),reduce(v10,v2),reduce(v8,v7),reduce(v9,v7)}, {reduce(v8,v2),reduce(v9,v2),reduce(v10,v5),reduce(v9,v1),reduce(v10,v1),reduce(v11,v7)}).


