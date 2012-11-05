#include "x_setup.sqf"
private ["_startLocation", "_uh60p", "_vec"];

_startLocation = _this select 0;

if (d_HALOWaitTime > 0) then {d_next_jump_time = time + d_HALOWaitTime};

#ifdef __OA__
_jump_helo = switch (playerSide) do {
	case east: {"Mi17_TK_EP1"};
	case west: {"UH60M_EP1"};
	case resistance: {"UH1H_TK_GUE_EP1"};
};
#else
_jump_helo = switch (playerSide) do {
	case east: {"Mi17_rockets_RU"};
	case west: {"MH60S"};
};
#endif

titleText ["","Plain"];
_uh60p = createVehicle [_jump_helo, _startLocation, [], 0, "FLY"];
_uh60p setpos [_startLocation select 0,_startLocation select 1, HALOJumpHeight];
_uh60p engineon true;
player moveincargo _uh60p;
_obj_jump = player;
if(vehicle player == player)exitWith {};

_obj_jump setvelocity [0,0,0];
#ifndef __ACE__
_obj_jump action["EJECT",vehicle _obj_jump];
if (vehicle _obj_jump isKindOf "ParachuteBase") then {
	_vec = vehicle _obj_jump;
	_obj_jump action["EJECT",vehicle _obj_jump];
	deleteVehicle _vec;
};
if (d_halo_jumptype == 0) then {
	[player, player call XfGetHeight] spawn bis_fnc_halo;
} else {
	[_obj_jump, _obj_jump call XfGetHeight] execVM "aahalo\scripts\halo_init.sqf";
};
#else
[_uh60p, player] execVM "x\ace\addons\sys_eject\jumpout.sqf";
#endif

sleep 3;

deleteVehicle _uh60p;
#ifdef __ACE__
if (d_with_ai) then {
	if (alive player) then {[position player, velocity player, direction player] execVM "x_client\x_moveai.sqf"};
};
#endif