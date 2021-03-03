#modeb(3, in(var(S),var(P)), (positive)).
#modeb(3, input0(var(P),var(PN)), (positive)).
#modeb(3, input1(var(S),var(A)), (positive)).
#modeb(3, c0(var(A)), (positive)).
#modeh(out(var(PN))).
#maxv(10).

in(11,12).
in(4,8).
in(2,7).
in(4,3).
in(2,10).
in(4,12).
in(4,5).
in(2,1).
in(0,1).
in(4,7).
in(0,9).
in(2,3).
in(0,3).
in(0,6).

input0(10,20).
input0(9,19).
input0(8,18).
input0(3,14).
input0(6,16).
input0(12,21).
input0(7,17).
input0(5,15).
input0(1,13).

input1(11,24).
input1(4,24).
input1(0,22).
input1(2,23).

c0(24).


#pos(p1, {out(21),out(17),out(18),out(15),out(14)}, {out(13),out(19),out(16),out(20)}).
#neg(n1, {out(13),out(19),out(16),out(20)}, {out(21),out(17),out(18),out(15),out(14)}).


