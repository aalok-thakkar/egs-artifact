#modeb(3, certificate(var(X),var(L)), (positive)).
#modeb(3, verify(var(X),var(L)), (positive)).
#modeb(3, check(var(X),var(L)), (positive)).
#modeb(3, opsucc(var(L),var(L)), (positive)).
#modeh(correct(var(L))).
#maxv(10).

certificate(0,3).
certificate(0,1).
certificate(0,2).
certificate(0,4).

verify(5,9).
verify(5,7).
verify(5,6).
verify(5,8).

check(0,15).
check(5,11).
check(5,12).
check(0,10).
check(0,14).
check(5,13).

opsucc(6,14).
opsucc(20,12).
opsucc(21,11).
opsucc(8,15).
opsucc(12,18).
opsucc(14,25).
opsucc(6,25).
opsucc(23,13).
opsucc(16,7).
opsucc(8,11).
opsucc(10,22).
opsucc(12,4).
opsucc(1,13).
opsucc(21,8).
opsucc(23,6).
opsucc(23,25).
opsucc(23,14).
opsucc(16,17).
opsucc(1,6).
opsucc(13,25).
opsucc(2,10).
opsucc(1,25).
opsucc(11,3).
opsucc(20,9).
opsucc(7,22).
opsucc(24,18).
opsucc(10,7).
opsucc(1,14).
opsucc(21,3).
opsucc(2,22).
opsucc(3,19).
opsucc(11,19).
opsucc(16,2).
opsucc(24,4).
opsucc(21,19).
opsucc(24,12).
opsucc(15,19).
opsucc(8,3).
opsucc(4,18).
opsucc(10,17).
opsucc(9,24).
opsucc(2,7).
opsucc(8,19).
opsucc(9,18).
opsucc(20,24).
opsucc(3,15).
opsucc(16,10).
opsucc(11,15).
opsucc(9,4).
opsucc(7,17).
opsucc(6,13).
opsucc(9,12).
opsucc(16,22).
opsucc(2,17).
opsucc(21,15).
opsucc(20,18).
opsucc(22,17).
opsucc(14,13).
opsucc(23,1).
opsucc(20,4).


#pos(p1, {correct(25),correct(19)}, {correct(6),correct(14),correct(8),correct(23),correct(20),correct(10),correct(22),correct(9),correct(3),correct(7),correct(17),correct(24),correct(1),correct(16),correct(18),correct(15),correct(13),correct(21),correct(4),correct(2),correct(11),correct(12)}).
#neg(n1, {correct(6),correct(14),correct(8),correct(23),correct(20),correct(10),correct(22),correct(9),correct(3),correct(7),correct(17),correct(24),correct(1),correct(16),correct(18),correct(15),correct(13),correct(21),correct(4),correct(2),correct(11),correct(12)}, {correct(25),correct(19)}).


