// by Xeno
#include "x_setup.sqf"
private ["_type_list_guard", "_selectit", "_type_list_guard_static", "_type_list_patrol", "_type_list_guard_static2", "_trgobj", "_radius","_number_basic_guard", "_selectitmen", "_number_specops_guard","_number_tank_guard", "_selectitvec", "_number_bmp_guard", "_number_brdm_guard", "_number_uaz_mg_guard", "_number_uaz_grenade_guard", "_number_basic_patrol", "_selectitmen", "_number_specops_patrol", "_number_tank_patrol", "_number_bmp_patrol", "_number_brdm_patrol", "_number_uaz_mg_patrol", "_number_uaz_grenade_patrol", "_number_basic_guardstatic", "_number_specops_guardstatic", "_number_tank_guardstatic", "_number_bmp_guardstatic", "_number_shilka_guardstatic", "_number_DSHKM_guardstatic", "_number_AGS_guardstatic", "_trg_center", "_trgobj", "_wp_array", "_radius", "_xx", "_type_list_guard", "_typeidx", "_number_", "_xxx", "_wp_ran", "_type_list_guard_static", "_type_list_guard_static2", "_point", "_ccc", "_type_list_patrol", "_baseran", "_fbobjs", "_dgrp", "_unit_array", "_agrp", "_xx_ran", "_xpos", "_units"];

if (!isServer) exitWith{};

_selectit = {(ceil (random (((_this select 0) select (_this select 1)) select 1)))};

_type_list_guard = [["basic",0],["specops",0],["tank",[d_vehicle_numbers_guard, 0] call _selectit],["bmp",[d_vehicle_numbers_guard, 1] call _selectit],["brdm",[d_vehicle_numbers_guard, 2] call _selectit],["uaz_mg",[d_vehicle_numbers_guard, 3] call _selectit],["uaz_grenade",[d_vehicle_numbers_guard, 4] call _selectit]];

_type_list_guard_static = [["basic",0],["specops",0],["tank",[d_vehicle_numbers_guard_static, 0] call _selectit],["bmp",[d_vehicle_numbers_guard_static, 1] call _selectit],["shilka",[d_vehicle_numbers_guard_static, 2] call _selectit]];

_type_list_patrol = [["basic",0],["specops",0],["tank",[d_vehicle_numbers_patrol, 0] call _selectit],["bmp",[d_vehicle_numbers_patrol, 1] call _selectit],["brdm",[d_vehicle_numbers_patrol, 2] call _selectit],["uaz_mg",[d_vehicle_numbers_patrol, 3] call _selectit],["uaz_grenade",[d_vehicle_numbers_patrol, 4] call _selectit]];
_type_list_guard_static2 = [["DSHKM",1],["AGS",1]];

_selectit = nil;

_trgobj = _this select 0;
_radius = _this select 1;

_selectitmen = {
	private ["_a_vng2","_num_ret"];
	_a_vng2 = (_this select 0) select (_this select 1);
	if ((_a_vng2 select 0) > 0) then {_num_ret = floor (random ((_a_vng2 select 0) + 1));if (_num_ret < (_a_vng2 select 1)) then {(_a_vng2 select 1)} else {_num_ret}} else {0}
};

_number_basic_guard = [d_footunits_guard, 0] call _selectitmen;
_number_specops_guard = [d_footunits_guard, 1] call _selectitmen;

_selectitvec = {
	private ["_a_vng","_a_vng2","_num_ret"];
	_a_vng = (_this select 0) select (_this select 1);
	_a_vng2 = _a_vng select 0;
	if ((_a_vng2 select 0) > 0) then {_num_ret = floor (random ((_a_vng2 select 0) + 1));if (_num_ret < (_a_vng2 select 1)) then {(_a_vng2 select 1)} else {_num_ret}} else {0}
};

_number_tank_guard = [d_vehicle_numbers_guard,0] call _selectitvec;
_number_bmp_guard = [d_vehicle_numbers_guard,1] call _selectitvec;
_number_brdm_guard = [d_vehicle_numbers_guard,2] call _selectitvec;
_number_uaz_mg_guard = [d_vehicle_numbers_guard,3] call _selectitvec;
_number_uaz_grenade_guard = [d_vehicle_numbers_guard,4] call _selectitvec;
sleep 0.1;

