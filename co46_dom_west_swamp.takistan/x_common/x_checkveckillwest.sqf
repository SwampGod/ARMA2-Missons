// by Xeno
#include "x_setup.sqf"
private ["_killer","_killed"];

_killed = _this select 0;
if (!local _killed) exitWith {};
_killer = _this select 1;

if (isPlayer _killer && side _killer == east) then {
	if (isServer) then {
		d_points_east = d_points_east + (d_tt_points select 7);
	} else {
		["d_a_p_e", d_tt_points select 7] call XNetCallEvent;
	};
	["vec_killer", [name _killer, "US", "EAST"]] call XNetCallEvent;
};