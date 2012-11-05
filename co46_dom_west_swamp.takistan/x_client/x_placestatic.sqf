// by Xeno
#include "x_setup.sqf"
private ["_caller","_id"];

_caller = _this select 1;
_id = _this select 2;

e_placing_running = 1;
_caller removeAction _id;
_caller removeAction e_placing_id1;
e_placing_id1 = -1000;
e_placing_id2 = -1000;
