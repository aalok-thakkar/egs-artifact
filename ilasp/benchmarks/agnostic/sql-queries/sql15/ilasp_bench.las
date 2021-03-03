#modeb(3, input_a(var(ID),var(C)), (positive)).
#modeb(3, input0(var(ID),var(C)), (positive)).
#modeb(3, neq(var(ID),var(ID)), (positive)).
#modeh(output_a(var(ID),var(C),var(C),var(ID))).
#maxv(10).

input_a(0,1).
input_a(2,3).
input_a(4,5).

input0(4,3).
input0(0,5).
input0(2,3).

neq(4,2).
neq(2,0).
neq(0,2).
neq(4,0).
neq(0,4).
neq(2,4).


#pos(p1, {output_a(4,5,3,2),output_a(0,1,5,4)}, {output_a(0,3,3,4),output_a(4,1,3,2),output_a(2,1,1,4),output_a(4,5,1,2),output_a(2,5,3,0),output_a(0,1,1,0),output_a(4,3,1,2),output_a(4,1,1,4),output_a(2,3,5,4),output_a(0,3,3,0),output_a(4,3,3,4),output_a(0,3,5,4),output_a(4,1,5,2),output_a(2,1,1,0),output_a(0,5,1,4),output_a(0,5,3,2),output_a(4,1,1,0),output_a(4,5,3,0),output_a(2,3,5,0),output_a(4,3,3,0),output_a(4,5,5,0),output_a(0,5,1,0),output_a(2,5,3,4),output_a(2,3,1,2),output_a(0,1,1,4),output_a(2,3,3,4),output_a(0,3,5,2),output_a(4,5,3,4),output_a(2,3,3,0),output_a(2,5,5,0),output_a(2,1,3,0),output_a(4,5,5,4),output_a(2,1,5,4),output_a(0,1,5,0),output_a(4,3,5,2),output_a(2,1,5,0),output_a(2,5,3,2),output_a(0,5,5,4),output_a(0,1,1,2),output_a(0,3,3,2),output_a(0,1,3,4),output_a(2,1,1,2),output_a(2,5,1,0),output_a(0,5,5,0),output_a(4,1,1,2),output_a(2,5,5,4),output_a(2,1,3,4),output_a(0,3,1,0),output_a(4,3,1,4),output_a(2,3,5,2),output_a(0,1,3,0),output_a(4,3,3,2),output_a(4,5,5,2),output_a(0,5,1,2),output_a(4,1,3,0),output_a(4,1,5,4),output_a(4,5,1,0),output_a(0,5,3,4),output_a(4,3,1,0),output_a(4,1,5,0),output_a(2,5,1,4),output_a(0,5,3,0),output_a(2,3,1,4),output_a(2,3,3,2),output_a(0,3,1,4),output_a(2,5,5,2),output_a(2,1,3,2),output_a(4,1,3,4),output_a(0,1,5,2),output_a(4,5,1,4),output_a(2,3,1,0),output_a(2,1,5,2),output_a(0,3,5,0),output_a(4,3,5,4),output_a(2,5,1,2),output_a(0,5,5,2),output_a(0,3,1,2),output_a(0,1,3,2),output_a(4,3,5,0)}).
#neg(n1, {output_a(0,3,3,4),output_a(4,1,3,2),output_a(2,1,1,4),output_a(4,5,1,2),output_a(2,5,3,0),output_a(0,1,1,0),output_a(4,3,1,2),output_a(4,1,1,4),output_a(2,3,5,4),output_a(0,3,3,0),output_a(4,3,3,4),output_a(0,3,5,4),output_a(4,1,5,2),output_a(2,1,1,0),output_a(0,5,1,4),output_a(0,5,3,2),output_a(4,1,1,0),output_a(4,5,3,0),output_a(2,3,5,0),output_a(4,3,3,0),output_a(4,5,5,0),output_a(0,5,1,0),output_a(2,5,3,4),output_a(2,3,1,2),output_a(0,1,1,4),output_a(2,3,3,4),output_a(0,3,5,2),output_a(4,5,3,4),output_a(2,3,3,0),output_a(2,5,5,0),output_a(2,1,3,0),output_a(4,5,5,4),output_a(2,1,5,4),output_a(0,1,5,0),output_a(4,3,5,2),output_a(2,1,5,0),output_a(2,5,3,2),output_a(0,5,5,4),output_a(0,1,1,2),output_a(0,3,3,2),output_a(0,1,3,4),output_a(2,1,1,2),output_a(2,5,1,0),output_a(0,5,5,0),output_a(4,1,1,2),output_a(2,5,5,4),output_a(2,1,3,4),output_a(0,3,1,0),output_a(4,3,1,4),output_a(2,3,5,2),output_a(0,1,3,0),output_a(4,3,3,2),output_a(4,5,5,2),output_a(0,5,1,2),output_a(4,1,3,0),output_a(4,1,5,4),output_a(4,5,1,0),output_a(0,5,3,4),output_a(4,3,1,0),output_a(4,1,5,0),output_a(2,5,1,4),output_a(0,5,3,0),output_a(2,3,1,4),output_a(2,3,3,2),output_a(0,3,1,4),output_a(2,5,5,2),output_a(2,1,3,2),output_a(4,1,3,4),output_a(0,1,5,2),output_a(4,5,1,4),output_a(2,3,1,0),output_a(2,1,5,2),output_a(0,3,5,0),output_a(4,3,5,4),output_a(2,5,1,2),output_a(0,5,5,2),output_a(0,3,1,2),output_a(0,1,3,2),output_a(4,3,5,0)}, {output_a(4,5,3,2),output_a(0,1,5,4)}).


