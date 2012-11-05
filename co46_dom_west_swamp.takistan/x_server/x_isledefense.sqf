// by Xeno
#include "x_setup.sqf"
private ["_isle_grps", "_i", "_retval", "_make_isle_grp", "_igrpa", "_igrp", "_make_new", "_units","_posigrp", "_leader"];
if (!isServer) exitWith {};

sleep 35.321;

d_old_old_start = [0,0,0];
d_isle_retval = [];

_make_isle_grp = {
	private ["_units", "_start_point", "_dc", "_agrp", "_elist", "_vecs", "_rand", "_leader", "_grp_array", "_npos"];
	_units = [];
	_dc = 0;
	_start_point = [d_with_isledefense select 0,d_with_isledefense select 1,d_with_isledefense select 2,d_with_isledefense select 3] call XfGetRanPointSquare;
	#ifndef __TT__
	while {(count _start_point < 3 || (_start_point distance FLAG_BASE < 2000) || (_start_point distance d_old_old_start < 500)) && _dc < 99} do {
	#else
	while {(count _start_point == 0 || (_start_point distance WFLAG_BASE < 1500) || (_start_point distance EFLAG_BASE < 1500) || _start_point distance d_old_old_start < 500) && _dc < 99} do {
	#endif
		_start_point = [d_with_isledefense select 0,d_with_isledefense select 1,d_with_isledefense select 2,d_with_isledefense select 3] call XfGetRanPointSquare;
		sleep 0.353;
		_dc = _dc + 1;
	};
	_start_point = _start_point call XfWorldBoundsCheck;
	sleep 0.01;
	d_old_old_start = _start_point;
	__GetEGrp(_agrp)
	_elist = [d_enemy_side] call x_getmixedliste;
	_vecs = [];
	_npos = _start_point;
	{
		_rand = floor random 2;
		if (_rand > 0) then {
			_reta = [_rand,_npos,_x select 0,_agrp,0,-1.111] call x_makevgroup;
			_vecs = [_vecs, _reta select 0] call X_fnc_arrayPushStack;
			_units = [_units, _reta select 1] call X_fnc_arrayPushStack;
			sleep 0.73;
			_npos = ((_reta select 0) select 0) modelToWorld [0,-12,0];
		};
	} forEach _elist;
	_elist = nil;
	sleep 0.31;
	
	_agrp setVariable ["D_PATR",true];
	_agrp setVariable ["D_PATR_ISLE",true];
	[_agrp, _start_point, [d_with_isledefense select 0,d_with_isledefense select 1,d_with_isledefense select 2,d_with_isledefense select 3]] spawn XMakePatrolWPX;
#ifndef __TT__
	if ((__XJIPGetVar(d_searchintel) select 6) == 1) then {
		_agrp spawn XfIsleDefMarkerMove;
	};
#endif
	d_isle_retval = [_agrp, _units, [0,0,0], _vecs];
};

_isle_grps = [];
for "_i" from 1 to (d_with_isledefense select 4) do {
	_retval = [] spawn _make_isle_grp;
	waitUntil {scriptDone _retval};
	_isle_grps set [count _isle_grps, d_isle_retval];
	sleep 3.012;
};

while {true} do {
	__MPCheck;
	__DEBUG_NET("x_isledefense.sqf",(call XPlayersNumber))
	sleep 600 + random 600;
	for "_i" from 0 to (count _isle_grps - 1) do {
		_igrpa = _isle_grps select _i;
		_igrp = _igrpa select 0;
		_make_new = false;
		if (!isNull _igrp) then {
			if ((_igrp call XfGetAliveUnitsGrp) == 0) then {
				_make_new = true;
			} else {
				_posigrp = _igrpa select 2;
				_leader = leader _igrp;
				if (!isNull _leader) then {
					if (_posigrp distance _leader < 100) then {
						_make_new = true;
					} else {
						_igrpa set [2, position _leader];
					};
				};
			};
		} else {
			_make_new = true;
		};
		if (_make_new) then {
			_units = _igrpa select 1;
			_vecs = _igrpa select 3;
			{if (!isNull _x) then {_x call XfDelVecAndCrew};sleep 0.01} forEach _vecs;
			sleep 0.01;
			{if (!isNull _x) then {deleteVehicle _x};sleep 0.01} forEach _units;
			_units = nil;
			_vecs = nil;
			_retval = [] spawn _make_isle_grp;
			waitUntil {scriptDone _retval};
			_isle_grps set [_i, d_isle_retval];
			sleep 3.012;
		};
		sleep 100 + random 100;
	};
};