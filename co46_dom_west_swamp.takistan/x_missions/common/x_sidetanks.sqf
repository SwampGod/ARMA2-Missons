// by Xeno
#include "x_setup.sqf"
private ["_posi_array","_tank1","_tank2","_tank3","_tank4","_tank5","_tank6","_dirs","_tank_type"];
if (!isServer) exitWith {};

_posi_array = _this select 0;
_dirs = _this select 1;

#ifndef __OA__
_tank_type = switch (d_enemy_side) do {
	case "EAST": {"T90"};
	case "WEST": {"M1A2_TUSK_MG"};
	case "GUER": {"T72_Gue"};
};
#else
_tank_type = switch (d_enemy_side) do {
	case "EAST": {"T72_TK_EP1"};
	case "WEST": {"M1A2_US_TUSK_MG_EP1"};
	case "GUER": {"T55_TK_GUE_EP1"};
};
#endif

dead_tanks = 0;

#ifdef __TT__
sm_points_west = 0;
sm_points_east = 0;
#endif

_tank1 = createVehicle [_tank_type, (_posi_array select 1), [], 0, "NONE"];
_tank1 setDir (_dirs select 0);
__addDead(_tank1)
#ifndef __ACE__
if(!(__TTVer)) then {_tank1 addEventHandler ["killed", {dead_tanks = dead_tanks + 1}]};
#endif
#ifdef __TT__
_tank1 addEventHandler ["killed", {dead_tanks = dead_tanks + 1;_this call XfAddSMPoints}];
#endif
_tank1 lock true;
sleep 0.512;
_tank2 = createVehicle [_tank_type, (_posi_array select 2), [], 0, "NONE"];
_tank2 setDir (_dirs select 1);
__addDead(_tank2)
#ifndef __ACE__
if(!(__TTVer)) then {_tank2 addEventHandler ["killed", {dead_tanks = dead_tanks + 1}]};
#endif
#ifdef __TT__
_tank2 addEventHandler ["killed", {dead_tanks = dead_tanks + 1;_this call XfAddSMPoints}];
#endif
_tank2 lock true;
sleep 0.512;
_tank3 = createVehicle [_tank_type, (_posi_array select 3), [], 0, "NONE"];
_tank3 setDir (_dirs select 2);
__addDead(_tank3)
#ifndef __ACE__
if(!(__TTVer)) then {_tank3 addEventHandler ["killed", {dead_tanks = dead_tanks + 1}]};
#endif
#ifdef __TT__
_tank3 addEventHandler ["killed", {dead_tanks = dead_tanks + 1;_this call XfAddSMPoints}];
#endif
_tank3 lock true;
sleep 0.512;
_tank4 = createVehicle [_tank_type, (_posi_array select 4), [], 0, "NONE"];
_tank4 setDir (_dirs select 3);
__addDead(_tank4)
#ifndef __ACE__
if(!(__TTVer)) then {_tank4 addEventHandler ["killed", {dead_tanks = dead_tanks + 1}]};
#endif
#ifdef __TT__
_tank4 addEventHandler ["killed", {dead_tanks = dead_tanks + 1;_this call XfAddSMPoints}];
#endif
_tank4 lock true;
sleep 0.512;
_tank5 = createVehicle [_tank_type, (_posi_array select 5), [], 0, "NONE"];
_tank5 setDir (_dirs select 4);
__addDead(_tank5)
#ifndef __ACE__
if(!(__TTVer)) then {_tank5 addEventHandler ["killed", {dead_tanks = dead_tanks + 1}]};
#endif
#ifdef __TT__
_tank5 addEventHandler ["killed", {dead_tanks = dead_tanks + 1;_this call XfAddSMPoints}];
#endif
_tank5 lock true;
sleep 0.512;
_tank6 = createVehicle [_tank_type, (_posi_array select 6), [], 0, "NONE"];
_tank6 setDir (_dirs select 5);
__addDead(_tank6)
#ifndef __ACE__
if(!(__TTVer)) then {_tank6 addEventHandler ["killed", {dead_tanks = dead_tanks + 1}]};
#endif
#ifdef __TT__
_tank6 addEventHandler ["killed", {dead_tanks = dead_tanks + 1;_this call XfAddSMPoints}];
#endif
_tank6 lock true;
sleep 2.333;
//["specops", 2, "basic", 2, _posi_array select 0,100,true] spawn XCreateInf;
sleep 2.333;
//["shilka", 1, "bmp", 1, "tank", 1, _posi_array select 0,2,150,true] spawn XCreateArmor;

_tank_type = nil;
_dirs = nil;
_posi_array = nil;

{_x lock true} forEach [_tank1, _tank2, _tank3, _tank4, _tank5, _tank6];

sleep 15.321;

#ifdef __ACE__
_t_list = [_tank1, _tank2, _tank3, _tank4, _tank5, _tank6];
#endif

while {dead_tanks < 6} do {
	#ifdef __ACE__
	_rm_ar = [];
	_hh = 0;
	{
		if (isNull _x) then {
			_hh = _hh + 1
		} else {
			if !(_x call ace_v_alive) then {_hh = _hh + 1};
		};
	} forEach _t_list;
	dead_tanks = _hh;
	#endif
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