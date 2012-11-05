// by Xeno
#include "x_setup.sqf"
private ["_m_name","_mg_nest"];

_mg_nest = __pGetVar(mg_nest);
if (isNil "_mg_nest") exitWith {};
if (vehicle player == _mg_nest) exitWith {"You have to get out of the MG nest before you can remove it." call XfGlobalChat};

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 3;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!alive player) exitWith {"You died before you could remove your MG nest." call XfGlobalChat};

deleteVehicle _mg_nest;
__pSetVar ["mg_nest", objNull];

"MG nest removed." call XfGlobalChat;
__pSetVar ["d_mgnest_pos", []];
_m_name = format ["MG Nest %1", str(player)];
["d_p_o_r", [str(player),_m_name]] call XNetCallEvent;