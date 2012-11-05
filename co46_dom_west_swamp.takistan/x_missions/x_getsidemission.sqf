// by Xeno
#include "x_setup.sqf"
private ["_ffolder", "_mfolder"];
if (!isServer) exitWith{};

if (__XJIPGetVar(all_sm_res)) exitWith {};

if (d_current_mission_counter == number_side_missions) exitWith {
	["all_sm_res",true] call XNetSetJIP;
	["all_sm_res"] call XNetCallEvent;
	#ifndef __TT__
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"AllSMissionsResolved",true];
	#else
	d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","AllSMissionsResolved",true];
	d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","AllSMissionsResolved",true];
	#endif
};

if (d_SidemissionsOnly == 1) then {
	while {!d_main_target_ready} do {sleep 2.321};
};

_current_mission_index = d_side_missions_random select d_current_mission_counter;
d_current_mission_counter = d_current_mission_counter + 1;

extra_mission_remover_array = [];
extra_mission_vehicle_remover_array = [];

//_current_mission_index = _this select 0;
//_current_mission_index = 25;

_ffolder = if (__OAVer) then {"moa"} else {"m"};
#ifdef __EVERON__
_ffolder = "mev";
#endif

_mfolder = "x_missions\" + _ffolder + "\%2%1.sqf";

execVM (format [_mfolder, _current_mission_index, d_mission_filename]);

sleep 7.012;
["current_mission_index",_current_mission_index] call XNetSetJIP;
["d_up_m"] call XNetCallEvent;
#ifndef __TT__
d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"NewMission",true];
#else
d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","NewMission",true];
d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","NewMission",true];
#endif
d_side_mission_resolved = false;
d_side_mission_winner = 0;