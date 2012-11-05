// by Xeno
#include "x_setup.sqf"

d_misc_stores = "HeliHEmpty" createVehicleLocal [0,0,0];

XfStoreAdd = {d_misc_stores setVariable [_this select 0, _this select 1]};
XfStoreGet = {d_misc_stores getVariable _this};

#ifdef __TT__
#define __addpw(wpoints) d_points_west = d_points_west + wpoints
#define __addpe(epoints) d_points_east = d_points_east + epoints

XAddKills = {private ["_points","_killer"];_points = _this select 0;_killer = _this select 1;switch (side _killer) do {case west: {__addkpw(_points)};case east: {__addkpe(_points)}}};
XAddPoints = {private ["_points","_killer"];_points = _this select 0;_killer = _this select 1;switch (side _killer) do {case west: {__addpw(_points)};case east: {__addpe(_points)}}};
#endif

if (d_with_ai) then {
	if (__RankedVer) then {
		XAddKillsAI = {
			private ["_points","_killer"];
			_points = _this select 0;_killer = _this select 1;
			if (!isPlayer _killer && side _killer != d_side_enemy) then {["d_ai_kill", [_killer,_points]] call XNetCallEvent}
		};
	};
};

["EAST", east] call XfStoreAdd;
["WEST", west] call XfStoreAdd;
["GUER", resistance] call XfStoreAdd;
["CIV", civilian] call XfStoreAdd;

x_creategroup = {
	private ["_found_empty","_grp","_i","_side","_side_str","_this","_tmp_grp","_tmp_grp_a","_tmp_time","_x"];
	_side = _this select 0;
	_side_str = if (typeName _side == "STRING") then {_side call XfStoreGet} else {_side};
	_grp = createGroup _side_str;
	_grp setVariable ["X_CREATED", time + 120];
	_grp
};

x_getwparray = {
	private["_tc", "_radius","_wp_a","_point"];
	_tc = _this select 0;_radius = _this select 1;_wp_a = [];_wp_a resize 100;
	for "_i" from 0 to 99 do {
		_point = [_tc, _radius] call XfGetRanPointCircle;
		if (count _point == 0) then {
			for "_e" from 0 to 99 do {_point = [_pos_center, _radius] call XfGetRanPointCircle;if (count _point > 0) exitWith {}};
		};
		_wp_a set [_i, _point];
	};
	_wp_a
};

x_getwparray2 = {
	private["_tc", "_radius","_wp_a","_point"];
	_tc = _this select 0;_radius = _this select 1;_wp_a = [];_wp_a resize 100;
	for "_i" from 0 to 99 do {
		_point = [_tc, _radius] call XfGetRanPointCircleOuter;
		if (count _point == 0) then {
			for "_e" from 0 to 99 do {_point = [_tc, _radius] call XfGetRanPointCircleOuter;if (count _point > 0) exitWith {}};
		};
		_wp_a set [_i, _point];
	};
	_wp_a
};

x_getwparray3 = {
	private ["_pos","_a","_b","_angle","_wp_a","_point"];
	_pos = _this select 0;_a = _this select 1;_b = _this select 2;_angle = _this select 3;_wp_a = [];_wp_a resize 100;
	for "_i" from 0 to 99 do {
		_point = [_pos, _a, _b, _angle] call XfGetRanPointSquare;
		if (count _point == 0) then {
			for "_e" from 0 to 99 do {_point = [_pos, _a, _b, _angle] call XfGetRanPointSquare;if (count _point > 0) exitWith {}};
		};
		_wp_a set [_i, _point];
	};
	_wp_a
};

x_getunitliste = {
	private ["_grptype","_how_many","_list","_one_man","_random","_side","_side_char","_unitliste","_vehiclename","_varray"];
	_grptype = _this select 0;_side = _this select 1;_unitliste = [];_vehiclename = "";_varray = [];
	_side_char = if (typeName _side == "STRING") then {
		switch (_side) do {case "EAST": {"E"};case "WEST": {"W"};case "GUER": {"G"};case "CIV": {"W"};}
	} else {
		switch (_side) do {case east: {"E"};case west: {"W"};case resistance: {"G"};case civilian: {"W"};}
	};
	switch (_grptype) do {
		case "basic": {_list = missionNamespace getVariable format ["d_allmen_%1",_side_char];_unitliste = _list call XfRandomArrayVal};
		case "specops": {_how_many = ceil random 5; if (_how_many < 2) then {_how_many = 2};_list = missionNamespace getVariable format ["d_specops_%1",_side_char];_unitliste resize _how_many;for "_i" from 0 to _how_many - 1 do {_unitliste set [_i, _list call XfRandomArrayVal]}};
		case "artiobserver": {_unitliste = [missionNamespace getVariable format["d_arti_observer_%1",_side_char]]};
		case "heli": {_list = missionNamespace getVariable format ["d_allmen_%1",_side_char];_unitliste = _list call XfRandomArrayVal};
		case "tank": {_varray = (missionNamespace getVariable format ["d_veh_a_%1", _side_char]) select 0;_vehiclename = _varray call XfRandomArrayVal};
		case "bmp": {_varray = (missionNamespace getVariable format ["d_veh_a_%1", _side_char]) select 1;_vehiclename = _varray call XfRandomArrayVal};
		case "brdm": {_varray = (missionNamespace getVariable format ["d_veh_a_%1", _side_char]) select 2;_vehiclename = _varray call XfRandomArrayVal};
		case "shilka": {_varray = (missionNamespace getVariable format ["d_veh_a_%1", _side_char]) select 3;_vehiclename = _varray call XfRandomArrayVal};
		case "uaz_mg": {_varray = (missionNamespace getVariable format ["d_veh_a_%1", _side_char]) select 4;_vehiclename = _varray call XfRandomArrayVal};
		case "uaz_grenade": {_varray = (missionNamespace getVariable format ["d_veh_a_%1", _side_char]) select 5;_vehiclename = _varray call XfRandomArrayVal};
		case "DSHKM": {_varray = (missionNamespace getVariable format ["d_veh_a_%1", _side_char]) select 6;_vehiclename = _varray call XfRandomArrayVal};
		case "AGS": {_varray = (missionNamespace getVariable format ["d_veh_a_%1", _side_char]) select 7;_vehiclename = _varray call XfRandomArrayVal};
		case "D30": {_varray = (missionNamespace getVariable format ["d_veh_a_%1", _side_char]) select 8;_vehiclename = _varray call XfRandomArrayVal};
		case "uralfuel": {_varray = (missionNamespace getVariable format ["d_veh_a_%1", _side_char]) select 9;_vehiclename = _varray call XfRandomArrayVal};
		case "uralrep": {_varray = (missionNamespace getVariable format ["d_veh_a_%1", _side_char]) select 10;_vehiclename = _varray call XfRandomArrayVal};
		case "uralammo": {_varray = (missionNamespace getVariable format ["d_veh_a_%1", _side_char]) select 11;_vehiclename = _varray call XfRandomArrayVal};
		case "civilian": {_unitliste resize 12; for "_i" from 0 to 11 do {_one_man = d_civilians_t call XfRandomArrayVal;_unitliste set [_i,_one_man]}};
		case "sabotage": {_how_many = ceil random 12; if (_how_many < 6) then {_how_many = 6};_list = missionNamespace getVariable format ["d_sabotage_%1",_side_char];_unitliste resize _how_many; for "_i" from 0 to _how_many - 1 do {_unitliste set [_i, _list call XfRandomArrayVal]}};
	};
	[_unitliste, _vehiclename]
};

