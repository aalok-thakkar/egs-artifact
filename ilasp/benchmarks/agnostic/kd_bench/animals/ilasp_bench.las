#modeb(3, hair(var(C)), (positive)).
#modeb(3, scales(var(C)), (positive)).
#modeb(3, has_gills(var(A)), (positive)).
#modeb(3, has_eggs(var(A)), (positive)).
#modeb(3, has_covering(var(A),var(C)), (positive)).
#modeb(3, homeothermic(var(A)), (positive)).
#modeb(3, feathers(var(C)), (positive)).
#modeb(3, none(var(C)), (positive)).
#modeb(3, has_milk(var(A)), (positive)).
#modeh(mammal(var(A))).
#modeh(fish(var(A))).
#modeh(reptile(var(A))).
#modeh(bird(var(A))).
#maxv(10).

hair(0).

scales(1).

has_gills(5).
has_gills(4).
has_gills(2).
has_gills(3).

has_eggs(13).
has_eggs(4).
has_eggs(3).
has_eggs(11).
has_eggs(10).
has_eggs(5).
has_eggs(8).
has_eggs(14).
has_eggs(9).
has_eggs(12).
has_eggs(2).
has_eggs(7).
has_eggs(6).

has_covering(5,16).
has_covering(10,15).
has_covering(4,16).
has_covering(11,1).
has_covering(17,0).
has_covering(12,15).
has_covering(9,1).
has_covering(18,16).
has_covering(2,16).
has_covering(19,0).
has_covering(3,16).
has_covering(13,0).
has_covering(8,1).
has_covering(6,15).
has_covering(14,1).
has_covering(7,1).

homeothermic(13).
homeothermic(10).
homeothermic(12).
homeothermic(18).
homeothermic(20).
homeothermic(19).
homeothermic(17).
homeothermic(6).

feathers(15).

none(16).

has_milk(13).
has_milk(18).
has_milk(20).
has_milk(19).
has_milk(17).


#pos(p1, {mammal(13),mammal(18),mammal(20),mammal(19),mammal(17)}, {mammal(4),mammal(3),mammal(11),mammal(10),mammal(5),mammal(14),mammal(8),mammal(9),mammal(12),mammal(2),mammal(7),mammal(6)}).
#neg(n1, {mammal(4),mammal(3),mammal(11),mammal(10),mammal(5),mammal(14),mammal(8),mammal(9),mammal(12),mammal(2),mammal(7),mammal(6)}, {mammal(13),mammal(18),mammal(20),mammal(19),mammal(17)}).

#pos(p2, {fish(5),fish(4),fish(3),fish(2)}, {fish(20),fish(13),fish(11),fish(7),fish(10),fish(14),fish(18),fish(8),fish(9),fish(12),fish(19),fish(17),fish(6)}).
#neg(n2, {fish(20),fish(13),fish(11),fish(7),fish(10),fish(14),fish(18),fish(8),fish(9),fish(12),fish(19),fish(17),fish(6)}, {fish(5),fish(4),fish(3),fish(2)}).

#pos(p3, {reptile(11),reptile(14),reptile(8),reptile(9),reptile(7)}, {reptile(20),reptile(13),reptile(4),reptile(3),reptile(10),reptile(5),reptile(18),reptile(12),reptile(2),reptile(19),reptile(17),reptile(6)}).
#neg(n3, {reptile(20),reptile(13),reptile(4),reptile(3),reptile(10),reptile(5),reptile(18),reptile(12),reptile(2),reptile(19),reptile(17),reptile(6)}, {reptile(11),reptile(14),reptile(8),reptile(9),reptile(7)}).

#pos(p4, {bird(12),bird(6),bird(10)}, {bird(13),bird(4),bird(3),bird(11),bird(7),bird(5),bird(14),bird(18),bird(8),bird(9),bird(20),bird(2),bird(19),bird(17)}).
#neg(n4, {bird(13),bird(4),bird(3),bird(11),bird(7),bird(5),bird(14),bird(18),bird(8),bird(9),bird(20),bird(2),bird(19),bird(17)}, {bird(12),bird(6),bird(10)}).


