// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_serverOPD.sqf"
#include "x_setup.sqf"
if (!isServer) exitWith{};
private ["_name", "_uid", "_pa", "_oldwtime", "_connecttime", "_newwtime"];
PARAMS_2(_name,_uid);

if (_name == "__SERVER__") exitWith {};

__TRACE_2("","_name","_uid")

_pa = GV2(GVAR(player_store),_uid);
if (!isNil "_pa") then {
	__TRACE_1("player store before change","_pa")
	_oldwtime = _pa select 0;
	_connecttime = _pa select 1;
	_newwtime = time - _connecttime;
	if (_newwtime >= _oldwtime) then {
		_newwtime = 0;
	} else {
		_newwtime = _oldwtime - _newwtime;
	};
	_pa set [0, _newwtime];
	_pa set [9, time];
	(_pa select 4) call FUNC(markercheck);
	__TRACE_1("player store after change","_pa")
};