// by Xeno
#include "x_setup.sqf"
private ["_is_dead","_leader","_nobjs","_officer","_offz_at_base","_rescued","_winner","_group"];
if (!isServer) exitWith {};

_officer = _this select 0;

_offz_at_base = false;
_is_dead = false;
_rescued = false;
_winner = 0;

if (d_with_ranked) then {d_sm_p_pos = nil};

while {!_offz_at_base && !_is_dead} do {
	__MPCheck;
	if (!alive _officer) then {
		_is_dead = true;
	} else {
		if (!_rescued) then {
			_nobjs = (position _officer) nearObjects ["Man", 20];
			if (count _nobjs > 0) then {
				{
					if (isPlayer _x) exitWith {
						_rescued = true;
						_officer enableAI "MOVE";
						[_officer] join (leader _x);
						["setcapt", [_officer, true]] call XNetCallEvent;
					};
					sleep 0.01;
				} forEach _nobjs;
			};
		} else {
			if (_officer distance FLAG_BASE < 30) then {
				_offz_at_base = true;
			};
		};
	};

	sleep 5.621;
};

if (_is_dead) then {
	d_side_mission_winner = -500;
} else {
	if (_offz_at_base) then {
		if (d_with_ranked) then {
			if (!(__TTVer)) then {
				["d_sm_p_pos", position FLAG_BASE] call XNetCallEvent;
			} else {
				if (_winner == 1) then {
					["d_sm_p_pos", position EFLAG_BASE] call XNetCallEvent;
				} else {
					["d_sm_p_pos", position WFLAG_BASE] call XNetCallEvent;
				};
			};
		};
		if (_winner != 0) then {
			d_side_mission_winner = _winner;
		} else {
			d_side_mission_winner = 2;
		};
		sleep 2.123;
		if (vehicle _officer != _officer) then {
			_officer action ["eject", vehicle _officer];
			unassignVehicle _officer;
			_officer setPos [0,0,0];
		};
		sleep 0.5;
		deleteVehicle _officer;
	};
};

d_side_mission_resolved = true;