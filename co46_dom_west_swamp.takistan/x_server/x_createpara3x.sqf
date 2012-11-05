// by Xeno
#include "x_setup.sqf"
private ["_type","_startpoint","_attackpoint","_heliendpoint","_number_vehicles","_parachute_type","_make_jump","_stop_it","_current_target_pos","_dummy","_delveccrew"];
if (!isServer) exitWith {};

_startpoint = _this select 0;
_attackpoint = _this select 1;
_heliendpoint = _this select 2;
_number_vehicles = _this select 3;

d_should_be_there = _number_vehicles;

d_c_attacking_grps = [];

_delveccrew = {
	private ["_crew_vec", "_vehicle", "_time"];
	_crew_vec = _this select 0;
	_vehicle = _this select 1;
	_time = _this select 2;
	sleep _time;
	{if (!isNull _x) then {_x setDamage 1}} forEach _crew_vec;
	sleep 1;
	if (!isNull _vehicle && ({isPlayer _x} count (crew _vehicle)) == 0) then {_vehicle setDamage 1};
};

_make_jump = {
	private ["_vgrp", "_vehicle", "_attackpoint", "_heliendpoint", "_driver_vec", "_wp", "_stop_me", "_parachute_type", "_dummy", "_current_target_pos", "_paragrp", "_unit_array", "_real_units", "_i", "_type", "_one_unit", "_para", "_grp_array","_crew_vec","_delveccrew"];
	_vgrp = _this select 0;
	_vehicle = _this select 1;
	_attackpoint = _this select 2;
	_heliendpoint = _this select 3;
	_delveccrew = _this select 4;
	
	_startpos = position _vehicle;
	_driver_vec = driver _vehicle;
	_crew_vec = crew _vehicle;
	
	_wp = _vgrp addWaypoint [_attackpoint, 0];
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointSpeed "NORMAL";
	_wp setwaypointtype "MOVE";
	_wp setWaypointFormation "VEE";
	_wp = _vgrp addWaypoint [_heliendpoint, 0];
	
	_vehicle flyInHeight 100;
	
	sleep 10.0231;
	
	_stop_me = false;
	_checktime = time + 300;
	while {_attackpoint distance (leader _vgrp) > 200} do {
		if (isNull _vehicle || !alive _vehicle || !alive _driver_vec || !canMove _vehicle) exitWith {__DEC(d_should_be_there)};
		sleep 0.01;
		if (__XJIPGetVar(d_mt_radio_down) && (_attackpoint distance (leader _vgrp) > 1300)) exitWith {
			[_crew_vec, _vehicle, 1 + random 1] spawn _delveccrew;
			_stop_me = true;
		};
		sleep 0.01;
		if (time > _checktime) then {
			if (_startpos distance position _vehicle < 500) then {
				__DEC(d_should_be_there);
				[_crew_vec, _vehicle, 1 + random 1] spawn _delveccrew;
				_stop_me = true;
			} else {
				_checktime = time + 9999999;
			};
		};
		if (_stop_me) exitWith {};
		sleep 2.023;
	};
	if (_stop_me) exitWith {};
	
	sleep 0.534;
	
	_parachute_type = d_enemy_side call XfGetParachuteSide;
	
	if (!isNull _vehicle && alive _vehicle && alive _driver_vec && canMove _vehicle) then {
		_dummy = d_target_names select __XJIPGetVar(current_target_index);
		_current_target_pos = _dummy select 0;
		if (!__XJIPGetVar(d_mt_radio_down) && (_vehicle distance _current_target_pos < 500)) then {
			_cur_radius = _dummy select 2;
			__GetEGrp(_paragrp)
			_unit_array = ["heli", d_enemy_side] call x_getunitliste;
			_real_units = _unit_array select 0;
			_unit_array = nil;
			sleep 0.1;
			for "_i" from 0 to (count _real_units - 1) do {
				_type = _real_units select _i;
				_one_unit = _paragrp createunit [_type, [10,10,0], [], 300,"NONE"];
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
				
				_para = createVehicle [_parachute_type, position _vehicle, [], 20, 'NONE'];
				_para setpos [(position _vehicle) select 0,(position _vehicle) select 1,((position _vehicle) select 2)- 10];
				_para setDir random 360;
				_one_unit moveInDriver _para;
				sleep 0.551;
			};
			_paragrp allowFleeing 0;
			_paragrp setCombatMode "YELLOW";
			_paragrp setBehaviour "AWARE";
			
			[_paragrp, _current_target_pos, _cur_radius] spawn {
				_grp = _this select 0;
				_pos = _this select 1;
				_rad = _this select 2;
				sleep 20;
				if ((_grp call XfGetAliveUnitsGrp) > 0) then {
					[_grp, _pos, [_pos, _rad], [10, 20, 50]] spawn XMakePatrolWPX;
					_grp setVariable ["D_PATR",true];
				};
			};
			
			d_c_attacking_grps set [count d_c_attacking_grps, _paragrp];
			
			sleep 0.112;
			__DEC(d_should_be_there);
			
			while {(_heliendpoint distance (leader _vgrp) > 300)} do {
				if (isNull _vehicle || !alive _vehicle || !alive _driver_vec || !canMove _vehicle) exitWith {};
				sleep 5.123;
			};
			
			if (!isNull _vehicle && (_heliendpoint distance _vehicle) > 300) then {
				[_crew_vec, _vehicle, 240 + random 100] spawn _delveccrew;
			} else {
				_vehicle call XfDelVecAndCrew;
			};
			if (!isNull _driver_vec) then {_driver_vec setDamage 1.1};
		};
	} else {
		[_crew_vec, _vehicle, 240 + random 100] spawn _delveccrew;
	};
};