x_getmixedliste = {
	private ["_side", "_ret_list", "_list"];
	_side = _this select 0;
	_ret_list = [];
	{
		_list = [_x,_side] call x_getunitliste;
		_ret_list set [count _ret_list, [_list select 1, _list select 2]];
	} forEach [switch (floor random 2) do {case 0: {"brdm"};case 1: {"uaz_mg"};}, "bmp", "tank", "shilka"];
	_ret_list
};

x_makevgroup = {
	private ["_numbervehicles", "_pos", "_vehiclename", "_grp", "_radius", "_direction", "_crews", "_grpskill", "_n", "_dir", "_vehicle", "_npos"];
	_numbervehicles = _this select 0;
	_pos = _this select 1;
	_vehiclename = _this select 2;
	_grp = _this select 3;
	_radius = _this select 4;
	_direction = _this select 5;
	_do_points = if (count _this > 6) then {true} else {false};
	_the_vehicles = [];
	_crews = [];
	_npos = _pos;
	
	_grpskill = if (_vehiclename isKindOf "StaticWeapon") then {1.0} else {(d_skill_array select 0) + (random (d_skill_array select 1))};
	
	_the_vehicles resize _numbervehicles;
	for "_n" from 0 to _numbervehicles - 1 do {
		_dir = if (_direction != -1.111) then {_direction} else {floor random 360};
		
		_vec_array = [_npos, _dir, _vehiclename, _grp] call X_fnc_spawnVehicle;
		_vehicle = _vec_array select 0;
		_crews = [_crews, (_vec_array select 1)] call X_fnc_arrayPushStack;
		
		_the_vehicles set [_n, _vehicle];
		_npos = _vehicle modelToWorld [0,-12,0];
		
		switch (true) do {
			case (_vehicle isKindOf "Tank"): {
				if (!(_vehiclename in x_heli_wreck_lift_types)) then {
					__addRemoveVehi(_vehicle)
					__addDead(_vehicle)
				};
				if (d_LockArmored == 0) then {_vehicle lock true};
			};
			case (_vehicle isKindOf "Car"): {
				if (!(_vehiclename in x_heli_wreck_lift_types)) then {
					__addRemoveVehi(_vehicle)
					__addDead(_vehicle)
				};
				if (d_LockCars == 0) then {_vehicle lock true};
			};
			default {
				if (!(_vehiclename in x_heli_wreck_lift_types)) then {
					__addDead(_vehicle)
				};
				if (_vehicle isKindOf "Air") then {if (d_LockAir == 0) then {_vehicle lock true}};
			};
		};
		#ifdef __TT__
		if (_do_points) then {_vehicle addEventHandler ["killed", {[3,_this select 1] call XAddKills}]};
		#endif
		if (d_with_ai) then {if (__RankedVer) then {_vehicle addEventHandler ["killed", {[5,_this select 1] call XAddKillsAI}]}};
	};
	(leader _grp) setSkill _grpskill;
	[_the_vehicles, _crews]
};

x_makemgroup = {
	private ["_pos", "_unitliste", "_grp", "_ret"];
	_pos = _this select 0;_unitliste = _this select 1;_grp = _this select 2;_do_points = (if (count _this > 3) then {true} else {false});_ret = [];
	{
		_one_unit = _grp createunit [_x, _pos, [], 10,"NONE"];
		_svec = sizeOf _x;
		_isFlat = (position _one_unit) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _one_unit];
		if (count _isFlat > 0) then {
			_one_unit setPos _isFlat;
		};
		_one_unit setVariable ["BIS_noCoreConversations", true];
		__addDead(_one_unit)
		#ifdef __TT__
		if (_do_points) then {_one_unit addEventHandler ["killed", {[1,_this select 1] call XAddKills}]};
		#endif
		if (d_with_ai) then {if (__RankedVer) then {_one_unit addEventHandler ["killed", {[1,_this select 1] call XAddKillsAI}]}};
		_one_unit setUnitAbility ((d_skill_array select 0) + (random (d_skill_array select 1)));
		_ret set [count _ret, _one_unit];
	} foreach _unitliste;
	(leader _grp) setRank "SERGEANT";
	_ret
};

XCreateInf = {
	private ["_radius", "_pos", "_nr", "_nrg", "_typenr", "_i", "_newgroup", "_units"];
	_pos_center = _this select 4;
	_radius = _this select 5;
	_do_patrol = (if (count _this == 7) then {_this select 6} else {false});
	if (_radius < 50) then {_do_patrol = false};

	_ret_grps = [];
	_pos = [];

	for "_nr" from 0 to 1 do {
		_nrg = _this select (1 + (_nr * 2));
		if (_nrg > 0) then {
			_typenr = _this select (_nr * 2);
			for "_i" from 1 to _nrg do {
				_newgroup = [d_side_enemy] call x_creategroup;
				_unit_array = [_typenr, d_enemy_side] call x_getunitliste;
				if (_radius > 0) then {
					_pos = [_pos_center, _radius] call XfGetRanPointCircle;
					if (count _pos == 0) then {
						for "_ee" from 0 to 99 do {_pos = [_pos_center, _radius] call XfGetRanPointCircle;if (count _pos > 0) exitWith {}};
					};
				} else {
					_pos = _pos_center;
				};
				_units = [_pos, (_unit_array select 0), _newgroup] call x_makemgroup;
				_newgroup allowFleeing 0;
				if (!_do_patrol) then {
					_newgroup setCombatMode "YELLOW";
					_newgroup setFormation (["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","DIAMOND"] call XfRandomArrayVal);
					_newgroup setFormDir (floor random 360);
					_newgroup setSpeedMode "NORMAL";
				};
				_ret_grps set [count _ret_grps, _newgroup];
				if (_do_patrol) then {
					[_newgroup, _pos, [_pos_center, _radius], [5, 15, 30]] spawn XMakePatrolWPX;
				} else {
					[_newgroup, _pos_center] spawn BI_fnc_taskDefend;
				};
				extra_mission_remover_array = [extra_mission_remover_array , _units] call X_fnc_arrayPushStack;
			};
		};
	};
	_ret_grps
};

