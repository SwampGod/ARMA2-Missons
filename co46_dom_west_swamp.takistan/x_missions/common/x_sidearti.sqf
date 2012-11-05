// by Xeno
#include "x_setup.sqf"
private ["_angle","_angle_plus","_arti","_arti_pos_dir","_arti_type","_center_x","_center_y","_count_arti","_crewman","_grp","_i","_pos_array","_poss","_radius","_this","_truck","_trucks","_unit","_x1","_y1"];
if (!isServer) exitWith {};

_poss = _this select 0;

#ifndef __OA__
_arti_type = switch (d_enemy_side) do {
	case "EAST": {"D30_RU"};
	case "WEST": {"M119"};
	case "GUER": {"D30_INS"};
};
#else
_arti_type = switch (d_enemy_side) do {
	case "EAST": {"D30_TK_EP1"};
	case "WEST": {"M119_US_EP1"};
	case "GUER": {"D30_TK_GUE_EP1"};
};
#endif

#ifndef __TT__
_crewman = getText (configFile >> "CfgVehicles" >> _arti_type >> "crew");
#else
_crewman = if (__OAVer) then {"TK_GUE_Soldier_EP1"} else {"GUE_Soldier_3"};
#endif

#ifndef __OA__
_trucks = switch (d_enemy_side) do {
	case "EAST": {"KamazReammo"};
	case "WEST": {"MtvrReammo"};
	case "GUER": {"V3S_Gue"};
};
#else
_trucks = switch (d_enemy_side) do {
	case "EAST": {"UralReammo_TK_EP1"};
	case "WEST": {"MtvrReammo_DES_EP1"};
	case "GUER": {"V3S_Reammo_TK_GUE_EP1"};
};
#endif

// calc positions
_center_x = _poss select 0;
_center_y = _poss select 1;
_radius = 30;
_angle = 0;
_pos_array = [];
_count_arti = 8;
_angle_plus = 360 / _count_arti;

for "_i" from 0 to _count_arti - 1 do {
	_x1 = _center_x - (_radius * sin _angle);
	_y1 = _center_y - (_radius * cos _angle);
	_pos_array set [count _pos_array, [[_x1,_y1,0], _angle]];
	_angle = _angle + _angle_plus;
};

d_dead_arti = 0;
__GetEGrp(_grp)

#ifdef __TT__
sm_points_west = 0;
sm_points_east = 0;
#endif

for "_i" from 0 to (_count_arti - 1) do {
	_arti_pos_dir = _pos_array select _i;
	_arti = createVehicle [_arti_type, (_arti_pos_dir select 0), [], 0, "NONE"];
	_arti setDir (_arti_pos_dir select 1);
	__addDead(_arti)
	#ifndef __TT__
	_arti addEventHandler ["killed", {d_dead_arti = d_dead_arti + 1}];
	#else
	_arti addEventHandler ["killed", {d_dead_arti = d_dead_arti + 1;_this call XfAddSMPoints}];
	#endif
	_arti lock true;
	_unit = _grp createUnit [_crewman, (_arti_pos_dir select 0), [], 0, "NONE"];_unit setSkill 1;_unit assignAsGunner _arti;_unit moveInGunner _arti;
	_unit setVariable ["BIS_noCoreConversations", true];
	__addDead(_unit)
	sleep 0.5321;
};

_pos_array = nil;

for "_i" from 1 to 3 do {
	_truck = createVehicle [_trucks, _poss, [], 0, "NONE"];
	_truck lock true;
	sleep 0.523;
};

sleep 2.123;
["specops", 3, "basic", 2, _poss, 100,true] spawn XCreateInf;
sleep 4.123;
["shilka", 1, "bmp", 2, "tank", 1, _poss,1,130,true] spawn XCreateArmor;

while {d_dead_arti != _count_arti} do {
	sleep 4.631;
};

d_dead_arti = nil;

#ifndef __TT__
d_side_mission_winner=2;
#endif
#ifdef __TT__
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
d_no_more_observers = true;