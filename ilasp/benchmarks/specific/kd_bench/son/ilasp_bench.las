#modeb(1, father(var(p),var(p)), (positive)).
#modeb(1, brother(var(p),var(p)), (positive)).
#modeb(1, sister(var(p),var(p)), (positive)).
#modeh(target(var(p),var(p))).
#maxv(3).

father(v3,v4).
father(v6,v7).
father(v6,v8).
father(v0,v2).
father(v0,v1).
father(v3,v5).

brother(v1,v2).
brother(v4,v5).
brother(v2,v1).

sister(v5,v2).
sister(v7,v8).
sister(v8,v7).


#pos(p1, {target(v2,v0),target(v4,v3),target(v1,v0)}, {target(v2,v6),target(v1,v5),target(v2,v8),target(v8,v5),target(v0,v1),target(v4,v2),target(v5,v2),target(v0,v0),target(v1,v1),target(v7,v2),target(v6,v6),target(v8,v1),target(v6,v8),target(v3,v2),target(v8,v0),target(v0,v7),target(v2,v5),target(v6,v4),target(v1,v7),target(v0,v2),target(v8,v7),target(v2,v1),target(v4,v4),target(v6,v5),target(v3,v6),target(v5,v4),target(v1,v2),target(v8,v2),target(v5,v3),target(v7,v4),target(v7,v3),target(v6,v1),target(v3,v4),target(v2,v7),target(v3,v3),target(v4,v6),target(v4,v8),target(v5,v6),target(v3,v5),target(v2,v2),target(v5,v8),target(v0,v4),target(v7,v6),target(v6,v7),target(v0,v3),target(v7,v8),target(v3,v8),target(v1,v4),target(v8,v4),target(v3,v1),target(v1,v3),target(v8,v3),target(v4,v5),target(v5,v5),target(v0,v6),target(v6,v0),target(v0,v8),target(v7,v7),target(v7,v5),target(v4,v1),target(v3,v7),target(v1,v6),target(v2,v4),target(v8,v6),target(v1,v8),target(v5,v1),target(v4,v0),target(v8,v8),target(v2,v3),target(v7,v1),target(v5,v0),target(v7,v0),target(v0,v5),target(v6,v2),target(v4,v7),target(v3,v0),target(v6,v3),target(v5,v7)}).
#neg(n1, {target(v2,v6),target(v1,v5),target(v2,v8),target(v8,v5),target(v0,v1),target(v4,v2),target(v5,v2),target(v0,v0),target(v1,v1),target(v7,v2),target(v6,v6),target(v8,v1),target(v6,v8),target(v3,v2),target(v8,v0),target(v0,v7),target(v2,v5),target(v6,v4),target(v1,v7),target(v0,v2),target(v8,v7),target(v2,v1),target(v4,v4),target(v6,v5),target(v3,v6),target(v5,v4),target(v1,v2),target(v8,v2),target(v5,v3),target(v7,v4),target(v7,v3),target(v6,v1),target(v3,v4),target(v2,v7),target(v3,v3),target(v4,v6),target(v4,v8),target(v5,v6),target(v3,v5),target(v2,v2),target(v5,v8),target(v0,v4),target(v7,v6),target(v6,v7),target(v0,v3),target(v7,v8),target(v3,v8),target(v1,v4),target(v8,v4),target(v3,v1),target(v1,v3),target(v8,v3),target(v4,v5),target(v5,v5),target(v0,v6),target(v6,v0),target(v0,v8),target(v7,v7),target(v7,v5),target(v4,v1),target(v3,v7),target(v1,v6),target(v2,v4),target(v8,v6),target(v1,v8),target(v5,v1),target(v4,v0),target(v8,v8),target(v2,v3),target(v7,v1),target(v5,v0),target(v7,v0),target(v0,v5),target(v6,v2),target(v4,v7),target(v3,v0),target(v6,v3),target(v5,v7)}, {target(v2,v0),target(v4,v3),target(v1,v0)}).


