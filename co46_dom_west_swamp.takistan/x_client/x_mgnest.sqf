// by Xeno
#include "x_setup.sqf"
private ["_dir_to_set","_m_name","_marker","_d_mgnest_pos","_exit_it"];

if ((player call XfGetHeight) > 5) exitWith {"You must be kidding..." call XfGlobalChat};

_d_mgnest_pos = __pGetVar(d_mgnest_pos);
if (count _d_mgnest_pos > 0) exitWith {"You have allready placed a mg nest. You have to remove it to build a new one." call XfGlobalChat};

_d_mgnest_pos = player modeltoworld [0,2,0];
_d_mgnest_pos set [2,0];

if (surfaceIsWater [_d_mgnest_pos select 0, _d_mgnest_pos select 1]) exitWith {
	"It is not possible to place a mg nest into water." call XfGlobalChat;
};

if (d_with_ranked && (score player < (d_ranked_a select 14))) exitWith {
	(format ["You need %2 points to build a mg nest. Your current score is: %1", score player,(d_ranked_a select 14)]) call XfHQChat;
};

_helper1 = "HeliHEmpty" createVehicleLocal [_d_mgnest_pos select 0, (_d_mgnest_pos select 1) + 4, 0];
_helper2 = "HeliHEmpty" createVehicleLocal [_d_mgnest_pos select 0, (_d_mgnest_pos select 1) - 4, 0];
_helper3 = "HeliHEmpty" createVehicleLocal [(_d_mgnest_pos select 0) + 4, _d_mgnest_pos select 1, 0];
_helper4 = "HeliHEmpty" createVehicleLocal [(_d_mgnest_pos select 0) - 4, _d_mgnest_pos select 1, 0];

_exit_it = false;
if ((abs (((getPosASL _helper1) select 2) - ((getPosASL _helper2) select 2)) > 2) || (abs (((getPosASL _helper3) select 2) - ((getPosASL _helper4) select 2)) > 2)) then {
	"Place not valid. Try another location to place the mg nest." call XfGlobalChat;
	_exit_it = true;
};

for "_mt" from 1 to 4 do {call compile format ["deleteVehicle _helper%1;", _mt]};

if (_exit_it) exitWith {};

if (d_with_ranked) then {["d_pas", [player, (d_ranked_a select 14) * -1]] call XNetCallEvent};

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 3;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!(alive player)) exitWith {"You died before your MG nest was ready." call XfGlobalChat};

_dir_to_set = getdir player;

_mg_nest = createVehicle [d_mg_nest, _d_mgnest_pos, [], 0, "NONE"];
_mg_nest setdir _dir_to_set;
_mg_nest setPos _d_mgnest_pos;
[_mg_nest, 0] call XfSetHeight;

__pSetVar ["mg_nest", _mg_nest];
player reveal _mg_nest;

_d_mgnest_pos = position _mg_nest;
__pSetVar ["d_mgnest_pos", _d_mgnest_pos];

"MG Nest ready." call XfGlobalChat;
_m_name = format ["MG Nest %1", str(player)];

["d_p_o_a", [str(player), [_mg_nest,_m_name,name player,playerSide]]] call XNetCallEvent;

_mg_nest addAction ["Remove MG Nest" call XRedText, "x_client\x_removemgnest.sqf"];
_mg_nest addEventHandler ["killed",{[_this select 0] call XMGnestKilled}];

player moveInGunner _mg_nest;