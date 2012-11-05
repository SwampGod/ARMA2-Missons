// by Xeno
#include "x_setup.sqf"

#define __getPos \
_poss = [_target_array2 select 0, _target_array2 select 2] call XfGetRanPointCircleBig;\
if (isOnRoad _poss) then {_poss = []};\
while {count _poss == 0} do {\
	_poss = [_target_array2 select 0, _target_array2 select 2] call XfGetRanPointCircleBig;\
	if (isOnRoad _poss) then {_poss = []};\
	sleep 0.01;\
}

#define __specops \
__GetEGrp(_newgroup)\
_unit_array = [#specops, d_enemy_side] call x_getunitliste;\
[_poss, (_unit_array select 0), _newgroup,true] spawn x_makemgroup;\
sleep 1.0112;\
_newgroup allowFleeing 0;\
[_newgroup, _poss] spawn BI_fnc_taskDefend

private ["_poss", "_newgroup", "_vehicle", "_mtmhandle", "_dummy", "_act2", "_nrcamps", "_i", "_wf", "_flagPole"];
if (!isServer) exitWith {};

_wp_array = _this select 0;

sleep 3.120;

_mtmhandle = _wp_array execVM "x_mtmissions\x_getmtmission.sqf";

waitUntil {scriptDone _mtmhandle};

sleep 5.0123;

__TargetInfo

__getPos;
#ifdef __OA__
_vehicle = createVehicle ["Land_Ind_IlluminantTower", _poss, [], 0, "NONE"];
#else
_vehicle = createVehicle ["Land_telek1", _poss, [], 0, "NONE"];
#endif
_vehicle setVectorUp [0,0,1];
[_vehicle] spawn XCheckMTHardTarget;
["d_mt_radio_down",false] call XNetSetJIP;
["mt_radio_pos",_poss] call XNetSetJIP;
["main_target_radiotower", _poss,"ICON","ColorBlack",[0.5,0.5],"Radiotower",0,"mil_dot"] call XfCreateMarkerGlobal;
#ifndef __TT__
d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTRadioTower",true];
#else
d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","MTRadioTower",true];
d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","MTRadioTower",true];
#endif
sleep 1.0112;
__specops;

sleep 5.234;
_dummy = d_target_names select __XJIPGetVar(current_target_index);
_current_target_pos = _dummy select 0;
_current_target_radius = _dummy select 2;
_act2 = d_enemy_side + " D";
#ifndef __TT__
d_f_check_trigger = [_current_target_pos, [_current_target_radius + 300, _current_target_radius + 300, 0, false], [d_own_side_trigger, _act2, false], ["this", "xhandle = [] spawn {if (!d_create_new_paras) then {d_create_new_paras = true;[] execFSM 'fsms\Parahandler.fsm'};d_mt_spotted = true;d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,'MTSightedByEnemy',true];sleep 5;deleteVehicle d_f_check_trigger}", ""]] call XfCreateTrigger;
#else
d_f_check_trigger2 = objNull;
d_f_check_trigger = [_current_target_pos, [_current_target_radius + 300, _current_target_radius + 300, 0, false], ["WEST", _act2, false], ["this", "xhandle = [] spawn {if (!d_create_new_paras) then {d_create_new_paras = true;[] execFSM 'fsms\Parahandler.fsm'};d_mt_spotted = true;d_hq_logic_en1 kbTell [d_hq_logic_en2,'HQ_W','MTSightedByEnemy',true];d_hq_logic_ru1 kbTell [d_hq_logic_ru2,'HQ_E','MTSightedByEnemy',true];sleep 5;deleteVehicle d_f_check_trigger;if (!isNull d_f_check_trigger2) then {deleteVehicle d_f_check_trigger2}}", ""]] call XfCreateTrigger;
d_f_check_trigger2 = [_current_target_pos, [_current_target_radius + 300, _current_target_radius + 300, 0, false], ["EAST", _act2, false], ["this", "xhandle = [] spawn {if (!d_create_new_paras) then {d_create_new_paras = true;[] execFSM 'fsms\Parahandler.fsm'};d_mt_spotted = true;d_hq_logic_en1 kbTell [d_hq_logic_en2,'HQ_W','MTSightedByEnemy',true];d_hq_logic_ru1 kbTell [d_hq_logic_ru2,'HQ_E','MTSightedByEnemy',true];sleep 5;deleteVehicle d_f_check_trigger2;if (!isNull d_f_check_trigger) then {deleteVehicle d_f_check_trigger}}", ""]] call XfCreateTrigger;
#endif

sleep 5.234;
_d_currentcamps = [];
_nrcamps = ceil random 4;
if (_nrcamps == 1) then {_nrcamps = 2};
_ctype =
#ifndef __OA__
	"WarfareBCamp";
#else
	"Land_fortified_nest_big_EP1";
#endif
for "_i" from 1 to _nrcamps do {
	__getPos;
	_wf = createVehicle [_ctype, _poss, [], 0, "NONE"];
	_wf setDir floor random 360;
	_svec = sizeOf _ctype;
	_isFlat = (position _wf) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _wf];
	if (count _isFlat > 0) then {
		_poss = _isFlat;
	};
	_wf setPos _poss;
	_d_currentcamps set [count _d_currentcamps, _wf];
	_wf setVariable ["D_SIDE", d_enemy_side, true];
	_wf setVariable ["D_INDEX", _i, true];
	_wf setVariable ["D_CAPTIME", 40 + (floor random 10), true];
	_wf setVariable ["D_CURCAPTIME", 0, true];
#ifndef __TT__
	_wf setVariable ["D_CURCAPTURER", d_own_side_trigger];
#else
	_wf setVariable ["D_CURCAPTURER", ""];
#endif
	_flagPole = createVehicle [(call XfGetEnemyFlagType), position _wf, [], 0, "NONE"];
	_flagPole setPos (position _wf);
	_wf setVariable ["D_FLAG", _flagPole];
	[format["dcamp%1",_i], _poss,"ICON","ColorBlack",[0.5,0.5],"",0,"Strongpoint"] call XfCreateMarkerGlobal;
	
	_wf addEventHandler ["HandleDamage", {false}];
	#ifndef __TT__
	[_wf, _flagPole] execFSM "fsms\HandleCamps.fsm";
	#else
	[_wf, _flagPole] execFSM "fsms\HandleCampsTT.fsm";
	#endif
	sleep 0.5;
};
["d_currentcamps",_d_currentcamps] call XNetSetJIP;
__XJIPSetVar ["d_numcamps", _nrcamps];
#ifndef __TT__
d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"CampAnnounce",["1","",str(_nrcamps),[]],true];
#else
d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","CampAnnounce",["1","",str(_nrcamps),[]],true];
d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","CampAnnounce",["1","",str(_nrcamps),[]],true];
#endif

sleep 5.213;
d_main_target_ready = true;