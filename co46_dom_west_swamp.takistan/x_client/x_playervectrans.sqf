// by Xeno
#include "x_setup.sqf"
if (!X_Client) exitWith {};

sleep 6;

d_getOutEHPoints = {
	private ["_vec", "_unit", "_var"];
	_vec = _this select 0;
	_unit = _this select 2;
	if (!isPlayer _unit) exitWith {};
	if (alive player && _unit != player && alive _unit) then {
		_var = _unit getVariable "D_TRANS_START";
		if (!isNil "_var") then {
			if (_var distance position _unit > d_transport_distance) then {
				["d_pas", [player, (d_ranked_a select 18)]] call XNetCallEvent;
			};
		};
	};
};

[] spawn {
	private ["_vec", "_eindex", "_i", "_egoindex"];
	while {true} do {
		waitUntil {alive player};
		waitUntil {sleep 0.407;vehicle player != player};
		_vec = vehicle player;
		_eindex = -1;
		_egoindex = -1;
		if (_vec isKindOf "Car" || (_vec isKindOf "Helicopter" && !(_vec isKindOf "ParachuteBase") && !(_vec isKindOf "BIS_Steerable_Parachute"))) then {
			while {vehicle player != player && alive player} do {
				if (player == driver _vec) then {
					if (_egoindex == -1) then {
						_egoindex = _vec addEventHandler ["getout",{_this call d_getOutEHPoints}];
						{if (_x != player && isPlayer _x) then {_x setVariable ["D_TRANS_START", position _vec]}} forEach (crew _vec);
					};
					if (_eindex == -1) then {
						_eindex = _vec addEventHandler ["getin",{if (isPlayer (_this select 2)) then {(_this select 2) setVariable ["D_TRANS_START", position (_this select 0)]}}];
					};
				};
				if (player != driver _vec) then {
					if (_eindex != -1) then {
						_vec removeEventHandler ["getin",_eindex];
						_eindex = -1;
					};
					if (_egoindex != -1) then {
						_vec removeEventHandler ["getout",_egoindex];
						_egoindex = -1;
					};
				};
				sleep 0.812;
			};
		} else {
			waitUntil {sleep 0.407;vehicle player == player || !alive player};
		};
		if (_eindex != -1) then {
			_vec removeEventHandler ["getin",_eindex];
			_eindex = -1;
		};
		if (_egoindex != -1) then {
			_vec removeEventHandler ["getout",_egoindex];
			_egoindex = -1;
		};
	};
};