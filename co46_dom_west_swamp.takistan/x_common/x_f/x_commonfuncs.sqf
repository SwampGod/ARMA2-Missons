#include "x_setup.sqf"

XfGetArtyKB = {["SecOp_Artillery_Barrage_Available_1", "SecOp_Artillery_Barrage_Available_2", "SecOp_Artillery_Barrage_Available_3"] call XfRandomArrayVal};

#ifndef __TT__
XfKBSendMsgAll = {
	private "_kbsound";
	_kbsound = if (count _this > 2) then {_this select 2} else {[]};
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,_this select 0,["1","",_this select 1,_kbsound],true];
};
XfKBSendMsgUnit = {
	private "_kbsound";
	_kbsound = if (count _this > 3) then {_this select 3} else {[]};
	d_kb_logic1 kbTell [_this select 0,d_kb_topic_side,_this select 1,["1","",_this select 2,_kbsound],true];
};
#else
XfKBSendMsgAll = {
	private "_kbsound";
	_kbsound = if (count _this > 3) then {_this select 3} else {[]};
	if ((_this select 0) == "") then {
		d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W",_this select 1,["1","",_this select 2,_kbsound],true];
		d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E",_this select 1,["1","",_this select 2,_kbsound],true];
	} else {
		switch (_this select 0) do {
			case "HQ_W": {d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W",_this select 1,["1","",_this select 2,_kbsound],true]};
			case "HQ_E": {d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E",_this select 1,["1","",_this select 2,_kbsound],true]};
		};
	};
};
XfKBSendMsgUnit = {
	private "_kbsound";
	_kbsound = if (count _this > 3) then {_this select 3} else {[]};
	switch (side (_this select 0)) do {
		case west: {d_hq_logic_en1 kbTell [_this select 0,"HQ_W",_this select 1,["1","",_this select 2,_kbsound],true]};
		case east: {d_hq_logic_ru1 kbTell [_this select 0,"HQ_E",_this select 1,["1","",_this select 2,_kbsound],true]};
	};
};
#endif

XfKBUseName = {
	switch (worldName) do {
		case "chernarus": {
			_usename = switch (_this) do {
				case "Stary Sobor": {"StarySobor"};
				case "Pustoschka": {"Pustoshka"};
				case "Berezino Harbour": {"Town"};
				default {""};
			};
			if (_usename == "") then {_this} else {_usename}
		};
		case "Takistan": {
			_usename = switch (_this) do {
				case "Mulladost": {"Mulladoost"};
				case "Feruz-Abad": {"FeeruzAbad"};
				case "Sakhe": {"Sakhee"};
				case "Chak Chak": {"ChakChak"};
				default {""};
			};
			if (_usename == "") then {_this} else {_usename}
		};
		default {
			"Town"
		};
	}
};

X_fnc_subSelect = {
	/************************************************************
		Subarray Select
		By Andrew Barron

	Returns a sub-selection of the passed array. There are various
	methods the sub-array can be determined.

	Parameters: [array, beg, <end>]
	Returns: subarray

	array - Array to select sub array from.
	beg - Index of array to begin sub-array. If negative, index is
		counted from the end of array.
	end - Optional. Index of array to end the sub-array. If ommitted,
		remainder of the array will be selected. If negative, it
		specifies the length of the sub-array (in absolute form).

	Examples:

		_array = ["a","b",true,3,8];
		[_array, 2] call X_fnc_subSelect; //returns [true,3,8]
		[_array, -2] call X_fnc_subSelect; //returns [3,8]
		[_array, 1, 3] call X_fnc_subSelect; //returns ["b",true,3]
		[_array, 1, -2] call X_fnc_subSelect; //returns ["b",true]

	************************************************************/

	private ["_ary","_beg","_len","_end","_ret","_i"];
	_ret = [];
	_ary = _this select 0;
	_len = (count _ary)-1;
	_beg = _this select 1;
	if(_beg < 0) then {_beg = _len + _beg + 1};
	_end = if(count _this > 2) then {_this select 2} else {_len};
	if(_end < 0) then {_end = _beg - _end - 1};
	if(_end > _len) then {_end = _len};
	for "_i" from _beg to _end do {_ret set [count _ret, _ary select _i]};
	_ret
};

X_fnc_arrayInsert = {
	/************************************************************
		Array Insert
		By Andrew Barron

	Parameters: [base array, insert array, index]
	Returs: [array]

	Inserts the elements of one array into another, at a specified
	index.

	Neither arrays are touched by reference, a new array is returned.

	Example: [[0,1,2,3,4], ["a","b","c"], 1] call X_fnc_arrayInsert
	Returns: [0,"a","b","c",1,2,3,4]
	************************************************************/

	private ["_baseArray","_toInsert","_index","_ret"];
	_baseArray = _this select 0;
	_toInsert = _this select 1;
	_index = _this select 2;
	if(_index > 0) then {
		_ret = [_baseArray, 0, _index-1] call X_fnc_subSelect;
		[_ret, _toInsert] call X_fnc_arrayPushStack;
	} else {
		_ret = _toInsert;
	};
	[_ret, [_baseArray, _index] call X_fnc_subSelect] call X_fnc_arrayPushStack;
	_ret
};

X_fnc_returnVehicleTurrets = {
	/*
		File: fn_returnVehicleTurrets.sqf
		Author: Joris-Jan van 't Land

		Description:
		Function return the path to all turrets and sub-turrets in a vehicle.

		Parameter(s):
		_this select 0: vehicle config entry (Config)

		Returns:
		Array of Scalars and Arrays - path to all turrets
	*/
	if ((count _this) < 1) exitWith {[]};
	private ["_entry"];
	_entry = _this select 0;
	if ((typeName _entry) != (typeName configFile)) exitWith {[]};
	private ["_turrets", "_turretIndex"];
	_turrets = [];
	_turretIndex = 0;
	for "_i" from 0 to ((count _entry) - 1) do {
		private ["_subEntry"];
		_subEntry = _entry select _i;
		if (isClass _subEntry) then {
			private ["_hasGunner"];
			_hasGunner = [_subEntry, "hasGunner"] call X_fnc_returnConfigEntry;
			if (!(isNil "_hasGunner")) then {
				if (_hasGunner == 1) then {
					_turrets set [count _turrets, _turretIndex];
					if (isClass (_subEntry >> "Turrets")) then {
						_turrets set [count _turrets, [_subEntry >> "Turrets"] call X_fnc_returnVehicleTurrets];
					} else {
						_turrets set [count _turrets, []];
					};
				};
			};
			_turretIndex = _turretIndex + 1;
		};
	};
	_turrets
};

X_fnc_returnConfigEntry = {
	/*
		File: returnConfigEntry.sqf
		Author: Joris-Jan van 't Land

		Description:
		Explores parent classes in the run-time config for the value of a config entry.
		
		Parameter(s):
		_this select 0: starting config class (Config)
		_this select 1: queried entry name (String)
		
		Returns:
		Number / String - value of the found entry
	*/
	if ((count _this) < 2) exitWith {nil};
	private ["_config", "_entryName"];
	_config = _this select 0;
	_entryName = _this select 1;
	if ((typeName _config) != (typeName configFile)) exitWith {nil};
	if ((typeName _entryName) != (typeName "")) exitWith {nil};
	private ["_entry", "_value"];
	_entry = _config >> _entryName;
	if (((configName (_config >> _entryName)) == "") && (!((configName _config) in ["CfgVehicles", "CfgWeapons", ""]))) then {
		[inheritsFrom _config, _entryName] call X_fnc_returnConfigEntry;
	} else {
		if (isNumber _entry) then {
			_value = getNumber _entry;
		} else {
			if (isText _entry) then {_value = getText _entry};
		};
	};
	if (isNil "_value") exitWith {nil};
	_value
};

x_commonfuncs_compiled = true;