// by Xeno
#define THIS_FILE "x_airtaxiserver.sqf"
#include "x_setup.sqf"
#define __del \
{deleteVehicle _x} forEach [_vehicle] + _crew
private ["_player", "_sidep", "_grp", "_vehicle", "_unit", "_crew"];
if (!isServer) exitWith {};

_player = _this;
_sidep = side (group _player);

_dstart_pos = call FUNC(GetRanPointOuterAir);

_grp = [_sidep] call FUNC(creategroup);
_spos = [_dstart_pos select 0, _dstart_pos select 1, 300];
_cdir = [_spos, position _player] call FUNC(DirTo);
_veca = [_spos, _cdir, GVAR(taxi_aircraft), _grp] call FUNC(spawnVehicle);
_vehicle = _veca select 0;
_crew = _veca select 1;
_unit = driver _vehicle;
__addDead(_vehicle)

_vehicle lockdriver true;

[_vehicle, [position _player], 80, true] execVM "scripts\mando_heliroute_arma.sqf";

sleep 10;

if (!alive _player) exitWith {
	[QGVAR(ataxi), [1,_player]] call FUNC(NetCallEvent);
	sleep 120;
	__del;
};

[QGVAR(ataxi), [0,_player]] call FUNC(NetCallEvent);

_toldp = false;
while {_vehicle getVariable "mando_heliroute" == "busy"} do {
	if (_vehicle distance _player < 1000 && alive _player && !_toldp) then {
		[QGVAR(ataxi), [6,_player]] call FUNC(NetCallEvent);
		_toldp = true;
	};
	sleep 2.012;
};

if (_vehicle getVariable "mando_heliroute" == "damaged") exitWith {
	[QGVAR(ataxi), [2,_player]] call FUNC(NetCallEvent);
	sleep 120;
	__del;
};

if (_vehicle getVariable "mando_heliroute" == "waiting") then {
	while {alive _player && !(_player in crew _vehicle)} do {sleep 1.012};
	if (alive _player) then {
		[QGVAR(ataxi), [3,_player]] call FUNC(NetCallEvent);
		
		sleep 30 + random 5;
		[QGVAR(ataxi), [5,_player]] call FUNC(NetCallEvent);
		//#ifndef __CARRIER__
		[_vehicle, [position d_AISPAWN], 80, true] execVM "scripts\mando_heliroute_arma.sqf";
		//#else
		//[_vehicle, [[getPosASL AI_LAND select 0,getPosASL AI_LAND select 1, 0]], 80, true] execVM "scripts\mando_heliroute_arma.sqf";
		//#endif
		sleep 5;
		while {_vehicle getVariable "mando_heliroute" == "busy"} do {sleep 2.012};
		if (_vehicle getVariable "mando_heliroute" == "damaged") exitWith {
			[QGVAR(ataxi), [2,_player]] call FUNC(NetCallEvent);
			sleep 120;
			__del;
		};
		if (_vehicle getVariable "mando_heliroute" == "waiting") then {
			while {_player in crew _vehicle} do {sleep 3.012};
			sleep 20 + random 5;
			[QGVAR(ataxi), [4,_player]] call FUNC(NetCallEvent);
			
			[_vehicle, [_dstart_pos], 80, false] execVM "scripts\mando_heliroute_arma.sqf";
			while {_vehicle getVariable "mando_heliroute" == "busy"} do {sleep 2.012};
			sleep 120;
			__del;
		};
	} else {
		[QGVAR(ataxi), [1,_player]] call FUNC(NetCallEvent);
		
		sleep 120;
		__del;
	};
};