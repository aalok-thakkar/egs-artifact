#modeb(3, car(var(C)), (positive)).
#modeb(3, train(var(T)), (positive)).
#modeb(3, closed(var(C)), (positive)).
#modeb(3, double(var(C)), (positive)).
#modeb(3, open_car(var(C)), (positive)).
#modeb(3, has_car(var(T),var(C)), (positive)).
#modeb(3, jagged(var(C)), (positive)).
#modeb(3, load(var(C),var(S)), (positive)).
#modeb(3, long(var(C)), (positive)).
#modeb(3, shape(var(C),var(S)), (positive)).
#modeb(3, short(var(C)), (positive)).
#modeb(3, wheels(var(C)), (positive)).
#modeh(e(var(T))).
#maxv(10).

car(24).
car(17).
car(0).
car(14).
car(22).
car(6).
car(19).
car(21).
car(2).
car(25).
car(23).
car(12).
car(20).
car(8).
car(1).
car(4).
car(5).
car(3).
car(13).
car(27).
car(28).
car(29).
car(9).
car(18).
car(11).
car(15).
car(10).
car(7).
car(16).
car(26).

train(30).
train(34).
train(36).
train(37).
train(35).
train(38).
train(33).
train(31).
train(32).
train(39).

closed(8).
closed(17).
closed(1).
closed(12).
closed(9).
closed(16).
closed(22).
closed(6).
closed(15).

double(14).
double(11).
double(19).

open_car(24).
open_car(0).
open_car(14).
open_car(19).
open_car(2).
open_car(23).
open_car(20).
open_car(4).
open_car(5).
open_car(3).
open_car(13).
open_car(27).
open_car(28).
open_car(29).
open_car(18).
open_car(11).
open_car(10).
open_car(7).
open_car(26).

has_car(36,20).
has_car(33,11).
has_car(37,22).
has_car(30,0).
has_car(32,9).
has_car(33,10).
has_car(35,17).
has_car(38,25).
has_car(30,2).
has_car(32,7).
has_car(39,28).
has_car(37,23).
has_car(39,29).
has_car(31,6).
has_car(38,27).
has_car(34,15).
has_car(30,1).
has_car(30,3).
has_car(33,12).
has_car(34,16).
has_car(35,18).
has_car(36,19).
has_car(36,21).
has_car(31,4).
has_car(31,5).
has_car(34,14).
has_car(38,26).
has_car(33,13).
has_car(38,24).
has_car(32,8).

jagged(25).
jagged(21).

load(9,41).
load(8,41).
load(15,40).
load(25,40).
load(28,40).
load(0,40).
load(26,43).
load(22,40).
load(10,41).
load(2,42).
load(16,43).
load(3,43).
load(13,40).
load(4,41).
load(19,43).
load(17,43).
load(12,40).
load(21,44).
load(23,43).
load(18,41).
load(20,41).
load(7,43).
load(26,40).
load(6,43).
load(29,40).
load(5,40).
load(11,41).
load(24,43).
load(14,41).
load(1,41).

long(25).
long(17).
long(0).
long(29).
long(9).
long(22).
long(21).
long(2).

shape(19,40).
shape(17,40).
shape(15,40).
shape(20,45).
shape(25,40).
shape(21,40).
shape(7,40).
shape(0,40).
shape(6,40).
shape(22,40).
shape(5,45).
shape(13,40).
shape(18,40).
shape(8,42).
shape(27,45).
shape(2,40).
shape(23,45).
shape(10,45).
shape(11,40).
shape(28,45).
shape(14,40).
shape(26,40).
shape(1,40).
shape(29,40).
shape(4,45).
shape(3,40).
shape(16,40).
shape(24,45).
shape(9,40).
shape(12,46).

short(24).
short(14).
short(6).
short(19).
short(23).
short(12).
short(20).
short(8).
short(1).
short(4).
short(5).
short(3).
short(13).
short(27).
short(28).
short(18).
short(11).
short(15).
short(10).
short(7).
short(16).
short(26).

wheels(24).
wheels(17).
wheels(0).
wheels(14).
wheels(22).
wheels(6).
wheels(19).
wheels(21).
wheels(2).
wheels(25).
wheels(23).
wheels(12).
wheels(20).
wheels(8).
wheels(1).
wheels(4).
wheels(5).
wheels(3).
wheels(13).
wheels(27).
wheels(28).
wheels(29).
wheels(9).
wheels(18).
wheels(11).
wheels(15).
wheels(10).
wheels(7).
wheels(16).
wheels(26).


#pos(p1, {e(30),e(34),e(33),e(31),e(32)}, {e(36),e(38),e(35),e(37),e(39)}).
#neg(n1, {e(36),e(38),e(35),e(37),e(39)}, {e(30),e(34),e(33),e(31),e(32)}).