XCreateArmor = {
	private ["_numvehicles", "_radius", "_pos", "_nr", "_nrg", "_typenr", "_i", "_newgroup", "_reta"];
	_pos_center = _this select 6;
	_numvehicles = _this select 7;
	_radius = _this select 8;
	_do_patrol = (if (count _this == 10) then {_this select 9} else {false});
	if (_radius < 50) then {_do_patrol = false};
	_ret_grps = [];
	_pos = [];
	
	for "_nr" from 0 to 2 do {
		_nrg = _this select (1 + (_nr * 2));
		if (_nrg > 0) then {
			_typenr = _this select (_nr * 2);
			for "_i" from 1 to _nrg do {
				_newgroup = [d_side_enemy] call x_creategroup;
				if (_radius > 0) then {
					_pos = [_pos_center, _radius] call XfGetRanPointCircle;
					if (count _pos == 0) then {
						for "_ee" from 0 to 99 do {_pos = [_pos_center, _radius] call XfGetRanPointCircle;if (count _pos > 0) exitWith {}};
					};
				} else {
					_pos = _pos_center;
				};
				_unit_array = [_typenr, d_enemy_side] call x_getunitliste;
				_reta = [_numvehicles, _pos, (_unit_array select 1), _newgroup, 0,-1.111] call x_makevgroup;
				extra_mission_vehicle_remover_array = [extra_mission_vehicle_remover_array, (_reta select 0)] call X_fnc_arrayPushStack;
				extra_mission_remover_array = [extra_mission_remover_array , (_reta select 1)] call X_fnc_arrayPushStack;
				_newgroup allowFleeing 0;
				if (!_do_patrol) then {
					_newgroup setCombatMode "YELLOW";
					_newgroup setFormation (["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","DIAMOND"] call XfRandomArrayVal);
					_newgroup setFormDir (floor random 360);
					_newgroup setSpeedMode "NORMAL";
				};
				_ret_grps set [count _ret_grps, _newgroup];
				if (_do_patrol) then {[_newgroup, _pos, [_pos_center, _radius], [5, 15, 30]] spawn XMakePatrolWPX};
			};
		};
	};
	_ret_grps
};

XGuardWP = {
	private ["_ggrp"];
	_ggrp = _this;
	_ggrp setCombatMode "YELLOW";
	_ggrp setFormation (["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"] call XfRandomArrayVal);
	_ggrp setFormDir (floor random 360);
	_ggrp setSpeedMode "NORMAL";
	_ggrp setBehaviour "SAFE";
};

XAttackWP = {
	private ["_ggrp","_gtarget_pos","_gwp"];
	_ggrp = _this select 0;
	_gtarget_pos = _this select 1;
	_ggrp setbehaviour "AWARE";
	_gwp = _ggrp addWaypoint [_gtarget_pos,30];
	_gwp setwaypointtype "SAD";
	_gwp setWaypointCombatMode "YELLOW";
	_gwp setWaypointSpeed "FULL";
};

#ifndef __ACE__
XGetWreck = {
	private ["_no","_rep_station","_types"];
	_rep_station = _this select 0;_types = _this select 1;
	_no = nearestObjects [position _rep_station, _types, 8];
	if (count _no > 0) then {if (damage (_no select 0) >= 1) then {_no select 0} else {objNull}} else {objNull}
};
#else
XGetWreck = {
	private ["_no","_rep_station","_types","_ret"];
	_rep_station = _this select 0;_types = _this select 1;
	_ret = objNull;
	_no = nearestObjects [position _rep_station, _types, 8];
	if (count _no > 0) then {if (damage (_no select 0) >= 1) then {_ret = _no select 0} else {_isv = (_no select 0) call ace_v_alive;if (!isNil "_isv") then {if (!_isv) then {_ret = _no select 0}}}};
	_ret
};
#endif

XOutOfBounds = {
	private ["_vec", "_p_x", "_vehicle", "_p_y"];
	_vec = _this;
	_p_x = position _vehicle select 0;
	_p_y = position _vehicle select 1;
	if ((_p_x < 0 || _p_x > ((d_island_center select 0) * 2)) && (_p_y < 0 || _p_y > ((d_island_center select 1) * 2))) then {true} else {false}
};

