#include "x_setup.sqf"
private ["_current_target_name","_current_target_pos","_marker","_t_array","_current_target_radius"];
if (!X_Client) exitWith{};

sleep 1.012;
_t_array = d_target_names select __XJIPGetVar(current_target_index);
_current_target_pos = _t_array select 0;
_current_target_name = _t_array select 1;
_current_target_radius = _t_array select 2;

#ifndef __TT__
[_current_target_name, _current_target_pos,"ELLIPSE","ColorRed",[_current_target_radius,_current_target_radius]] call XfCreateMarkerLocal;
#else
[_current_target_name, _current_target_pos,"ELLIPSE","ColorYellow",[_current_target_radius,_current_target_radius]] call XfCreateMarkerLocal;
#endif
"dummy_marker" setMarkerPosLocal _current_target_pos;

if (!isNil "task1") then {task1 setTaskState "Succeeded"};

if (d_current_seize != _current_target_name) then {
	call compile format ["
		task%1 = player createSimpleTask ['obj%1'];
		task%1 setSimpleTaskDescription ['Seize %2...','Main Target: Seize %2','Main Target: Seize %2'];
		task%1 setTaskState 'Created';
		task%1 setSimpleTaskDestination _current_target_pos;
		d_current_task = task%1;
	", __XJIPGetVar(current_target_index) + 2,_current_target_name];
};

playSound "IncomingChallenge";
[d_current_task, "CREATED"] spawn XTaskHint;

hint format ["Next target is: %1", _current_target_name];
