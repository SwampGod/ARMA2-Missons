// Function file for Armed Assault
// Created by: -eutf-Myke
#include "x_setup.sqf"
private ["_vehicle", "_engineer", "_cargo", "_ok", "_i", "_ele", "_static", "_isVeh"];

_vehicle = _this select 0;
_engineer = _this select 1;
_cargo = "";
_do_exit = false;

d_cargo_selected_index = -1;

_tr_cargo_array = _vehicle getVariable "D_CARGO_AR";
if (isNil "_tr_cargo_array") then {_tr_cargo_array = []};

if (!d_with_ai) then {
	if (!(d_string_player in d_is_engineer)) exitWith {hintSilent "Only engineers can place static weapons"};
};

if (vehicle _engineer == _vehicle) exitWith {hintSilent "You have to get out before you can place the static weapon!"};

if (count _tr_cargo_array > 0) then {
	d_current_truck_cargo_array = _tr_cargo_array;
	_ok = createDialog "XD_UnloadDialog";
} else {
	_do_exit = true;
};

if (_do_exit) exitWith {hintSilent "No static weapon loaded..."};

waitUntil {d_cargo_selected_index != -1 || !dialog || !alive player};

if (!alive player) exitWith {closeDialog 0};

if (d_cargo_selected_index == -1) exitWith {"Unload canceled" call XfGlobalChat};

if ((d_cargo_selected_index + 1) > count _tr_cargo_array) exitWith {
	hintSilent "Someone else unloaded allready an item. Try again.";
};

_cargo = _tr_cargo_array select d_cargo_selected_index;
for "_i" from 0 to (count _tr_cargo_array - 1) do {
	_ele = _tr_cargo_array select _i;
	if (_ele == _cargo) exitWith {_tr_cargo_array set [_i, -1]};
};
_tr_cargo_array = _tr_cargo_array - [-1];
_vehicle setVariable ["D_CARGO_AR", _tr_cargo_array, true];

_pos_to_set = _engineer modeltoworld [0,5,0];
_static = _cargo createVehicleLocal _pos_to_set;
_static lock true;
_dir_to_set = getdir _engineer;

_place_error = false;
"Static placement preview mode. Press Place Static to place the object. You may place the object 20 m arround the Salvage truck" call XfGlobalChat;
e_placing_running = 0; // 0 = running, 1 = placed, 2 = placing canceled
e_placing_id1 = player addAction ["Cancel Placing Static" call XRedText, "x_client\x_cancelplacestatic.sqf"];
e_placing_id2 = player addAction ["Place Static" call XGreyText, "x_client\x_placestatic.sqf",[], 0];
while {e_placing_running == 0} do {
	_pos_to_set = _engineer modeltoworld [0,5,0];
	_dir_to_set = getdir _engineer;

	_static setdir _dir_to_set;
	_static setPos [_pos_to_set select 0, _pos_to_set select 1, 0];
	sleep 0.211;
	if (_vehicle distance _engineer > 20) exitWith {
		"You are too far away from the Salvage truck to place the static vehicle, placing canceled !" call XfGlobalChat;
		_place_error = true;
	};
	if (!alive _engineer || !alive _vehicle) exitWith {
		_place_error = true;
		if (e_placing_id1 != -1000) then {
			player removeAction e_placing_id1;
			e_placing_id1 = -1000;
		};
		if (e_placing_id2 != -1000) then {
			player removeAction e_placing_id2;
			e_placing_id2 = -1000;
		};
	};
};

deleteVehicle _static;

if (_place_error) exitWith {
	_tr_cargo_array set [count _tr_cargo_array, _cargo];
	_vehicle setVariable ["D_CARGO_AR", _tr_cargo_array, true];
};

if (e_placing_running == 2) exitWith {
	"Static placement canceled..." call XfGlobalChat;
	_tr_cargo_array set [count _tr_cargo_array, _cargo];
	_vehicle setVariable ["D_CARGO_AR", _tr_cargo_array, true];
};

_type_name = [_cargo,0] call XfGetDisplayName;

_static = createVehicle [_cargo, _pos_to_set, [], 0, "NONE"];
_static setdir _dir_to_set;
_static setPos [_pos_to_set select 0, _pos_to_set select 1, 0];
player reveal _static;
["d_ad", _static] call XNetCallEvent;

hintSilent format ["%1 placed!", _type_name];
format ["%1 placed!", _type_name] call XfGlobalChat;

#ifndef __ACE__
if ((getNumber(configFile >> "CfgVehicles" >> _cargo >> "ARTY_IsArtyVehicle")) == 1) then {
	["d_bi_a_v", _static] call XNetCallEvent;
	["d_bi_a_v2", _static] call XNetCallEvent;
};
#endif