// by Xeno
#include "x_setup.sqf"

#ifdef __ACE__
if (!(player hasWeapon "ACE_ParachutePack")) exitWith {
	[vehicle player, "!!!!!!!!!!!! You need a parachute pack first !!!!!!!!!!!"] call XfVehicleChat;
};
if (player hasWeapon "ACE_ParachutePack") then {player removeWeapon "ACE_ParachutePack"};
#endif

player action ["EJECT", (_this select 0)];

if (vehicle player isKindOf "ParachuteBase") then {
	_vec = vehicle player;
	player action ["EJECT",vehicle player];
	deleteVehicle _vec;
};

#ifndef __ACE__
if (d_halo_jumptype == 0) then {
	[player, player call XfGetHeight] spawn bis_fnc_halo;
} else {
	[player, player call XfGetHeight] execVM "AAHALO\Scripts\HALO_init.sqf";
};
#else
[player] execVM "x\ace\addons\sys_eject\jumpout_cord.sqf";
#endif