#modeb(3, reallocexp(var(FID)), (positive)).
#modeb(3, assign(var(S),var(FID)), (positive)).
#modeb(3, params(var(FID),var(I),var(S)), (positive)).
#modeh(reallocmisuse(var(FID),var(S))).
#maxv(10).

reallocexp(0).
reallocexp(1).
reallocexp(2).

assign(6,1).
assign(3,0).
assign(4,5).
assign(7,2).
assign(3,8).

params(8,18,19).
params(0,9,3).
params(8,9,16).
params(2,10,15).
params(1,10,13).
params(8,10,17).
params(2,9,14).
params(1,9,12).
params(0,10,11).
params(5,9,4).


#pos(p1, {reallocmisuse(0,3)}, {reallocmisuse(1,11),reallocmisuse(0,11),reallocmisuse(8,3),reallocmisuse(2,7),reallocmisuse(5,13),reallocmisuse(1,4),reallocmisuse(0,4),reallocmisuse(2,3),reallocmisuse(5,7),reallocmisuse(5,3),reallocmisuse(8,11),reallocmisuse(1,19),reallocmisuse(1,15),reallocmisuse(0,19),reallocmisuse(0,15),reallocmisuse(2,11),reallocmisuse(8,7),reallocmisuse(1,14),reallocmisuse(8,4),reallocmisuse(0,14),reallocmisuse(1,17),reallocmisuse(2,4),reallocmisuse(5,11),reallocmisuse(0,17),reallocmisuse(8,15),reallocmisuse(1,12),reallocmisuse(5,4),reallocmisuse(0,12),reallocmisuse(1,6),reallocmisuse(2,15),reallocmisuse(8,19),reallocmisuse(8,14),reallocmisuse(2,19),reallocmisuse(2,14),reallocmisuse(0,6),reallocmisuse(1,16),reallocmisuse(8,17),reallocmisuse(5,15),reallocmisuse(0,16),reallocmisuse(2,17),reallocmisuse(8,12),reallocmisuse(5,19),reallocmisuse(5,14),reallocmisuse(1,13),reallocmisuse(2,12),reallocmisuse(0,13),reallocmisuse(8,6),reallocmisuse(5,17),reallocmisuse(2,6),reallocmisuse(1,7),reallocmisuse(0,7),reallocmisuse(8,16),reallocmisuse(5,12),reallocmisuse(2,16),reallocmisuse(1,3),reallocmisuse(8,13),reallocmisuse(5,6),reallocmisuse(2,13),reallocmisuse(5,16)}).
#neg(n1, {reallocmisuse(1,11),reallocmisuse(0,11),reallocmisuse(8,3),reallocmisuse(2,7),reallocmisuse(5,13),reallocmisuse(1,4),reallocmisuse(0,4),reallocmisuse(2,3),reallocmisuse(5,7),reallocmisuse(5,3),reallocmisuse(8,11),reallocmisuse(1,19),reallocmisuse(1,15),reallocmisuse(0,19),reallocmisuse(0,15),reallocmisuse(2,11),reallocmisuse(8,7),reallocmisuse(1,14),reallocmisuse(8,4),reallocmisuse(0,14),reallocmisuse(1,17),reallocmisuse(2,4),reallocmisuse(5,11),reallocmisuse(0,17),reallocmisuse(8,15),reallocmisuse(1,12),reallocmisuse(5,4),reallocmisuse(0,12),reallocmisuse(1,6),reallocmisuse(2,15),reallocmisuse(8,19),reallocmisuse(8,14),reallocmisuse(2,19),reallocmisuse(2,14),reallocmisuse(0,6),reallocmisuse(1,16),reallocmisuse(8,17),reallocmisuse(5,15),reallocmisuse(0,16),reallocmisuse(2,17),reallocmisuse(8,12),reallocmisuse(5,19),reallocmisuse(5,14),reallocmisuse(1,13),reallocmisuse(2,12),reallocmisuse(0,13),reallocmisuse(8,6),reallocmisuse(5,17),reallocmisuse(2,6),reallocmisuse(1,7),reallocmisuse(0,7),reallocmisuse(8,16),reallocmisuse(5,12),reallocmisuse(2,16),reallocmisuse(1,3),reallocmisuse(8,13),reallocmisuse(5,6),reallocmisuse(2,13),reallocmisuse(5,16)}, {reallocmisuse(0,3)}).


