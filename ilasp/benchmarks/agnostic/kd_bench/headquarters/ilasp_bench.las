#modeb(3, isbasedin(var(B),var(C)), (positive)).
#modeb(3, islocatedin(var(C),var(S)), (positive)).
#modeh(isheadquarteredin(var(B),var(S))).
#maxv(10).

isbasedin(0,1).
isbasedin(6,3).
isbasedin(4,5).
isbasedin(2,3).

islocatedin(3,8).
islocatedin(1,7).
islocatedin(10,11).
islocatedin(5,9).
islocatedin(12,13).


#pos(p1, {isheadquarteredin(0,7),isheadquarteredin(6,8),isheadquarteredin(4,9),isheadquarteredin(2,8)}, {isheadquarteredin(4,13),isheadquarteredin(2,9),isheadquarteredin(0,11),isheadquarteredin(4,11),isheadquarteredin(2,13),isheadquarteredin(4,7),isheadquarteredin(0,8),isheadquarteredin(6,9),isheadquarteredin(4,8),isheadquarteredin(2,7),isheadquarteredin(2,11),isheadquarteredin(6,7),isheadquarteredin(6,13),isheadquarteredin(6,11),isheadquarteredin(0,9),isheadquarteredin(0,13)}).
#neg(n1, {isheadquarteredin(4,13),isheadquarteredin(2,9),isheadquarteredin(0,11),isheadquarteredin(4,11),isheadquarteredin(2,13),isheadquarteredin(4,7),isheadquarteredin(0,8),isheadquarteredin(6,9),isheadquarteredin(4,8),isheadquarteredin(2,7),isheadquarteredin(2,11),isheadquarteredin(6,7),isheadquarteredin(6,13),isheadquarteredin(6,11),isheadquarteredin(0,9),isheadquarteredin(0,13)}, {isheadquarteredin(0,7),isheadquarteredin(6,8),isheadquarteredin(4,9),isheadquarteredin(2,8)}).


