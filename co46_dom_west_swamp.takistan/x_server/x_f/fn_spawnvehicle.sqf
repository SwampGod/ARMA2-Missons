#include "x_setup.sqf"
/*
	File: spawnVehicle.sqf
	Author: Joris-Jan van 't Land

	Description:
	Function to spawn a certain vehicle type with all crew (including turrets).
	The vehicle can either become part of an existing group or create a new group.

	Parameter(s):
	_this select 0: desired position (Array).
	_this select 1: desired azimuth (Number).
	_this select 2: type of the vehicle (String).
	_this select 3: side or existing group (Side or Group).

	Returns:
	Array:
	0: new vehicle (Object).
	1: all crew (Array of Objects).
	2: vehicle's group (Group).
*/

private ["_pos", "_azi", "_type", "_param4", "_grp", "_side", "_newGrp"];
_pos = _this select 0;
_azi = _this select 1;
_type = _this select 2;
_param4 = _this select 3;

if ((typeName _param4) == (typeName sideEnemy)) then {
	_side = _param4;
	_grp = [_side] call x_creategroup;
	_newGrp = true;
} else {
	_grp = _param4;
	_side = side _grp;
	_newGrp = false;
};

private ["_sim", "_veh", "_crew"];
_sim = getText(configFile >> "CfgVehicles" >> _type >> "simulation");

if (_sim in ["airplane", "helicopter"]) then {
	if ((count _pos) == 2) then {_pos set [count _pos, 200]};

	_veh = createVehicle [_type, _pos, [], 0, "FLY"];

	_veh setVelocity [50 * (sin _azi), 50 * (cos _azi), 0];
} else {
	_veh = createVehicle [_type, _pos, [], 0, "NONE"];
	_svec = sizeOf _type;
	_isFlat = (position _veh) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _veh];
	if (count _isFlat > 0) then {
		_pos = _isFlat;
	};
};

_veh setDir _azi;
_veh setPos _pos;

#ifndef __ACE__
if ((getNumber(configFile >> "CfgVehicles" >> _type >> "ARTY_IsArtyVehicle")) == 1) then {
	switch (_type) do {
		case "MLRS": {
			_veh removeMagazine "12Rnd_MLRS";
			_veh addMagazine "ARTY_12Rnd_227mmHE_M270";
		};
		case "GRAD_RU": {
			_veh removeMagazine "40Rnd_GRAD";
			_veh addMagazine "ARTY_40Rnd_120mmHE_BM21";
		};
		case "MLRS_DES_EP1": {
			_veh removeMagazine "12Rnd_MLRS";
			_veh addMagazine "ARTY_12Rnd_227mmHE_M270";
		};
		case "GRAD_TK_EP1": {
			_veh removeMagazine "40Rnd_GRAD";
			_veh addMagazine "ARTY_40Rnd_120mmHE_BM21";
		};
	};
	["d_bi_a_v", _veh] call XNetCallEvent;
};
#endif

_grp addVehicle _veh;
_crew = [_veh, _grp] call X_fnc_spawnCrew;

if (_newGrp) then {_grp selectLeader (commander _veh)};

[_veh, _crew, _grp]