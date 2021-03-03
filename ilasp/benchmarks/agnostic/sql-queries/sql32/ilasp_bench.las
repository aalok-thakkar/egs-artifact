#modeb(3, input_a(var(B),var(DATE),var(DATE)), (positive)).
#modeb(3, end(var(DATE)), (positive)).
#modeb(3, start(var(DATE)), (positive)).
#modeh(output_a(var(B))).
#maxv(10).

input_a(0,1,2).
input_a(3,1,4).
input_a(10,11,12).
input_a(0,8,9).
input_a(13,14,15).
input_a(19,20,21).
input_a(5,6,7).
input_a(16,17,18).

end(4).
end(9).
end(7).

start(1).
start(14).
start(20).
start(6).
start(17).
start(11).


#pos(p1, {output_a(5),output_a(3)}, {output_a(19),output_a(13),output_a(10),output_a(0),output_a(16)}).
#neg(n1, {output_a(19),output_a(13),output_a(10),output_a(0),output_a(16)}, {output_a(5),output_a(3)}).


