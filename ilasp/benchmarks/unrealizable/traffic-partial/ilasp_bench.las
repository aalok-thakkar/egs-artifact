#modeb(2, greensignal(var(v)), (positive)).
#modeb(2, hastraffic(var(v)), (positive)).
#modeb(1, intersect(var(v),var(v)), (positive)).
#modeh(crashes(var(v))).
#maxv(2).

greensignal(v0).
greensignal(v1).

hastraffic(v0).
hastraffic(v1).
hastraffic(v2).

intersect(v1,v0).
intersect(v0,v2).
intersect(v0,v1).
intersect(v2,v0).


#pos(p1, {crashes(v1)}, {crashes(v0),crashes(v2)}).
#neg(n1, {crashes(v0),crashes(v2)}, {crashes(v1)}).