// supports also patrols in square areas, including angle
XMakePatrolWPX = {
	private ["_grp", "_start_pos", "_wp_array", "_i", "_wp_pos", "_counter", "_wp", "_wppos", "_pos", "_cur_pos","_no_pos_found"];
	_grp = _this select 0;
	_start_pos = _this select 1;
	_wp_array = _this select 2;
	if (typeName _wp_array == "OBJECT") then {_wp_array = position _wp_array};
	if (typeName _wp_array != "ARRAY") exitWith {};
	if (typeName _start_pos == "OBJECT") then {_start_pos = position _start_pos};
	if (typeName _start_pos != "ARRAY") exitWith {};
	if (count _start_pos == 0) exitWith {};
	_timeout = if ((count _this) > 3) then {_this select 3} else {[]};
	_grp setBehaviour "SAFE";
	_cur_pos = _start_pos;
	_no_pos_found = false;
	for "_i" from 0 to (2 + (floor (random 3))) do {
		_wp_pos = switch (count _wp_array) do {
			case 2: {[_wp_array select 0, _wp_array select 1] call XfGetRanPointCircle};
			case 4: {[_wp_array select 0, _wp_array select 1, _wp_array select 2, _wp_array select 3] call XfGetRanPointSquare};
		};
		if (count _wp_pos == 0) exitWith {_no_pos_found = true};
		_counter = 0;
		while {_wp_pos distance _cur_pos < ((_wp_array select 1)/6) && _counter < 100} do {
			_wp_pos = switch (count _wp_array) do {
				case 2: {[_wp_array select 0, _wp_array select 1] call XfGetRanPointCircle};
				case 4: {[_wp_array select 0, _wp_array select 1, _wp_array select 2, _wp_array select 3] call XfGetRanPointSquare};
			};
			if (count _wp_pos == 0) exitWith {};
			_counter = _counter + 1;
		};
		if (count _wp_pos == 0) exitWith {_no_pos_found = true};
		_wp_pos = _wp_pos call XfWorldBoundsCheck;
		_cur_pos = _wp_pos;
		_wp = _grp addWaypoint [_wp_pos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius (0 + random 10);
		if (count _timeout > 0) then {_wp setWaypointTimeout _timeout};

		if (_i == 0) then {
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointFormation "STAG COLUMN";
		};
	};
	if (_no_pos_found) exitWith {
		_wp1 = _grp addWaypoint [_start_pos, 0];
		_wp1 setWaypointType "SAD";
	};
	_wp1 = _grp addWaypoint [_start_pos, 0];
	_wp1 setWaypointType "SAD";
	_wp1 setWaypointCompletionRadius (10 + random 10);
	if (count _timeout > 0) then {_wp1 setWaypointTimeout _timeout};
	_wp = _grp addWaypoint [_start_pos, 0];
	_wp setWaypointType "CYCLE";
	_wp setWaypointCompletionRadius (10 + random 10);
};

XfDelVecAndCrew = {{deleteVehicle _x} forEach ([[_this], crew _this] call X_fnc_arrayPushStack)};

XfPlacedObjKilled = {
	private "_val";
	_val = (_this select 0) getVariable "d_owner";
	if (!isNil "_val") then {
		["d_p_o_an", _val] call XNetCallEvent;
	};
};

XGetPlayerArray = {
	private ["_uid","_parray"];
	_uid = _this select 0;
	_parray = d_player_store getVariable _uid;
	if (!isNil "_parray") then {
		_parray set [4, (_this select 1)];
#ifdef __TT__
		_parray set [5, (_this select 2)];
#endif
	};
};

XfTKKickCheck = {
	private ["_tk", "_p", "_sel", "_numtk", "_uid"];
	_tk = _this select 2;
	_tk addScore (d_sub_tk_points * -1);
	_uid = getPlayerUID _tk;
	_p = d_player_store getVariable _uid;
	if (!isNil "_p") then {
		_sel =
#ifndef __TT__
		6;
#else
		7;
#endif
		_numtk = _p select _sel;
		__INC(_numtk);
		_p set [_sel, _numtk];
		if (_numtk >= d_maxnum_tks_forkick) exitWith {
			serverCommand ("#kick " + (_p select (_sel -1)));
			diag_log format ["Player %1 was kicked automatically because of teamkilling, # team kills: %3, ArmA 2 Key: %2", _p select (_sel -1), _uid, _numtk];
			["d_tk_an", [_p select (_sel -1), _numtk]] call XNetCallEvent;
		};
#ifdef __ACE__
		["d_haha", _tk] call XNetCallEvent;
#endif
	};
};

XfKickPlayerBS = {
	private ["_pl", "_uid", "_reason"];
	_pl = _this select 0;
	_pl_name = _this select 1;
	_reason = _this select 2;
	_uid = getPlayerUID _pl;
	serverCommand ("#kick " + _pl_name);
	switch (_reason) do {
		case 0: {
			diag_log format ["Player %1 was kicked automatically because of too much unnecessary shooting at base, ArmA 2 Key: %2", _pl_name, _uid];
		};
		case 1: {
			diag_log format ["Player %1 was kicked automatically because trying to place a satchel at base, ArmA 2 Key: %2", _pl_name, _uid];
		};
		case 2: {
			diag_log format ["Player %1 was kicked automatically because he didn't log on in the admin slot, ArmA 2 Key: %2", _pl_name, _uid];
		};
		case 3: {
			diag_log format ["Player %1 was kicked automatically because he uses cheat tools, ArmA 2 Key: %2", _pl_name, _uid];
		};
	};
	["d_ps_an", [_pl_name, _reason]] call XNetCallEvent;
};

XfRptMsgBS = {
	private ["_pl", "_uid", "_reason"];
	_pl = _this select 0;
	_pl_name = _this select 1;
	_reason = _this select 2;
	_uid = getPlayerUID _pl;
	switch (_reason) do {
		case 0: {
			diag_log format ["Player %1 does too much shooting at base, ArmA 2 Key: %2", _pl_name, _uid];
		};
		case 1: {
			diag_log format ["Player %1 placed a satchel at base, ArmA 2 Key: %2", _pl_name, _uid];
		};
	};
};

XAdminDelTKs = {
	private ["_p", "_sel"];
	_p = d_player_store getVariable _this;
	if (!isNil "_p") then {
		_sel =
#ifndef __TT__
		6;
#else
		7;
#endif
		_p set [_sel, 0];
	};
};

XAddPlayerScore = {
	private ["_uid", "_score", "_pa"];
	_uid = _this select 0;_score = _this select 1;
	_pa = d_player_store getVariable _uid;
	if (!isNil "_pa") then {_pa set [3, _score]};
};

XGetPlayerPoints = {
	private ["_uid", "_pa"];
	_uid = _this;
	_pa = d_player_store getVariable _uid;
	__DEBUG_NET("XGetPlayerPoints",_uid)
	if (!isNil "_pa") then {["d_p_ar", _pa] call XNetCallEvent};
};

XGetAdminArray = {
	_p = d_player_store getVariable _this;
	if (isNil "_p") then {_p = []};
	["d_s_p_inf", _p] call XNetCallEvent;
};

XRemABox = {
	private ["_i", "_box_a", "_pos"];
	if (typeName _this == "SCALAR") exitWith {};
	_boxes = __XJIPGetVar(d_ammo_boxes);
	for "_i" from 0 to (count _boxes - 1) do {
		_box_a = _boxes select _i;
		_pos = _box_a select 0;
		if (_pos distance _this < 5) exitWith {_box_a set [0,[]]};
	};
};

#ifndef __OA__
["FEAST", "FlagCarrierRU"] call XfStoreAdd;
["FWEST", "FlagCarrierUSA"] call XfStoreAdd;
["FGUER", "FlagCarrierGUE"] call XfStoreAdd;
#else
["FEAST", "FlagCarrierTakistan_EP1"] call XfStoreAdd;
["FWEST", "FlagCarrierUSArmy_EP1"] call XfStoreAdd;
["FGUER", "FlagCarrierTKMilitia_EP1"] call XfStoreAdd;
#endif

XfGetEnemyFlagType = {("F" + d_enemy_side) call XfStoreGet};

XfGetOwnFlagType = {("F" + d_own_side) call XfStoreGet};

X_fnc_selectCrew = {
	/*
		File: selectCrew.sqf
		Author: Joris-Jan van 't Land

		Description:
		Return an appropriate crew type for a certain vehicle.
		
		Parameter(s):
		_this select 0: side (Side)
		_this select 1: vehicle config entry (Config)
		
		Returns:
		Array - crew type, cargo types (array) for Wheeled APCs
	*/
	if ((count _this) < 2) exitWith {};
	private ["_side", "_entry", "_type"];
	_side = _this select 0;
	_entry = _this select 1;
	_type = _this select 2;
	if ((typeName _side) != (typeName sideEnemy)) exitWith {""};
	if ((typeName _entry) != (typeName configFile)) exitWith {""};
	private ["_crew", "_typcargo"];
	_crew = "";
	_typcargo = [];
	_crew = getText (_entry >> "crew");
	if (_crew == "") then {
		switch (_side) do {
#ifndef __OA__
			case west: {_crew = "USMC_Soldier_Crew"};
			case east: {_crew = "RU_Soldier_Crew"};
#else
			case west: {_crew = "US_Soldier_Crew_EP1"};
			case east: {_crew = "TK_Soldier_Crew_EP1"};
#endif
			default {};
		};
	} else {
		if (_type isKindOf "Car" || _type isKindOf "Tracked_APC") then {
			_typcargo = (getArray (_entry >> "typicalCargo")) - [_crew,"Soldier"];
		};
	};
	[_crew, _typcargo]
};

XSideMissionResolved = {
	execFSM "fsms\XClearSidemission.fsm";
	if (X_SPE) then {
		deleteMarkerLocal (format ["XMISSIONM%1", __XJIPGetVar(current_mission_index) + 1]);
		if (x_sm_type == "convoy") then {deleteMarkerLocal (format ["XMISSIONM2%1", __XJIPGetVar(current_mission_index) + 1])};
	};
	["current_mission_index",-1] call XNetSetJIP;
	if (d_side_mission_winner > 0) then {
		#ifdef __TT__
		switch (d_side_mission_winner) do {
			case 1: {d_points_east = d_points_east + (d_tt_points select 4)};
			case 2: {d_points_west = d_points_west + (d_tt_points select 4)};
		};	
		#endif
		execVM "x_server\x_getbonus.sqf";
	};
	if (d_side_mission_winner in [-1,-2,-300,-400,-500,-600,-700,-878,-879]) then {
		["sm_res_client", [d_side_mission_winner,-1]] call XNetCallEvent;
		#ifndef __TT__
		d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MissionFailure",true];
		#else
		d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","MissionFailure",true];
		d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","MissionFailure",true];
		#endif
		if (!X_SPE) then {d_side_mission_winner = 0};
	};
};

if (!AmmoBoxHandling) then {
#ifndef __TT__
	XCreateDroppedBox = {
		private ["_the_box_pos","_boxes","_mname"];
		_the_box_pos = _this;
		["ammo_boxes",__XJIPGetVar(ammo_boxes) + 1] call XNetSetJIP;
		_mname = format ["bm_%1", str(_the_box_pos)];
		_boxes = __XJIPGetVar(d_ammo_boxes);
		_boxes set [count _boxes, [_the_box_pos,_mname]];
		["d_ammo_boxes",_boxes] call XNetSetJIP;
		[_mname, _the_box_pos,"ICON","ColorBlue",[0.5,0.5],"Ammo",0,"mil_marker"] call XfCreateMarkerGlobal;
	};
#else
	XCreateDroppedBox = {
		private ["_the_box_pos", "_boxside", "_boxes", "_mname"];
		_the_box_pos = _this select 0;
		_boxside = _this select 1;
		["ammo_boxes",__XJIPGetVar(ammo_boxes) + 1] call XNetSetJIP;
		_mname = format ["bm_%1", str(_the_box_pos)];
		_boxes = __XJIPGetVar(d_ammo_boxes);
		_boxes set [count _boxes, [_the_box_pos,_mname, _boxside]];
		["d_ammo_boxes",_boxes] call XNetSetJIP;
		[_mname, _the_box_pos,"ICON","ColorBlue",[0.5,0.5],"Ammo",0,"mil_marker"] call XfCreateMarkerGlobal;
		["d_r_mark", [_mname, _boxside]] call XNetCallEvent;
	};
#endif
} else {
	#ifndef __TT__
	// drop ammo box from vehicle, old version
	XCreateDroppedBox = {
		private ["_vec","_the_box_pos","_cbox", "_boxes"];
		_vec = _this select 0;
		_the_box_pos = _this select 1;
		["ammo_boxes",__XJIPGetVar(ammo_boxes) + 1] call XNetSetJIP;
		_cbox = [_vec, _the_box_pos];
		d_check_boxes set [count d_check_boxes, _cbox];
		_boxes = __XJIPGetVar(d_ammo_boxes);
		_boxes set [count _boxes, [_the_box_pos,""]];
		["d_ammo_boxes",_boxes] call XNetSetJIP;
	};
	#else
	XCreateDroppedBox = {
		private ["_vec","_the_box_pos","_cbox","_boxside", "_boxes"];
		_vec = _this select 0;
		_the_box_pos = _this select 1;
		_boxside = _this select 2;
		["ammo_boxes",__XJIPGetVar(ammo_boxes) + 1] call XNetSetJIP;
		_cbox = [_vec, _the_box_pos, _boxside];
		d_check_boxes set [count d_check_boxes, _cbox];
		_boxes = __XJIPGetVar(d_ammo_boxes);
		_boxes set [count _boxes, [_the_box_pos,""]];
		["d_ammo_boxes",_boxes] call XNetSetJIP;
		["d_r_mark", [_mname, _boxside]] call XNetCallEvent;
	};
	#endif
};

XCheckMTHardTarget = {
	private ["_vehicle", "_trigger", "_trigger2"];
	_vehicle = _this select 0;
	[_vehicle] execFSM "fsms\XRemoveVehiExtra.fsm";
	_vehicle addEventHandler ["killed", {
		mt_spotted = false;
		["d_mt_radio_down",true] call XNetSetJIP;
		deleteMarker "main_target_radiotower";
		#ifndef __TT__
		d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTRadioTowerDown",true];
		#else
		d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","MTRadioTowerDown",true];
		d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","MTRadioTowerDown",true];
		#endif
	}];
	#ifdef __TT__
	_vehicle addEventHandler ["killed", {
		[d_tt_points select 2,_this select 1] call XAddPoints;
		_killedby = switch (_this select 1) do {case west: {"US"};case east: {"EAST"};default {"N"};};
		if (_killedby != "N") then {
			d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","MTRadioAnnounce",["1","",_killedby,[]],["2","",str(d_tt_points select 2),[]],true];
			d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","MTRadioAnnounce",["1","",_killedby,[]],["2","",str(d_tt_points select 2),[]],true];
		};
	}];
	#endif
	["d_dam", [_vehicle, false]] call XNetCallEvent;
	friendly_near_mt_target = false;
	_trigger = createTrigger["EmptyDetector" ,position _vehicle];
	_trigger setTriggerArea [20, 20, 0, false];
	#ifndef __TT__
	_trigger setTriggerActivation [d_own_side_trigger, "PRESENT", false];
	#else
	_trigger setTriggerActivation ["WEST", "PRESENT", false];
	#endif
	_trigger setTriggerStatements["(getpos (thislist select 0)) select 2 < 20", "friendly_near_mt_target = true", ""];
	#ifdef __TT__
	_trigger2 = [position _vehicle, [20, 20, 0, false], ["EAST", "PRESENT", false], ["(getpos (thislist select 0)) select 2 < 20", "friendly_near_mt_target = true", ""]] call XfCreateTrigger;
	#endif
	while {!friendly_near_mt_target && alive _vehicle} do {
		__MPCheck;
		sleep (1.021 + random 1);
	};
	["d_dam", [_vehicle, true]] call XNetCallEvent;
	deleteVehicle _trigger;
	#ifdef __TT__
	deleteVehicle _trigger2;
	#endif
};

XDamHandler = {
	private "_d_dam";
	(_this select 0) allowDamage (_this select 1);
	if (_this select 1) then {
		_d_dam = __XJIPGetVar(d_dam);
		if ((_this select 0) in _d_dam) then {
			_d_dam = _d_dam - [_this select 0];
			_d_dam = _d_dam - [objNull];
			["d_dam",_d_dam] call XNetSetJIP;
		};
	} else {
		_d_dam = __XJIPGetVar(d_dam);
		if (!((_this select 0) in _d_dam)) then {
			_d_dam set [count _d_dam, _this select 0];
			_d_dam = _d_dam - [objNull];
			["d_dam",_d_dam] call XNetSetJIP;
		};
	};
};

// get a random point inside a circle
// parameters:
// center position, radius of the circle
// example: _random_point = [position trigger1, 200] call XfGetRanPointCircle;
XfGetRanPointCircle = {
	private ["_center", "_radius", "_co", "_angle", "_x1", "_y1", "_no", "_valid", "_slope"];
	_center = _this select 0;_radius = _this select 1;
	_center_x = _center select 0;_center_y = _center select 1;
	_ret_val = [];
	for "_co" from 0 to 99 do {
		_angle = floor (random 360);
		_x1 = _center_x - ((random _radius) * sin _angle);
		_y1 = _center_y - ((random _radius) * cos _angle);
		if (!(surfaceiswater [_x1, _y1])) then {
			_no = [_x1, _y1, 0] nearestObject "Static";
			_valid = true;
			if (!isNull _no) then {
				if ([_x1, _y1, 0] distance _no < 11) then {_valid = false};
			};
			if (_valid) then {
				_slope = [[_x1, _y1, 0], 5] call XfGetSlope;
				if (_slope < 0.5) then {_ret_val = [_x1, _y1,0]};
			};
		};
		if (count _ret_val != 0) exitWith {};
	};
	_ret_val
};

// no slope check, for patrolling
XfGetRanPointCircleOld = {
	private ["_center", "_radius", "_center_x", "_center_y", "_ret_val", "_co", "_angle", "_x1", "_y1", "_helper"];
	_center = _this select 0;_radius = _this select 1;
	_center_x = _center select 0;_center_y = _center select 1;
	_ret_val = [];
	for "_co" from 0 to 99 do {
		_angle = floor (random 360);
		_x1 = _center_x - ((random _radius) * sin _angle);
		_y1 = _center_y - ((random _radius) * cos _angle);
		if (!(surfaceiswater [_x1, _y1])) then {_ret_val = [_x1, _y1, 0]};
		if (count _ret_val != 0) exitWith {};
	};
	_ret_val
};

// get a random point inside a circle for bigger objects
// parameters:
// center position, radius of the circle
// example: _random_point = [position trigger1, 200] call XfGetRanPointCircleBig;
XfGetRanPointCircleBig = {
	private ["_center", "_radius", "_co", "_angle", "_x1", "_y1", "_no", "_valid", "_slope"];
	_center = _this select 0;_radius = _this select 1;
	_center_x = _center select 0;_center_y = _center select 1;
	_ret_val = [];
	for "_co" from 0 to 99 do {
		_angle = floor (random 360);
		_x1 = _center_x - ((random _radius) * sin _angle);
		_y1 = _center_y - ((random _radius) * cos _angle);
		if (!(surfaceiswater [_x1, _y1])) then {
			_no = [_x1, _y1, 0] nearestObject "Static";
			_valid = true;
			if (!isNull _no) then {
				if ([_x1, _y1, 0] distance _no < 21) then {_valid = false};
			};
			if (_valid) then {
				_slope = [[_x1,_y1,0], 5] call XfGetSlope;
				if (_slope < 0.5 && !(isOnRoad ([_x1,_y1,0]))) then {_ret_val = [_x1,_y1,0]};
			};
		};
		if (count _ret_val != 0) exitWith {};
	};
	_ret_val
};

// get a random point at the borders of a circle
// parameters:
// center position, radius of the circle
// example: _random_point = [position trigger1, 200] call XfGetRanPointCircleOuter;
XfGetRanPointCircleOuter = {
	private ["_center", "_radius", "_co", "_angle", "_x1", "_y1", "_no", "_valid", "_slope"];
	_center = _this select 0;_radius = _this select 1;
	_center_x = _center select 0;_center_y = _center select 1;
	_ret_val = [];
	for "_co" from 0 to 99 do {
		_angle = floor (random 360);
		_x1 = _center_x - (_radius * sin _angle);
		_y1 = _center_y - (_radius * cos _angle);
		if (!(surfaceiswater [_x1, _y1])) then {
			_no = [_x1, _y1, 0] nearestObject "Static";
			_valid = true;
			if (!isNull _no) then {
				if ([_x1, _y1, 0] distance _no < 11) then {_valid = false};
			};
			if (_valid) then {
				_slope = [[_x1, _y1, 0], 5] call XfGetSlope;
				if (_slope < 0.5) then {_ret_val = [_x1, _y1, 0]};
			};
		};
		if (count _ret_val != 0) exitWith {};
	};
	_ret_val
};

// get a random point inside a square
// parameters:
// center position, a and b (like in triggers), angle
// example: _random_point  = [position trigger2, 200, 300, 30] call XfGetRanPointSquare;
XfGetRanPointSquare = {
	private ["_pos", "_a", "_b", "_angle", "_centerx", "_centery", "_leftx", "_lefty", "_width", "_height", "_co", "_px1", "_py1", "_radius", "_atan", "_x1", "_y1", "_no", "_valid", "_slope"];
	_pos = _this select 0;_a = _this select 1;_b = _this select 2;_angle = _this select 3;
	_centerx = _pos select 0;_centery = _pos select 1;_leftx = _centerx - _a;_lefty = _centery - _b;
	_width = 2 * _a;_height = 2 * _b;_ret_val = [];
	for "_co" from 0 to 99 do {
		_px1 = _leftx + random _width; _py1 = _lefty + random _height;
		_radius = _pos distance [_px1,_py1];
		_atan = (_centerx - _px1) atan2 (_centery - _py1);
		_x1 = _centerx - (_radius * sin (_atan + _angle));
		_y1 = _centery - (_radius * cos (_atan + _angle));
		if (!(surfaceiswater [_x1, _y1])) then {
			_no = [_x1, _y1, 0] nearestObject "Static";
			_valid = true;
			if (!isNull _no) then {
				if ([_x1, _y1, 0] distance _no < 11) then {_valid = false};
			};
			if (_valid) then {
				_slope = [[_x1, _y1, 0], 5] call XfGetSlope;
				if (_slope < 0.5) then {_ret_val = [_x1, _y1, 0]};
			};
		};
		if (count _ret_val != 0) exitWith {};
	};
	_ret_val
};

// no slope check, for patrolling
XfGetRanPointSquareOld = {
	private ["_pos", "_a", "_b", "_angle", "_centerx", "_centery", "_leftx", "_lefty", "_width", "_height", "_ret_val", "_co", "_px1", "_py1", "_radius", "_atan", "_x1", "_y1"];
	_pos = _this select 0;_a = _this select 1;_b = _this select 2;_angle = _this select 3;
	_centerx = _pos select 0;_centery = _pos select 1;_leftx = _centerx - _a;_lefty = _centery - _b;
	_width = 2 * _a;_height = 2 * _b;_ret_val = [];
	for "_co" from 0 to 99 do {
		_px1 = _leftx + random _width; _py1 = _lefty + random _height;
		_radius = _pos distance [_px1,_py1];
		_atan = (_centerx - _px1) atan2 (_centery - _py1);
		_x1 = _centerx - (_radius * sin (_atan + _angle));
		_y1 = _centery - (_radius * cos (_atan + _angle));
		if (!(surfaceiswater [_x1, _y1])) then {_ret_val = [_x1, _y1, 0]};
		if (count _ret_val != 0) exitWith {};
	};
	_ret_val
};

// get a random point at the borders of a square
// parameters:
// center position, a and b (like in triggers), angle
// example: _random_point  = [position trigger2, 200, 300, 30] call XfGetRanPointSquareOuter;
XfGetRanPointSquareOuter = {
	private ["_pos", "_a", "_b", "_angle", "_centerx", "_centery", "_leftx", "_lefty", "_width", "_height", "_co", "_rside", "_px1", "_py1", "_radius", "_atan", "_x1", "_y1", "_no", "_valid", "_slope"];
	_pos = _this select 0;_a = _this select 1;_b = _this select 2;_angle = _this select 3;
	_centerx = _pos select 0;_centery = _pos select 1;_leftx = _centerx - _a;_lefty = _centery - _b;
	_width = 2 * _a;_height = 2 * _b;_ret_val = [];
	for "_co" from 0 to 99 do {
		_rside = floor (random 4);
		_px1 = switch (_rside) do {
			case 0: {_leftx + random _width};
			case 1: {_leftx + _width};
			case 2: {_leftx + random _width};
			case 3: {_leftx};
		};
		_py1 = switch (_rside) do {
			case 0: {_lefty + _height};
			case 1: {_lefty + random _height};
			case 2: {_lefty};
			case 3: {_lefty + random _height};
		};
		_radius = _pos distance [_px1,_py1];
		_atan = (_centerx - _px1) atan2 (_centery - _py1);
		_x1 = _centerx - (_radius * sin (_atan + _angle));
		_y1 = _centery - (_radius * cos (_atan + _angle));
		if (!(surfaceiswater [_x1, _y1])) then {
			_no = [_x1, _y1, 0] nearestObject "Static";
			_valid = true;
			if (!isNull _no) then {
				if ([_x1, _y1, 0] distance _no < 11) then {_valid = false};
			};
			if (_valid) then {
				_slope = [[_x1, _y1, 0], 5] call XfGetSlope;
				if (_slope < 0.5) then {_ret_val = [_x1, _y1,0]};
			};
		};
		if (count _ret_val != 0) exitWith {};
	};
	_ret_val
};

// get a random point at the borders of a square
// parameters:
// center position, a and b (like in triggers), angle
// example: _random_point  = [position trigger2, 200, 300, 30] call XfGetRanPointSquareOuter;
XfGetRanPointSquareOuter = {
	private ["_pos", "_a", "_b", "_angle", "_centerx", "_centery", "_leftx", "_lefty", "_width", "_height", "_co", "_rside", "_px1", "_py1", "_radius", "_atan", "_x1", "_y1", "_no", "_valid", "_slope"];
	_pos = _this select 0;_a = _this select 1;_b = _this select 2;_angle = _this select 3;
	_centerx = _pos select 0;_centery = _pos select 1;_leftx = _centerx - _a;_lefty = _centery - _b;
	_width = 2 * _a;_height = 2 * _b;_ret_val = [];
	for "_co" from 0 to 99 do {
		_rside = floor (random 4);
		_px1 = switch (_rside) do {
			case 0: {_leftx + random _width};
			case 1: {_leftx + _width};
			case 2: {_leftx + random _width};
			case 3: {_leftx};
		};
		_py1 = switch (_rside) do {
			case 0: {_lefty + _height};
			case 1: {_lefty + random _height};
			case 2: {_lefty};
			case 3: {_lefty + random _height};
		};
		_radius = _pos distance [_px1,_py1];
		_atan = (_centerx - _px1) atan2 (_centery - _py1);
		_x1 = _centerx - (_radius * sin (_atan + _angle));
		_y1 = _centery - (_radius * cos (_atan + _angle));
		if (!(surfaceiswater [_x1, _y1])) then {
			_no = [_x1, _y1, 0] nearestObject "Static";
			_valid = true;
			if (!isNull _no) then {
				if ([_x1, _y1, 0] distance _no < 11) then {_valid = false};
			};
			if (_valid) then {
				_slope = [[_x1, _y1, 0], 5] call XfGetSlope;
				if (_slope < 0.5) then {_ret_val = [_x1, _y1,0]};
			};
		};
		if (count _ret_val != 0) exitWith {};
	};
	_ret_val
};

// get a random point at the borders of the current island for spawning air vehicles (no slope check, no is water check, etc)
// parameters:
// center position, left x, left y, width, height, angle (optional)
XfGetRanPointOuterAir = {
	private ["_pos", "_centerx", "_centery", "_leftx", "_lefty", "_width", "_height", "_rside", "_px1", "_py1", "_radius", "_atan", "_x1", "_y1"];
	_pos = d_island_center;
	_centerx = _pos select 0; _centery = _pos select 1;
	_leftx = 250;_lefty = 250;
	_width = (2 * (_pos select 0)) - 500;
	_height = (2 * (_pos select 1)) - 500;
	_rside = floor (random 4);
	_px1 = switch (_rside) do {
		case 0: {_leftx + random _width};
		case 1: {_leftx + _width};
		case 2: {_leftx + random _width};
		case 3: {_leftx};
	};
	_py1 = switch (_rside) do {
		case 0: {_lefty + _height};
		case 1: {_lefty + random _height};
		case 2: {_lefty};
		case 3: {_lefty + random _height};
	};
	_radius = _pos distance [_px1,_py1,_pos select 2];
	_atan = (_centerx - _px1) atan2 (_centery - _py1);
	_x1 = _centerx - (_radius * sin _atan);
	_y1 = _centery - (_radius * cos _atan);
	[_x1, _y1, 300]
};

XfGetLinePoints = {
	private ["_startpoint", "_endpoint", "_radius", "_ret", "_curpoint", "_wpdist", "_wpangle", "_x1", "_y1"];
	_startpoint = _this select 0;
	_endpoint = _this select 1;
	_radius = if (count _this > 2) then {_this select 2} else {8000};
	if (typeName _startpoint == "OBJECT") then {_startpoint = position _startpoint};
	if (typeName _endpoint == "OBJECT") then {_endpoint = position _endpoint};
	_ret = [];
	_curpoint = _startpoint;
	_wpdist = _curpoint distance _endpoint;
	if (_wpdist > _radius) then {
		_wpangle = [_curpoint, _endpoint] call XfDirTo;
		while {_wpdist > _radius} do {
			_x1 = (_curpoint select 0) + (_radius * sin _wpangle);
			_y1 = (_curpoint select 1) + (_radius * cos _wpangle);
			_curpoint = [_x1, _y1, 0];
			_wpdist = _curpoint distance _endpoint;
			_ret set [count _ret, _curpoint];
		};
	};
	_ret set [count _ret, [_endpoint select 1, _endpoint select 2, 0]];
	_ret
};

XfWorldBoundsCheck = {
	private "_pos";
	_pos = _this;
	if (_pos select 0 < 0) then {_pos set [0, 400]};
	if (_pos select 1 < 0) then {_pos set [1, 400]};
	if (_pos select 0 > (d_island_x_max - 2)) then {_pos set [0, d_island_x_max - 400]};
	if (_pos select 1 > (d_island_y_max - 2)) then {_pos set [1, d_island_y_max - 400]};
	_pos
};

XfGetSMTargetMessage = {
	switch (_this) do {
		case "gov_dead": {"Your team eliminated the governor."};
		case "radar_down": {"Your team destroyed the communication tower."};
		case "ammo_down": {"Your team destroyed the ammo truck."};
		case "apc_down": {"Your team destroyed the APC."};
		case "hq_down": {"Your team destroyed the enemy HQ."};
		case "light_down": {"Your team destroyed the light enemy factory."};
		case "heavy_down": {"Your team destroyed the heavy enemy factory."};
		case "artrad_down": {"Your team destroyed the enemy artillery radar."};
		case "airrad_down": {"Your team destroyed the enemy anti air radar."};
		case "lopo_dead": {"Your team killed the collaborateur."};
		case "dealer_dead": {"Your team killed the drug dealer."};
		case "sec_over": {"Secondary main target mission not solved..."};
	};
};

XfMTSMTargetKilled = {
	private "_type";
	_type = _this select (count _this - 1);
	d_side_main_done = true;
#ifdef __TT__
	[side (_this select 1), (if (side (_this select 1) in [west,east]) then {_type} else {"sec_over"})] spawn {
		private ["_si", "_type", "_s", "_westmsg", "_eastmsg","_killedby2"];
		_si = _this select 0;
		_type = _this select 1;
		_s = _type call XfGetSMTargetMessage;
		if (_type != "sec_over") then {
			_westmsg = if (_si == west) then {_s} else {"The other team solved the main target mission"};
			_eastmsg = if (_si == east) then {_s} else {"The other team solved the main target mission"};
		} else {
			_westmsg = _s;
			_eastmsg = _s;
		};
		d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","Dummy",["1","",_westmsg,[]],true];
		d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","Dummy",["1","",_eastmsg,[]],true];
	};
	[d_tt_points select 3,_this select 1] spawn XAddPoints;
	_killedby2 = switch (_this select 1) do {case west: {"US"};case east: {"EAST"};default {"N"};};
	if (_killedby2 != "N") then {
		d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","MTSMAnnounce",["1","",_killedby2,[]],["2","",str(d_tt_points select 3),[]],true];
		d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","MTSMAnnounce",["1","",_killedby2,[]],["2","",str(d_tt_points select 3),[]],true];
	};
#else
	[(if (side (_this select 1) == d_side_player) then {_type} else {"sec_over"})] spawn {
		private "_s";
		_s = (_this select 0) call XfGetSMTargetMessage;
		d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"Dummy",["1","",_s,[]],true];
	};
#endif
	["sec_kind",0] call XNetSetJIP;
};

