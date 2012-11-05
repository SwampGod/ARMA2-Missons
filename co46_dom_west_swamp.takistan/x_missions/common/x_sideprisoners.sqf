// by Xeno
#include "x_setup.sqf"
private ["_posi_a", "_pos", "_newgroup", "_unit_array", "_leader", "_hostages_reached_dest", "_all_dead", "_rescued", "_units", "_winner", "_nobjs", "_retter", "_do_loop", "_i", "_one"];
if (!isServer) exitWith {};

_posi_a = _this select 0;
_pos = _posi_a select 0;

_posi_a = nil;

if (d_with_ranked) then {d_sm_p_pos = nil};

sleep 2;

#ifndef __TT__
_newgroup = [d_own_side] call x_creategroup;
#else
_newgroup = [civilian] call x_creategroup;
#endif
_unit_array = ["civilian", "CIV"] call x_getunitliste;
[_pos, (_unit_array select 0), _newgroup] call x_makemgroup;
_leader = leader _newgroup;
_leader setSkill 1;
_unit_array = nil;
sleep 2.0112;
_newgroup allowFleeing 0;
_units = units _newgroup;
{
	removeAllWeapons _x;
	_x setCaptive true;
	_x disableAI "MOVE";
} forEach _units;

sleep 2.333;
["specops", 2, "basic", 2, _pos,100,true] spawn XCreateInf;
sleep 2.333;
["shilka", 1, "bmp", 1, "tank", 1, _pos,1,140,true] spawn XCreateArmor;

sleep 32.123;

_hostages_reached_dest = false;
_all_dead = false;
_rescued = false;

#ifdef __TT__
_winner = 0;
#endif

if (!d_with_ai) then {
	while {!_hostages_reached_dest && !_all_dead} do {
		__MPCheck;
		if ((_units call XfGetAliveUnits) == 0) then {
			_all_dead = true;
		} else {
			if (!_rescued) then {
				_leader = leader _newgroup;
				_nobjs = (position _leader) nearObjects ["Man", 20];
				if (count _nobjs > 0) then {
					{
						if (isPlayer _x && (str(_x) in ["RESCUE","RESCUE2"])) exitWith {
							_rescued = true;
							_retter = _x;
							{
								if (!(isNull _x) && alive _x) then {
									_x setCaptive false;
									_x enableAI "MOVE";
								};
							} forEach _units;
							_units join _retter;
						};
						sleep 0.01;
					} forEach _nobjs;
				};
			} else {
				_do_loop = true;
				{
					if (!(isNull _x) && (alive _x)) then {
						if (!(__TTVer)) then {
							if (_x distance FLAG_BASE < 20) then {
								_hostages_reached_dest = true;
								_do_loop = false;
							};
						} else {
							if (_x distance WFLAG_BASE < 20) then {
								_hostages_reached_dest = true;
								_do_loop = false;
								_winner = 2;
							} else {
								if (_x distance EFLAG_BASE < 20) then {
									_hostages_reached_dest = true;
									_do_loop = false;
									_winner = 1;
								};
							};
						};
					};
					if (!_do_loop) exitWith {};
				} forEach _units;
			};
		};
		if (__RankedVer) then {
			if (_hostages_reached_dest) then {
				if (!(__TTVer)) then {
					["d_sm_p_pos", position FLAG_BASE] call XNetCallEvent;
				} else {
					switch (_winner) do {
						case 1: {["d_sm_p_pos", position EFLAG_BASE] call XNetCallEvent};
						case 2: {["d_sm_p_pos", position WFLAG_BASE] call XNetCallEvent};
					};
				};
			};
		};
		sleep 5.123;
	};
} else {
	_retter = objNull;

	while {!_hostages_reached_dest && !_all_dead} do {
		__MPCheck;
		if ((_units call XfGetAliveUnits) == 0) then {
			_all_dead = true;
		} else {
			if (!_rescued) then {
				_leader = leader _newgroup;
				_nobjs = (position _leader) nearObjects ["Man", 20];
				if (count _nobjs > 0) then {
					{
						if (isPlayer _x) exitWith {
							_rescued = true;
							_retter = _x;
						};
						sleep 0.01;
					} forEach _nobjs;
					if (_rescued && !isNull _retter) then {
						{
							if (!(isNull _x) && alive _x) then {
								_x setCaptive false;
								_x enableAI "MOVE";
							};
						} forEach _units;
						_units join (leader _retter);
					};
				};
			} else {
				{
					if (!(isNull _x) && (alive _x) && _x distance FLAG_BASE < 20) exitWith {_hostages_reached_dest = true};
				} forEach _units;
			};
		};
		if (__RankedVer) then {
			if (_hostages_reached_dest) then {["d_sm_p_pos", position FLAG_BASE] call XNetCallEvent};
		};
		sleep 5.123;
	};
};

if (_all_dead) then {
	d_side_mission_winner = -400;
} else {
	if (_hostages_reached_dest) then {
		if ((_units call XfGetAliveUnits) > 7) then {
#ifndef __TT__
			d_side_mission_winner = 2;
#else
			d_side_mission_winner = _winner;
#endif
		} else {
			d_side_mission_winner = -400;
		};
	} else {
		d_side_mission_winner = -400;
	};
};

d_side_mission_resolved = true;

sleep 5.123;

{
	if (!isNull _x) then {
		if (vehicle _x != _x) then {
			_x action ["eject", vehicle _x];
			unassignVehicle _x;
			_x setPos [0,0,0];
		};
		deleteVehicle _x;
	};
} forEach _units;
sleep 0.5321;
if (!isNull _newgroup) then {deleteGroup _newgroup};

_units = nil;
