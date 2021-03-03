#modeb(3, weather(var(S),var(S),var(S)), (positive)).
#modeb(3, hightemp(var(S)), (positive)).
#modeh(output_a(var(S))).
#maxv(10).

weather(6,7,8).
weather(3,4,5).
weather(0,1,2).
weather(9,10,11).

hightemp(17).
hightemp(15).
hightemp(13).
hightemp(16).
hightemp(19).
hightemp(12).
hightemp(14).
hightemp(11).
hightemp(18).
hightemp(5).


#pos(p1, {output_a(9),output_a(3)}, {output_a(17),output_a(15),output_a(4),output_a(13),output_a(5),output_a(16),output_a(2),output_a(7),output_a(19),output_a(12),output_a(10),output_a(8),output_a(14),output_a(1),output_a(6),output_a(18),output_a(0),output_a(11)}).
#neg(n1, {output_a(17),output_a(15),output_a(4),output_a(13),output_a(5),output_a(16),output_a(2),output_a(7),output_a(19),output_a(12),output_a(10),output_a(8),output_a(14),output_a(1),output_a(6),output_a(18),output_a(0),output_a(11)}, {output_a(9),output_a(3)}).


