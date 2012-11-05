#include "x_setup.sqf"
if (!isServer) exitWith{};
private ["_name", "_uid", "_pa", "_oldwtime", "_connecttime", "_newwtime"];
_name = _this select 0;
_uid = _this select 1;

if (_name == "__SERVER__") exitWith {};

__DEBUG_NET("x_serverOPD player disconnected",_name)

_pa = d_player_store getVariable _uid;
if (!isNil "_pa") then {
	_oldwtime = _pa select 0;
	_connecttime = _pa select 1;
	_newwtime = time - _connecttime;
	if (_newwtime >= _oldwtime) then {
		_newwtime = 0;
	} else {
		_newwtime = _oldwtime - _newwtime;
	};
	_pa set [0, _newwtime];
	(_pa select 4) spawn x_markercheck;
	__DEBUG_NET("x_serverOPD player disconnected _pa",_pa)
};