#ifndef __TT__
XfAirMarkerMove = {
	private ["_vec", "_markern"];
	_vec = _this;
	sleep 30;
	if (!isNull _vec && alive _vec && canMove _vec && !d_banti_airdown) then {
		_markern = str(_vec);
		[_markern, [0,0,0],"ICON","ColorRed",[0.5,0.5],"Unknown air contact",0,"Air"] call XfCreateMarkerGlobal;
		while {!isNull _vec && alive _vec && canMove _vec && !d_banti_airdown} do {
			_markern setMarkerPos getPosASL _vec;
			sleep (3 + random 1);
		};
		deleteMarker _markern;
	};
};

XfIsleDefMarkerMove = {
	private ["_grp", "_markern"];
	_grp = _this;
	sleep 30;
	if (!isNull _grp && (_grp call XfGetAliveUnitsGrp) > 0) then {
		_markern = str(_grp);
		[_markern, [0,0,0],"ICON","ColorRed",[0.5,0.5],"Enemy patrol",0,"n_mech_inf"] call XfCreateMarkerGlobal;
		while {!isNull _grp && (_grp call XfGetAliveUnitsGrp) > 0} do {
			_markern setMarkerPos getPosASL (leader _grp);
			sleep (10 + random 10);
		};
		deleteMarker _markern;
	};
};
#endif