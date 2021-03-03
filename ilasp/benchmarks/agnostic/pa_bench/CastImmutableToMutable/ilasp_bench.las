#modeb(3, castexpr(var(I),var(T),var(T)), (positive)).
#modeb(3, immutable(var(T)), (positive)).
#modeb(3, mutable(var(T)), (positive)).
#modeh(castimmutabletomutable(var(I))).
#maxv(10).

castexpr(14,13,12).
castexpr(0,1,2).
castexpr(6,7,8).
castexpr(3,4,5).
castexpr(9,8,10).
castexpr(11,12,13).

immutable(1).
immutable(4).
immutable(10).
immutable(5).
immutable(12).

mutable(2).
mutable(13).
mutable(8).
mutable(7).


#pos(p1, {castimmutabletomutable(0),castimmutabletomutable(11)}, {castimmutabletomutable(9),castimmutabletomutable(14),castimmutabletomutable(3),castimmutabletomutable(6)}).
#neg(n1, {castimmutabletomutable(9),castimmutabletomutable(14),castimmutabletomutable(3),castimmutabletomutable(6)}, {castimmutabletomutable(0),castimmutabletomutable(11)}).


