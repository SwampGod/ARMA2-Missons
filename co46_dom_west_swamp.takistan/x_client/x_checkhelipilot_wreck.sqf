// by Xeno
#include "x_setup.sqf"
private ["_vehicle","_position","_enterer","_was_engineon"];

_enterer = _this select 2;
__notlocalexit(_enterer);

_vehicle = _this select 0;
_position = _this select 1;

_was_engineon = isEngineOn _vehicle;

_exit_it = false;

#ifdef __TT__
_d_side = _vehicle getVariable "d_side";
if (!isNil "_d_side") then {
	if (playerSide == west && _d_side == east) then {
		_exit_it = true;
		["This is a East chopper.\nYou are not allowed to enter it !!!", "SIDE"] call XHintChatMsg;
	} else {
		if (playerSide == east && _d_side == west) then {
			_exit_it = true;
			["This is a US chopper.\n You are not allowed to enter it !!!", "SIDE"] call XHintChatMsg;
		};
	};
};
#endif

if (!_exit_it && _position == "driver") then {
	if (d_with_ranked) then {
		_index = (toUpper d_wreck_lift_rank) call XGetRankIndex;
		_indexp = (rank player) call XGetRankIndex;
		if (_indexp < _index) exitWith {
			(format ["You current rank (%1) doesn't allow you to fly the wreck lift chopper. You need to be at least %2 for that", rank player,(toUpper d_wreck_lift_rank) call XGetRankString]) call XfHQChat;
			_exit_it = true;
		};
	};
	if (_exit_it) exitWith {};
	_may_fly = true;
	if (count d_only_pilots_can_fly > 0) then {
		_type_enterer = typeOf _enterer;
		if (!(_type_enterer in d_only_pilots_can_fly)) then {
			_may_fly = false;
			hintSilent "You're not allowed to fly!";
			_exit_it = true;
		};
	};
	if (_exit_it) exitWith {};
	if (_may_fly && _enterer == player) then {
		if (d_chophud_on) then {
			__pSetVar ["d_hud_id", _vehicle addAction ["Turn Off Hud" call XGreyText, "x_client\x_sethud.sqf",0,-1,false]];
		} else {
			__pSetVar ["d_hud_id", _vehicle addAction ["Turn On Hud" call XGreyText, "x_client\x_sethud.sqf",1,-1,false]];
		};
		[_vehicle] execVM "x_client\x_helilift_wreck.sqf";
	};
};

if (_exit_it) exitWith {
	_enterer action["Eject",_vehicle];
	if (!_was_engineon && isEngineOn _vehicle) then {_vehicle engineOn false};
};