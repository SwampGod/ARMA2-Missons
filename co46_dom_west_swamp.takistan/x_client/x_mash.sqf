// by Xeno
#include "x_setup.sqf"
private ["_dir_to_set","_m_name","_marker","_d_medtent", "_exit_it"];

if ((player call XfGetHeight) > 5) exitWith {"You must be kidding..." call XfGlobalChat};

_d_medtent = __pGetVar(d_medtent);
if (count _d_medtent > 0) exitWith {"You have allready build a mash. You have to remove it to build a new one." call XfGlobalChat};

_d_medtent = player modeltoworld [0,5,0];
_d_medtent set [2,0];

if (surfaceIsWater [_d_medtent select 0, _d_medtent select 1]) exitWith {
	"It is not possible to place a medic tent into water." call XfGlobalChat;
};

_helper1 = "HeliHEmpty" createVehicleLocal [_d_medtent select 0, (_d_medtent select 1) + 4, 0];
_helper2 = "HeliHEmpty" createVehicleLocal [_d_medtent select 0, (_d_medtent select 1) - 4, 0];
_helper3 = "HeliHEmpty" createVehicleLocal [(_d_medtent select 0) + 4, _d_medtent select 1, 0];
_helper4 = "HeliHEmpty" createVehicleLocal [(_d_medtent select 0) - 4, _d_medtent select 1, 0];

_exit_it = false;
if ((abs (((getPosASL _helper1) select 2) - ((getPosASL _helper2) select 2)) > 2) || (abs (((getPosASL _helper3) select 2) - ((getPosASL _helper4) select 2)) > 2)) then {
	"Place not valid. Try another location to place the mash." call XfGlobalChat;
	_exit_it = true;
};

for "_mt" from 1 to 4 do {call compile format ["deleteVehicle _helper%1;", _mt]};

if (_exit_it) exitWith {};

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 3;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
if (!(alive player)) exitWith {"You died before your mash was ready." call XfGlobalChat};

_dir_to_set = getdir player - 180;

#ifndef __OA__
_medic_tent = createVehicle ["Mash", _d_medtent, [], 0, "NONE"];
#else
_medic_tent = createVehicle ["MASH_EP1", _d_medtent, [], 0, "NONE"];
#endif
_medic_tent setdir _dir_to_set;
_medic_tent setPos _d_medtent;
[_medic_tent, 0] call XfSetHeight;

__pSetVar ["medic_tent", _medic_tent];
player reveal _medic_tent;
_d_medtent = position _medic_tent;
__pSetVar ["d_medtent", _d_medtent];

"Mash ready." call XfGlobalChat;
_m_name = format ["Mash %1", str(player)];

["d_p_o_a", [str(player), [_medic_tent,_m_name,name player,playerSide]]] call XNetCallEvent;

_medic_tent addAction ["Remove Mash" call XRedText, "x_client\x_removemash.sqf"];
_medic_tent addEventHandler ["killed",{[_this select 0] call XMashKilled}];

if (d_with_ranked) then {
	_medic_tent spawn {
		private ["_tent", "_pos_healers", "_healerslist", "_points", "_nobs", "_i", "_h", "_healanims"];
		_tent = _this;
		_pos_healers = switch (d_own_side) do {
			case "WEST": {"SoldierWB"};
			case "EAST": {"SoldierEB"};
			case "GUER": {"SoldierGB"};
		};
		_healerslist = [];
		_healanims = ["ainvpknlmstpslaywrfldnon_healed","ainvpknlmstpslaywrfldnon_healed2","ainvpknlmstpsnonwnondnon_healed_1","ainvpknlmstpsnonwnondnon_healed_2","amovppnemstpsnonwnondnon_healed","amovppnemstpsraswpstdnon_healed","amovppnemstpsraswrfldnon_healed"];
		while {!isNull _tent && alive _tent} do {
			_points = 0;
			_nobs = nearestObjects [_tent, [_pos_healers], 13];
			{
				if (!(_x in _healerslist) && (_x != player)) then {
					if (animationState _x in _healanims) then {
						_points = _points + (d_ranked_a select 7);
						_healerslist set [count _healerslist, _x];
					};
				};
			} forEach _nobs;
			if (_points > 0) then {
				["d_pas", [player, _points]] call XNetCallEvent;
				(format ["You get %1 points because other units used your mash for healing!", _points]) call XfHQChat;
			};
			sleep 0.01;
			if (count _healerslist > 0) then {
				for "_i" from 0 to (count _healerslist - 1) do {
					_h = _healerslist select _i;
					if (!(animationState _h in _healanims)) then {_healerslist set [_i, -1]};
				};
				_healerslist = _healerslist - [-1];
			};
			sleep 0.521;
		};
	};
};