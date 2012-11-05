// by Xeno
#include "x_setup.sqf"
private ["_killed","_killer","_killedfriendly"];
_killed = _this select 0;
_killer = _this select 1;

if (d_WithMHQTeleport == 0) then {if (!isNil "x_dlgopen") then {[] spawn x_dlgopen}};
[] spawn x_playerspawn;

["d_ad", _killed] call XNetCallEvent;

_killedfriendly = false;

if (d_with_ai) then {
	if (!isNull _killer && side _killer == d_side_player && !isPlayer _killer) then {
		_leader_killer = leader _killer;
		if (isPlayer _leader_killer) then {
			["unit_tk", [name _leader_killer, d_name_pl, _killer]] call XNetCallEvent;
		};
		_killedfriendly = true;
	};
};

if (!isNull _killer && isPlayer _killer && player != _killed) then {
	["unit_tk", [name _killer, d_name_pl, _killer]] call XNetCallEvent;
	_killedfriendly = true;
};

if (d_with_ranked) then {
	if (d_sub_kill_points != 0) then {
		if (!_killedfriendly) then {["d_pas", [player, d_sub_kill_points]] call XNetCallEvent};
	};
};

#ifndef __REVIVE__
sleep d_respawn_delay + 10 + (random 15);
deleteVehicle _killed;
#endif