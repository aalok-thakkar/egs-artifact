#modeb(2, greensignal(var(v)), (positive)).
#modeb(2, hastraffic(var(v)), (positive)).
#modeh(crashes(var(v))).
#maxv(2).

greensignal(v2).
greensignal(v1).
greensignal(v0).
greensignal(v3).

hastraffic(v2).
hastraffic(v1).
hastraffic(v0).
hastraffic(v4).


#pos(p1, {crashes(v2),crashes(v0)}, {crashes(v1),crashes(v3),crashes(v4)}).
#neg(n1, {crashes(v1),crashes(v3),crashes(v4)}, {crashes(v2),crashes(v0)}).


