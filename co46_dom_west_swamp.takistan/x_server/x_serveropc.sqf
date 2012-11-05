#include "x_setup.sqf"
if (!isServer) exitWith{};
private ["_name", "_uid", "_p"];
_name = _this select 0;
_uid = _this select 1;

if (_name == "__SERVER__") exitWith {};

__DEBUG_NET("x_serverOPC player connected",_uid)
__DEBUG_NET("x_serverOPC player connected",_name)

_p = d_player_store getVariable _uid;
d_placed_objs_store setVariable [_name, []];
if (isNil "_p") then {
#ifndef __TT__
	d_player_store setVariable [_uid, [AutoKickTime, time, _uid, 0, "", _name, 0]];
#else
	d_player_store setVariable [_uid, [AutoKickTime, time, _uid, 0, "", sideUnknown, _name, 0]];
#endif
} else {
	_sel =
#ifndef __TT__
	5;
#else
	6;
#endif
	if (_name != (_p select _sel)) then {
		["d_w_n", [_name, _p select _sel]] call XNetCallEvent;
		diag_log (_name + " has changed his name... It was " + (_p select _sel) + " before, ArmA 2 Key: " + _uid);
	};
	_p set [1, time];
	_p set [_sel, _name];
};