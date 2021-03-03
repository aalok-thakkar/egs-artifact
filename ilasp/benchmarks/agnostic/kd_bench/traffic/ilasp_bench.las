#modeb(3, greensignal(var(V)), (positive)).
#modeb(3, hastraffic(var(V)), (positive)).
#modeb(3, intersect(var(V),var(V)), (positive)).
#modeh(crashes(var(V))).
#maxv(10).

greensignal(1).
greensignal(2).
greensignal(0).
greensignal(3).

hastraffic(1).
hastraffic(4).
hastraffic(2).
hastraffic(0).

intersect(4,0).
intersect(3,1).
intersect(0,3).
intersect(1,4).
intersect(3,0).
intersect(4,1).
intersect(0,4).
intersect(0,2).
intersect(2,0).
intersect(1,3).


#pos(p1, {crashes(2),crashes(0)}, {crashes(1),crashes(4),crashes(3)}).
#neg(n1, {crashes(1),crashes(4),crashes(3)}, {crashes(2),crashes(0)}).


