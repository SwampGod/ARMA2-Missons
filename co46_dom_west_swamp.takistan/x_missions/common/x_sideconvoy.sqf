// by Xeno
#include "x_setup.sqf"
private ["_direction", "_numconfv", "_newgroup", "_reta", "_vehicles", "_nextpos", "_leader", "_i", "_wp", "_endtime"];

_pos_start = _this select 0;
_pos_end = _this select 1;
_direction = _this select 2;

_crew_member = "";

#ifdef __TT__
sm_points_west = 0;
sm_points_east = 0;
#endif

if (d_with_ranked) then {d_sm_p_pos = nil};

d_confvdown = 0;
_numconfv = count d_sm_convoy_vehicles;
_newgroup = [d_side_enemy] call x_creategroup;
_reta = [1, _pos_start, (d_sm_convoy_vehicles select 0), _newgroup, 0, _direction] call x_makevgroup;
_vehicles = _reta select 0;
(_vehicles select 0) lock true;
_nextpos = (_vehicles select 0) modeltoworld [0, -9, 0];
_nextpos set [2,0];
(_vehicles select 0) addEventHandler ["killed", {d_confvdown = d_confvdown + 1}];
#ifdef __TT__
(_vehicles select 0) addEventHandler ["killed", {_this call XfAddSMPoints}];
#endif
extra_mission_vehicle_remover_array = [extra_mission_vehicle_remover_array, _vehicles] call X_fnc_arrayPushStack;
extra_mission_remover_array = [extra_mission_remover_array, _reta select 1] call X_fnc_arrayPushStack;
_leader = leader _newgroup;
_leader setRank "LIEUTENANT";
_newgroup allowFleeing 0;
_newgroup setCombatMode "GREEN";
_newgroup setFormation "COLUMN";
_newgroup setSpeedMode "LIMITED";
sleep 1.933;
_vehicles = nil;
for "_i" from 1 to (_numconfv - 1) do {
	_reta = [1, _nextpos, (d_sm_convoy_vehicles select _i), _newgroup, 20, _direction] call x_makevgroup;
	_vehicles = _reta select 0;
	(_vehicles select 0) lock true;
	_nextpos = (_vehicles select 0) modeltoworld [0, -9, 0];
	_nextpos set [2,0];
	(_vehicles select 0) addEventHandler ["killed", {d_confvdown = d_confvdown + 1}];
	#ifdef __TT__
	(_vehicles select 0) addEventHandler ["killed", {_this call XfAddSMPoints}];
	#endif
	extra_mission_vehicle_remover_array = [extra_mission_vehicle_remover_array, _vehicles] call X_fnc_arrayPushStack;
	extra_mission_remover_array = [extra_mission_remover_array, _reta select 1] call X_fnc_arrayPushStack;
	sleep 1.933;
	_vehicles = nil;
};

_wp =_newgroup addWaypoint[_pos_start, 0];
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "NORMAL";
_wp setwaypointtype "MOVE";
_wp setWaypointFormation "COLUMN";
_wp setWaypointTimeout [60,80,70];
_wp=_newgroup addWaypoint[_pos_end, 0];

sleep 20.123;

_convoy_reached_dest = false;
_convoy_destroyed = false;
_endtime = time + 3600;

while {true} do {
	__MPCheck;
	if (d_confvdown == _numconfv) exitWith {
		_convoy_destroyed = true;
	};
	if ((position (leader _newgroup)) distance _pos_end < 40) exitWith {
		_convoy_reached_dest = true;
	};
	if (d_with_ranked) then {["d_sm_p_pos", position _leader] call XNetCallEvent};
	if (time > _endtime) exitWith {_convoy_reached_dest = true};
	sleep 5.123;
};

if (_convoy_reached_dest) then {
	d_side_mission_winner = -300;
} else {
#ifndef __TT__
	if (_convoy_destroyed) then {d_side_mission_winner=2};
#else
	if (sm_points_west > sm_points_east) then {
		d_side_mission_winner = 2;
	} else {
		if (sm_points_east > sm_points_west) then {
			d_side_mission_winner = 1;
		} else {
			if (sm_points_east == sm_points_west) then {
				d_side_mission_winner = 123;
			};
		};
	};
#endif
};

d_side_mission_resolved = true;