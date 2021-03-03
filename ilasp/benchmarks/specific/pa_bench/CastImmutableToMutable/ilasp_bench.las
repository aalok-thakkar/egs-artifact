#modeb(1, immutable(var(t)), (positive)).
#modeb(1, mutable(var(t)), (positive)).
#modeb(1, castexpr(var(i), var(t), var(t)), (positive)).
#modeh(castimmutabletomutable(var(i))).
#maxv(3).

castexpr(v6,v7,v8).
castexpr(v0,v1,v2).
castexpr(v11,v12,v13).
castexpr(v14,v13,v12).
castexpr(v3,v4,v5).
castexpr(v9,v8,v10).

immutable(v1).
immutable(v12).
immutable(v5).
immutable(v10).
immutable(v4).

mutable(v2).
mutable(v13).
mutable(v7).
mutable(v8).


#pos(p1, {castimmutabletomutable(v0),castimmutabletomutable(v11)}, {castimmutabletomutable(v3),castimmutabletomutable(v14),castimmutabletomutable(v6),castimmutabletomutable(v9)}).
#neg(n1, {castimmutabletomutable(v3),castimmutabletomutable(v14),castimmutabletomutable(v6),castimmutabletomutable(v9)}, {castimmutabletomutable(v0),castimmutabletomutable(v11)}).


