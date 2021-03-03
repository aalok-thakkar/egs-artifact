#modeb(3, store(var(S),var(S),var(S)), (positive)).
#modeb(3, varpointsto(var(S),var(H)), (positive)).
#modeb(3, intvar(var(S),var(I)), (positive)).
#modeh(intfield(var(H),var(S),var(I))).
#maxv(10).

store(6,7,8).
store(0,1,2).
store(3,4,5).

varpointsto(6,12).
varpointsto(10,11).
varpointsto(0,9).

intvar(5,16).
intvar(2,13).
intvar(14,15).


#pos(p1, {intfield(9,1,13)}, {intfield(11,0,15),intfield(11,2,16),intfield(12,14,16),intfield(9,0,15),intfield(9,2,16),intfield(11,1,15),intfield(9,5,13),intfield(9,14,16),intfield(11,5,13),intfield(11,14,16),intfield(12,14,15),intfield(9,4,13),intfield(11,0,13),intfield(9,2,15),intfield(11,10,15),intfield(9,5,16),intfield(11,4,16),intfield(11,5,16),intfield(12,3,16),intfield(12,10,16),intfield(11,2,13),intfield(9,5,15),intfield(9,7,13),intfield(11,4,15),intfield(11,5,15),intfield(12,3,15),intfield(12,6,13),intfield(9,14,13),intfield(9,4,15),intfield(11,7,16),intfield(11,14,13),intfield(9,7,16),intfield(12,6,16),intfield(12,0,16),intfield(11,4,13),intfield(11,7,15),intfield(12,3,13),intfield(11,2,15),intfield(12,10,13),intfield(9,7,15),intfield(12,6,15),intfield(12,0,15),intfield(12,2,16),intfield(9,14,15),intfield(9,8,16),intfield(11,14,15),intfield(11,7,13),intfield(12,5,13),intfield(9,3,16),intfield(9,8,15),intfield(12,0,13),intfield(12,10,15),intfield(12,4,16),intfield(12,5,16),intfield(9,3,15),intfield(11,8,13),intfield(12,2,13),intfield(9,8,13),intfield(12,4,15),intfield(12,5,15),intfield(11,8,16),intfield(12,7,16),intfield(12,1,16),intfield(9,3,13),intfield(9,0,16),intfield(11,8,15),intfield(12,4,13),intfield(12,7,15),intfield(12,1,15),intfield(9,10,13),intfield(12,2,15),intfield(9,1,16),intfield(11,3,16),intfield(11,10,16),intfield(12,8,16),intfield(9,10,16),intfield(9,1,15),intfield(9,6,13),intfield(12,7,13),intfield(12,1,13),intfield(11,3,15),intfield(11,6,13),intfield(12,8,15),intfield(9,0,13),intfield(9,10,15),intfield(11,1,13),intfield(9,6,16),intfield(9,4,16),intfield(11,6,16),intfield(11,0,16),intfield(12,14,13),intfield(11,3,13),intfield(9,2,13),intfield(11,10,13),intfield(12,8,13),intfield(11,1,16),intfield(9,6,15),intfield(11,6,15)}).
#neg(n1, {intfield(11,0,15),intfield(11,2,16),intfield(12,14,16),intfield(9,0,15),intfield(9,2,16),intfield(11,1,15),intfield(9,5,13),intfield(9,14,16),intfield(11,5,13),intfield(11,14,16),intfield(12,14,15),intfield(9,4,13),intfield(11,0,13),intfield(9,2,15),intfield(11,10,15),intfield(9,5,16),intfield(11,4,16),intfield(11,5,16),intfield(12,3,16),intfield(12,10,16),intfield(11,2,13),intfield(9,5,15),intfield(9,7,13),intfield(11,4,15),intfield(11,5,15),intfield(12,3,15),intfield(12,6,13),intfield(9,14,13),intfield(9,4,15),intfield(11,7,16),intfield(11,14,13),intfield(9,7,16),intfield(12,6,16),intfield(12,0,16),intfield(11,4,13),intfield(11,7,15),intfield(12,3,13),intfield(11,2,15),intfield(12,10,13),intfield(9,7,15),intfield(12,6,15),intfield(12,0,15),intfield(12,2,16),intfield(9,14,15),intfield(9,8,16),intfield(11,14,15),intfield(11,7,13),intfield(12,5,13),intfield(9,3,16),intfield(9,8,15),intfield(12,0,13),intfield(12,10,15),intfield(12,4,16),intfield(12,5,16),intfield(9,3,15),intfield(11,8,13),intfield(12,2,13),intfield(9,8,13),intfield(12,4,15),intfield(12,5,15),intfield(11,8,16),intfield(12,7,16),intfield(12,1,16),intfield(9,3,13),intfield(9,0,16),intfield(11,8,15),intfield(12,4,13),intfield(12,7,15),intfield(12,1,15),intfield(9,10,13),intfield(12,2,15),intfield(9,1,16),intfield(11,3,16),intfield(11,10,16),intfield(12,8,16),intfield(9,10,16),intfield(9,1,15),intfield(9,6,13),intfield(12,7,13),intfield(12,1,13),intfield(11,3,15),intfield(11,6,13),intfield(12,8,15),intfield(9,0,13),intfield(9,10,15),intfield(11,1,13),intfield(9,6,16),intfield(9,4,16),intfield(11,6,16),intfield(11,0,16),intfield(12,14,13),intfield(11,3,13),intfield(9,2,13),intfield(11,10,13),intfield(12,8,13),intfield(11,1,16),intfield(9,6,15),intfield(11,6,15)}, {intfield(9,1,13)}).


