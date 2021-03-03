#modeb(1, car(var(c)), (positive)).
#modeb(1, train(var(t)), (positive)).
#modeb(1, closed(var(c)), (positive)).
#modeb(1, double(var(c)), (positive)).
#modeb(1, open_car(var(c)), (positive)).
#modeb(1, has_car(var(t),var(c)), (positive)).
#modeb(1, jagged(var(c)), (positive)).
#modeb(1, load(var(c),var(s)), (positive)).
#modeb(1, long(var(c)), (positive)).
#modeb(1, shape(var(c),var(s)), (positive)).
#modeb(1, short(var(c)), (positive)).
#modeb(1, wheels(var(c)), (positive)).
#modeh(e(var(t))).
#maxv(2).

car(v17).
car(v14).
car(v26).
car(v1).
car(v10).
car(v11).
car(v4).
car(v24).
car(v16).
car(v13).
car(v19).
car(v22).
car(v20).
car(v12).
car(v2).
car(v5).
car(v8).
car(v25).
car(v0).
car(v29).
car(v9).
car(v15).
car(v6).
car(v3).
car(v18).
car(v21).
car(v7).
car(v28).
car(v23).
car(v27).

train(v34).
train(v30).
train(v38).
train(v36).
train(v39).
train(v31).
train(v32).
train(v35).
train(v37).
train(v33).

closed(v17).
closed(v22).
closed(v12).
closed(v9).
closed(v1).
closed(v15).
closed(v6).
closed(v8).
closed(v16).

double(v19).
double(v11).
double(v14).

open_car(v14).
open_car(v26).
open_car(v10).
open_car(v11).
open_car(v4).
open_car(v24).
open_car(v13).
open_car(v19).
open_car(v20).
open_car(v2).
open_car(v5).
open_car(v0).
open_car(v29).
open_car(v3).
open_car(v18).
open_car(v7).
open_car(v28).
open_car(v23).
open_car(v27).

has_car(v37,v23).
has_car(v36,v21).
has_car(v32,v7).
has_car(v33,v10).
has_car(v33,v11).
has_car(v30,v1).
has_car(v38,v27).
has_car(v33,v13).
has_car(v33,v12).
has_car(v37,v22).
has_car(v35,v18).
has_car(v38,v26).
has_car(v34,v15).
has_car(v31,v4).
has_car(v38,v24).
has_car(v30,v2).
has_car(v36,v19).
has_car(v36,v20).
has_car(v35,v17).
has_car(v39,v29).
has_car(v31,v5).
has_car(v30,v0).
has_car(v32,v8).
has_car(v38,v25).
has_car(v30,v3).
has_car(v34,v14).
has_car(v32,v9).
has_car(v31,v6).
has_car(v39,v28).
has_car(v34,v16).

jagged(v25).
jagged(v21).

load(v26,v40).
load(v4,v41).
load(v22,v40).
load(v0,v40).
load(v23,v43).
load(v2,v42).
load(v26,v43).
load(v5,v40).
load(v16,v43).
load(v1,v41).
load(v12,v40).
load(v10,v41).
load(v28,v40).
load(v20,v41).
load(v13,v40).
load(v24,v43).
load(v11,v41).
load(v25,v40).
load(v18,v41).
load(v19,v43).
load(v14,v41).
load(v6,v43).
load(v9,v41).
load(v17,v43).
load(v8,v41).
load(v29,v40).
load(v15,v40).
load(v7,v43).
load(v3,v43).
load(v21,v44).

long(v25).
long(v17).
long(v0).
long(v22).
long(v29).
long(v21).
long(v9).
long(v2).

shape(v26,v40).
shape(v16,v40).
shape(v22,v40).
shape(v0,v40).
shape(v11,v40).
shape(v23,v45).
shape(v14,v40).
shape(v9,v40).
shape(v18,v40).
shape(v19,v40).
shape(v6,v40).
shape(v10,v45).
shape(v20,v45).
shape(v17,v40).
shape(v13,v40).
shape(v24,v45).
shape(v5,v45).
shape(v25,v40).
shape(v7,v40).
shape(v12,v46).
shape(v3,v40).
shape(v8,v42).
shape(v28,v45).
shape(v21,v40).
shape(v2,v40).
shape(v29,v40).
shape(v15,v40).
shape(v27,v45).
shape(v4,v45).
shape(v1,v40).

short(v14).
short(v26).
short(v1).
short(v10).
short(v11).
short(v4).
short(v24).
short(v16).
short(v13).
short(v19).
short(v20).
short(v12).
short(v5).
short(v8).
short(v15).
short(v6).
short(v3).
short(v18).
short(v7).
short(v28).
short(v23).
short(v27).

wheels(v17).
wheels(v14).
wheels(v26).
wheels(v1).
wheels(v10).
wheels(v11).
wheels(v4).
wheels(v24).
wheels(v16).
wheels(v13).
wheels(v19).
wheels(v22).
wheels(v20).
wheels(v12).
wheels(v2).
wheels(v5).
wheels(v8).
wheels(v25).
wheels(v0).
wheels(v29).
wheels(v9).
wheels(v15).
wheels(v6).
wheels(v3).
wheels(v18).
wheels(v21).
wheels(v7).
wheels(v28).
wheels(v23).
wheels(v27).


#pos(p1, {e(v34),e(v30),e(v31),e(v32),e(v33)}, {e(v38),e(v36),e(v39),e(v37),e(v35)}).
#neg(n1, {e(v38),e(v36),e(v39),e(v37),e(v35)}, {e(v34),e(v30),e(v31),e(v32),e(v33)}).


