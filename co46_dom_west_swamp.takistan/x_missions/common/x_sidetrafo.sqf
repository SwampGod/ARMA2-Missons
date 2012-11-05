// by Xeno
#include "x_setup.sqf"
if (!isServer) exitWith {};

_poss = _this select 0;

_objs = nearestObjects [_poss, ["Land_trafostanica_velka"], 40];

#ifdef __TT__
sm_points_west = 0;
sm_points_east = 0;
{_x addEventHandler ["killed", {_this call XfAddSMPoints}]} forEach _objs;
#endif

sleep 2.123;
["specops", 2, "basic", 1, _poss,80,true] spawn XCreateInf;
sleep 2.221;
["shilka", 1, "bmp", 1, "tank", 1, _poss,1,100,true] spawn XCreateArmor;

while {(_objs call XfGetAliveUnits) > 0} do {sleep 5.326};

_objs = nil;

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