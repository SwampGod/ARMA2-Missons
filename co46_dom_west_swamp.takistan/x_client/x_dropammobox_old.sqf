// by Xeno
#include "x_setup.sqf"
private ["_unit", "_caller", "_chatfunc", "_vehicle", "_s", "_height", "_speed", "_time", "_boxpos"];

if (!X_Client) exitWith {};

_unit = _this select 0;
_caller = _this select 1;

if (_unit == _caller) then {_unit = d_curvec_dialog};

if (_caller != driver _unit && !isNil {_unit getVariable "d_choppertype"}) exitWith {};

_chatfunc = {
	if (vehicle (_this select 1) == (_this select 0)) then {
		[(_this select 0), _this select 2] call XfVehicleChat;
	} else {
		[_this select 1, _this select 2] call XfSideChat;
	};
};

_vehicle = vehicle _caller;
if (__XJIPGetVar(ammo_boxes) >= d_MaxNumAmmoboxes) exitWith {
	_s = format ["You have created the maximum number (%1) ammo crates!", d_MaxNumAmmoboxes];
	[_unit, _caller, _s] call _chatfunc;
	[_unit, _caller, "Please wait until one or more get automatically deleted..."] call _chatfunc;
};
_height = (position _unit) select 2;
if (_height > 3) exitWith {[_unit, _caller, "Too high to drop an ammocrate, please land!"] call _chatfunc};
_speed = speed _unit;
if (_speed > 3) exitWith {[_unit, _caller, "Too fast to drop an ammocrate, please stop!"] call _chatfunc};
_time = time;
if (_time - last_ammo_drop < d_drop_ammobox_time) exitWith {
	[_unit, _caller, format ["You have to wait %1 seconds before you can drop a new ammocrate",d_drop_ammobox_time]] call _chatfunc;
};
last_ammo_drop = _time;

_boxpos = _unit modelToWorld [4,0,0];
_boxpos set [2, 0];

#ifndef __TT__
["d_m_box", [_vehicle, _boxpos]] call XNetCallEvent;
#else
["d_m_box",[_vehicle, _boxpos, playerside]] call XNetCallEvent;
#endif

[_unit, _caller, "Ammobox created !!!!!!!!"] call _chatfunc;