_dummy = d_target_names select __XJIPGetVar(current_target_index);
_current_target_pos = _dummy select 0;
_stop_it = false;

#ifndef __TT__
if ((__XJIPGetVar(d_searchintel) select 1) == 1) then {
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TellAirDropAttack"];
};
#endif

for "_i" from 1 to _number_vehicles do {
	if (__XJIPGetVar(d_mt_radio_down)) exitWith {_stop_it = true};
	_dummy = d_target_names select __XJIPGetVar(current_target_index);
	_new_current_target_pos = _dummy select 0;
	if (_new_current_target_pos distance _current_target_pos > 500) exitWith {_stop_it = true};
	__GetEGrp(_vgrp)
	_heli_type = d_transport_chopper call XfRandomArrayVal;
	_spos = [_startpoint select 0, _startpoint select 1, 300];
	_cdir = [_spos, _attackpoint] call XfDirTo;
	_veca = [_spos, _cdir, _heli_type, _vgrp] call X_fnc_spawnVehicle;
	_vehicle = _veca select 0;
	if (!(_heli_type in x_heli_wreck_lift_types)) then {__addDead(_vehicle)};
#ifdef __TT__
	_vehicle addEventHandler ["killed", {[8,_this select 1] call XAddKills}];
#else
	if (!d_banti_airdown) then {_vehicle spawn XfAirMarkerMove};
#endif
	if (d_with_ai) then {
		if (__RankedVer) then {_vehicle addEventHandler ["killed", {[8,_this select 1] call XAddKillsAI}]};
	};
	if (d_LockAir == 0) then {_vehicle lock true};
	sleep 5.012;
	
	_vehicle flyInHeight 100;

	if (__XJIPGetVar(d_mt_radio_down)) exitWith {_stop_it = true};
	
	[_vgrp,_vehicle,_attackpoint,_heliendpoint, _delveccrew] spawn _make_jump;
	
	sleep 40 + random 30;
};

if (_stop_it) exitWith {};

while {d_should_be_there > 0 && !__XJIPGetVar(d_mt_radio_down)} do {sleep 1.021};

if (!__XJIPGetVar(d_mt_radio_down)) then {
	sleep 20.0123;
	if (count d_c_attacking_grps > 0) then {
		[d_c_attacking_grps] execVM "x_server\x_handleattackgroups.sqf";
	} else {
		d_c_attacking_grps = [];
		d_create_new_paras = true;
	};
};