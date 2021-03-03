#modeb(3, reduces(var(D),var(S)), (positive)).
#modeb(3, knowngenericallyas(var(B),var(D)), (positive)).
#modeh(reduce(var(B),var(S))).
#maxv(10).

reduces(0,2).
reduces(6,7).
reduces(0,1).
reduces(4,1).
reduces(4,5).
reduces(3,2).

knowngenericallyas(9,0).
knowngenericallyas(10,4).
knowngenericallyas(8,3).
knowngenericallyas(11,6).


#pos(p1, {reduce(10,1),reduce(11,7),reduce(8,2),reduce(10,5),reduce(9,2),reduce(9,1)}, {reduce(9,5),reduce(11,2),reduce(11,1),reduce(10,7),reduce(11,5),reduce(8,1),reduce(8,7),reduce(8,5),reduce(9,7),reduce(10,2)}).
#neg(n1, {reduce(9,5),reduce(11,2),reduce(11,1),reduce(10,7),reduce(11,5),reduce(8,1),reduce(8,7),reduce(8,5),reduce(9,7),reduce(10,2)}, {reduce(10,1),reduce(11,7),reduce(8,2),reduce(10,5),reduce(9,2),reduce(9,1)}).


