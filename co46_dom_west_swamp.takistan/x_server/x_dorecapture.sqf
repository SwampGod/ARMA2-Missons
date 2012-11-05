// by Xeno
#include "x_setup.sqf"
private ["_target_center", "_radius", "_recap_index", "_helih", "_unitslist", "_ulist", "_posran", "_grp", "_vecs", "_grp_array", "_i", "_units", "_vec","_veclist", "_reta", "_completel"];

if (!isServer) exitWith	{};

_target_center = _this select 0;
_radius = _this select 1;
_recap_index = _this select 2;
_helih = _this select 3;

_veclist = [];
_unitslist = [];

{
	_ulist = [_x,d_enemy_side] call x_getunitliste;
	_posran = [_target_center, _radius] call XfGetRanPointCircle;
	while {count _posran == 0} do {
		_posran = [_target_center, _radius] call XfGetRanPointCircle;
		sleep 0.4;
	};
	_grp = [d_side_enemy] call x_creategroup;
	_reta = [(2 call XfRandomCeil),_posran,(_ulist select 1),_grp,0,-1.111,true] call x_makevgroup;
	_vecs = _reta select 0;
	{_x lock true} forEach _vecs;
	sleep 1.012;
	_veclist = _vecs;
	_unitslist = [_unitslist, _reta select 1] call X_fnc_arrayPushStack;
	sleep 0.01;
} forEach ["tank","bmp"];

sleep 1.23;

for "_i" from 0 to 1 do {
	_ulist = ["basic",d_enemy_side] call x_getunitliste;
	_posran = [_target_center, _radius] call XfGetRanPointCircle;
	 while {count _posran == 0} do {
		_posran = [_target_center, _radius] call XfGetRanPointCircle;
		sleep 0.4;
	};
	_grp = [d_side_enemy] call x_creategroup;
	_units = [_posran,(_ulist select 0),_grp,true] call x_makemgroup;
	_unitslist = [_unitslist, _units] call X_fnc_arrayPushStack;
	sleep 0.512;
};

sleep 10;

_completel = _unitslist;
_completel = [_completel, _veclist] call X_fnc_arrayPushStack;
while {(_completel call XfGetAliveUnits) > 5} do {sleep 10.312};

sleep 5;

_helih setDir -532.37;

d_recapture_indices = d_recapture_indices - [_recap_index];

["recaptured", [_recap_index, 1]] call XNetCallEvent;
_target_array = d_target_names select _recap_index;
_target_name = _target_array select 1;
_tname = _target_name call XfKBUseName;
d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"Captured3",["1","",_target_name,[_tname]],true];

sleep 300;

{
	if (!isNull _x) then {
		_vec = _x;
		_vec call XfDelVecAndCrew;
	};
} forEach _veclist;

{if (!isNull _x) then {if (!isNull _x) then {deleteVehicle _x}}} forEach _unitslist;
_unitslist = nil;
_veclist = nil;