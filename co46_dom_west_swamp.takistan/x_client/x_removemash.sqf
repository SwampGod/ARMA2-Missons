// by Xeno
#include "x_setup.sqf"
private "_m_name";

if (isNil {__pGetVar(medic_tent)}) exitWith {};
player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 3;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!alive player) exitWith {"You died before you could remove your mash." call XfGlobalChat};

deleteVehicle __pGetVar(medic_tent);
__pSetVar ["medic_tent", objNull];

"Mash removed." call XfGlobalChat;
__pSetVar ["d_medtent", []];
_m_name = format ["Mash %1", str(player)];
["d_p_o_r", [str(player),_m_name]] call XNetCallEvent;
