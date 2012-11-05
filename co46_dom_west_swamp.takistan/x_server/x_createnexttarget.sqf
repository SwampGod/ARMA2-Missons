#include "x_setup.sqf"
private ["_current_target_pos","_current_target_radius","_dummy","_emptyH","_current_target_name"];
if (!isServer) exitWith{};

["current_target_index",d_maintargets_list select d_current_counter] call XNetSetJIP;
__INC(d_current_counter);

sleep 1.0123;
if (d_first_time_after_start) then {
	d_first_time_after_start = false;
	sleep 18.123;
};

d_update_target=false;
d_main_target_ready = false;
d_side_main_done = false;

__XJIPSetVar ["d_numcamps", -91];

_dummy = d_target_names select __XJIPGetVar(current_target_index);
_current_target_pos = _dummy select 0;
_current_target_name = _dummy select 1;
_current_target_radius = _dummy select 2;

_tname = _current_target_name call XfKBUseName;
#ifndef __TT__
_tsar = if (WithLessArmor == 0) then {
	["(""Man"" countType thislist >= d_man_count_for_target_clear) && (""Tank"" countType thislist >= d_tank_count_for_target_clear) && (""Car"" countType thislist  >= d_car_count_for_target_clear)", "X_JIPH setVariable ['target_clear',false,true];d_update_target=true;['update_target'] call XNetCallEvent;d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,'Attack',['1','','" + _current_target_name + "',['" + _tname + "']],true];deleteVehicle d_check_trigger", ""]
} else {
	["(""Man"" countType thislist >= d_man_count_for_target_clear)", "X_JIPH setVariable ['target_clear',false,true];d_update_target=true;['update_target'] call XNetCallEvent;d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,'Attack',['1','','" + _current_target_name + "',['" + _tname + "']],true];deleteVehicle d_check_trigger;", ""]
};
#else
_tsar = if (WithLessArmor == 0) then {
	["(""Man"" countType thislist >= d_man_count_for_target_clear) && (""Tank"" countType thislist >= d_tank_count_for_target_clear) && (""Car"" countType thislist  >= d_car_count_for_target_clear)", "X_JIPH setVariable ['target_clear',false,true];d_update_target=true;['update_target'] call XNetCallEvent;d_hq_logic_en1 kbTell [d_hq_logic_en2,'HQ_W','Attack',['1','','" + _current_target_name + "',['" + _tname + "']],true];d_hq_logic_ru1 kbTell [d_hq_logic_ru2,'HQ_E','Attack',['1','','" + _current_target_name + "',['" + _tname + "']],true];deleteVehicle d_check_trigger", ""]
} else {
	["(""Man"" countType thislist >= d_man_count_for_target_clear)", "X_JIPH setVariable ['target_clear',false,true];d_update_target=true;['update_target'] call XNetCallEvent;d_hq_logic_en1 kbTell [d_hq_logic_en2,'HQ_W','Attack',['1','','" + _current_target_name + "',['" + _tname + "']],true];d_hq_logic_ru1 kbTell [d_hq_logic_ru2,'HQ_E','Attack',['1','','" + _current_target_name + "',['" + _tname + "']],true];deleteVehicle d_check_trigger;", ""]
};
#endif
d_check_trigger = [_current_target_pos, [_current_target_radius + 20, _current_target_radius + 20, 0, false], [d_enemy_side, "PRESENT", false], _tsar] call XfCreateTrigger;

[_current_target_pos, _current_target_radius] execVM "x_server\x_createmaintarget.sqf";

while {!d_update_target} do {sleep 2.123};

#ifndef __TT__
_tsar = ["(X_JIPH getVariable 'd_mt_radio_down') && d_side_main_done && (X_JIPH getVariable 'd_campscaptured') == (X_JIPH getVariable 'd_numcamps') && (""Car"" countType thislist <= d_car_count_for_target_clear) && (""Tank"" countType thislist <= d_tank_count_for_target_clear) && (""Man"" countType thislist <= d_man_count_for_target_clear)", "xhandle = [] execVM ""x_server\x_target_clear.sqf""", ""];
#else
_tsar = ["(X_JIPH getVariable 'd_mt_radio_down') && d_side_main_done && ((X_JIPH getVariable 'd_campscaptured_e') == (X_JIPH getVariable 'd_numcamps') || (X_JIPH getVariable 'd_campscaptured_w') == (X_JIPH getVariable 'd_numcamps')) && (""Car"" countType thislist <= d_car_count_for_target_clear) && (""Tank"" countType thislist <= d_tank_count_for_target_clear) && (""Man"" countType thislist <= d_man_count_for_target_clear)", "xhandle = [] execVM ""x_server\x_target_clear.sqf""", ""];
#endif
d_current_trigger = [_current_target_pos, [_current_target_radius  + 50, _current_target_radius + 50, 0, false],[d_enemy_side, "PRESENT", false], _tsar] call XfCreateTrigger;

#ifndef __TT__
_emptyH = createVehicle ["HeliHEmpty", _current_target_pos, [], 0, "NONE"];
_emptyH setPos _current_target_pos;
// dir 0 = normal, not recaptured
// dir > 350 = recaptured by enemy
_emptyH setDir 0;
#endif