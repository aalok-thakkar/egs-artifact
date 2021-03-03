#modeb(3, agent_at(var(C),var(T)), (positive)).
#modeb(3, adjacent(var(C),var(C)), (positive)).
#modeb(3, unlocked(var(C)), (positive)).
#modeb(3, not_wall(var(C),var(C)), (positive)).
#modeh(valid_move(var(C),var(T))).
#maxv(10).

agent_at(2,3).
agent_at(4,5).
agent_at(0,1).

adjacent(11,4).
adjacent(7,0).
adjacent(9,10).
adjacent(6,0).
adjacent(0,7).
adjacent(2,7).
adjacent(4,11).
adjacent(4,2).
adjacent(8,6).
adjacent(10,4).
adjacent(0,6).
adjacent(2,6).
adjacent(7,2).
adjacent(6,2).
adjacent(8,9).
adjacent(2,9).
adjacent(9,11).
adjacent(2,4).
adjacent(4,10).
adjacent(9,2).
adjacent(7,10).
adjacent(10,7).
adjacent(11,9).
adjacent(6,8).

unlocked(9).
unlocked(2).
unlocked(0).
unlocked(4).
unlocked(7).
unlocked(10).

not_wall(7,7).
not_wall(10,6).
not_wall(10,0).
not_wall(8,10).
not_wall(6,7).
not_wall(0,10).
not_wall(4,6).
not_wall(8,8).
not_wall(2,10).
not_wall(4,0).
not_wall(0,8).
not_wall(7,6).
not_wall(2,8).
not_wall(7,0).
not_wall(9,10).
not_wall(10,11).
not_wall(6,6).
not_wall(8,7).
not_wall(6,0).
not_wall(0,7).
not_wall(9,8).
not_wall(10,9).
not_wall(10,2).
not_wall(9,7).
not_wall(4,2).
not_wall(11,10).
not_wall(10,4).
not_wall(0,6).
not_wall(8,0).
not_wall(7,11).
not_wall(0,0).
not_wall(2,6).
not_wall(4,9).
not_wall(11,8).
not_wall(2,0).
not_wall(6,11).
not_wall(4,4).
not_wall(7,9).
not_wall(6,2).
not_wall(9,6).
not_wall(9,0).
not_wall(6,9).
not_wall(11,7).
not_wall(0,11).
not_wall(6,4).
not_wall(7,4).
not_wall(8,11).
not_wall(0,9).
not_wall(0,2).
not_wall(2,11).
not_wall(11,6).
not_wall(8,9).
not_wall(8,2).
not_wall(2,2).
not_wall(10,10).
not_wall(11,0).
not_wall(10,8).
not_wall(2,9).
not_wall(9,11).
not_wall(0,4).
not_wall(8,4).
not_wall(2,4).
not_wall(9,9).
not_wall(9,2).
not_wall(4,10).
not_wall(4,8).
not_wall(11,11).
not_wall(9,4).
not_wall(7,8).
not_wall(6,10).
not_wall(11,2).
not_wall(4,7).
not_wall(11,9).


#pos(p1, {valid_move(2,5),valid_move(7,1),valid_move(9,3),valid_move(10,5),valid_move(4,3)}, {valid_move(4,1),valid_move(11,3),valid_move(6,1),valid_move(4,5),valid_move(8,1),valid_move(0,1),valid_move(2,1),valid_move(7,5),valid_move(10,3),valid_move(6,5),valid_move(9,1),valid_move(0,5),valid_move(8,5),valid_move(7,3),valid_move(11,1),valid_move(6,3),valid_move(9,5),valid_move(0,3),valid_move(8,3),valid_move(2,3),valid_move(11,5),valid_move(10,1)}).
#neg(n1, {valid_move(4,1),valid_move(11,3),valid_move(6,1),valid_move(4,5),valid_move(8,1),valid_move(0,1),valid_move(2,1),valid_move(7,5),valid_move(10,3),valid_move(6,5),valid_move(9,1),valid_move(0,5),valid_move(8,5),valid_move(7,3),valid_move(11,1),valid_move(6,3),valid_move(9,5),valid_move(0,3),valid_move(8,3),valid_move(2,3),valid_move(11,5),valid_move(10,1)}, {valid_move(2,5),valid_move(7,1),valid_move(9,3),valid_move(10,5),valid_move(4,3)}).


