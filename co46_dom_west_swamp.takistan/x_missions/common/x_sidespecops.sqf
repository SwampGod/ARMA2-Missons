// by Xeno
#include "x_setup.sqf"
private ["_poss", "_fire", "_radius", "_angle", "_i", "_x1", "_y1", "_tent", "_grps", "_units", "_endnum"];
if (!isServer) exitWith {};

_poss = _this select 0;

_fire = createVehicle ["Land_Fire", _poss, [], 0, "NONE"];
_fire setPos _poss;
__AddToExtraVec(_fire)
sleep 0.01;

_center_x = _poss select 0;
_center_y = _poss select 1;
_radius = 5;
_angle = 0;
_pos_array = [];
_count_obj = 4;
_angle_plus = 360 / _count_obj;

for "_i" from 0 to _count_obj - 1 do {
	_x1 = _center_x - (_radius * sin _angle);
	_y1 = _center_y - (_radius * cos _angle);
	_pos_array set [count _pos_array, [[_x1,_y1,0], _angle]];
	_angle = _angle + _angle_plus;
};


#ifdef __TT__
sm_points_west = 0;
sm_points_east = 0;
#endif

for "_i" from 0 to (_count_obj - 1) do {
	_obj_pos_dir = _pos_array select _i;
#ifndef __OA__
	_tent = createVehicle ["ACamp", (_obj_pos_dir select 0), [], 0, "NONE"];
#else
	_tent = createVehicle ["ACamp_EP1", (_obj_pos_dir select 0), [], 0, "NONE"];
#endif
	_tent setDir (_obj_pos_dir select 1);
	_tent setPos (_obj_pos_dir select 0);
	__AddToExtraVec(_tent)
	sleep 0.2321;
};

_pos_array = nil;

_grps = ["specops", 3, "basic", 0, _poss , 50, true] call XCreateInf;
_units = [];
{_units = [_units, units _x] call X_fnc_arrayPushStack} forEach _grps;

d_num_species = 0;
#ifdef __TT__
{_x addEventHandler ["killed", {_this call XfAddSMPoints}]} forEach _units;
#endif
{_x allowFleeing 0;_x addEventHandler ["killed", {d_num_species = d_num_species + 1}]} forEach _units;
sleep 2.123;
_endnum = (count _units) - 2;

while {d_num_species < _endnum} do {
	{
		if (alive _x) then {
			_dist = _x distance _poss;
			if (_dist > 200 && _dist < 400) then {
				(leader _x) doMove _poss;
			} else {
				if (_dist >= 400) then {_x setDamage 1};
			};
			sleep 0.01;
		};
	} forEach _units;
	sleep 4.631;
};

_units = nil;

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