// by Xeno
#include "x_setup.sqf"
private ["_nearestbase", "_healerslist", "_objs", "_points", "_nobs", "_i", "_h", "_healanims", "_medhealanims", "_mtent", "_distok"];

sleep 5;

_nearestbase = switch (d_own_side) do {
	case "WEST": {"SoldierWB"};
	case "EAST": {"SoldierEB"};
	case "GUER": {"SoldierGB"};
};
_healerslist = [];
_healanims = ["ainvpknlmstpslaywrfldnon_healed","ainvpknlmstpslaywrfldnon_healed2","ainvpknlmstpsnonwnondnon_healed_1","ainvpknlmstpsnonwnondnon_healed_2","amovppnemstpsnonwnondnon_healed","amovppnemstpsraswpstdnon_healed","amovppnemstpsraswrfldnon_healed"];
_medhealanims = ["ainvpknlmstpslaywrfldnon_medic","ainvpknlmstpsnonwnondnon_medic_1","ainvpknlmstpsnonwnondnon_medic_2"];
while {true} do {
	_points = 0;
	_objs = if (alive player) then {nearestObjects [player, [_nearestbase], 3]} else {[]};
	if (count _objs > 0) then {
		_mtent = __pGetVar(medic_tent);
		if (isNil "_mtent") then {_mtent = objNull};
		_distok = if (isNull _mtent) then {true} else {_mtent distance player > 13};
		{
			if (!(_x in _healerslist) && (_x != player) && (animationState player in _medhealanims) && _distok) then {
				if (animationState _x in _healanims) then {
					_points = _points + (d_ranked_a select 17);
					_healerslist set [count _healerslist, _x];
				};
			};
		} forEach _objs;
		if (_points > 0) then {
			["d_pas", [player, _points]] call XNetCallEvent;
			(format ["You get %1 points for healing other units!", _points]) call XfHQChat;
		};
		sleep 0.01;
	};
	if (count _healerslist > 0) then {
		for "_i" from 0 to (count _healerslist - 1) do {
			_h = _healerslist select _i;
			if (!(animationState _h in _healanims)) then {_healerslist set [_i, -1]};
		};
		_healerslist = _healerslist - [-1];
	};
	if (!alive player) then {	
		_healerslist = [];
		waitUntil {alive player};
	};
	sleep 0.561;
};
