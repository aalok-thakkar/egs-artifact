#modeb(2, greensignal(var(v)), (positive)).
#modeb(2, hastraffic(var(v)), (positive)).
#modeb(1, intersect(var(v),var(v)), (positive)).
#modeh(crashes(var(v))).
#maxv(2).

greensignal(v1).
greensignal(v0).
greensignal(v2).
greensignal(v3).

hastraffic(v4).
hastraffic(v1).
hastraffic(v0).
hastraffic(v2).

intersect(v4,v0).
intersect(v1,v4).
intersect(v0,v2).
intersect(v0,v3).
intersect(v3,v0).
intersect(v4,v1).
intersect(v0,v4).
intersect(v2,v0).
intersect(v3,v1).
intersect(v1,v3).


#pos(p1, {crashes(v0),crashes(v2)}, {crashes(v4),crashes(v1),crashes(v3)}).
#neg(n1, {crashes(v4),crashes(v1),crashes(v3)}, {crashes(v0),crashes(v2)}).


