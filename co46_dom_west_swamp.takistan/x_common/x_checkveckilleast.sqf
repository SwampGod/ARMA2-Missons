// by Xeno
#include "x_setup.sqf"
private ["_killer","_killed"];

_killed = _this select 0;
if (!local _killed) exitWith {};
_killer = _this select 1;

if (side _killer == west && isPlayer _killer) then {
	if (isServer) then {
		d_points_west = d_points_west + (d_tt_points select 7);
	} else {
		["d_a_p_w", d_tt_points select 7] call XNetCallEvent;
	};
	["vec_killer", [name _killer, "EAST", "US"]] call XNetCallEvent;
};
