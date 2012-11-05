// by Xeno
#define THIS_FILE "x_lockc.sqf"
#include "x_setup.sqf"
private ["_vec", "_arg","_id"];

PARAMS_1(_vec);
_id = _this select 2;
_arg = _this select 3;

if (vehicle player != player) exitWith {
	"You can only lock/unlock a vehicle when you are outside the vehicle!" call FUNC(GlobalChat)
};

if (locked _vec && _arg == 0) exitWith {"Vehicle allready locked..." call FUNC(GlobalChat)};

if (!(locked _vec) && _arg == 1) exitWith {"Vehicle is allready unlocked" call FUNC(GlobalChat)};

_dexit = false;
_depl = GV(_vec,GVAR(MHQ_Deployed));
if (!isNil "_depl") then {
	if (_depl && _arg == 1) then {
		"Even as an admin you can't unlock a deployed MHQ :-)" call FUNC(GlobalChat);
		_dexit = true;
	};
};
if (_dexit) exitWith {};

if (_arg == 0 && count (crew _vec) > 0) then {{_x action ["Eject", vehicle _x]} forEach ((crew _vec) - [player])};

switch (_arg) do {
	case 0: {[QGVAR(l_v), [_vec, true]] call FUNC(NetCallEvent); "Vehicle locked" call FUNC(GlobalChat)};
	case 1: {[QGVAR(l_v), [_vec, false]] call FUNC(NetCallEvent); "Vehicle unlocked" call FUNC(GlobalChat)};
};

GVAR(adm_currentvec) = objNull;
_vec removeAction _id;
GVAR(admin_idd) =  -9999;
