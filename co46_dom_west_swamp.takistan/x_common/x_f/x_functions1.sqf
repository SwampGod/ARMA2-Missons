// by Xeno
#include "x_setup.sqf"

x_funcs1_compiled = false;

X_fnc_arrayPushStack = {
	{(_this select 0) set [count (_this select 0), _x]} foreach (_this select 1);
	(_this select 0)
};

// get a random numer, floored
// parameters: number
// example: _randomint = 30 call XfRandomFloor;
XfRandomFloor = {floor (random _this)};

// shuffles the content of an array
// parameters: array
// example: _myrandomarray = _myNormalArray call XfRandomArray;
XfRandomArray = {
	private ["_ar","_ran_array","_this"];
	_ar =+ _this;
	_ran_array = [];
	while {count _ar > 0} do {
		_ran = (count _ar) call XfRandomFloor;
		_ran_array set [count _ran_array, _ar select _ran];
		_ar set [_ran, "xfXX_del"];
		_ar = _ar - ["xfXX_del"];
	};
	_ran_array
};

// creates an array with count random indices
// parameters: int (number of entries)
// example: _myrandomindexarray = _numberentries call XfRandomIndexArray;
XfRandomIndexArray = {
	private ["_count","_ran_array"];
	_count = _this;
	_ran_array = [];
	for "_i" from 0 to (_count - 1) do {_ran_array set [count _ran_array, _i]};
	_ran_array = _ran_array call XfRandomArray;
	_ran_array
};

XfGetConfigGroup = {
	private ["_side", "_type", "_typeunits", "_typegroup", "_ret", "_config", "_i", "_cfgn"];
	_side = _this select 0; // "West"
	_type = _this select 1; // "USMC"
	_typeunits = _this select 2; // "Infantry"
	_typegroup = _this select 3;  // "USMC_InfSquad"
	_ret = [];
	
	_config = (configFile >> "CfgGroups" >> _side >> _type >> _typeunits >> _typegroup);
	if (isClass _config) then {
		for "_i" from 0 to (count _config - 1) do {
			_cfgn = _config select _i;
			if (isClass _cfgn) then {_ret set [count _ret, getText (_cfgn >> "vehicle")]};
		};
	};
	_ret
};

#ifdef __ACE__
XfGetAltTankStatus = {
	private ["_c", "_s"];
	_c = [_this, "ace_canmove", true] call XfGetVar;
	_s = [_this, "ace_canshoot", true] call XfGetVar;
	if (!_s && !_c) then {true} else {false}
};
#endif

// direction from one object to another
// parameters: object1, object2
// example: _dir = [tank1, apc1] call XfDirToObj;
XfDirToObj = {
	private ["_o1","_o2","_deg"];
	_o1 = _this select 0;_o2 = _this select 1;
	_deg = ((position _o2 select 0) - (position _o1 select 0)) atan2 ((position _o2 select 1) - (position _o1 select 1));
	if (_deg < 0) then {_deg = _deg + 360};
	_deg
};

// get a random number, floored, from count array
// parameters: array
// example: _randomarrayint = _myarray call XfRandomFloorArray;
XfRandomFloorArray = {floor (random (count _this))};

// get a random item from an array
// parameters: array
// example: _randomval = _myarray call XfRandomArrayVal;
XfRandomArrayVal = {_this select (_this call XfRandomFloorArray)};

// get a random numer, ceiled
// parameters: number
// example: _randomint = 30 call XfRandomCeil;
XfRandomCeil = {ceil (random _this)};

// returns the number of human players currently playing a mission in MP
XPlayersNumber = {(playersNumber east + playersNumber west + playersNumber resistance + playersNumber civilian)};

// gets a random number in a specific range
// parameters: number from, number to (second number must be greater than first)
// example: _random_number = [30,150] call XfGetRandomRange;
XfGetRandomRange = {
	private ["_num1","_num2","_ra"];
	_num1 = _this select 0;_num2 = _this select 1;
	_ra = _num2 - _num1;
	_ra = random _ra;
	(_num1 + _ra)
};

// gets a random integer number in a specific range
// parameters: integer from, integer to (second number must be greater than first)
// example: _random_integer = [30,150] call XfGetRandomRangeInt;
XfGetRandomRangeInt = {
	private ["_num1","_num2","_ra"];
	_num1 = _this select 0;_num2 = _this select 1;
	if (_num1 > _num2) then {_num1 = _this select 1;_num2 = _this select 0};
	_ra = _num2 - _num1;
	_ra = _ra call XfRandomFloor;
	(_num1 + _ra)
};

