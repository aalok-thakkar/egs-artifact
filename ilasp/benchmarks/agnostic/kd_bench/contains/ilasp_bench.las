#modeb(3, allergens(var(I),var(A)), (positive)).
#modeb(3, ismadefrom(var(D),var(I)), (positive)).
#modeh(contains(var(D),var(A))).
#maxv(10).

allergens(0,1).
allergens(2,3).
allergens(4,3).

ismadefrom(13,12).
ismadefrom(11,10).
ismadefrom(13,2).
ismadefrom(8,0).
ismadefrom(5,6).
ismadefrom(5,7).
ismadefrom(11,12).
ismadefrom(9,10).
ismadefrom(11,2).
ismadefrom(11,6).
ismadefrom(9,4).


#pos(p1, {contains(9,3),contains(11,3),contains(13,3),contains(8,1)}, {contains(13,1),contains(9,1),contains(5,1),contains(11,1),contains(5,3),contains(8,3)}).
#neg(n1, {contains(13,1),contains(9,1),contains(5,1),contains(11,1),contains(5,3),contains(8,3)}, {contains(9,3),contains(11,3),contains(13,3),contains(8,1)}).


