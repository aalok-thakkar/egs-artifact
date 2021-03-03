#modeb(1, isbasedin(var(b),var(c)), (positive)).
#modeb(1, islocatedin(var(c),var(s)), (positive)).
#modeh(isheadquarteredin(var(b),var(s))).
#maxv(3).

isbasedin(v2,v3).
isbasedin(v4,v5).
isbasedin(v6,v3).
isbasedin(v0,v1).

islocatedin(v12,v13).
islocatedin(v1,v7).
islocatedin(v10,v11).
islocatedin(v3,v8).
islocatedin(v5,v9).


#pos(p1, {isheadquarteredin(v0,v7),isheadquarteredin(v6,v8),isheadquarteredin(v2,v8),isheadquarteredin(v4,v9)}, {isheadquarteredin(v4,v13),isheadquarteredin(v2,v13),isheadquarteredin(v2,v11),isheadquarteredin(v0,v8),isheadquarteredin(v2,v9),isheadquarteredin(v0,v11),isheadquarteredin(v6,v7),isheadquarteredin(v0,v13),isheadquarteredin(v4,v8),isheadquarteredin(v4,v7),isheadquarteredin(v2,v7),isheadquarteredin(v6,v11),isheadquarteredin(v0,v9),isheadquarteredin(v6,v13),isheadquarteredin(v4,v11),isheadquarteredin(v6,v9)}).
#neg(n1, {isheadquarteredin(v4,v13),isheadquarteredin(v2,v13),isheadquarteredin(v2,v11),isheadquarteredin(v0,v8),isheadquarteredin(v2,v9),isheadquarteredin(v0,v11),isheadquarteredin(v6,v7),isheadquarteredin(v0,v13),isheadquarteredin(v4,v8),isheadquarteredin(v4,v7),isheadquarteredin(v2,v7),isheadquarteredin(v6,v11),isheadquarteredin(v0,v9),isheadquarteredin(v6,v13),isheadquarteredin(v4,v11),isheadquarteredin(v6,v9)}, {isheadquarteredin(v0,v7),isheadquarteredin(v6,v8),isheadquarteredin(v2,v8),isheadquarteredin(v4,v9)}).


