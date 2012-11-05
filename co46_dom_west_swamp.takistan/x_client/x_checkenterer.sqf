// by Xeno
#include "x_setup.sqf"
private ["_vehicle","_position","_enterer","_was_engineon","_d_side"];

#ifdef __TT__
_enterer = _this select 2;
__notlocalexit(_enterer);

_vehicle = _this select 0;
_position = _this select 1;

_was_engineon = isEngineOn _vehicle;

_exit_it = false;
_exit_it = false;
_d_side = _vehicle getVariable "d_side";
if (!isNil "_d_side") then {
	if (playerSide == west && _d_side == east) then {
		_exit_it = true;
		["This is a East vehicle.\nYou are not allowed to enter it !!!", "SIDE"] call XHintChatMsg;
	} else {
		if (playerSide == east && _d_side == west) then {
			_exit_it = true;
			["This is a US vehicle. You are not allowed to enter it !!!", "SIDE"] call XHintChatMsg;
		};
	};
};
if (_exit_it) exitWith {
	_enterer action["Eject",_vehicle];
	if (!_was_engineon && isEngineOn _vehicle) then {_vehicle engineOn false};
};
#endif