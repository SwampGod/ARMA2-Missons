// by Xeno
#include "x_setup.sqf"
private ["_posi_array", "_ran", "_ran_pos", "_flagtype", "_ini_str", "_flag", "_owner"];

if (!isServer) exitWith {};

_posi_array = _this select 0;

_ran = _posi_array call XfRandomFloorArray;
_ran_pos = _posi_array select _ran;

_posi_array = nil;

if (d_with_ranked) then {d_sm_p_pos = nil};

#ifndef __OA__
_flagtype = "FlagCarrierUSA";
_ini_str = "this setflagside west;";
if (d_enemy_side == "EAST") then {
	_flagtype = "FlagCarrierRU";
	_ini_str = "this setflagside east;";
} else {
	if (d_enemy_side == "GUER") then {
		_flagtype = "FlagCarrierGUE";
		_ini_str = "this setflagside resistance;";
	};
};
#else
_flagtype = "FlagCarrierUSArmy_EP1";
_ini_str = "this setflagside west;";
if (d_enemy_side == "EAST") then {
	_flagtype = "FlagCarrierTakistan_EP1";
	_ini_str = "this setflagside east;";
} else {
	if (d_enemy_side == "GUER") then {
		_flagtype = "FlagCarrierTKMilitia_EP1";
		_ini_str = "this setflagside resistance;";
	};
};
#endif

_flag = createVehicle [_flagtype, _ran_pos, [], 0, "NONE"];
_flag setVehicleInit _ini_str;
processInitCommands;

sleep 2.123;
["shilka", 1, "bmp", 1, "tank", 1, _ran_pos,1,110,true] spawn XCreateArmor;
sleep 2.123;
["specops", 2, "basic", 1, _ran_pos,100,true] spawn XCreateInf;

_ran_pos = nil;
_ran = nil;
_flagtype = nil;
_ini_str = nil;

sleep 15.111;

while {true} do {
	__MPCheck;
	_owner = flagOwner _flag;
	#ifndef __TT__
	if ((!isNull _owner) && (_owner distance FLAG_BASE < 20)) exitWith {
		if (__RankedVer) then {["d_sm_p_pos", position FLAG_BASE] call XNetCallEvent};
		_flag setFlagOwner objNull;
		deleteVehicle _flag;
		d_side_mission_winner=2;
		d_side_mission_resolved = true;
	};
	#else
	if ((!isNull _owner) && (_owner distance EFLAG_BASE < 20)) exitWith {
		if (__RankedVer) then {["d_sm_p_pos", position EFLAG_BASE] call XNetCallEvent};
		_flag setFlagOwner objNull;
		deleteVehicle _flag;
		d_side_mission_winner = 1;
		d_side_mission_resolved = true;
	};
	if ((!isNull _owner) && (_owner distance WFLAG_BASE < 20)) exitWith {
		if (__RankedVer) then {["d_sm_p_pos", position WFLAG_BASE] call XNetCallEvent};
		_flag setFlagOwner objNull;
		deleteVehicle _flag;
		d_side_mission_winner = 2;
		d_side_mission_resolved = true;
	};
	#endif
	sleep 5.123;
};