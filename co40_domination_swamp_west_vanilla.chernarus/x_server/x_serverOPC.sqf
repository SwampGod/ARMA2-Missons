// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_serverOPC.sqf"
#include "x_setup.sqf"
if (!isServer) exitWith{};
private ["_name", "_uid", "_p", "_lt"];
PARAMS_2(_name,_uid);

if (_name == "__SERVER__") exitWith {};

__TRACE_2("","_uid","_name")

_p = GV2(GVAR(player_store),_uid);
if (isNil "_p") then {
	GVAR(player_store) setVariable [_uid, [GVAR(AutoKickTime), time, _uid, 0, "", sideUnknown, _name, 0, xr_max_lives, time]];
	__TRACE_2("Player not found","_uid","_name")
} else {
	__TRACE_1("player store before change","_p")
	_pna = _p select 6;
	if (_name != _pna) then {
		[QGVAR(w_n), [_name, _pna]] call FUNC(NetCallEvent);
		diag_log (_name + " has changed his name... It was " + _pna + " before, ArmA 2 Key: " + _uid);
	};
	_lt = _p select 9;
	if (time - _lt > 600) then {
		_p set [8, xr_max_lives];
	};
	_p set [1, time];
	_p set [6, _name];
	__TRACE_1("player store after change","_p")
};