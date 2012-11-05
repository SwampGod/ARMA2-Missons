// by Xeno
#include "x_setup.sqf"
private ["_unit", "_caller", "_chatfunc", "_height", "_speed", "_s", "_hasbox", "_boxpos"];

if (!X_Client) exitWith {};

_unit = _this select 0;
_caller = _this select 1;

if (_unit == _caller) then {_unit = d_curvec_dialog};

if (_caller != driver _unit && !isNil {_unit getVariable "d_choppertype"}) exitWith {};

_chatfunc = {
	if (vehicle (_this select 1) == (_this select 0)) then {
		[_this select 0, _this select 2] call XfVehicleChat;
	} else {
		[_this select 1, _this select 2] call XfSideChat;
	};
};

if (_unit distance AMMOLOAD < 20) exitWith {[_unit, _caller,"Can't drop box near Ammo Point."] call _chatfunc};
#ifdef __TT__
if (_unit distance AMMOLOAD2 < 20) exitWith {[_unit, _caller, "Can't drop box near Ammo Point."] call _chatfunc};
#endif

_height = _unit call XfGetHeight;
if (_height > 3) exitWith {[_unit,"Too high to drop an ammocrate, please land!"] call XfVehicleChat};
_speed = speed _unit;
if (_speed > 3) exitWith {[_unit,"Too fast to drop an ammocrate, please stop!"] call XfVehicleChat};

if (__XJIPGetVar(ammo_boxes) >= d_MaxNumAmmoboxes) exitWith {
	_s = format ["Maximum number (%1) of ammo crates reached!", d_MaxNumAmmoboxes];
	[_unit,_caller,_s] call _chatfunc;
	[_unit,_caller,"Pick up a dropped box..."] call _chatfunc;
};

_hasbox = _unit getVariable "d_ammobox";
if (isNil "_hasbox") then {_hasbox = false};
if (!_hasbox) exitWith {[_unit, _caller, "No ammobox loaded into this vehicle !!!"] call _chatfunc};

_time_next = _unit getVariable "d_ammobox_next";
if (isNil "_time_next") then {_time_next = -1};
if (_time_next > time) exitWith {[_unit, _caller, format ["You have to wait %1 seconds before you can drop a box from this vehicle again !!!",round (_time_next - time)]] call _chatfunc};

[_unit, _caller, "Dropping ammo box... stand by..."] call _chatfunc;

_unit setVariable ["d_ammobox", false, true];
_time_next = time + d_drop_ammobox_time;
_unit setVariable ["d_ammobox_next", _time_next, true];

_boxpos = _unit modelToWorld [4,0,0];
_boxpos set [2, 0];

#ifndef __TT__
["d_m_box", [_boxpos]] call XNetCallEvent;
#else
["d_m_box", [_boxpos, playerside]] call XNetCallEvent;
#endif

[_unit, _caller, "Ammobox dropped !!!"] call _chatfunc;