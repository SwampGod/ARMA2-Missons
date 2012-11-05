// by Xeno
#include "x_setup.sqf"

#define __Trans(tkind) _trans = getNumber(configFile >> #CfgVehicles >> typeOf _vehicle >> #tkind)
private ["_vehicle", "_camotype", "_camo", "_i", "_disabled", "_trans", "_empty", "_outb", "_hasbox"];
if (!isServer) exitWith{};

_vec_array = [];
{
	_vehicle = _x select 0;
	_number_v = _x select 1;
	_vec_array set [count _vec_array, [_vehicle,_number_v,position _vehicle,direction _vehicle,typeOf _vehicle]];
	
	_vehicle setVariable ["D_OUT_OF_SPACE", -1];
	_vehicle setVariable ["d_vec", _number_v, true];
	_vehicle setAmmoCargo 0;
	_vehicle setVariable ["d_vec_islocked", if (locked _vehicle) then {true} else {false}];
	
	#ifdef __TT__
	if (_number_v < 100) then {
		_vehicle addeventhandler ["killed", {_this call x_checkveckillwest}];
	} else {
		_vehicle addeventhandler ["killed", {_this call x_checkveckilleast}];
	};
	#endif
	if (_number_v < 10 || (_number_v > 99 && _number_v < 110)) then {
		_vehicle addeventhandler ["killed", {(_this select 0) setVariable ["D_MHQ_Deployed",false,true]}];
	};
	#ifndef __CARRIER__
	_camotype = switch (getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "side")) do {
		case 1: {if (__OAVer) then {"Land_CamoNetB_NATO_EP1"} else {"Land_CamoNetB_NATO"}};
		case 0: {if (__OAVer) then {"Land_CamoNetB_EAST_EP1"} else {"Land_CamoNetB_EAST"}};
	};
	_camo = createVehicle [_camotype, position _vehicle, [], 0, "NONE"];
	_camo setPos position _vehicle;
	_camo setDir (direction _vehicle) + 180;
	_vehicle setVariable ["d_camonet", _camo];
	#endif
} forEach _this;
_this = nil;

sleep 65;

while {true} do {
	sleep 8 + random 5;
	__MPCheck;
	__DEBUG_NET("x_vrespawn2.sqf",(call XPlayersNumber))
	for "_i" from 0 to (count _vec_array - 1) do {
		_vec_a = _vec_array select _i;
		_vehicle = _vec_a select 0;
		
		_disabled = false;
		if (damage _vehicle > 0.9) then {
			_disabled = true;
		} else {
			__Trans(transportAmmo);
			if (_trans > 0) then {
				_vehicle setAmmoCargo 1;
#ifdef __MANDO__
				_msl = _vehicle getVariable "mando_source_level";
				if (isNil "_msl") then {_msl = 0};
				if (_msl < 20) then {
					_vehicle setVariable ["mando_source_level", 100];
					["d_man_r", _vehicle] call XNetCallEvent;
				};
#endif
			};
			__Trans(transportRepair);
			if (_trans > 0) then {
				_vehicle setRepairCargo 1;
			};
			__Trans(transportFuel);
			if (_trans > 0) then {
				_vehicle setFuelCargo 1;
			};
		};
		
		_empty = if ((_vehicle call XfGetAliveCrew) > 0) then {false} else {true};
		
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

#ifdef __ACE__
		_aliveve = if (!isNil {_vehicle getVariable "ace_canmove"}) then {_vehicle call ace_v_alive} else {alive _vehicle};
#else
		_aliveve = alive _vehicle;
#endif
		
		if ((_disabled && _empty) || (_empty && !_aliveve)) then {
			_number_v = _vec_a select 1;
			_hasbox = [_vehicle, "d_ammobox", false] call XfGetVar;
			if (_hasbox) then {["ammo_boxes",__XJIPGetVar(ammo_boxes) - 1] call XNetSetJIP};
			if (_number_v < 10 || (_number_v > 99 && _number_v < 110)) then {
				_dhqcamo = [_vehicle, "D_MHQ_Camo", objNull] call XfGetVar;
				if (!isNull _dhqcamo) then {deleteVehicle _dhqcamo};
			};
#ifndef __CARRIER__
			_camo = _vehicle getVariable "d_camonet";
			if (!isNil "_camo") then {deleteVehicle _camo;_camo = objNull} else {_camo = objNull};
#endif
			_isitlocked = _vehicle getVariable "d_vec_islocked";
			sleep 0.1;
			deletevehicle _vehicle;
			sleep 0.5;
			_vehicle = objNull;
			_vehicle = createVehicle [(_vec_a select 4), (_vec_a select 2), [], 0, "NONE"];
#ifndef __CARRIER__
			_vehicle setpos (_vec_a select 2);
#else
			if (_number_v > 9) then {
				_vehicle setPos (_vec_a select 3);
			} else {
				_vehicle setPosASL [(_vec_a select 2) select 0, (_vec_a select 2) select 1, 15.9];
			};
#endif
			_vehicle setdir (_vec_a select 3);
			if (_number_v < 10 || (_number_v > 99 && _number_v < 110)) then {
				_vehicle addeventhandler ["killed", {(_this select 0) setVariable ["D_MHQ_Deployed",false,true]}];
			};
			_vec_a set [0, _vehicle];
			_vec_array set [_i, _vec_a];
			_vehicle setVariable ["D_OUT_OF_SPACE", -1];
			_vehicle setVariable ["d_vec", _number_v, true];
			_vehicle setAmmoCargo 0;
			_vehicle setVariable ["d_vec_islocked", _isitlocked];
			if (_isitlocked) then {_vehicle lock true};
			["d_n_v", _vehicle] call XNetCallEvent;
			
#ifdef __TT__
			if (_number_v < 100) then {
				_vehicle addeventhandler ["killed", {_this call x_checkveckillwest}];
			} else {
				_vehicle addeventhandler ["killed", {_this call x_checkveckilleast}];
			};
#endif
#ifndef __CARRIER__
			if (isNull _camo) then {
				_camotype = switch (getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "side")) do {
					case 1: {if (__OAVer) then {"Land_CamoNetB_NATO_EP1"} else {"Land_CamoNetB_NATO"}};
					case 0: {if (__OAVer) then {"Land_CamoNetB_EAST_EP1"} else {"Land_CamoNetB_EAST"}};
				};
				_camo = createVehicle [_camotype, position _vehicle, [], 0, "NONE"];
				_camo setPos position _vehicle;
				_camo setDir (direction _vehicle) + 180;
				_vehicle setVariable ["d_camonet", _camo];
			};
#endif
		};
		sleep 8 + random 5;
	};
};