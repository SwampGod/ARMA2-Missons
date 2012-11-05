// by Xeno
#include "x_setup.sqf"
private ["_b1", "_b2", "_b3", "_b1_down", "_b2_down", "_b3_down"];
if (!isServer) exitWith {};

_b1 = _this select 0;
_b2 = _this select 1;
_b3 = _this select 2;

_b1_down = false;
_b2_down = false;
_b3_down = false;

#ifdef __TT__
sm_points_west = 0;
sm_points_east = 0;
_b1 addEventHandler ["killed", {_this call XfAddSMPoints}];
_b2 addEventHandler ["killed", {_this call XfAddSMPoints}];
_b3 addEventHandler ["killed", {_this call XfAddSMPoints}];
#endif

while {(!_b1_down) && (!_b2_down) && (!_b3_down)} do {
	__MPCheck;
	if (!(alive  _b1) && !_b1_down) then {_b1_down = true};
	if (!(alive  _b2) && !_b2_down) then {_b2_down = true};
	if (!(alive  _b3) && !_b3_down) then {_b3_down = true};
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
