// by Xeno
#include "x_setup.sqf"
#define __exitchop if (isNull _chopper || !alive _chopper || !canMove _chopper || !alive driver _chopper) exitWith {[_crew_vec, _chopper,240 + random 100] spawn _delveccrew}
private ["_assigned","_helifirstpoint","_chopper","_paragrp","_pos_end","_u","_unit_array","_vgrp","_wp","_xx","_heliendpoint","_wp2","_attack_pos","_del_me","_delveccrew","_crew_vec"];
if (!isServer) exitWith {};

_vgrp = _this select 0;
_chopper = _this select 1;
_helifirstpoint = _this select 2;
_heliendpoint = _this select 3;
_crew_vec = crew _chopper;

sleep 2.123;

_wp = _vgrp addWaypoint [_helifirstpoint, 30];
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointSpeed "NORMAL";
_wp setwaypointtype "MOVE";
_wp setWaypointFormation "WEDGE";

_wp2 = _vgrp addWaypoint [_heliendpoint, 0];
_wp2 setwaypointtype "MOVE";
_wp2 setWaypointBehaviour "CARELESS";
_wp2 setWaypointSpeed "NORMAL";
_wp2 setwaypointtype "MOVE";

_chopper flyinheight 100;

#ifndef __TT__
if (!d_banti_airdown) then {_chopper spawn XfAirMarkerMove};
if ((__XJIPGetVar(d_searchintel) select 0) == 1) then {
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TellInfiltrateAttack"];
};
#endif

_parachute_type = d_enemy_side call XfGetParachuteSide;

_delveccrew = {
	private ["_crew_vec","_vehicle","_time"];
	_crew_vec = _this select 0;
	_vehicle = _this select 1;
	_time = _this select 2;
	sleep _time;
	{if (!isNull _x) then {_x setDamage 1.1}} forEach _crew_vec;
	sleep 1;
	if (!isNull _vehicle && ({isPlayer _x} count (crew _vehicle)) == 0) then {_vehicle setDamage 1};
};

while {_helifirstpoint distance (leader _vgrp) > 150} do {
	__exitchop;
	sleep 2.123;
};

if (alive _chopper && !isNull _chopper && canMove _chopper && alive driver _chopper) then {
	__GetEGrp(_paragrp)
	_unit_array = ["sabotage", d_enemy_side] call x_getunitliste;
	_real_units = _unit_array select 0;
	_unit_array = nil;
	sleep 0.1;
	for "_i" from 0 to (count _real_units - 1) do {
		_type = _real_units select _i;
		_one_unit = _paragrp createunit [_type, [0,0,0], [], 300,"NONE"];
		_one_unit setVariable ["BIS_noCoreConversations", true];
		__addDead(_one_unit)
		#ifndef __ACE__
		if (d_smoke) then {[_one_unit, _paragrp] call XfDoSmokeAddCheck};
		#endif
		#ifdef __TT__
		_one_unit addEventHandler ["killed", {[1,_this select 1] call XAddKills}];
		#endif
		if (d_with_ai) then {
			if (__RankedVer) then {_one_unit addEventHandler ["killed", {[1,_this select 1] call XAddKillsAI}]};
		};
		_one_unit setSkill ((d_skill_array select 0) + (random (d_skill_array select 1)));
		
		_para = createVehicle [_parachute_type, position _chopper, [], 20, 'NONE'];
		_para setpos [(position _chopper) select 0,(position _chopper) select 1,((position _chopper) select 2)- 10];
		_para setDir random 360;
		_one_unit moveInDriver _para;
		sleep 0.551;
	};
	_paragrp allowFleeing 0;
	_paragrp setCombatMode "YELLOW";
	_paragrp setBehaviour "AWARE";
	
	sleep 0.113;
	_paragrp spawn {
		private "_grp";
		_grp = _this;
		sleep 20;
		if ((_grp call XfGetAliveUnitsGrp) > 0) then {
			[_grp, d_base_array select 0, [d_base_array select 0,d_base_array select 1,d_base_array select 2,d_base_array select 3]] spawn XMakePatrolWPX;
			_grp setVariable ["D_PATR",true];
		};
	};
	sleep 0.112;
	[_paragrp, _attack_pos] execVM "x_server\x_sabotage.sqf";
};

__exitchop;

while {(_heliendpoint distance (leader _vgrp) > 300)} do {
	__exitchop;
	sleep 5.123;
};

if (!isNull _chopper) then {_chopper call XfDelVecAndCrew};