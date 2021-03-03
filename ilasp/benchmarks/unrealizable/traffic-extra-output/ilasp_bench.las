#modeb(2, greensignal(var(v)), (positive)).
#modeb(2, hastraffic(var(v)), (positive)).
#modeb(1, intersect(var(v),var(v)), (positive)).
#modeh(crashes(var(v))).
#maxv(2).

greensignal(v1).
greensignal(v3).
greensignal(v0).
greensignal(v2).

hastraffic(v4).
hastraffic(v1).
hastraffic(v3).
hastraffic(v0).

intersect(v2,v0).
intersect(v4,v3).
intersect(v0,v3).
intersect(v3,v0).
intersect(v2,v4).
intersect(v1,v0).
intersect(v4,v2).
intersect(v3,v4).
intersect(v0,v1).
intersect(v0,v2).


#pos(p1, {crashes(v5),crashes(v1),crashes(v0)}, {crashes(v4),crashes(v3),crashes(v2)}).
#neg(n1, {crashes(v4),crashes(v3),crashes(v2)}, {crashes(v5),crashes(v1),crashes(v0)}).


