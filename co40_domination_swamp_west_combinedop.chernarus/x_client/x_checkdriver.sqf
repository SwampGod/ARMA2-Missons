// by Xeno
#define THIS_FILE "x_checkdriver.sqf"
#include "x_setup.sqf"
private ["_vehicle","_position","_enterer","_was_engineon","_d_side"];

#ifdef __TT__
_enterer = _this select 2;
__notlocalexit(_enterer);

PARAMS_2(_vehicle,_position);

_was_engineon = isEngineOn _vehicle;
_exit_it = false;
_d_side = GV(_vehicle,GVAR(side));
if (!isNil "_d_side") then {
	if (GVAR(player_side) == west && _d_side == east) then {
		_exit_it = true;
		["This is a East mobile respawn vehicle.\nYou are not allowed to enter it !!!", "SIDE"] call FUNC(HintChatMsg);
	} else {
		if (GVAR(player_side) == east && _d_side == west) then {
			_exit_it = true;
			["This is a US mobile respawn vehicle.\nYou are not allowed to enter it !!!", "SIDE"] call FUNC(HintChatMsg);
		};
	};
};
if (_exit_it) exitWith {
	_enterer action ["Eject",_vehicle];
	if (!_was_engineon && isEngineOn _vehicle) then {_vehicle engineOn false};
};
#endif