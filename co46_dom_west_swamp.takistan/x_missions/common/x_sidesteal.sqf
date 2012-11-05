// by Xeno
#include "x_setup.sqf"
private ["_reached_base","_vehicle"];
if (!isServer) exitWith {};

_vehicle = _this select 0;

sleep 10.213;

_reached_base = false;
#ifdef __TT__
_winner = 0;
#endif

while {alive _vehicle && !_reached_base} do {
	__MPCheck;
#ifndef __TT__
	if (_vehicle distance FLAG_BASE < 100) then {_reached_base = true};
#else
	if (_vehicle distance WFLAG_BASE < 100) then {
		_reached_base = true;
		_winner = 2;
	} else {
		if (_vehicle distance EFLAG_BASE < 100) then {
			_reached_base = true;
			_winner = 1;
		};
	};
#endif
	sleep 5.2134;
};

if (alive _vehicle && _reached_base) then {
#ifndef __TT__
	d_side_mission_winner = 2;
#else
	d_side_mission_winner = _winner;
#endif
} else {
	d_side_mission_winner = -600;
};

d_side_mission_resolved = true;