#include "x_setup.sqf"
/*
	File: spawnCrew.sqf
	Author: Joris-Jan van 't Land

	Description:
	Function to fill all crew positions in a vehicle, including turrets.
	In dummy mode no objects are created and the returned array contains only ones.
	In this mode the function can be used to count the actual crew of an existing vehicle or vehicle type.

	Parameter(s):
	_this select 0: the vehicle (Object)
	_this select 1: the crew's group (Group)
	_this select 2: (optional) dummy mode toggle (Boolean)
	_this select 3: (optional) dummy mode type (String)
	_this select 4: (optional) crew type (String)

	Returns:
	Array of Objects or Scalars - newly created crew or crew count
*/

private ["_vehicle", "_grp"];
_vehicle = _this select 0;
_grp = _this select 1;

private "_dummy";
_dummy = if ((count _this) > 2) then {_this select 2} else {false};

private "_dummyType";
_dummyType = if ((count _this) > 3) then {_this select 3} else {""};

private "_crewType";
_crewType = if ((count _this) > 4) then {_this select 4} else {""};

if ((typeName _vehicle) != (typeName objNull)) exitWith {[]};
if ((typeName _grp) != (typeName grpNull)) exitWith {[]};
if ((typeName _dummy) != (typeName false)) exitWith {[]};
if ((typeName _dummyType) != (typeName "")) exitWith {[]};
if ((typeName _crewType) != (typeName "")) exitWith {[]};
_crewType = [_crewType];

private ["_type", "_entry", "_crew"];
if (!_dummy) then {
	_type = typeOf _vehicle;
} else {
	if (_dummyType != "") then {_type = _dummyType};
};
_entry = configFile >> "CfgVehicles" >> _type;
_crew = [];

private "_hasDriver";
_hasDriver = getNumber (_entry >> "hasDriver");

private ["_crewType", "_unit"];
if (!_dummy && ((_crewType select 0) == "")) then {_crewType = [side _grp, _entry, _type] call X_fnc_selectCrew};

if ((_hasDriver == 1) && (isNull (driver _vehicle))) then {
	if (!_dummy) then {
		_unit = _grp createUnit [(_crewType select 0), position _vehicle, [], 0, "NONE"];
		_unit setVariable ["BIS_noCoreConversations", true];
		_crew set [count _crew, _unit];

		__addDead(_unit)
		#ifdef __TT__
		if (_do_points) then {_unit addEventHandler ["killed", {[1,_this select 1] call XAddKills}]};
		#endif
		if (d_with_ai) then {
			if (__RankedVer) then {_unit addEventHandler ["killed", {[1,_this select 1] call XAddKillsAI}]};
		};
		_unit setUnitAbility ((d_skill_array select 0) + (random (d_skill_array select 1)));

		_unit moveInDriver _vehicle;
	} else {
		_crew set [count _crew, 1];
	};
};

_turrets = [_entry >> "turrets"] call X_fnc_returnVehicleTurrets;

_funcSpawnTurrets = {
	private ["_turrets", "_path"];
	_turrets = _this select 0;
	_path = _this select 1;

	private ["_i"];
	_i = 0;
	while {_i < (count _turrets)} do {
		private ["_turretIndex", "_thisTurret"];
		_turretIndex = _turrets select _i;
		_thisTurret = _path + [_turretIndex];

		if (!_dummy) then {
			if (isNull (_vehicle turretUnit _thisTurret)) then {
				_unit = _grp createUnit [(_crewType select 0), position _vehicle, [], 0, "NONE"];
				_unit setVariable ["BIS_noCoreConversations", true];
				_crew set [count _crew, _unit];
				
				__addDead(_unit)
#ifdef __TT__
				if (_do_points) then {_unit addEventHandler ["killed", {[1,_this select 1] call XAddKills}]};
#endif
				if (d_with_ai) then {
					if (__RankedVer) then {_unit addEventHandler ["killed", {[1,_this select 1] call XAddKillsAI}]};
				};
				_unit setUnitAbility ((d_skill_array select 0) + (random (d_skill_array select 1)));
				
				_unit moveInTurret [_vehicle, _thisTurret];
			};
		} else {
			_crew set [count _crew, 1];
		};

		[_turrets select (_i + 1), _thisTurret] call _funcSpawnTurrets;

		_i = _i + 2;
	};
};

[_turrets, []] call _funcSpawnTurrets;

// if (count (_crewType select 1) > 0) then {
	// {
		// _unit = _grp createUnit [_x, position _vehicle, [], 0, "NONE"];
		// _unit setVariable ["BIS_noCoreConversations", true];
		// _crew set [count _crew, _unit];

		// __addDead(_unit)
// #ifdef __TT__
		// if (_do_points) then {_unit addEventHandler ["killed", {[1,_this select 1] call XAddKills}]};
// #endif
		// if (d_with_ai) then {
			// if (__RankedVer) then {_unit addEventHandler ["killed", {[1,_this select 1] call XAddKillsAI}]};
		// };
		// _unit setUnitAbility ((d_skill_array select 0) + (random (d_skill_array select 1)));

		// _unit moveInCargo _vehicle;
	// } forEach (_crewType select 1);
// };

if (!_dummy) then {
	if (!(isNull (driver _vehicle))) then {(driver _vehicle) setRank "LIEUTENANT"};
	if (!(isNull (gunner _vehicle))) then {(gunner _vehicle) setRank "SERGEANT"};
	if (!(isNull (effectiveCommander _vehicle))) then {(effectiveCommander _vehicle) setRank "CORPORAL"};
};

_crew