_number_basic_patrol = [d_footunits_patrol, 0] call _selectitmen;
_number_specops_patrol = [d_footunits_patrol, 1] call _selectitmen;
_number_tank_patrol = [d_vehicle_numbers_patrol,0] call _selectitvec;
_number_bmp_patrol = [d_vehicle_numbers_patrol,1] call _selectitvec;
_number_brdm_patrol = [d_vehicle_numbers_patrol,2] call _selectitvec;
_number_uaz_mg_patrol = [d_vehicle_numbers_patrol,3] call _selectitvec;
_number_uaz_grenade_patrol = [d_vehicle_numbers_patrol,4] call _selectitvec;
sleep 0.1;
_number_basic_guardstatic = [d_footunits_guard_static, 0] call _selectitmen;
_number_specops_guardstatic = [d_footunits_guard_static, 1] call _selectitmen;
_number_tank_guardstatic = [d_vehicle_numbers_guard_static,0] call _selectitvec;
_number_bmp_guardstatic = [d_vehicle_numbers_guard_static,1] call _selectitvec;
_number_shilka_guardstatic = [d_vehicle_numbers_guard_static,2] call _selectitvec;
_number_DSHKM_guardstatic = ceil (random 4);
_number_AGS_guardstatic = ceil (random 3);
sleep 0.1;

_selectitmen = nil;
_selectitvec = nil;

_trg_center = if (typeName _trgobj == "OBJECT") then {position _trgobj} else {_trgobj};
_wp_array = [_trg_center, _radius] call x_getwparray;

sleep 0.112;

for "_xx" from 0 to (count _type_list_guard - 1) do {
	_typeidx = _type_list_guard select _xx;
	_nums = call compile format ["_number_%1_guard", _typeidx select 0];
	if (_nums > 0) then {
		for "_xxx" from 1 to _nums do {
			_wp_ran = (count _wp_array) call XfRandomFloor;
			_shandle = [_typeidx select 0, [_wp_array select _wp_ran], _trg_center, _typeidx select 1, "guard",d_enemy_side,0,-1.111] spawn x_makegroup;
			_wp_array set [_wp_ran, -1];
			_wp_array = _wp_array - [-1];
			waitUntil {scriptDone _shandle};
			sleep 0.4;
		};
	};
};

sleep 0.233;

for "_xx" from 0 to (count _type_list_guard_static - 1) do {
	_typeidx = _type_list_guard_static select _xx;
	_nums = call compile format ["_number_%1_guardstatic", _typeidx select 0];
	if (_nums > 0) then {
		for "_xxx" from 1 to _nums do {
			_wp_ran = (count _wp_array) call XfRandomFloor;
			_shandle = [_typeidx select 0, [_wp_array select _wp_ran], _trg_center, _typeidx select 1, "guardstatic",d_enemy_side,0,-1.111] spawn x_makegroup;
			_wp_array set [_wp_ran, -1];
			_wp_array = _wp_array - [-1];
			waitUntil {scriptDone _shandle};
			sleep 0.4;
		};
	};
};

for "_xx" from 0 to (count _type_list_guard_static2 - 1) do {
	_typeidx = _type_list_guard_static2 select _xx;
	_nrgs = call compile format["_number_%1_guardstatic;", _typeidx select 0];
	if (_nrgs > 0) then {
		for "_xxx" from 1 to _nrgs do {
			_wp_ran = (count _wp_array) call XfRandomFloor;
			_point = [_trg_center, _radius] call XfGetRanPointCircleBig;
			_ccc = 0;
			while {count _point == 0 && _ccc < 100} do {
				_point = [_trg_center, _radius] call XfGetRanPointCircleBig;
				__INC(_ccc);
				sleep 0.01;
			};
			_shandle = [_typeidx select 0, [_point], _trg_center, _typeidx select 1, "guardstatic2",d_enemy_side,0,-1.111] spawn x_makegroup;
			waitUntil {scriptDone _shandle};
			sleep 0.1;
		};
	};
};

d_delfirebase_objects = [];
#ifndef __TT__
_baseran = floor (random 4);
if (_baseran < 1) then {_baseran = 1};

