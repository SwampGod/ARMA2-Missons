// by Xeno
#define THIS_FILE "x_dropammobox2.sqf"
#include "x_setup.sqf"
private ["_unit", "_caller", "_chatfunc", "_height", "_speed", "_s", "_hasbox", "_boxpos"];

if (!X_Client) exitWith {};

PARAMS_2(_unit,_caller);

if (_unit == _caller) then {_unit = GVAR(curvec_dialog)};

if (_caller != driver _unit && !isNil {GV(_unit,GVAR(choppertype))}) exitWith {};

_chatfunc = {
	if (vehicle (_this select 1) == (_this select 0)) then {
		[_this select 0, _this select 2] call FUNC(VehicleChat);
	} else {
		[_this select 1, _this select 2] call FUNC(SideChat);
	};
};

if (_unit distance AMMOLOAD < 20) exitWith {[_unit, _caller,"Can't drop box near Ammo Point."] call _chatfunc};
#ifdef __TT__
if (_unit distance AMMOLOAD2 < 20) exitWith {[_unit, _caller, "Can't drop box near Ammo Point."] call _chatfunc};
#endif

_height = _unit call FUNC(GetHeight);
if (_height > 3) exitWith {[_unit,"Too high to drop an ammocrate, please land!"] call FUNC(VehicleChat)};
_speed = speed _unit;
if (_speed > 3) exitWith {[_unit,"Too fast to drop an ammocrate, please stop!"] call FUNC(VehicleChat)};

if (__XJIPGetVar(ammo_boxes) >= GVAR(MaxNumAmmoboxes)) exitWith {
	_s = format ["Maximum number (%1) of ammo crates reached!", GVAR(MaxNumAmmoboxes)];
	[_unit,_caller,_s] call _chatfunc;
	[_unit,_caller,"Pick up a dropped box..."] call _chatfunc;
};

_hasbox = GV(_unit,GVAR(ammobox));
if (isNil "_hasbox") then {_hasbox = false};
if (!_hasbox) exitWith {[_unit, _caller, "No ammobox loaded into this vehicle !!!"] call _chatfunc};

_time_next = GV(_unit,GVAR(ammobox_next));
if (isNil "_time_next") then {_time_next = -1};
if (_time_next > time) exitWith {[_unit, _caller, format ["You have to wait %1 seconds before you can drop a box from this vehicle again !!!",round (_time_next - time)]] call _chatfunc};

[_unit, _caller, "Dropping ammo box... stand by..."] call _chatfunc;

_unit setVariable [QGVAR(ammobox), false, true];
_time_next = time + GVAR(drop_ammobox_time);
_unit setVariable [QGVAR(ammobox_next), _time_next, true];

_boxpos = _unit modelToWorld [4,0,0];
_boxpos set [2, 0];

#ifndef __TT__
[QGVAR(m_box), [_boxpos]] call FUNC(NetCallEvent);
#else
[QGVAR(m_box), [_boxpos, GVAR(player_side)]] call FUNC(NetCallEvent);
#endif

[_unit, _caller, "Ammobox dropped !!!"] call _chatfunc;