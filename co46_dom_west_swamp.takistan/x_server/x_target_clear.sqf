// by Xeno
#include "x_setup.sqf"
private ["_current_target_pos","_dummy","_ran","_start_real"];
if (!isServer) exitWith{};

sleep 1.123;

if (!isNull d_f_check_trigger) then {deleteVehicle d_f_check_trigger};
#ifdef __TT__
if (!isNull d_f_check_trigger2) then {deleteVehicle d_f_check_trigger2};
#endif
deleteVehicle d_current_trigger;
sleep 0.01;

#ifndef __TT__
d_counterattack = false;
_start_real = false;
_ran = random 100;
if (_ran > 96) then {
	d_counterattack = true;
	_start_real = true;
	__TargetInfo
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"CounterattackEnemy",["1","",_current_target_name,[]],true];
	execVM "x_server\x_counterattack.sqf";
};

while {d_counterattack} do {sleep 3.123};

if (_start_real) then {
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"CounterattackDefeated",true];
	sleep 2.321;
};
#endif

d_old_target_pos =+ ((d_target_names select __XJIPGetVar(current_target_index)) select 0);
d_old_radius = [(d_target_names select __XJIPGetVar(current_target_index)) select 2];

#ifndef __TT__
_resolved_targets = __XJIPGetVar(resolved_targets);
_resolved_targets set [count _resolved_targets, __XJIPGetVar(current_target_index)];
["resolved_targets",_resolved_targets] call XNetSetJIP;
#endif

#ifdef __TT__
if (d_kill_points_west > d_kill_points_east) then {
	d_mt_winner = 1;
	d_points_west = d_points_west + (d_tt_points select 0);
} else {
	if (d_kill_points_east > d_kill_points_west) then {
		d_mt_winner = 2;
		d_points_east = d_points_east + (d_tt_points select 0);
	} else {
		if (d_kill_points_east == d_kill_points_west) then {
			d_mt_winner = 3;
			d_points_west = d_points_west + (d_tt_points select 1);
			d_points_east = d_points_east + (d_tt_points select 1);
		};
	};
};
["points_array",[d_points_west,d_points_east,d_kill_points_west,d_kill_points_east]] call XNetSetJIP;
_resolved_targets = __XJIPGetVar(resolved_targets);
_resolved_targets set [count _resolved_targets, [__XJIPGetVar(current_target_index),d_mt_winner]];
["resolved_targets",_resolved_targets] call XNetSetJIP;
["mt_winner", d_mt_winner] call XNetCallEvent;

sleep 0.5;
d_public_points = false;
#endif

if (!isNull d_intel_unit) then {
	deleteVehicle d_intel_unit;
	d_intel_unit = objNull;
};

sleep 0.5;

if (d_current_counter < d_MainTargets) then {
	execVM "x_server\x_gettargetbonus.sqf";
} else {
	__TargetInfo
	["target_clear",true] call XNetSetJIP;
	["target_clear", -1] call XNetCallEvent;
	_tname = _current_target_name call XfKBUseName;
#ifndef __TT__
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"Captured2",["1","",_current_target_name,[_tname]],true];
#else
	d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","Captured2",["1","",_current_target_name,[_tname]],true];
	d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","Captured2",["1","",_current_target_name,[_tname]],true];
#endif
};

sleep 2.123;

__XJIPGetVar(current_target_index) execFSM "fsms\DeleteUnits.fsm";

sleep 4.321;

#ifndef __TT__
if (WithJumpFlags == 1) then {
	if (d_current_counter < d_MainTargets) then {execVM "x_server\x_createjumpflag.sqf"};
};
#endif

d_del_camps_stuff = [];
{
	_flag = _x getVariable "D_FLAG";
	_mar = format ["dcamp%1",_x getVariable "D_INDEX"];
	deleteMarker _mar;
	d_del_camps_stuff set [count d_del_camps_stuff, _x];
	d_del_camps_stuff set [count d_del_camps_stuff, _flag];
} forEach __XJIPGetVar(d_currentcamps);
["d_currentcamps",[]] call XNetSetJIP;
#ifndef __TT__
["d_campscaptured",0] call XNetSetJIP;
#else
["d_campscaptured_w",0] call XNetSetJIP;
["d_campscaptured_e",0] call XNetSetJIP;
#endif

sleep 0.245;

if (d_do_delete_empty_main_target_vecs) then {[d_old_target_pos,d_old_radius] execFSM "fsms\DeleteEmpty.fsm"};

d_run_illum = false;

if (d_current_counter < d_MainTargets) then {
	sleep 15;
#ifdef __TT__
	d_kill_points_west = 0;
	d_kill_points_east = 0;
	d_public_points = true;
#endif
	execVM "x_server\x_createnexttarget.sqf";
} else {
#ifndef __TT__
	if (count d_recapture_indices == 0) then {
#endif
		["the_end",true] call XNetSetJIP;
#ifndef __TT__
	} else {
		[] spawn {
			while {count d_recapture_indices > 0} do {
				sleep 2.543;
			};
			["the_end",true] call XNetSetJIP;
		};
	};
#endif
};