// by Xeno
#include "x_setup.sqf"
private ["_killed","_killer","_killedfriendly"];

_killed = _this select 0;
_killer = _this select 1;

if (d_WithMHQTeleport == 0) then {if (!isNil "x_dlgopen") then {[] spawn x_dlgopen}};
[] spawn x_playerspawn;

_killedfriendly = false;

if (!isNull _killer && side _killer == west && isPlayer _killer) then {
	["d_a_p_w", d_tt_points select 8] call XNetCallEvent;
	["d_u_k", [name _killer, d_name_pl, "US"]] call XNetCallEvent;
} else {
	if (!isNull _killer && side _killer == playerSide && isPlayer _killer) then {
		["unit_tk", [name _killer, d_name_pl, _killer]] call XNetCallEvent;
		_killedfriendly = true;
	};
};

if (d_with_ranked) then {
	if (!_killedfriendly) then {if (!isNull _killer && side _killer == d_side_player) then {_killedfriendly = true}}; // AI check, who knows
	if (!_killedfriendly) then {
		if (d_sub_kill_points != 0) then {
			["d_pas", [player, d_sub_kill_points]] call XNetCallEvent;
		};
	};
};

sleep d_respawn_delay + 10 + (random 15);
deleteVehicle _killed;