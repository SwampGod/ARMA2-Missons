// by Xeno
#include "x_setup.sqf"
private ["_nos", "_notruck", "_vt", "_helper1", "_helper2", "_helper3", "_helper4", "_mt", "_helper", "_farptype", "_farp"];

if ((player call XfGetHeight) > 5) exitWith {"You must be kidding..." call XfGlobalChat};

_d_farp_pos = __pGetVar(d_farp_pos);
if (count _d_farp_pos > 0) exitWith {"You have allready placed a FARP. You have to remove it to build a new one." call XfGlobalChat};

_nos = (position player) nearObjects ["Truck", 20];
_notruck = true;
if (count _nos > 0) then {
	{
		_vt = _x getVariable "d_vec_type";
		if (isNil "_vt") then {_vt = ""};
		if (_vt == "Engineer") exitWith {_notruck = false};
	} forEach _nos;
};

if (_notruck) exitWith {
	"No engineer truck nearby to build a FARP!" call XfGlobalChat
};

_d_farp_pos = player modeltoworld [0,8,0];
_d_farp_pos set [2,0];

if (surfaceIsWater [_d_farp_pos select 0, _d_farp_pos select 1]) exitWith {
	"It is not possible to place a FARP into water." call XfGlobalChat;
};

if (d_with_ranked && (score player < (d_ranked_a select 20))) exitWith {
	(format ["You need %2 points to build a FARP. Your current score is: %1", score player,(d_ranked_a select 20)]) call XfHQChat;
};

_helper1 = "HeliHEmpty" createVehicleLocal [_d_farp_pos select 0, (_d_farp_pos select 1) + 4, 0];
_helper2 = "HeliHEmpty" createVehicleLocal [_d_farp_pos select 0, (_d_farp_pos select 1) - 4, 0];
_helper3 = "HeliHEmpty" createVehicleLocal [(_d_farp_pos select 0) + 4, _d_farp_pos select 1, 0];
_helper4 = "HeliHEmpty" createVehicleLocal [(_d_farp_pos select 0) - 4, _d_farp_pos select 1, 0];

_exit_it = false;
if ((abs (((getPosASL _helper1) select 2) - ((getPosASL _helper2) select 2)) > 2) || (abs (((getPosASL _helper3) select 2) - ((getPosASL _helper4) select 2)) > 2)) then {
	"Place not valid. Try another location to place the FARP." call XfGlobalChat;
	_exit_it = true;
};

for "_mt" from 1 to 4 do {call compile format ["deleteVehicle _helper%1;", _mt]};

if (_exit_it) exitWith {};

if (d_with_ranked) then {["d_pas", [player, (d_ranked_a select 20) * -1]] call XNetCallEvent};

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 3;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!(alive player)) exitWith {"You died before your FARP was ready." call XfGlobalChat};

_dir_to_set = getdir player;

_farptype = switch (playerSide) do {
	case west: {"US_WarfareBVehicleServicePoint_Base_EP1"};
	case east: {"TK_WarfareBVehicleServicePoint_Base_EP1"};
};

_farp = createVehicle [_farptype, _d_farp_pos, [], 0, "NONE"];
_farp setdir _dir_to_set;
_farp setPos _d_farp_pos;
[_farp, 0] call XfSetHeight;
player reveal _farp;
_d_farp_pos = position _farp;
__pSetVar ["d_farp_pos", _d_farp_pos];

__pSetVar ["d_farp_obj", _farp];

_farpsar = __XJIPGetVar(d_farps);
_farpsar set [count _farpsar, _farp];
__XJIPSetVar ["d_farps", _farpsar, true];

"FARP ready." call XfGlobalChat;
_m_name = format ["FARP %1", str(player)];
["d_p_o_a", [str(player), [_farp,_m_name,name player,playerSide]]] call XNetCallEvent;

_farp addAction ["Remove FARP" call XRedText, "x_client\x_removefarp.sqf"];
_farp addEventHandler ["killed",{[_this select 0] call XFarpKilled}];

["d_farp_e", _farp] call XNetCallEvent;
