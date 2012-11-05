// by Xeno
#include "x_setup.sqf"
private ["_pos_array", "_poss", "_endtime", "_side_crew", "_pilottype", "_wrecktype", "_wreck", "_owngroup", "_pilot1", "_owngroup2", "_pilot2", "_hideobject", "_is_dead", "_pilots_at_base", "_rescued", "_winner", "_time_over", "_enemy_created", "_nobjs", "_estart_pos", "_unit_array", "_ran", "_i", "_newgroup", "_units", "_leader"];
if (!isServer) exitWith {};

_pos_array = _this select 0;
_poss = _pos_array select 0;
_endtime = _this select 1;

_side_crew = if (d_enemy_side == "EAST") then {west} else {east};
#ifdef __OA__
_pilottype = if (d_enemy_side == "EAST") then {"US_Soldier_Pilot_EP1"} else {"TK_Soldier_Pilot_EP1"};
_wrecktype = if (d_enemy_side == "EAST") then {"UH60_wreck_EP1"} else {"Mi8Wreck"};
#else
_pilottype = if (d_enemy_side == "EAST") then {"USMC_Soldier_Pilot"} else {"RU_Soldier_Pilot"};
_wrecktype = if (d_enemy_side == "EAST") then {"UH1Wreck"} else {"Mi8Wreck"};
#endif

_wreck = createVehicle [_wrecktype, _poss, [], 0, "NONE"];
_wreck lock true;
_wreck setDir (random 360);
_wreck setPos _poss;
__AddToExtraVec(_wreck)
_wrecktype = nil;

sleep 2;

_owngroup = [_side_crew] call x_creategroup;
_pilot1 = _owngroup createUnit [_pilottype, _poss, [], 60, "FORM"];
_pilot1 setVariable ["BIS_noCoreConversations", true];

_pilot2 = _owngroup createUnit [_pilottype, position _pilot1, [], 60, "FORM"];
_pilot2 setVariable ["BIS_noCoreConversations", true];

sleep 15;
_side_crew = nil;
_pilot1 disableAI "MOVE";
_pilot1 setDamage 0.5;
_pilot1 setUnitPos "DOWN";
_pilot2 disableAI "MOVE";
_pilot2 setDamage 0.5;
_pilot2 setUnitPos "DOWN";

_is_dead = false;
_pilots_at_base = false;
_rescued = false;
_winner = 0;
_time_over = 3;
_enemy_created = false;

while {!_pilots_at_base && !_is_dead} do {
	__MPCheck;
	if (!alive _pilot1 && !alive _pilot2) then {
		_is_dead = true;
	} else {
		if (!_rescued) then {
			_nobjs = [];
			if (alive _pilot1) then {_nobjs = (position _pilot1) nearObjects ["Man", 20]};
			if (alive _pilot2) then {[_nobjs, (position _pilot2) nearObjects ["Man", 20]] call X_fnc_arrayPushStack};
			if (count _nobjs > 0) then {
				{
					if (isPlayer _x) exitWith {
						_rescued = true;
						if (alive _pilot1) then {
							_pilot1 setUnitPos "AUTO";
							_pilot1 enableAI "MOVE";
							[_pilot1] join (leader _x);
						};
						if (alive _pilot2) then {
							_pilot2 setUnitPos "AUTO";
							_pilot2 enableAI "MOVE";
							[_pilot2] join (leader _x);
						};
					};
					sleep 0.01;
				} forEach _nobjs;
			};
		} else {
			if (alive _pilot1 && alive _pilot2) then {
				if (_pilot1 distance FLAG_BASE < 20 && _pilot2 distance FLAG_BASE < 20) then {_pilots_at_base = true};
			} else {
				if (_pilot1 distance FLAG_BASE < 20 || _pilot2 distance FLAG_BASE < 20) then {_pilots_at_base = true};
			};
		};
	};

	sleep 5.621;
	if (_time_over > 0) then {
		if (_time_over == 3) then {
			if (_endtime - time <= 600) then {
				_time_over = 2;
				d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TimeLimitSM",["1","","10",[]],true];
			};
		} else {
			if (_time_over == 2) then {
				if (_endtime - time <= 300) then {
					_time_over = 1;
					d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TimeLimitSM",["1","","5",[]],true];
				};
			} else {
				if (_time_over == 1) then {
					if (_endtime - time <= 120) then {
						_time_over = 0;
						d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TimeLimitSMTwoM",true];
					};
				};
			};
		};
	} else {
		if (!_enemy_created) then {
			_enemy_created = true;
			_estart_pos = [_poss,250] call XfGetRanPointCircleOuter;
			_unit_array = ["basic", d_enemy_side] call x_getunitliste;
			_ran = [3,5] call XfGetRandomRangeInt;
			for "_i" from 1 to _ran do {
				_newgroup = [d_enemy_side] call x_creategroup;
				_units = [_estart_pos, (_unit_array select 0), _newgroup] call x_makemgroup;
				sleep 1.045;
				_leader = leader _newgroup;
				_leader setRank "LIEUTENANT";
				_newgroup allowFleeing 0;
				[_newgroup, _poss] call XAttackWP;
				extra_mission_remover_array = [extra_mission_remover_array, _units] call X_fnc_arrayPushStack;
				sleep 1.012;
			};
			_unit_array = nil;
		};
	};
};

if (_is_dead) then {
	d_side_mission_winner = -700;
} else {
	if (_pilots_at_base) then {
		if (d_with_ranked) then {
			if (!(__TTVer)) then {
				["d_sm_p_pos", position FLAG_BASE] call XNetCallEvent;
			} else {
				if (_winner == 1) then {
					["d_sm_p_pos", position EFLAG_BASE] call XNetCallEvent;
				} else {
					["d_sm_p_pos", position WFLAG_BASE] call XNetCallEvent;
				}
			};
		};
		if (_winner != 0) then {
			d_side_mission_winner = _winner;
		} else {
			d_side_mission_winner = 2;
		};
		sleep 2.123;
		if (alive _pilot1) then {
			if (vehicle _pilot1 != _pilot1) then {
				_pilot1 action ["eject", vehicle _pilot1];
				unassignVehicle _pilot1;
				_pilot1 setPos [0,0,0];
			};
		};
		if (alive _pilot2) then {
			if (vehicle _pilot2 != _pilot2) then {
				_pilot1 action ["eject", vehicle _pilot2];
				unassignVehicle _pilot2;
				_pilot2 setPos [0,0,0];
			};
		};
		sleep 0.5;
		deleteVehicle _pilot1;
		deleteVehicle _pilot2;
	};
};

d_side_mission_resolved = true;