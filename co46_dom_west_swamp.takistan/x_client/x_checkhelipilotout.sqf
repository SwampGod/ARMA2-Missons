// by Xeno
#include "x_setup.sqf"
private ["_vehicle","_position","_enterer"];

_enterer = _this select 2;
__notlocalexit(_enterer);

_vehicle = _this select 0;
_position = _this select 1;

if (_position == "driver") then {
	if (_enterer == player) then {
		if (__pGetVar(d_hud_id) != -1000) then {
			_vehicle removeAction __pGetVar(d_hud_id);
			__pSetVar ["d_hud_id", -1000];
		};
	};
};