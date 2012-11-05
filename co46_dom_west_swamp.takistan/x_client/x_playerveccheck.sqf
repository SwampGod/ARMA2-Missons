// by Xeno
#include "x_setup.sqf"
private ["_vec", "_not_allowed", "_needed_rank", "_index"];
if (!X_Client) exitWith {};

while {true} do {
	waitUntil {alive player};
	waitUntil {sleep 0.317;vehicle player != player};
	_vec = vehicle player;
	_not_allowed = false;
	_needed_rank = "";
	
	_d_vec_type = _vec getVariable "d_vec_type";
	if (isNil "_d_vec_type") then {
		_index = (rank player) call XGetRankIndex;
		_vrs = d_ranked_a select 8;
		_indexsb = (toUpper (_vrs select 0)) call XGetRankIndex;
		_indexta = (toUpper (_vrs select 1)) call XGetRankIndex;
		_indexheli = (toUpper (_vrs select 2)) call XGetRankIndex;
		_indexplane = (toUpper (_vrs select 3)) call XGetRankIndex;
		switch (true) do {
			case (_vec isKindOf "LandVehicle"): {
				switch (true) do {
					case (_vec isKindOf "Wheeled_APC"): {
						if (_index < _indexsb) then {
							_not_allowed = true;
							_needed_rank = (_vrs select 0);
						};
					};
					case (_vec isKindOf "BRDM2"): {
						if (_index < _indexsb) then {
							_not_allowed = true;
							_needed_rank = (_vrs select 0);
						};
					};
					case (_vec isKindOf "Tank"): {
						if (_index < _indexta) then {
							_not_allowed = true;
							_needed_rank = (_vrs select 1);
						};
					};
				};
			};
			case (_vec isKindOf "Air"): {
				switch (true) do {
					case (_vec isKindOf "Helicopter" && !(_vec isKindOf "ParachuteBase")): {
						if (_index < _indexheli) then {
							_not_allowed = true;
							_needed_rank = (_vrs select 2);
						};
					};
					case (_vec isKindOf "Plane"): {
						if (_index < _indexplane) then {
							_not_allowed = true;
							_needed_rank = (_vrs select 3);
						};
					};
				};
			};
		};
	};
	
	if (_not_allowed) then {
		player action["Eject",_vec];
		[format ["Your current rank %1 doesn't allow you to use a %3.\n\nYou need to be %2 for this.", (rank player) call XGetRankString, _needed_rank,[typeOf _vec,0] call XfGetDisplayName], "HQ"] call XHintChatMsg;
	};
	waitUntil {sleep 0.317;(vehicle player == player || !alive player)};
};