// compares two arrays, if equal returns true, if not false
// parameters: array1, array2
// example: _isequal = [array1, array2] call XfArrayCompare;
XfArrayCompare = {if (str (_this select 0) == str (_this select 1)) then {true} else {false}};

// get height of object
// parameters: object (no brackets)
// _height = tank1 call XfGetHeight;
XfGetHeight = {position _this select 2};

// set only height of an object
// parameters: object, height
// example: [unit1, 30] call XfSetHeight;
XfSetHeight = {(this select 0) setPos [position (this select 0) select 0, position (this select 0) select 1, (_this select 1)]};

// set only ASL height of an object
// parameters: object, height
// example: [unit1, 30] call XfSetASLHeight;
XfSetASLHeight = {(this select 0) setPosASL [position (this select 0) select 0, position (this select 0) select 1, (_this select 1)]};

// set only ATL height of an object
// parameters: object, height
// example: [unit1, 30] call XfSetATLHeight;
XfSetATLHeight = {(this select 0) setPosATL [position (this select 0) select 0, position (this select 0) select 1, (_this select 1)]};

// get x position of an object
// parameters: object (no brackets)
// _posx = tank1 call XfGetPosX;
XfGetPosX = {position _this select 0};

// set only x position of an object
// parameters: object, x
// example: [unit1, 30] call XfSetPosX;
XfSetPosX = {(this select 0) setPos [(_this select 1), position (this select 0) select 1, position (this select 0) select 2]};

// get y position of an object
// parameters: object (no brackets)
// _posy = tank1 call XfGetPosY;
XfGetPosY = {position _this select 1};

// set only y position of an object
// parameters: object, y
// example: [unit1, 30] call XfSetPosY;
XfSetPosY = {(this select 0) setPos [position (this select 0) select 0, (_this select 1), position (this select 0) select 2]};

// get displayname of an object
// parameters: type of object (string), what (0 = CfgVehicles, 1 = CfgWeapons, 2 = CfgMagazines)
// example: _dispname = ["UAZ", 0] call XfGetDisplayName;
XfGetDisplayName = {
	private ["_obj_name", "_obj_kind", "_cfg"];
	_obj_name = _this select 0;_obj_kind = _this select 1;
	_cfg = switch (_obj_kind) do {case 0: {"CfgVehicles"};case 1: {"CfgWeapons"};case 2: {"CfgMagazines"};};
	getText (configFile >> _cfg >> _obj_name >> "displayName")
};

// from warfare
// Returns an average slope value of terrain within passed radius.
// a little bit modified. no need to create a "global" logic, local is enough, etc
// parameters: position, radius
// example: _slope = [the_position, the_radius] call XfGetSlope;
if (isNil "X_SlopeObject") then {X_SlopeObject = "HeliHEmpty" createVehicleLocal [0,0,0]};
XfGetSlope = {
	private ["_position", "_radius", "_centerHeight", "_height", "_direction", "_count"];
	_position = _this select 0;_radius = _this select 1;
	X_SlopeObject setPos _position;
	_centerHeight = getPosASL X_SlopeObject select 2;
	_height = 0;_direction = 0;
	for "_count" from 0 to 7 do {
		X_SlopeObject setPos [(_position select 0)+((sin _direction)*_radius),(_position select 1)+((cos _direction)*_radius),0];
		_direction = _direction + 45;
		_height = _height + abs (_centerHeight - (getPosASL X_SlopeObject select 2));
	};
	_height / 8
};

// create a global marker, returns created marker
// parameters: marker name, marker pos, marker shape, marker color, marker size;(optional) marker text, marker dir, marker type, marker brush
// example: ["my marker",  position player, "Dot", "ColorBlue", [0.5,0.5]] call XfCreateMarkerGlobal;
XfCreateMarkerGlobal = {
	private ["_m_name","_m_pos","_m_shape","_m_col","_m_size","_m_text","_m_dir","_m_type","_m_brush","_m_alpha"];
	_m_name = _this select 0;
	_m_pos = _this select 1;
	_m_shape = _this select 2;
	_m_col = _this select 3;
	_m_size = _this select 4;
	_m_text = (if (count _this > 5) then {_this select 5} else {""});
	_m_dir = (if (count _this > 6) then {_this select 6} else {-888888});
	_m_type = (if (count _this > 7) then {_this select 7} else {""});
	_m_brush = (if (count _this > 8) then {_this select 8} else {""});
	_m_alpha = (if (count _this > 9) then {_this select 9} else {0});
	
	_marker = createMarker [_m_name, _m_pos];
	if (_m_shape != "") then {_marker setMarkerShape _m_shape};
	if (_m_col != "") then {_marker setMarkerColor _m_col};
	if (count _m_size > 0) then {_marker setMarkerSize _m_size};
	if (_m_text != "") then {_marker setMarkerText _m_text};
	if (_m_dir != -888888) then {_marker setMarkerDir _m_dir};
	if (_m_type != "") then {_marker setMarkerType _m_type};
	if (_m_brush != "") then {_marker setMarkerBrush _m_brush};
	if (_m_alpha != 0) then {_marker setMarkerAlpha _m_alpha};
	_marker
};

