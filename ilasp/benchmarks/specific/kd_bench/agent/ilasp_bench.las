#modeb(1, agent_at(var(c),var(t)), (positive)).
#modeb(1, adjacent(var(c),var(c)), (positive)).
#modeb(1, unlocked(var(c)), (positive)).
#modeb(1, not_wall(var(c),var(c)), (positive)).
#modeh(valid_move(var(c),var(t))).
#maxv(3).

agent_at(v0,v1).
agent_at(v4,v5).
agent_at(v2,v3).

adjacent(v0,v7).
adjacent(v9,v11).
adjacent(v7,v2).
adjacent(v7,v0).
adjacent(v10,v4).
adjacent(v4,v2).
adjacent(v9,v10).
adjacent(v10,v7).
adjacent(v11,v9).
adjacent(v8,v9).
adjacent(v11,v4).
adjacent(v8,v6).
adjacent(v9,v2).
adjacent(v7,v10).
adjacent(v4,v11).
adjacent(v2,v9).
adjacent(v6,v8).
adjacent(v4,v10).
adjacent(v2,v6).
adjacent(v6,v2).
adjacent(v6,v0).
adjacent(v2,v4).
adjacent(v2,v7).
adjacent(v0,v6).

unlocked(v10).
unlocked(v7).
unlocked(v4).
unlocked(v9).
unlocked(v2).
unlocked(v0).

not_wall(v0,v7).
not_wall(v9,v11).
not_wall(v9,v7).
not_wall(v7,v0).
not_wall(v0,v11).
not_wall(v10,v9).
not_wall(v11,v8).
not_wall(v6,v6).
not_wall(v6,v4).
not_wall(v2,v10).
not_wall(v10,v4).
not_wall(v4,v8).
not_wall(v8,v8).
not_wall(v10,v6).
not_wall(v7,v9).
not_wall(v4,v0).
not_wall(v6,v7).
not_wall(v9,v10).
not_wall(v4,v2).
not_wall(v11,v0).
not_wall(v11,v2).
not_wall(v0,v10).
not_wall(v8,v2).
not_wall(v6,v11).
not_wall(v8,v0).
not_wall(v7,v6).
not_wall(v7,v4).
not_wall(v11,v9).
not_wall(v10,v11).
not_wall(v4,v9).
not_wall(v8,v9).
not_wall(v7,v7).
not_wall(v6,v10).
not_wall(v11,v6).
not_wall(v7,v11).
not_wall(v4,v6).
not_wall(v11,v7).
not_wall(v2,v8).
not_wall(v4,v4).
not_wall(v9,v8).
not_wall(v10,v10).
not_wall(v8,v4).
not_wall(v2,v2).
not_wall(v2,v0).
not_wall(v4,v7).
not_wall(v11,v11).
not_wall(v8,v7).
not_wall(v0,v8).
not_wall(v9,v0).
not_wall(v9,v2).
not_wall(v0,v2).
not_wall(v0,v0).
not_wall(v8,v11).
not_wall(v2,v9).
not_wall(v9,v9).
not_wall(v11,v10).
not_wall(v4,v10).
not_wall(v10,v8).
not_wall(v0,v9).
not_wall(v8,v10).
not_wall(v6,v2).
not_wall(v6,v0).
not_wall(v2,v6).
not_wall(v2,v4).
not_wall(v2,v11).
not_wall(v9,v4).
not_wall(v9,v6).
not_wall(v10,v2).
not_wall(v10,v0).
not_wall(v0,v6).
not_wall(v0,v4).
not_wall(v7,v8).
not_wall(v6,v9).


#pos(p1, {valid_move(v2,v5),valid_move(v4,v3),valid_move(v7,v1),valid_move(v10,v5),valid_move(v9,v3)}, {valid_move(v7,v5),valid_move(v8,v3),valid_move(v11,v5),valid_move(v6,v1),valid_move(v4,v5),valid_move(v10,v1),valid_move(v8,v5),valid_move(v2,v3),valid_move(v11,v1),valid_move(v4,v1),valid_move(v8,v1),valid_move(v0,v3),valid_move(v9,v5),valid_move(v0,v5),valid_move(v6,v3),valid_move(v10,v3),valid_move(v6,v5),valid_move(v2,v1),valid_move(v7,v3),valid_move(v9,v1),valid_move(v0,v1),valid_move(v11,v3)}).
#neg(n1, {valid_move(v7,v5),valid_move(v8,v3),valid_move(v11,v5),valid_move(v6,v1),valid_move(v4,v5),valid_move(v10,v1),valid_move(v8,v5),valid_move(v2,v3),valid_move(v11,v1),valid_move(v4,v1),valid_move(v8,v1),valid_move(v0,v3),valid_move(v9,v5),valid_move(v0,v5),valid_move(v6,v3),valid_move(v10,v3),valid_move(v6,v5),valid_move(v2,v1),valid_move(v7,v3),valid_move(v9,v1),valid_move(v0,v1),valid_move(v11,v3)}, {valid_move(v2,v5),valid_move(v4,v3),valid_move(v7,v1),valid_move(v10,v5),valid_move(v9,v3)}).


