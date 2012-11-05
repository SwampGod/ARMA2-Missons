// by Xeno
#include "x_setup.sqf"
private "_farp";

_farp = __pGetVar(d_farp_obj);
if (isNil "_farp") exitWith {};

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 3;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!alive player) exitWith {"You died before you could remove your FARP nest." call XfGlobalChat};

_farpsar = __XJIPGetVar(d_farps); 
_farpsar = _farpsar - [_farp];
__XJIPSetVar ["d_farps", _farpsar, true];

deleteVehicle _farp;
__pSetVar ["d_farp_obj", objNull];

"FARP removed." call XfGlobalChat;
__pSetVar ["d_farp_pos", []];
_m_name = format ["FARP %1", str(player)];
["d_p_o_r", [str(player),_m_name]] call XNetCallEvent;