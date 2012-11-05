// by Xeno
#include "x_setup.sqf"
private ["_pos", "_trains"];
if (!isServer) exitWith {};

_pos = _this select 0;
_trains = _this select 1;
dead_trains = 0;

#ifdef __TT__
sm_points_west = 0;
sm_points_east = 0;
#endif

{
#ifdef __TT__
	_x addEventHandler ["killed", {dead_trains = dead_trains + 1;_this call XfAddSMPoints}];
#else
	_x addEventHandler ["killed", {dead_trains = dead_trains + 1}];
#endif
	__AddToExtraVec(_x)
} forEach _trains;

sleep 2.333;
["specops", 2, "basic", 2, _pos,50,true] spawn XCreateInf;
sleep 2.333;
["shilka", 1, "bmp", 1, "tank", 1, _pos,2,70,true] spawn XCreateArmor;

sleep 15.321;

while {dead_trains < 4} do {
	sleep 5.321;
};

#ifndef __TT__
d_side_mission_winner=2;
#else
if (sm_points_west > sm_points_east) then {
	d_side_mission_winner = 2;
} else {
	if (sm_points_east > sm_points_west) then {
		d_side_mission_winner = 1;
	} else {
		if (sm_points_east == sm_points_west) then {
			d_side_mission_winner = 123;
		};
	};
};
#endif
d_side_mission_resolved = true;