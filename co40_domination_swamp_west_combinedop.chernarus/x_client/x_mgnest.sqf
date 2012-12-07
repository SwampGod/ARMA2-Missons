// by Xeno
#define THIS_FILE "x_mgnest.sqf"
#include "x_setup.sqf"
private ["_dir_to_set","_m_name","_marker","_d_mgnest_pos","_exit_it"];

if ((player call FUNC(GetHeight)) > 5) exitWith {"You must be kidding..." call FUNC(GlobalChat)};

_d_mgnest_pos = __pGetVar(GVAR(mgnest_pos));
if (count _d_mgnest_pos > 0) exitWith {"You have allready placed a mg nest. You have to remove it to build a new one." call FUNC(GlobalChat)};

_d_mgnest_pos = player modeltoworld [0,2,0];
_d_mgnest_pos set [2,0];

if (surfaceIsWater [_d_mgnest_pos select 0, _d_mgnest_pos select 1]) exitWith {
	"It is not possible to place a mg nest into water." call FUNC(GlobalChat);
};

_exit_it = false;
if (GVAR(with_ranked)) then {
	if (score player < (GVAR(ranked_a) select 14)) then {
		(format ["You need %2 points to build a mg nest. Your current score is: %1", score player,(GVAR(ranked_a) select 14)]) call FUNC(HQChat);
		_exit_it = true;
	};
};

if (_exit_it) exitWith {};

_helper1 = GVAR(HeliHEmpty) createVehicleLocal [_d_mgnest_pos select 0, (_d_mgnest_pos select 1) + 4, 0];
_helper2 = GVAR(HeliHEmpty) createVehicleLocal [_d_mgnest_pos select 0, (_d_mgnest_pos select 1) - 4, 0];
_helper3 = GVAR(HeliHEmpty) createVehicleLocal [(_d_mgnest_pos select 0) + 4, _d_mgnest_pos select 1, 0];
_helper4 = GVAR(HeliHEmpty) createVehicleLocal [(_d_mgnest_pos select 0) - 4, _d_mgnest_pos select 1, 0];

_exit_it = false;
if ((abs (((getPosASL _helper1) select 2) - ((getPosASL _helper2) select 2)) > 2) || (abs (((getPosASL _helper3) select 2) - ((getPosASL _helper4) select 2)) > 2)) then {
	"Place not valid. Try another location to place the mg nest." call FUNC(GlobalChat);
	_exit_it = true;
};

for "_mt" from 1 to 4 do {call compile format ["deleteVehicle _helper%1;", _mt]};

if (_exit_it) exitWith {};

if (GVAR(with_ranked)) then {[QGVAR(pas), [player, (GVAR(ranked_a) select 14) * -1]] call FUNC(NetCallEvent)};

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 3;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!alive player) exitWith {"You died before your MG nest was ready." call FUNC(GlobalChat)};

_dir_to_set = getdir player;

_mg_nest = createVehicle [GVAR(mg_nest), _d_mgnest_pos, [], 0, "NONE"];
_mg_nest setdir _dir_to_set;
_mg_nest setPos _d_mgnest_pos;
[_mg_nest, 0] call FUNC(SetHeight);

__pSetVar ["mg_nest", _mg_nest];
player reveal _mg_nest;

_d_mgnest_pos = position _mg_nest;
__pSetVar [QGVAR(mgnest_pos), _d_mgnest_pos];

"MG Nest ready." call FUNC(GlobalChat);
_m_name = "MG Nest " + GVAR(string_player);

[QGVAR(p_o_a), [GVAR(string_player), [_mg_nest,_m_name,GVAR(name_pl),GVAR(player_side)]]] call FUNC(NetCallEvent);

_mg_nest addAction ["Remove MG Nest" call FUNC(RedText),"x_client\x_removemgnest.sqf",[],-1,false,true,"","vehicle player == player"];

player moveInGunner _mg_nest;