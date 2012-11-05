// by Xeno
#define THIS_FILE "x_update_dlg.sqf"
#include "x_setup.sqf"
private ["_pos", "_dir", "_trenchtype", "_trench"];

if ((player call FUNC(GetHeight)) > 5) exitWith {"You must be kidding..." call FUNC(GlobalChat)};

if (!isNull __pGetVar(GVAR(trench))) exitWith {
	"You can not create a trench currently!" call FUNC(GlobalChat);
};

_pos = player modeltoworld [0,1,0];
_pos set [2, 0];
_dir = direction player;

if (surfaceIsWater _pos) exitWith {
	"It is not possible to create a trench in water." call FUNC(GlobalChat);
};

if (isOnRoad _pos) exitWith {
	"It is not possible to create a trench on a road." call FUNC(GlobalChat);
};

"Creating trench... You can create a trench again after respawn." call FUNC(GlobalChat);

_trenchtype = 
#ifndef __A2ONLY__
	"Fort_EnvelopeSmall_EP1";
#else
	"Fort_EnvelopeSmall";
#endif

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 3;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!alive player) exitWith {"You died before your trench was ready." call FUNC(GlobalChat)};

_trench = createVehicle [_trenchtype, _pos, [], 0, "NONE"];
_trench setdir _dir;
_trench setPos _pos;

[QGVAR(p_o_a2), [GVAR(string_player), _trench]] call FUNC(NetCallEvent);
__pSetVar [QGVAR(trench), _trench];
