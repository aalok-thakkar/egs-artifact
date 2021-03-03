#modeb(3, input_a(var(I),var(R),var(D)), (positive)).
#modeb(3, c0(var(R),var(D)), (positive)).
#modeb(3, c1(var(D),var(D)), (positive)).
#modeh(output_a(var(I),var(R),var(D))).
#maxv(10).

input_a(0,9,10).
input_a(0,15,16).
input_a(0,1,2).
input_a(0,11,12).
input_a(0,5,6).
input_a(0,7,8).
input_a(0,17,18).
input_a(0,13,14).
input_a(0,3,4).

c0(19,10).

c1(2,4).
c1(16,18).
c1(14,16).
c1(4,6).
c1(12,14).
c1(8,10).
c1(6,8).
c1(10,12).


#pos(p1, {output_a(0,15,16),output_a(0,13,14),output_a(0,17,18),output_a(0,11,12)}, {output_a(0,17,16),output_a(0,9,16),output_a(0,7,4),output_a(0,5,10),output_a(0,11,6),output_a(0,13,18),output_a(0,11,10),output_a(0,7,18),output_a(0,15,6),output_a(0,19,18),output_a(0,5,14),output_a(0,15,8),output_a(0,19,2),output_a(0,3,12),output_a(0,13,6),output_a(0,1,10),output_a(0,13,8),output_a(0,19,6),output_a(0,7,6),output_a(0,7,8),output_a(0,13,16),output_a(0,19,10),output_a(0,3,4),output_a(0,17,10),output_a(0,9,10),output_a(0,7,16),output_a(0,1,14),output_a(0,5,4),output_a(0,15,18),output_a(0,15,2),output_a(0,19,14),output_a(0,17,14),output_a(0,9,14),output_a(0,13,2),output_a(0,7,2),output_a(0,15,10),output_a(0,3,6),output_a(0,11,14),output_a(0,3,8),output_a(0,5,12),output_a(0,13,10),output_a(0,3,16),output_a(0,7,10),output_a(0,15,14),output_a(0,17,4),output_a(0,9,4),output_a(0,7,14),output_a(0,3,18),output_a(0,11,4),output_a(0,1,12),output_a(0,5,18),output_a(0,3,2),output_a(0,5,2),output_a(0,17,12),output_a(0,9,12),output_a(0,1,4),output_a(0,17,8),output_a(0,5,6),output_a(0,3,10),output_a(0,5,8),output_a(0,19,4),output_a(0,5,16),output_a(0,1,18),output_a(0,11,8),output_a(0,3,14),output_a(0,1,2),output_a(0,11,16),output_a(0,15,12),output_a(0,9,18),output_a(0,1,6),output_a(0,17,2),output_a(0,9,2),output_a(0,13,12),output_a(0,1,8),output_a(0,15,4),output_a(0,19,12),output_a(0,7,12),output_a(0,17,6),output_a(0,9,6),output_a(0,1,16),output_a(0,11,18),output_a(0,19,8),output_a(0,9,8),output_a(0,13,4),output_a(0,11,2),output_a(0,19,16)}).
#neg(n1, {output_a(0,17,16),output_a(0,9,16),output_a(0,7,4),output_a(0,5,10),output_a(0,11,6),output_a(0,13,18),output_a(0,11,10),output_a(0,7,18),output_a(0,15,6),output_a(0,19,18),output_a(0,5,14),output_a(0,15,8),output_a(0,19,2),output_a(0,3,12),output_a(0,13,6),output_a(0,1,10),output_a(0,13,8),output_a(0,19,6),output_a(0,7,6),output_a(0,7,8),output_a(0,13,16),output_a(0,19,10),output_a(0,3,4),output_a(0,17,10),output_a(0,9,10),output_a(0,7,16),output_a(0,1,14),output_a(0,5,4),output_a(0,15,18),output_a(0,15,2),output_a(0,19,14),output_a(0,17,14),output_a(0,9,14),output_a(0,13,2),output_a(0,7,2),output_a(0,15,10),output_a(0,3,6),output_a(0,11,14),output_a(0,3,8),output_a(0,5,12),output_a(0,13,10),output_a(0,3,16),output_a(0,7,10),output_a(0,15,14),output_a(0,17,4),output_a(0,9,4),output_a(0,7,14),output_a(0,3,18),output_a(0,11,4),output_a(0,1,12),output_a(0,5,18),output_a(0,3,2),output_a(0,5,2),output_a(0,17,12),output_a(0,9,12),output_a(0,1,4),output_a(0,17,8),output_a(0,5,6),output_a(0,3,10),output_a(0,5,8),output_a(0,19,4),output_a(0,5,16),output_a(0,1,18),output_a(0,11,8),output_a(0,3,14),output_a(0,1,2),output_a(0,11,16),output_a(0,15,12),output_a(0,9,18),output_a(0,1,6),output_a(0,17,2),output_a(0,9,2),output_a(0,13,12),output_a(0,1,8),output_a(0,15,4),output_a(0,19,12),output_a(0,7,12),output_a(0,17,6),output_a(0,9,6),output_a(0,1,16),output_a(0,11,18),output_a(0,19,8),output_a(0,9,8),output_a(0,13,4),output_a(0,11,2),output_a(0,19,16)}, {output_a(0,15,16),output_a(0,13,14),output_a(0,17,18),output_a(0,11,12)}).


