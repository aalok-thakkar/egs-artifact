#modeb(1, hair(var(c)), (positive)).
#modeb(1, scales(var(c)), (positive)).
#modeb(1, has_gills(var(a)), (positive)).
#modeb(1, has_eggs(var(a)), (positive)).
#modeb(1, has_covering(var(a),var(c)), (positive)).
#modeb(1, homeothermic(var(a)), (positive)).
#modeb(1, feathers(var(c)), (positive)).
#modeb(1, none(var(c)), (positive)).
#modeb(1, has_milk(var(a)), (positive)).
#modeh(mammal(var(a))).
#modeh(fish(var(a))).
#modeh(reptile(var(a))).
#modeh(bird(var(a))).
#maxv(2).

hair(v0).

scales(v1).

has_gills(v3).
has_gills(v4).
has_gills(v5).
has_gills(v2).

has_eggs(v7).
has_eggs(v5).
has_eggs(v10).
has_eggs(v3).
has_eggs(v4).
has_eggs(v2).
has_eggs(v12).
has_eggs(v13).
has_eggs(v8).
has_eggs(v14).
has_eggs(v11).
has_eggs(v6).
has_eggs(v9).

has_covering(v17,v0).
has_covering(v2,v16).
has_covering(v11,v1).
has_covering(v8,v1).
has_covering(v7,v1).
has_covering(v10,v15).
has_covering(v4,v16).
has_covering(v3,v16).
has_covering(v12,v15).
has_covering(v14,v1).
has_covering(v9,v1).
has_covering(v6,v15).
has_covering(v5,v16).
has_covering(v13,v0).
has_covering(v18,v16).
has_covering(v19,v0).

homeothermic(v10).
homeothermic(v20).
homeothermic(v18).
homeothermic(v12).
homeothermic(v13).
homeothermic(v19).
homeothermic(v6).
homeothermic(v17).

feathers(v15).

none(v16).

has_milk(v20).
has_milk(v18).
has_milk(v13).
has_milk(v19).
has_milk(v17).


#pos(p1, {mammal(v20),mammal(v18),mammal(v13),mammal(v19),mammal(v17)}, {mammal(v7),mammal(v5),mammal(v10),mammal(v3),mammal(v4),mammal(v2),mammal(v12),mammal(v8),mammal(v14),mammal(v11),mammal(v6),mammal(v9)}).
#neg(n1, {mammal(v7),mammal(v5),mammal(v10),mammal(v3),mammal(v4),mammal(v2),mammal(v12),mammal(v8),mammal(v14),mammal(v11),mammal(v6),mammal(v9)}, {mammal(v20),mammal(v18),mammal(v13),mammal(v19),mammal(v17)}).

#pos(p2, {fish(v3),fish(v5),fish(v4),fish(v2)}, {fish(v7),fish(v10),fish(v18),fish(v20),fish(v12),fish(v13),fish(v8),fish(v14),fish(v11),fish(v19),fish(v6),fish(v9),fish(v17)}).
#neg(n2, {fish(v7),fish(v10),fish(v18),fish(v20),fish(v12),fish(v13),fish(v8),fish(v14),fish(v11),fish(v19),fish(v6),fish(v9),fish(v17)}, {fish(v3),fish(v5),fish(v4),fish(v2)}).

#pos(p3, {reptile(v7),reptile(v8),reptile(v11),reptile(v14),reptile(v9)}, {reptile(v5),reptile(v10),reptile(v3),reptile(v18),reptile(v20),reptile(v4),reptile(v2),reptile(v12),reptile(v13),reptile(v19),reptile(v6),reptile(v17)}).
#neg(n3, {reptile(v5),reptile(v10),reptile(v3),reptile(v18),reptile(v20),reptile(v4),reptile(v2),reptile(v12),reptile(v13),reptile(v19),reptile(v6),reptile(v17)}, {reptile(v7),reptile(v8),reptile(v11),reptile(v14),reptile(v9)}).

#pos(p4, {bird(v10),bird(v6),bird(v12)}, {bird(v7),bird(v5),bird(v3),bird(v20),bird(v18),bird(v4),bird(v2),bird(v13),bird(v8),bird(v11),bird(v19),bird(v14),bird(v9),bird(v17)}).
#neg(n4, {bird(v7),bird(v5),bird(v3),bird(v20),bird(v18),bird(v4),bird(v2),bird(v13),bird(v8),bird(v11),bird(v19),bird(v14),bird(v9),bird(v17)}, {bird(v10),bird(v6),bird(v12)}).


