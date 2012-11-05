// by Xeno
#include "x_setup.sqf"
private ["_grp", "_units"];
if (!isServer) exitWith {};

sleep 60;
while {true} do {
	__MPCheck;
	__DEBUG_NET("AI playercheck",(call XPlayersNumber))
	{
		if (!isNull _x) then {
			_group = _x;
			_has_player = false;
			{if (isPlayer _x) exitWith {_has_player = true}} forEach units _group;
			if (!_has_player) then {
				{
					if (!isPlayer _x) then {
						if (vehicle _x != _x) then {
							_x action ["eject", vehicle _x];
							unassignVehicle _x;
							_x setPos [0,0,0];
						};
						sleep 0.01;
						deleteVehicle _x;
					};
					sleep 0.01;
				} forEach units _group;
			};
		};
		sleep 0.51;
	} forEach d_player_groups;
	sleep 5.321;
};