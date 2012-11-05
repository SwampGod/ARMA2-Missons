// by Xeno
#include "x_setup.sqf"
private ["_heli_array", "_vec_a", "_vehicle", "_number_v", "_is_west_chopper", "_i", "_tt", "_ifdamage", "_empty", "_disabled", "_empty_respawn", "_startpos", "_hasbox"];
if (!isServer) exitWith{};

_heli_array = [];
{
	_vec_a = _x;
	_vehicle = _vec_a select 0;
	_number_v = _vec_a select 1;
	_ifdamage = _vec_a select 2;
	_heli_array set [count _heli_array, [_vehicle,_number_v,_ifdamage,0, position _vehicle,direction _vehicle,typeOf _vehicle,(if (_ifdamage) then {0} else {_vec_a select 3})]];
	
	_vehicle setVariable ["D_OUT_OF_SPACE", -1];
	_vehicle setVariable ["d_vec", _number_v, true];
	_vehicle setVariable ["d_vec_islocked", if (locked _vehicle) then {true} else {false}];

#ifdef __TT__
	if (_number_v < 400) then {
		_vehicle addeventhandler ["killed", {_this call x_checkveckillwest}];
	} else {
		_vehicle addeventhandler ["killed", {_this call x_checkveckilleast}];
	};
#endif
} forEach _this;
_this = nil;

_isfirst = true;

while {true} do {
	__MPCheck;
	__DEBUG_NET("x_helirespawn2.sqf",(call XPlayersNumber))
	for "_i" from 0 to (count _heli_array - 1) do {
		_tt = 20 + random 10;
		sleep _tt;
		_vec_a = _heli_array select _i;
		_vehicle = _vec_a select 0;
		_ifdamage = _vec_a select 2;
		
		_empty = (if ((_vehicle call XfGetAliveCrew) > 0) then {false} else {true});
		
		_disabled = false;
		if (!_ifdamage) then {
			_empty_respawn = _vec_a select 3;
			if (_empty && _vehicle distance _startpos > 10) then {
				_empty_respawn = _empty_respawn + _tt;
				_vec_a set [3,_empty_respawn];
			};
			
			if (_empty && _empty_respawn > (_vec_a select 7)) then {
				_disabled = true;
			} else {
				if (!_empty && alive _vehicle) then {_vec_a set [3,0]};
			};
		};
			
		if (damage _vehicle > 0.9) then {_disabled = true};
		
		if (_empty && !_disabled && alive _vehicle && (_vehicle call XOutOfBounds)) then {
			_outb = _vehicle getVariable "D_OUT_OF_SPACE";
			if (_outb != -1) then {
				if (time > _outb) then {_disabled = true};
			} else {
				_vehicle setVariable ["D_OUT_OF_SPACE", time + 600];
			};
		} else {
			_vehicle setVariable ["D_OUT_OF_SPACE", -1];
		};
		
		sleep 0.01;
		
		if ((_disabled && _empty) || (_empty && !(alive _vehicle))) then {
			_hasbox = _vehicle getVariable "d_ammobox";
			if (isNil "_hasbox") then {
				_hasbox = false;
			};
			if (_hasbox) then {["ammo_boxes",__XJIPGetVar(ammo_boxes) - 1] call XNetSetJIP};
			_isitlocked = _vehicle getVariable "d_vec_islocked";
			sleep 0.1;
			deletevehicle _vehicle;
			if (!_ifdamage) then {_vec_a set [3,0]};
			sleep 0.5;
			_vehicle = objNull;
			_vehicle = createVehicle [(_vec_a select 6), (_vec_a select 4), [], 0, "NONE"];
#ifndef __CARRIER__
			_vehicle setpos (_vec_a select 4);
#else
			_vehicle setPosASL [(_vec_a select 4) select 0, (_vec_a select 4) select 1, 15.9];
#endif
			_vehicle setdir (_vec_a select 5);
			
			_vehicle setVariable ["d_vec_islocked", _isitlocked];
			if (_isitlocked) then {_vehicle lock true};
			
			_vec_a set [0,_vehicle];
			_heli_array set [_i, _vec_a];
			_number_v = _vec_a select 1;
			_vehicle setVariable ["D_OUT_OF_SPACE", -1];
			_vehicle setVariable ["d_vec", _number_v, true];
			["d_n_v", _vehicle] call XNetCallEvent;
			
#ifdef __TT__
			if (_number_v < 400) then {
				_vehicle addeventhandler ["killed", {_this call x_checkveckillwest}];
			} else {
				_vehicle addeventhandler ["killed", {_this call x_checkveckilleast}];
			};
#endif
		};
	};
	sleep 20 + random 5;
};