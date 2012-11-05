// Function file for Armed Assault
// Created by: -eutf-Myke
#include "x_setup.sqf"
private ["_vehicle", "_engineer", "_cargo", "_i"];

_vehicle = _this select 0;
_engineer = _this select 1;
_cargo = objnull;
_loading_allowed = false;

_tr_cargo_array = _vehicle getVariable "D_CARGO_AR";
if (isNil "_tr_cargo_array") then {_tr_cargo_array = []};

if (!d_with_ai) then {if (!(d_string_player in d_is_engineer)) exitWith {hintSilent "Only engineers can load static weapons"}};

_tr_full = false;
if (count _tr_cargo_array >= d_max_truck_cargo) then {
	(format ["Allready %1 items loaded. Not possible to load more.", d_max_truck_cargo]) call XfGlobalChat;
	_tr_full = true;
};

if (_tr_full) exitWith {};

_cargo = nearestobject [_vehicle, "StaticWeapon"];
if (isNull _cargo) exitwith {hintSilent "No static weapon in range."};
if (!alive _cargo) exitWith {hintSilent "Static weapon destroyed."};
_cargo_type = typeof _cargo;
_type_name = [_cargo_type,0] call XfGetDisplayName;
if (_cargo distance _vehicle > 10) exitwith {hintSilent format ["You're too far from %1!", _type_name]};
if (!alive _engineer) exitWith {};

_loading_allowed = true;

_c_l = __pGetVar(currently_loading);
if (isNil "_c_l") then {_c_l = false};
if (_loading_allowed && _c_l) exitWith {"You are allready loading an item. Please wait until it is finished" call XfGlobalChat};

if (_loading_allowed) then {
	__pSetVar ["currently_loading", true];
	_tr_cargo_array = _vehicle getVariable "D_CARGO_AR";
	if (isNil "_tr_cargo_array") then {_tr_cargo_array = []};
	if (count _tr_cargo_array >= d_max_truck_cargo) then {
		(format ["Allready %1 items loaded. Not possible to load more.", d_max_truck_cargo]) call XfGlobalChat;
	} else {
		_tr_cargo_array set [count _tr_cargo_array, _cargo_type];
		_vehicle setVariable ["D_CARGO_AR", _tr_cargo_array, true];
	};
	_alive = true;
	for "_i" from 10 to 1 step -1 do {
		hintSilent format ["%1 will be loaded in %2 sec.", _type_name, _i];
		if (!alive _engineer || !alive _vehicle) exitWith {_alive = false};
		sleep 1;
	};
	if (_alive) then {
		deletevehicle _cargo;
		hintSilent format ["%1 loaded and attached!", _type_name];
	};
	__pSetVar ["currently_loading", false];
} else {
	hintSilent format ["You can't load a %1 into a %2!", _type_name, typeof _vehicle];
};
