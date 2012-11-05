// by Xeno
#include "x_setup.sqf"
private ["_grptype", "_numbervehicles", "_type", "_side", "_grpspeed", "_vehicles", "_grp", "_pos", "_reta", "_fran", "_one"];

if (!isServer) exitWith{};

_grptype = _this select 0;
_wp_array = _this select 1;
_target_pos = _this select 2;
_numbervehicles = _this select 3; // only for tanks and cars
_type = _this select 4;
_side = _this select 5;
_grp_in = _this select 6;
_vec_dir = _this select 7;
_center_rad = if (count _this == 9) then {_this select 8} else {[]};
_grpspeed = "LIMITED";
_vehicles = [];

_grp = if (_grp_in == 0) then {[_side] call x_creategroup} else {_grp_in};
_pos = if (count _wp_array > 1) then {_wp_array call XfRandomArrayVal} else {_wp_array select 0};

_unit_array = [_grptype, _side] call x_getunitliste;

if (_numbervehicles > 0) then {
	_reta = [_numbervehicles, _pos, (_unit_array select 1), _grp, 0,_vec_dir,true] call x_makevgroup;
	_vehicles = [_vehicles, _reta select 0] call X_fnc_arrayPushStack;
	_grp setspeedmode _grpspeed;
} else {
	[_pos, (_unit_array select 0), _grp,true] call x_makemgroup;
};

sleep 1.011;

_unit_array = nil;
_fran = (floor random 3) + 1;
_grp allowFleeing (_fran / 10);

switch (_type) do {
	case "patrol": {
		_grp setVariable ["D_PATR",true];
		_min = 1 + random 15;
		_max = _min + (1 + random 15);
		_mid = _min + (random (_max - _min));
		[_grp, _pos, _center_rad, [_min, _mid, _max]] spawn XMakePatrolWPX;
	};
	case "patrol2mt": {
		_grp setVariable ["D_PATR",true];
		_min = 1 + random 15;
		_max = _min + (1 + random 15);
		_mid = _min + (random (_max - _min));
		[_grp, _pos, _center_rad, [_min, _mid, _max]] spawn XMakePatrolWPX;
		//d_house_pat_grps set [count d_house_pat_grps, _grp];
	};
	case "guard": {
		sleep 0.0123;
		if (toUpper (_grptype) in ["BASIC","SPECOPS"]) then {
			[_grp, _pos] spawn BI_fnc_taskDefend;
		} else {
			_grp call XGuardWP;
		};
	};
	case "guardstatic": {
		sleep 0.0123;
		if (toUpper (_grptype) in ["BASIC","SPECOPS"]) then {
			[_grp, _pos] spawn BI_fnc_taskDefend;
		} else {
			_grp call XGuardWP;
		};
	};
	case "guardstatic2": {
		_one = _vehicles select 0;
		_one setDir floor random 360;
	};
	case "attack": {
		[_grp, _target_pos] call XAttackWP;
	};
	case "attackwaves": {
		[_grp, _target_pos] call XAttackWP;
	};
};

_vehicles = nil;