// create a local marker, returns created marker
// parameters: marker name, marker pos, marker shape, marker color, marker size;(optional) marker text, marker dir, marker type, marker brush
// example: ["my marker",  position player, "Dot", "ColorBlue", [0.5,0.5]] call XfCreateMarkerLocal;
XfCreateMarkerLocal = {
	private ["_m_name","_m_pos","_m_shape","_m_col","_m_size","_m_text","_m_dir","_m_type","_m_brush","_m_alpha"];
	_m_name = _this select 0;
	_m_pos = _this select 1;
	_m_shape = _this select 2;
	_m_col = _this select 3;
	_m_size = _this select 4;
	_m_text = (if (count _this > 5) then {_this select 5} else {""});
	_m_dir = (if (count _this > 6) then {_this select 6} else {-888888});
	_m_type = (if (count _this > 7) then {_this select 7} else {""});
	_m_brush = (if (count _this > 8) then {_this select 8} else {""});
	_m_alpha = (if (count _this > 9) then {_this select 9} else {0});
	
	_marker = createMarkerLocal [_m_name, _m_pos];
	if (_m_shape != "") then {_marker setMarkerShapeLocal _m_shape};
	if (_m_col != "") then {_marker setMarkerColorLocal _m_col};
	if (count _m_size > 0) then {_marker setMarkerSizeLocal _m_size};
	if (_m_text != "") then {_marker setMarkerTextLocal _m_text};
	if (_m_dir != -888888) then {_marker setMarkerDirLocal _m_dir};
	if (_m_type != "") then {_marker setMarkerTypeLocal _m_type};
	if (_m_brush != "") then {_marker setMarkerBrushLocal _m_brush};
	if (_m_alpha != 0) then {_marker setMarkerAlphaLocal _m_alpha};
	_marker
};

XfGetAliveUnits = {({alive _x} count _this)};

XfGetAliveUnitsGrp = {({alive _x} count (units _this))};

XfGetAliveCrew = {({alive _x} count (crew _this))};

XfGetAllAlive = {
	private "_ret";
	_ret = [];
	{if (alive _x) then {_ret set [count _ret, _x]}} forEach (units _this);
	_ret
};

XfDirTo = {
	/************************************************************
		Direction To
		By Andrew Barron

	Parameters: [object or position 1, object or position 2]

	Returns the compass direction from object/position 1 to
	object/position 2. Return is always >=0 <360.

	Example: [player, getpos dude] call BIS_fnc_dirTo
	************************************************************/
	private ["_pos1","_pos2","_ret"];
	_pos1 = _this select 0; _pos2 = _this select 1;

	if(typename _pos1 == "OBJECT") then {_pos1 = getpos _pos1};
	if(typename _pos2 == "OBJECT") then {_pos2 = getpos _pos2};

	_ret = ((_pos2 select 0) - (_pos1 select 0)) atan2 ((_pos2 select 1) - (_pos1 select 1));
	if (_ret < 0) then {_ret = _ret + 360};
	_ret
};

XfGetParachuteSide = {
	private "_ret";
	_ret = if (typeName _this == "STRING") then {
		switch (_this) do {
			case "EAST": {"ParachuteEast"};
			case "WEST": {"ParachuteWest"};
			case "GUER": {"ParachuteG"};
			case "CIV": {"ParachuteC"};
		}
	} else {
		switch (_this) do {
			case east: {"ParachuteEast"};
			case west: {"ParachuteWest"};
			case resistance: {"ParachuteG"};
			case civilian: {"ParachuteC"};
		}
	};
	_ret
};

XfCreateTrigger = {
	private ["_pos", "_trigarea", "_trigact", "_trigstatem", "_trigger"];
	_pos = _this select 0;
	_trigarea = _this select 1;
	_trigact = _this select 2;
	_trigstatem = _this select 3;
	_trigger = createTrigger ["EmptyDetector" ,_pos];
	_trigger setTriggerArea _trigarea;
	_trigger setTriggerActivation _trigact;
	_trigger setTriggerStatements _trigstatem;
	_trigger
};

XfGetVar = {
	private "_r";
	_r = (_this select 0) getVariable (_this select 1);
	if (isNil "_r") then {_this select 2} else {_r}
};

x_funcs1_compiled = true;