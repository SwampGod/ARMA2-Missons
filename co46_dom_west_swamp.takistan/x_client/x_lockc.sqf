// by Xeno
#include "x_setup.sqf"
private ["_vec", "_arg","_id"];

_vec = _this select 0;
_id = _this select 2;
_arg = _this select 3;

if (locked _vec && _arg == 0) exitWith {"Vehicle allready locked..." call XfGlobalChat};

if (!(locked _vec) && _arg == 1) exitWith {"Vehicle is allready unlocked" call XfGlobalChat};

_dexit = false;
_depl = _vec getVariable "D_MHQ_Deployed";
if (!isNil "_depl") then {
	if (_depl && _arg == 1) then {
		"Even as an admin you can't unlock a deployed MHQ :-)" call XfGlobalChat;
		_dexit = true;
	};
};
if (_dexit) exitWith {};

if (_arg == 0 && count (crew _vec) > 0) then {{_x action ["Eject", vehicle _x]} forEach ((crew _vec) - [player])};

switch (_arg) do {
	case 0: {["l_v", [_vec, true]] call XNetCallEvent; "Vehicle locked" call XfGlobalChat};
	case 1: {["l_v", [_vec, false]] call XNetCallEvent; "Vehicle unlocked" call XfGlobalChat};
};

d_adm_currentvec = objNull;
_vec removeAction _id;
d_admin_idd =  -9999;