for "_xxx" from 1 to _baseran do {
	_point = [_trg_center, _radius] call XfGetRanPointCircleBig;
	if (isOnRoad _point) then {_point = []};
	_ccc = 0;
	while {count _point == 0 && _ccc < 100} do {
		_point = [_trg_center, _radius] call XfGetRanPointCircleBig;
		if (isOnRoad _point) then {_point = []};
		__INC(_ccc);
		sleep 0.01;
	};
	if (count _point > 0) then {
		_fbobjs = [_point, random 360, d_firebase] call BI_fnc_objectMapper;
		sleep 0.1;
		{
			if (!(_x isKindOf "Air") && !(_x isKindOf "Car") && !(_x isKindOf "Tank")) then {d_delfirebase_objects set [count d_delfirebase_objects, _x]};
			__addDead(_x)
		} forEach _fbobjs;
		sleep 0.1;
		_dgrp = [d_side_enemy] call x_creategroup;
		_unit_array = ["basic", d_enemy_side] call x_getunitliste;
		[_point, (_unit_array select 0), _dgrp,true] spawn x_makemgroup;
		sleep 0.4;
		[_dgrp, _point] spawn BI_fnc_taskDefend;
	};
	sleep 0.5;
};
#endif
if (random 1 > 0.6) then {
	_point = [_trg_center, _radius] call XfGetRanPointCircleBig;
	if (isOnRoad _point) then {_point = []};
	_ccc = 0;
	while {count _point == 0 && _ccc < 100} do {
		_point = [_trg_center, _radius] call XfGetRanPointCircleBig;
		if (isOnRoad _point) then {_point = []};
		__INC(_ccc);
		sleep 0.01;
	};
	if (count _point > 0) then {
		_mg = createVehicle ["Mass_grave", _point, [], 0, "NONE"];
		d_delfirebase_objects set [count d_delfirebase_objects, _mg];
	};
};
sleep 0.01;

for "_xx" from 0 to (count _type_list_patrol - 1) do {
	_typeidx = _type_list_patrol select _xx;
	_nums = call compile format ["_number_%1_patrol", _typeidx select 0];
	if (_nums > 0) then {
		for "_xxx" from 1 to _nums do {
			_wp_ran = (count _wp_array) call XfRandomFloor;
			_shandle = [_typeidx select 0, [_wp_array select _wp_ran], _trg_center, _typeidx select 1, if ((_typeidx select 0) in ["basic","specops"]) then {"patrol2mt"} else {"patrol"},d_enemy_side,0,-1.111,[_trg_center, _radius]] spawn x_makegroup;
			_wp_array set [_wp_ran, -1];
			_wp_array = _wp_array - [-1];
			waitUntil {scriptDone _shandle};
			sleep 0.4;
		};
	};
};

_type_list_guard = nil;
_type_list_guard_static = nil;
_type_list_guard_static2 = nil;
_type_list_patrol = nil;

sleep 2.124;

if (!d_no_more_observers && d_WithEnemyArtySpotters == 0) then {
	d_nr_observers = floor random 4;
	if (d_nr_observers < 2) then {d_nr_observers = 2};

	d_obs_array = [objNull, objNull, objNull];
	_unit_array = ["artiobserver", d_enemy_side] call x_getunitliste;
	for "_xx" from 0 to d_nr_observers - 1 do {
		__GetEGrp(_agrp)
		_xx_ran = (count _wp_array) call XfRandomFloor;
		_xpos = _wp_array select _xx_ran;
		_wp_array set [_xx_ran, -1];
		_wp_array = _wp_array - [-1];
		_units = [_xpos, (_unit_array select 0), _agrp, true] call x_makemgroup;
		[_agrp, _xpos, [_trg_center, _radius], [5, 20, 40]] spawn XMakePatrolWPX;
		_agrp setVariable ["D_PATR",true];
		_observer = _units select 0;
		_observer addEventHandler ["killed", {d_nr_observers = d_nr_observers - 1;
			if (d_nr_observers == 0) then {
#ifndef __TT__
				d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"AllObserversDown",true];
#else
				d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","AllObserversDown",true];
				d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","AllObserversDown",true];
#endif
			}
		}];
		d_obs_array set [_xx, _observer];
		sleep 0.4;
	};
	_unit_array = nil;

#ifndef __TT__
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TellNrObservers",["1","",str(d_nr_observers),[]],true];
#else
	d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","TellNrObservers",["1","",str(d_nr_observers),[]],true];
	d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","TellNrObservers",["1","",str(d_nr_observers),[]],true];
#endif
	execVM "x_server\x_handleobservers.sqf";
	sleep 1.214;
};

[_wp_array] execVM "x_server\x_createsecondary.sqf";

if (d_IllumMainTarget == 0) then {
	d_run_illum = true;
	[_trg_center, _radius] execFSM "fsms\Illum.fsm";
};