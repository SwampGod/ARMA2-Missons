// by Xeno
#define THIS_FILE "x_removemgnest.sqf"
#include "x_setup.sqf"
private ["_m_name","_mg_nest"];

_mg_nest = __pGetVar(mg_nest);
if (isNil "_mg_nest") exitWith {};
if (vehicle player == _mg_nest) exitWith {"You have to get out of the MG nest before you can remove it." call FUNC(GlobalChat)};

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 3;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!alive player) exitWith {"You died before you could remove your MG nest." call FUNC(GlobalChat)};

deleteVehicle _mg_nest;
__pSetVar ["mg_nest", objNull];

"MG nest removed." call FUNC(GlobalChat);
__pSetVar [QGVAR(mgnest_pos), []];
_m_name = "MG Nest " + GVAR(string_player);
[QGVAR(p_o_r), [GVAR(string_player),_m_name]] call FUNC(NetCallEvent);