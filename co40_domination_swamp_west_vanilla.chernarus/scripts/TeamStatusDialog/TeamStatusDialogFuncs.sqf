// Desc: Team Status Dialog
// Features: Group joining, Team Leader selection, statistics for team/group/vehicle/opposition
// By: Dr Eyeball

// Dialog is now dependent on STR_TSD9_ entries which must be #include'd in stringtable.csv
#define THIS_FILE "TeamStatusDialogFuncs.sqf"
#include "x_setup.sqf"
#include "common.hpp"

#define TSD9_color_white [1.0, 1.0, 1.0, 1.0]
#define TSD9_color_black [0.0, 0.0, 0.0, 1.0]
#define TSD9_color_maroon [0.5, 0.0, 0.2, 1.0]
#define TSD9_color_red [1.0, 0.0, 0.0, 1.0]
#define TSD9_color_green [0.0, 1.0, 0.0, 1.0]
#define TSD9_color_blue [0.0, 0.0, 1.0, 1.0]
#define TSD9_color_orange [0.8, 0.2, 0.1, 1.0]
#define TSD9_color_yellow [.85, .85, 0.0, 1.0]
#define TSD9_color_ltPurple [0.7, 0.7, 1.0, 1.0]
#define TSD9_color_paleYellow [.35, .35, 0.0, 1]
#define TSD9_color_paleGreen [0.33, 0.73, 0.49, 0.5]
#define TSD9_color_paleBlue [0.3, 0.3, 0.7, 0.5]
#define TSD9_color_paleBlue2 [0, 0.4, 0.7, 1]
#define TSD9_color_paleRed [0.7, 0.3, 0.3, 0.7]
#define TSD9_color_Gray_10 [0.1, 0.1, 0.1, 1]
#define TSD9_color_Gray_20 [0.2, 0.2, 0.2, 1]
#define TSD9_color_Gray_30 [0.3, 0.3, 0.3, 1]
#define TSD9_color_Gray_40 [0.4, 0.4, 0.4, 1]
#define TSD9_color_Gray_50 [0.5, 0.5, 0.5, 1]
#define TSD9_AltBGDiff 0.02
#define TSD9_ColorScheme_DialogBackground 0x29/256, 0x37/256, 0x46/256
#define TSD9_ColorScheme_CaptionBackground 0x3E/256, 0x74/256, 0x58/256
#define TSD9_ColorScheme_3DControlBackground 40/256, 51/256, 34/256
#define TSD9_ColorScheme_3DControlBackgroundAlt (40/256)-TSD9_AltBGDiff, (51/256)-TSD9_AltBGDiff, (34/256)-TSD9_AltBGDiff
#define TSD9_ColorScheme_HighlightBackground 0x99/256, 0x8C/256, 0x58/256
#define TSD9_color_default [-1.0, -1.0, -1.0, -1.0]
#define TSD9_color_textFG TSD9_color_white
#define TSD9_color_groupBG [TSD9_ColorScheme_CaptionBackground, 1]
#define TSD9_color_playerBG [TSD9_ColorScheme_HighlightBackground, 1]
#define TSD9_color_cellABG [TSD9_ColorScheme_3DControlBackgroundAlt, 1]
#define TSD9_color_cellBBG [TSD9_ColorScheme_3DControlBackground, 1]

#define __disp (uiNamespace getVariable "D_ICE_TeamStatusDialog")

TSD9_ClosedGroups = [];
TSD9_funcs_inited = true;

TSD9_groupChat = {(_this select 0) groupChat (_this select 1)};
if !(isNil "ICE_groupChat") then {TSD9_groupChat = ICE_groupChat};

TSD9_GetParamIndexByName = {
	private ["_result","_paramName","_nestedArray","_paramIndex","_record","_dexit"];
	PARAMS_2(_paramName,_nestedArray);
	_paramIndex = if (count _this > 2) then {_this select 2} else {0};
	_result = -1;
	if (typeName _paramName == "ARRAY") exitWith {_result};
	if (typeName _nestedArray != "ARRAY") exitWith {_result};
	if (_paramIndex < 0) exitWith {_result};
	_dexit = false;
	{
		_record = _x;
		if (typeName _record == "ARRAY") then {
			if (count _record > _paramIndex) then {
				if (typeName(_record select _paramIndex) == typeName _paramName) then {
					if ((_record select _paramIndex) == _paramName) exitWith {
						_result = _forEachIndex;
						_dexit = true;
					};
				};
			};
		};
		if (_dexit) exitWith {};
	} forEach _nestedArray;
	_result
};

TSD9_GetParamByName = {
	private ["_result", "_paramName", "_nestedArray", "_default", "_paramIndex", "_resultIndex", "_index", "_record"];
	PARAMS_3(_paramName,_nestedArray,_default);
	_paramIndex = if (count _this > 3) then {_this select 3} else {0};
	_resultIndex = if (count _this > 4) then {_this select 4} else {1};
	_result = _default;
	_index = [_paramName, _nestedArray, _paramIndex] call TSD9_GetParamIndexByName;
	if (_index >= 0) then {
		_record = _nestedArray select _index;
		if (count _record > _resultIndex) then {
			_result = _record select _resultIndex;
		};
	};  
	_result
};

TSD9_ArraysAreEqual = {
    private ["_Result","_Array1","_Array2"];
	PARAMS_2(_Array1,_Array2);
	_Result = true;
	if (count _Array1 != count _Array2) then {
		_Result = false
	} else {
		{if (_x != (_Array2 select _forEachIndex)) exitWith {_Result = false}} forEach _Array1;
	};
	_Result
};

TSD9_SetCtrlColors = {
    private ["_fg2","_bg2","_altRow0","_altRow1","_altRow2","_row","_idc2","_col","_grey0","_grey1","_grey2"];
	PARAMS_4(_idc2,_col,_fg2,_bg2);
	if (_fg2 select 0 == TSD9_color_default select 0) then {_fg2 = TSD9_color_textFG};
	if (_bg2 select 0 == TSD9_color_default select 0) then {
		if (_col in [1,3,5,8,18,15]) then {
			_bg2 = TSD9_color_cellABG
		} else {
			_bg2 = TSD9_color_cellBBG
		};
	};
	_grey0 = _bg2 select 0;
	_grey1 = _bg2 select 1;
	_grey2 = _bg2 select 2;
	if ((([_bg2, TSD9_color_cellABG] call TSD9_ArraysAreEqual) || ([_bg2, TSD9_color_cellBBG] call TSD9_ArraysAreEqual))) then {
		_row = round((_idc2-1000)/100);
		if (_row / 3 == round(_row / 3)) then {
			_altRow0 = _grey0-TSD9_AltBGDiff;
			_altRow1 = _grey1-TSD9_AltBGDiff;
			_altRow2 = _grey2-TSD9_AltBGDiff;
			_bg2 = [_altRow0, _altRow1, _altRow2, _bg2 select 3];
		};  
	};
	(_idc2 call TSD9_getControl) ctrlSetTextColor _fg2;
	(_idc2 call TSD9_getControl) ctrlSetBackgroundColor _bg2;
};

TSD9_SetText = {
	ctrlSetText [_this select 0, _this select 4];
	_this call TSD9_SetCtrlColors
};

TSD9_SetCombo = {
    private ["_value","_picture","_index","_idc2","_txtArray2"];
	PARAMS_1(_idc2);
	_txtArray2 = _this select 4;
	lbClear _idc2;
	{
		_value = if (count _x > 0) then {_x select 0} else {""};
		_picture = if (count _x > 2) then {_x select 2} else {""};
		_index = lbAdd [_idc2, _value];
		lbSetPicture [_idc2, _index, _picture];
		lbSetData [_idc2, _index, _value];
	} forEach _txtArray2;
	lbSetCurSel [_idc2, 0];
	_this call TSD9_SetCtrlColors;
};

TSD9_HideCtrl = {
    private "_idc2";
	PARAMS_1(_idc2);
	lbClear _idc2;
	ctrlShow [_idc2, false];
};

TSD9_ShowCtrl = {
	ctrlShow [_this select 0, true];
};

TSD9_GetRowIdc = {
    1000+((_this select 0)*100);
};

TSD9_FilterIcons = {
	if (TSD9_HideIcons) then {""} else {_this select 0}
};

TSD9_GetPlayerIndex = {
    private "_id";
	_id = _this select 2;
	if (_id < 0) then {""} else {str(_id)}
};

TSD9_GetCloseGroupButtonText = {
    private "_group";
	_group = _this select 0;
	if ((TSD9_Page == "Team") || (TSD9_Page == "Opposition")) then {
		if ((str(_group)) in TSD9_ClosedGroups) then {
			"[+]"
		} else {
			"[-]"
		}
	} else {
		""
	}
};

TSD9_CreateCloseGroupButtonAction = {
    private ["_group","_AddOrRemoveSet"];
	PARAMS_1(_group);
	if ((TSD9_Page == "Team") || (TSD9_Page == "Opposition")) then {
		_AddOrRemoveSet = if ((str(_group)) in TSD9_ClosedGroups) then {"-"} else {"+"};
		format[ "TSD9_ClosedGroups = TSD9_ClosedGroups %1 [""%2""]; [] call TSD9_DrawPage", _AddOrRemoveSet, _group];
	} else {
		""
	};
};

TSD9_GetRank = {
    switch (rank (_this select 0)) do {
		case "PRIVATE": {localize "STR_TSD9_26"};
		case "CORPORAL": {localize "STR_TSD9_27"};
		case "SERGEANT": {localize "STR_TSD9_28"};
		case "LIEUTENANT": {localize "STR_TSD9_29"};
		case "CAPTAIN": {localize "STR_TSD9_30"}; 
		case "MAJOR": {localize "STR_TSD9_31"};
		case "COLONEL": {localize "STR_TSD9_32"};
		default {"UNKNOWN"};
	}
};

TSD9_GetPlayerName = {
    private ["_player","_name","_rank"];
	PARAMS_1(_player);
	_name = name _player;
	_rank = [_player] call TSD9_GetRank;
	_name = _rank+". "+_name;
	if (_name == "Error: No unit") then {_name = format["--%1-- %2. %3", localize "STR_TSD9_34", vehicleVarName _player, localize "STR_TSD9_35"]};
	if (!isPlayer _player) then {_name = format["(%1) %2", localize "STR_TSD9_33", _name]};
	_name
};

TSD9_VehicleHasTrueWeapons = {
    private ["_vehicle","_hasTrueWeapon","_weaponName","_weapons","_count"];
	PARAMS_1(_vehicle);
	_weapons = weapons _vehicle;
	_count = count _weapons;
	_hasTrueWeapon = (_count > 0);
	if (_count == 1) then {
		_weaponName = (_weapons select 0);
		if (_weaponName in ["CarHorn", "TruckHorn", "BikeHorn", "SportCarHorn"]) then {_hasTrueWeapon = false};
	};
	_hasTrueWeapon
};

TSD9_IsVehicle = {
    private "_obj";
	PARAMS_1(_obj);
	((_obj isKindOf "LandVehicle") || (_obj isKindOf "Air") || (_obj isKindOf "Ship"))
};

TSD9_PlayerIsOpposition = {
	(side (group (_this select 0)) != sideFriendly)
};

TSD9_HideOppositionInfo = {
    private ["_player","_txt"];
	PARAMS_2(_player,_txt);
	if (side (group _player) != playerSide) then {""} else {_txt}
};

TSD9_HideOppositionComboInfo = {
    private ["_player","_array"];
	PARAMS_2(_player,_array);
	if (side (group _player) != playerSide) then {[]} else {_array}
};

TSD9_GetVehicleType = {
    private ["_vehicle","_picture","_value","_class","_noAmmo","_classPath","_result","_weapons","_obj","_isVehicle","_data"];
    _result = [];
	PARAMS_1(_obj);
	_vehicle = objNull;
	_isVehicle = ([_obj] call TSD9_IsVehicle);
	if (_isVehicle) then {_vehicle = _obj} else {_vehicle = vehicle _obj};
	_value = "";
	_data = "";
	_picture = "";
	if ([_vehicle] call TSD9_IsVehicle) then {
		_value = typeOf _vehicle;
		_classPath = configFile >> "cfgVehicles" >> _value;
		if (isClass _classPath) then {
			_class = _classPath >> "picture"; if (isText _class) then {_picture = getText _class};
			_class = _classPath >> "displayName"; if (isText _class) then {_value = getText _class};
		};
		_result = [[_value, _data, [_picture] call TSD9_FilterIcons]];
		_result set [count _result, ["", "", ""]];
		_result set [count _result, [format["%1", round((1.0 - (damage _vehicle)) * 100) ]+"%", "", "\CA\ui\data\ui_action_repair_ca.paa"]];
		_result set [count _result, [format["%1", round((fuel _vehicle) * 100) ]+"%", "", "\CA\ui\data\ui_action_refuel_ca.paa"]];
		if ([_vehicle] call TSD9_VehicleHasTrueWeapons) then {
			_noAmmo = if (someAmmo _vehicle) then {localize "STR_TSD9_36"} else {"0%"};
			_result set [count _result, [_noAmmo, "", "\CA\ui\data\ui_action_reammo_ca.paa"]];
		};
		_weapons = [_vehicle, true] call TSD9_GetGear;
		if (count _weapons > 0) then {
			_result set [count _result, ["--------------------", "", ""]];
			{_result set [count _result, _x]} forEach _weapons;
		};
	} else {
		_result = [];
	};
	_result
};

TSD9_GetVehicleSeat = {
    private ["_unit","_seat","_vehicle"];
	PARAMS_1(_unit);
	_seat = [];
	if (!([_unit] call TSD9_IsVehicle)) then {
		_vehicle = vehicle _unit;
		if ([_vehicle] call TSD9_IsVehicle) then {
			if (_unit == driver _vehicle) then {
				_seat = if (_vehicle isKindOf "Air") then {
					[["", "Pilot", "\CA\ui\data\i_driver_ca.paa"]]
				} else {
					[["", "Driver", "\CA\ui\data\i_driver_ca.paa"]]
				};
			};
			switch (true) do {
				case (_unit == gunner _vehicle): {_seat = [["", "Gunner", "\CA\ui\data\i_gunner_ca.paa"]]};
				case (_unit == commander _vehicle): {_seat = [["", "Cmdr", "\CA\ui\data\i_commander_ca.paa"]]};
			};
			if (count _seat == 0 && _unit in _vehicle) then {_seat = [["", "Cargo", "\CA\ui\data\i_cargo_ca.paa"]]};
		};
	};
	_seat
};

TSD9_GetShortRoleName = {
    private ["_ObjType","_role","_class","_classPath"];
	PARAMS_1(_ObjType);
	_role = _ObjType;
	_classPath = configFile >> "cfgVehicles" >> _role;
	if (isClass _classPath) then {
		_class = _classPath >> "displayName"; 
		if (isText _class) then {_role = getText _class};
	};
	_role
};

TSD9_GetRoleAndGear = {
    private ["_player","_allowVehicleGear","_role","_gear"];
	PARAMS_2(_player,_allowVehicleGear);
	_role = [_player] call TSD9_GetRole;
	_gear = [_player, _allowVehicleGear] call TSD9_GetGear;
	(_role + [["", "", ""]] + _gear)
};

TSD9_GetRole = {
    private ["_player","_role"];
	PARAMS_1(_player);
	_role = "";
	if !([_player] call TSD9_IsVehicle) then {
		_role = typeOf _player;
		_role = [_role] call TSD9_GetShortRoleName;
		if (_player == leader _player) then {
			_role = format["[%1] %2", localize "STR_TSD9_37", _role];
		};
	};
	[[_role, "", ""]]
};

TSD9_GetGear = {
    private ["_gear","_fn_GetGearArray","_weapons","_secondaryWeapon","_magazines","_player","_allowVehicleGear"];
	PARAMS_2(_player,_allowVehicleGear);
	_gear = [];
	if (!_allowVehicleGear && [_player] call TSD9_IsVehicle) then {
		_gear = [];
	} else {
		_fn_GetGearArray = {
            private ["_picture","_value","_class","_classPath","_type","_data"];
			PARAMS_2(_type,_value);
			_data = "";
			_picture = "";
			if (_type == "m") then {
				_classPath = configFile >> "CfgMagazines" >> _value;
				if (isClass _classPath) then {
					_class = _classPath >> "picture"; if (isText _class) then {_picture = getText _class};
					_class = _classPath >> "displayName"; if (isText _class) then {_value = getText _class};
				};
			};
			if (_type == "w") then {
				_classPath = configFile >> "cfgWeapons" >> _value;
				if (isClass _classPath) then {
					_class = _classPath >> "picture"; if (isText _class) then {_picture = getText _class};
					_class = _classPath >> "displayName"; if (isText _class) then {_value = getText _class};
				};
			};
			if (_picture == "") then {
				_classPath = configFile >> "cfgVehicles" >> _value;
				if (isClass _classPath) then {
					_class = _classPath >> "picture"; if (isText _class) then {_picture = getText _class};
					_class = _classPath >> "displayName"; if (isText _class) then {_value = getText _class};
				};
			};
			[_value, _data, [_picture] call TSD9_FilterIcons]
		};
		_weapons = weapons _player;
		_secondaryWeapon = secondaryWeapon _player;
		{
			if (_x == _secondaryWeapon) then {
				_gear = [["w", _x] call _fn_GetGearArray] + _gear;
			} else {
				_gear = _gear + [["w", _x] call _fn_GetGearArray];
			};
		} forEach _weapons;
		if (count _weapons > 0) then {_gear set [count _gear, ["--------------------"+"            ", "", ""]]};
		_magazines = magazines _player;
		{_gear set [count _gear, ["m", _x] call _fn_GetGearArray]} forEach _magazines;
	};
	_gear
};

TSD9_GetScoreTotal = {
    private "_player";
	PARAMS_1(_player);
	if ([_player] call TSD9_IsVehicle) then {
		"--"
	} else {
		str(score _player)
	}
};

/*TSD9_GetBonusScore = {
	//_player = _this select 0;
	"--"
};*/

/*TSD9_GetKills = {
	//_player = _this select 0;
	"--"
};*/

/*TSD9_GetDeaths = {
	//_player = _this select 0;
	"--"
};*/

/*TSD9_GetTKs = {
	//_player = _this select 0;
	"--"
};*/

TSD9_GetCommand = {
    private ["_wpGrifRef","_MapGridRef","_command","_player","_WPs"];
	PARAMS_1(_player);
	_command = currentCommand _player;
	_WPs = waypoints _player;
	if (count _WPs >= 2) then {
		_wpGrifRef = "";
		_MapGridRef = mapGridPosition waypointPosition (_WPs select 1);
		_wpGrifRef = format[" %1", _MapGridRef];
		if (count _WPs > 2) then {
			_wpGrifRef = _wpGrifRef + format[",%1", count _WPs];
		} else {
			_wpGrifRef = _wpGrifRef + " ";
		};
		_command = _wpGrifRef + _command;
	};
	if (!alive _player) then {_command = format["--%1--", localize "STR_TSD9_34"]};
	_command
};

TSD9_GetRequires = {
    private ["_vehicle","_obj","_requires"];
	PARAMS_1(_obj);
	_requires = [];
	_vehicle = objNull;
	if ([_obj] call TSD9_IsVehicle) then {
		_vehicle = _obj
	} else {
		_vehicle = vehicle player
	};
	if ([_vehicle] call TSD9_IsVehicle) then {
		if (damage _vehicle > 0.1) then {
			_requires set [count _requires, [format["%1", round((1.0 - (damage _vehicle)) * 100) ]+"%", "", "\CA\ui\data\ui_action_repair_ca.paa"]]
		};
		if (fuel _vehicle < 0.3) then {
			_requires set [count _requires, [ format["%1", round((fuel _vehicle) * 100) ]+"%", "", "\CA\ui\data\ui_action_refuel_ca.paa" ]]
		};
		if (([_vehicle] call TSD9_VehicleHasTrueWeapons) && (!someAmmo _vehicle)) then {
			_requires set [count _requires, ["", "", "\CA\ui\data\ui_action_reammo_ca.paa"]]
		};
	};
	if (!([_obj] call TSD9_IsVehicle)) then {
		if (damage _obj > 0.1) then {
			_requires set [count _requires, [format["%1", round((damage _obj) * 100) ]+"%", "", "\CA\ui\data\ui_action_heal_ca.paa"]]
		};
	};
	_requires
};

TSD9_GetPos = {
    mapGridPosition (_this select 0)
};

TSD9_GetSLProximity = {
    private ["_prox","_player"];
	PARAMS_1(_player);
	_prox = round(_player distance leader _player);
	if (_prox < 0.5 || _prox > 99999) then {_prox = 0.0};
	(str(_prox) + "m")
};

TSD9_GetMyProximity = {
    private ["_prox","_player"];
	PARAMS_1(_player);
	_prox = round(_player distance player);
	if (_prox < 0.5 || _prox > 99999) then {_prox = 0.0};
	(str(_prox) + "m")
};

TSD9_GetTargetOrThreats = {
    private ["_Target","_TargetName","_player"];
	PARAMS_1(_player);
	_Target = objNull;
	if (vehicle _player == _player) then {
		_Target = assignedTarget _player
	} else {
		_Target = assignedTarget (vehicle _player)
	};
	_TargetName = if (isNull _Target) then {
		""
	} else {
		[typeOf _Target] call TSD9_GetShortRoleName
	};
	_TargetName
};

TSD9_GetGroupDesc = {
    private ["_MyGroup","_GroupName","_group"];
	PARAMS_1(_group);
	_MyGroup = if (_group == group player) then {" " + localize "STR_TSD9_38"} else {""};
	_GroupName = str(_group);
	if ((TSD9_Page == "Vehicle") && (isNull _group || (_GroupName == "<NULL-group>"))) then {
		_GroupName = localize "STR_TSD9_39"
	};
	(_GroupName + _MyGroup)
};

TSD9_GetGroupSize = {
	if (TSD9_Page == "Vehicle") then {""} else {"(" + str(count units (_this select 0)) + ")"}
};

TSD9_GetGroupVehicleClassComposition = {
    private ["_currentVehicleClass","_class","_vehicle","_classPath","_vehicleClassesList","_vehicleClasses","_result","_group"];
	PARAMS_1(_group);
	_result = [];
	if (count _result == 0) then {
		_vehicleClasses = [];
		{
			_vehicle = vehicle _x;
			_currentVehicleClass = "";
			_classPath = configFile >> "cfgVehicles" >> typeOf _vehicle;
			if (isClass _classPath) then {
				_class = _classPath >> "vehicleClass";
				if (isText _class) then {_currentVehicleClass = getText _class};
			};
			if (!(_currentVehicleClass in _vehicleClasses)) then {
				_vehicleClasses set [count _vehicleClasses, _currentVehicleClass];
			};
		} forEach units _group;
		_vehicleClassesList = "";
		{
			if (_vehicleClassesList != "") then {_vehicleClassesList = _vehicleClassesList + ","};
			_vehicleClassesList = _vehicleClassesList + format["%1", _x];
		} forEach _vehicleClasses;
		_result = [[_vehicleClassesList, "", ""]];
	};
	_result
};

TSD9_JoinGroupByName = {
    private ["_has_player","_group","_groupName","_groupList"];
	PARAMS_1(_groupName);
	_groupList = allGroups;
	{
		_group = _x;
		if (str(_group) == _groupName) exitWith {
			[leader player, format["%1 %2 (%3)", name player, localize "STR_TSD9_40", group player]] call TSD9_groupChat;
			[player] join _group;
			if (d_with_ai) then {
				["d_p_group", [_group, player]] call FUNC(NetCallEvent);
				if (!isNull d_grp_caller) then {
					_has_player = false;
					{
						if (isPlayer _x) exitWith {_has_player = true};
					} forEach units d_grp_caller;
					if (!_has_player) then {
						{
							deleteVehicle _x;
						} forEach units d_grp_caller;
						deleteGroup d_grp_caller;
					};
				};
				d_grp_caller = _group;
			};
			[(leader _group), format["%1 %2 (%3)", name player, localize "STR_TSD9_41", _group]] call TSD9_groupChat;
			[] call TSD9_DrawPage;
		};
	} forEach _groupList;
};

TSD9_InviteAIOrPlayerIntoGroupByName = {
    private ["_unit","_playerToFind","_UnitList","_CheckIfPlayerMatches"];
	PARAMS_1(_playerToFind);
	_UnitList = allUnits;
	_CheckIfPlayerMatches = {
        private ["_groupIsEntirelyAI","_player"];
		PARAMS_1(_player);
		if (str(_player) == _playerToFind) then {
			if (isPlayer _player) then {
				[leader player, format["%1 %2 %3.", localize "STR_TSD9_44", name _player, localize "STR_TSD9_61"]] call TSD9_groupChat;
				[_player, format["%1, %2: %3 (%4).", name _player, localize "STR_TSD9_63", name player,group player]] call TSD9_groupChat;
			} else {
				_groupIsEntirelyAI = true;
				{
					if (isPlayer _x) then {_groupIsEntirelyAI = false};
				} forEach units _player;
				
				if (_groupIsEntirelyAI) then {
					[leader player, format["%1 %2 %3.", localize "STR_TSD9_33", [typeOf _player] call TSD9_GetShortRoleName, localize "STR_TSD9_62"]] call TSD9_groupChat;
					[_player] join group player;
					if ("AI" in d_version) then {
						["d_p_group", [group player, player]] call FUNC(NetCallEvent);
					};
					[] call TSD9_DrawPage;
				};
			};
		};
	};
	{
		_unit = _x;
		if ([_unit] call TSD9_IsVehicle) then {
			{
				[_x] call _CheckIfPlayerMatches;
			} forEach crew _unit;      
		} else {
			[_unit] call _CheckIfPlayerMatches;
		};
	} forEach _UnitList;
};

TSD9_SetNewTeamLeaderByName = {
	PARAMS_1(_playerToFind);
	_UnitList = allUnits;
	_CheckIfPlayerMatches = {
		PARAMS_1(_player);
		if (str(_player) == _playerToFind) then {
			[leader player, format["%1 %2. %3 %4.", localize "STR_TSD9_42", name _player, name player, localize "STR_TSD9_43"]] call TSD9_groupChat;
			(group player) selectLeader _player;
	  
			[] call TSD9_DrawPage;
		};
	};
	{
		_unit = _x;
		if (group _unit == group player) then {
			if ([_unit] call TSD9_IsVehicle) then {
				{[_x] call _CheckIfPlayerMatches} forEach crew _unit;
			} else {
				[_unit] call _CheckIfPlayerMatches;
			};
		};
	} forEach _UnitList;
};

TSD9_RemoveAIOrPlayerFromYourGroupByName = {
	PARAMS_1(_playerToFind);
	_CheckIfPlayerMatches = {
		PARAMS_1(_player);
		if (str(_player) == _playerToFind) then {
			if (isPlayer _player) then {
				[leader player, format["%1 %2 %3.", localize "STR_TSD9_44", name _player, localize "STR_TSD9_45"]] call TSD9_groupChat;
			} else {
				[leader player, format["%1 %2 %3.", localize "STR_TSD9_33", [typeOf _player] call TSD9_GetShortRoleName, localize "STR_TSD9_46"]] call TSD9_groupChat;

				if (TSD9_DeleteRemovedAI) then {deleteVehicle _player};
			};
			[_player] join grpNull;
			[] call TSD9_DrawPage;
		};
	};
	{
		_unit = _x;
		if (group _unit == group player) then {
			if ([_unit] call TSD9_IsVehicle) then {
				{[_x] call _CheckIfPlayerMatches} forEach crew _unit;
			} else {
				[_unit] call _CheckIfPlayerMatches;
			};
		};
	} forEach (units player);
};

TSD9_GetVehicleByName = {
	PARAMS_1(_VehicleName);
	_UnitList = allUnits;
	{
		_unit = _x;
		if ([_unit] call TSD9_IsVehicle) then {
			if (str(_unit) == _VehicleName) then {
				TSD9_Vehicle = _unit;
			};
		};
	} forEach _UnitList;
};

TSD9_LeaveGroup = {
	[leader player, format["%1 %2", name player, localize "STR_TSD9_40"]] call TSD9_groupChat;
	[player] join grpNull;
	if (d_with_ai) then {
		if (!isNull d_grp_caller) then {
			_has_player = false;
			{
				if (isPlayer _x) exitWith {_has_player = true};
			} forEach units d_grp_caller;
			if (!_has_player) then {
				{
					deleteVehicle _x;
				} forEach units d_grp_caller;
				deleteGroup d_grp_caller;
			};
		};
		d_grp_caller = objNull;
	};
	[] call TSD9_DrawPage;
};

TSD9_SetNewTLForAITeamLeader = {
	_TL_is_AI = !(isPlayer (leader player));
	if (_TL_is_AI) then {
		[leader player, format["%1. (%2) %3 %4.", localize "STR_TSD9_48",localize "STR_TSD9_33",name (leader player),localize "STR_TSD9_49"]] call TSD9_groupChat;
		(group player) selectLeader player;
	} else {
		[leader player, localize "STR_TSD9_50"] call TSD9_groupChat;
		hint (localize "STR_TSD9_50");
	};
	[] call TSD9_DrawPage;
};

TSD9_HideRow = {
	PARAMS_1(_row);
	_idc = [_row] call TSD9_GetRowIdc;
	[_idc+01, 01] call TSD9_HideCtrl;
	[_idc+02, 02] call TSD9_HideCtrl;
	[_idc+03, 03] call TSD9_HideCtrl;
	[_idc+04, 04] call TSD9_HideCtrl;
	[_idc+05, 05] call TSD9_HideCtrl;
	[_idc+07, 07] call TSD9_HideCtrl;
	[_idc+08, 08] call TSD9_HideCtrl;
	[_idc+13, 13] call TSD9_HideCtrl;
	[_idc+14, 14] call TSD9_HideCtrl;
	[_idc+15, 15] call TSD9_HideCtrl;
	[_idc+17, 17] call TSD9_HideCtrl;
	[_idc+18, 18] call TSD9_HideCtrl;
	[_idc+19, 19] call TSD9_HideCtrl;
	buttonSetAction [_idc+01, ""];
	buttonSetAction [_idc+19, ""];
};

TSD9_ShowRow = {
	PARAMS_1(_row);
	_idc = [_row] call TSD9_GetRowIdc;
	{[_idc+_x, _x] call TSD9_ShowCtrl} forEach [01, 02, 03, 04, 05, 07, 08, 13, 14, 15, 17, 18, 19];
	{[_idc+_x, _x, TSD9_color_default, TSD9_color_default] call TSD9_SetCtrlColors} forEach [01, 02, 03, 04, 05, 07, 08, 13, 14, 15, 17, 18, 19];
};

TSD9_ConfigTitleRow = {
	_row = 0;
	_idc = [_row] call TSD9_GetRowIdc;
	_fg = TSD9_color_default;
	_bg = TSD9_color_default;
	[_idc+01, 01, _fg, _bg, localize "STR_TSD9_11"] call TSD9_SetText;
	[_idc+02, 02, _fg, _bg, localize "STR_TSD9_12"] call TSD9_SetText;
	[_idc+03, 03, _fg, _bg, localize "STR_TSD9_13"] call TSD9_SetText;
	[_idc+04, 04, _fg, _bg, format["%1 %2", localize "STR_TSD9_05", localize "STR_TSD9_47"]] call TSD9_SetText;
	[_idc+05, 05, _fg, _bg, localize "STR_TSD9_15"] call TSD9_SetText;
	[_idc+07, 07, _fg, _bg, format["%1/%2 %3", localize "STR_TSD9_16", localize "STR_TSD9_17", localize "STR_TSD9_47"]] call TSD9_SetText;
	[_idc+08, 08, _fg, _bg, localize "STR_TSD9_18"] call TSD9_SetText;
	[_idc+13, 13, _fg, _bg, localize "STR_TSD9_19"] call TSD9_SetText;
	[_idc+14, 14, _fg, _bg, format["%1 %2", localize "STR_TSD9_20", localize "STR_TSD9_47"]] call TSD9_SetText;
	[_idc+15, 15, _fg, _bg, localize "STR_TSD9_21"] call TSD9_SetText;
	[_idc+17, 17, _fg, _bg, localize "STR_TSD9_23"] call TSD9_SetText;
	[_idc+18, 18, _fg, _bg, localize "STR_TSD9_24"] call TSD9_SetText;
	[_idc+19, 19, _fg, _bg, localize "STR_TSD9_25"] call TSD9_SetText;
};

TSD9_AddGroupRowButtonAction = {
	if (!((TSD9_Page == "Team") || (TSD9_Page == "Group") || (TSD9_Page == "Vehicle"))) exitWith {};
	PARAMS_2(_group,_idc2);
	_col = 19;
	_fg = TSD9_color_default;
	_bg = TSD9_color_groupBG;
	if (_group == group player) then {
		if (count units group player > 1) then {
			[_idc2, _col, _fg, _bg, localize "STR_TSD9_51"] call TSD9_SetText;  
			buttonSetAction [_idc2, "[] call TSD9_LeaveGroup"]; 
		};
	} else {
		if (count units _group > 0) then {
			[_idc2, _col, _fg, _bg, localize "STR_TSD9_52"] call TSD9_SetText;  
			buttonSetAction [_idc2, format["['%1'] call TSD9_JoinGroupByName", _group]];
		};
	};
};

TSD9_AddPlayerStatsRowButtonAction = {
	if (!((TSD9_Page == "Team") || (TSD9_Page == "Group") || (TSD9_Page == "Vehicle"))) exitWith {};
	PARAMS_2(_player,_idc2);
	_emptySeatStatRow = _this select 2;
	_col = 19;
	_fg = TSD9_color_default;
	_bg = TSD9_color_cellABG;
	if (_player == player) then {
		_TL_is_AI = !isPlayer (leader player);
		if (_TL_is_AI) then {
			[_idc2, _col, _fg, _bg, localize "STR_TSD9_53"] call TSD9_SetText;
			buttonSetAction [_idc2, "[] call TSD9_SetNewTLForAITeamLeader"];  
		};
	} else {
		_leaderAndYourGroup = (player == leader player) && (group _player == group player) && (!_emptySeatStatRow);
		_leaderAndOtherGroup = (player == leader player) && (group _player != group player) && (!_emptySeatStatRow);
		if ((TSD9_Page == "Group") && _leaderAndYourGroup && (TSD9_AllowAILeaderSelect || isPlayer _player) ) then {
			[_idc2, _col, _fg, _bg, localize "STR_TSD9_54"] call TSD9_SetText;
			buttonSetAction [_idc2, format["['%1'] call TSD9_SetNewTeamLeaderByName", _player]];
		};
		if ((TSD9_Page == "Team") && _leaderAndYourGroup) then {
			_command = if (isPlayer _player) then {localize "STR_TSD9_56"} else {localize "STR_TSD9_55"};
			[_idc2, _col, _fg, _bg, _command] call TSD9_SetText;
			buttonSetAction [_idc2, format["['%1'] call TSD9_RemoveAIOrPlayerFromYourGroupByName", _player]];
		};
		if ((TSD9_Page == "Team") && _leaderAndOtherGroup) then {
			_command = "";
			if (TSD9_AllowAIRecruitment && (TSD9_AllowPlayerRecruitment || not (isPlayer _player))) then {
				_command = localize "STR_TSD9_57";
			};
			if (TSD9_AllowPlayerInvites && isPlayer _player) then {
				_command = localize "STR_TSD9_58";
			};
			if (_command != "") then {
				[_idc2, _col, _fg, _bg, _command] call TSD9_SetText;
				buttonSetAction [_idc2, format["['%1'] call TSD9_InviteAIOrPlayerIntoGroupByName", _player]];
			};
		};
	};
};

TSD9_AddGroupRow = {
	PARAMS_2(_group,_row);
	_idc = [_row] call TSD9_GetRowIdc;
	[_row] call TSD9_ShowRow;
	_fg = TSD9_color_default;
	_bg = TSD9_color_groupBG;
	if ((TSD9_Page == "Team") || (TSD9_Page == "Opposition")) then {
		buttonSetAction [_idc+01, [_group] call TSD9_CreateCloseGroupButtonAction ];
		[_idc+01, 01, _fg, TSD9_color_cellABG, [_group] call TSD9_GetCloseGroupButtonText ] call TSD9_SetText;
	} else {
		buttonSetAction [_idc+01, "" ];
		[_idc+01, 01, _fg, TSD9_color_cellABG, "" ] call TSD9_SetText;
	};
	[_idc+02, 02, _fg, _bg, [_group] call TSD9_GetGroupSize ] call TSD9_SetText;
	[_idc+03, 03, _fg, _bg, [_group] call TSD9_GetGroupDesc ] call TSD9_SetText;
	[_idc+04, 04, _fg, _bg, [leader _group, [_group] call TSD9_GetGroupVehicleClassComposition] call TSD9_HideOppositionComboInfo] call TSD9_SetCombo;
	[_idc+05, 05, _fg, _bg, []] call TSD9_SetCombo;
	[_idc+07, 07, _fg, _bg, []] call TSD9_SetCombo;
	[_idc+08, 08, _fg, _bg, ""] call TSD9_SetText;
	[_idc+13, 13, _fg, _bg, ""] call TSD9_SetText;
	[_idc+14, 14, _fg, _bg, []] call TSD9_SetCombo;
	[_idc+15, 15, _fg, _bg, ""] call TSD9_SetText;
	[_idc+17, 17, _fg, _bg, ""] call TSD9_SetText;
	[_idc+18, 18, _fg, _bg, ""] call TSD9_SetText;
	[_idc+19, 19, _fg, TSD9_color_cellABG, ""] call TSD9_SetText;  
	buttonSetAction [_idc+19, ""];
	[_group, _idc+19] call TSD9_AddGroupRowButtonAction;
};

TSD9_AddPlayerStatsRow = {
	PARAMS_3(_player,_row,_id);
	_nameDesc = "";
	_seatDesc = [];
	_emptySeatStatRow = count _this >= 4;
	if (_emptySeatStatRow) then  {
		_seatName = _this select 3;
		_nameDesc = _seatName select 0;
		_seatDesc = [["", "", _seatName select 1]];
	} else {
		_nameDesc = [_player] call TSD9_GetPlayerName;
		_seatDesc = [_player, [_player] call TSD9_GetVehicleSeat] call TSD9_HideOppositionComboInfo;
	};
	_idc = [_row] call TSD9_GetRowIdc;
	[_row] call TSD9_ShowRow;
	_fg = TSD9_color_default;
	_bg = TSD9_color_default;
	if (_player == player) then {_bg = TSD9_color_playerBG};
	buttonSetAction [_idc+01, "" ];
	[_idc+01, 01, _fg, _bg, ""] call TSD9_SetText;
	[_idc+02, 02, _fg, _bg, [_player, _row, _id] call TSD9_GetPlayerIndex ] call TSD9_SetText;
	[_idc+03, 03, _fg, _bg, _nameDesc] call TSD9_SetText;
	[_idc+04, 04, _fg, _bg, [_player, [_player] call TSD9_GetVehicleType] call TSD9_HideOppositionComboInfo ] call TSD9_SetCombo;
	[_idc+05, 05, _fg, _bg, _seatDesc] call TSD9_SetCombo;
	[_idc+07, 07, _fg, _bg, [_player, [_player, false] call TSD9_GetRoleAndGear] call TSD9_HideOppositionComboInfo ] call TSD9_SetCombo;
	[_idc+08, 08, _fg, _bg, [_player] call TSD9_GetScoreTotal ] call TSD9_SetText;
	[_idc+13, 13, _fg, _bg, [_player, [_player] call TSD9_GetCommand] call TSD9_HideOppositionInfo ] call TSD9_SetText;
	[_idc+14, 14, _fg, _bg, [_player, [_player] call TSD9_GetRequires] call TSD9_HideOppositionComboInfo ] call TSD9_SetCombo;
	[_idc+15, 15, _fg, _bg, [_player, [_player] call TSD9_GetPos] call TSD9_HideOppositionInfo ] call TSD9_SetText;
	[_idc+17, 17, _fg, _bg, [_player, [_player] call TSD9_GetMyProximity] call TSD9_HideOppositionInfo ] call TSD9_SetText;
	[_idc+18, 18, _fg, _bg, [_player, [_player] call TSD9_GetTargetOrThreats] call TSD9_HideOppositionInfo ] call TSD9_SetText;
	[_idc+19, 19, _fg, TSD9_color_cellABG, ""] call TSD9_SetText;
	buttonSetAction [_idc+19, ""];
	[_player, _idc+19, _emptySeatStatRow] call TSD9_AddPlayerStatsRowButtonAction;
};

TSD9_GetAllGroupsFromUnits = {
	PARAMS_1(_AllUnits);
	_AllGroups = [];
	{
		_group = group _x;
		if (!(_group in _AllGroups) && _group != grpNull) then {_AllGroups set [count _AllGroups, _group]};
	} forEach _AllUnits;
  _AllGroups
};

TSD9_SortGroupsArray = {
	PARAMS_1(_GroupArray);
	_Result = [];
	{
		_SideStr = _x;
		{
			_Letter = _x;
			_GroupStr = _SideStr + " 1-1-" + _Letter;
			{
				_Group = _x;
				if (_GroupStr == str(_Group)) then {
					_Result set [count _Result, _Group];
					_GroupArray = _GroupArray - [_Group];
				};
			} forEach _GroupArray;
		} forEach ["A","B","C","D","E","F","G","H","I","J","K","L","M"];
	} forEach ["B", "O", "G", "C"];
	[_Result, _GroupArray] call FUNC(arrayPushStack)
};

TSD9_FillGroups = {
	PARAMS_1(_AllUnitsOrVehicle);
	_row = 1;
	_lastRow = TSD9_ROWS;
	if (TSD9_Page == "Team" || TSD9_Page == "Opposition" || TSD9_Page == "Group") then {
		_AllUnits = _AllUnitsOrVehicle;
		_AllGroups = [_AllUnits] call TSD9_GetAllGroupsFromUnits;
		_AllGroups = [_AllGroups] call TSD9_SortGroupsArray;
		{
			_group = _x;
			_ShowAIGroups = TSD9_ShowAIGroups || ({isPlayer _x} count (units _group) > 0);
			if ((count units _group > 0) && (((TSD9_Page == "Team") && (side _group == playerSide) && _ShowAIGroups) || 
			((TSD9_Page == "Opposition") && (side _group != playerSide) && _ShowAIGroups) || (TSD9_Page == "Group"))) then {
				[_group, _row] call TSD9_AddGroupRow;
				__INC(_row);
				if ((TSD9_Page == "Group") || (((TSD9_Page == "Team") || (TSD9_Page == "Opposition")) && !(str(_group) in TSD9_ClosedGroups))) then {
					_units = units _group;
					_id = 1;
					{
						if (_row <= _lastRow) then {
							[_x, _row, _id] call TSD9_AddPlayerStatsRow;
							__INC(_row);
							__INC(_id);
						};
					} forEach _units;
				};
			};
		} forEach _AllGroups;
	};
	if (TSD9_Page == "Vehicle") then {
		_vehicle = _AllUnitsOrVehicle;
		if (typeName _vehicle == "OBJECT") then {
			if ([_vehicle] call TSD9_IsVehicle) then {
				_AllUnits = crew _vehicle;
				_AllGroups = [_AllUnits] call TSD9_GetAllGroupsFromUnits;
				_id = 0;
				{
					_group = _x;
					[_group, _row] call TSD9_AddGroupRow;
					__INC(_row);
					_id = 1;
					{
						if (_row <= _lastRow) then {
							if (_x in (units _group)) then {
								[_x, _row, _id] call TSD9_AddPlayerStatsRow;
								__INC(_row);
								__INC(_id);
							};
						};
					} forEach _AllUnits;
				} forEach _AllGroups;
				_dr = _vehicle emptyPositions "driver";
				_gu = _vehicle emptyPositions "gunner";
				_co = _vehicle emptyPositions "commander";
				_ca = _vehicle emptyPositions "cargo";
				if ((_dr > 0) || (_gu > 0) || (_co > 0) || (_ca > 0)) then {
					[grpNull, _row] call TSD9_AddGroupRow;
					__INC(_row);
					_id = 1; 
					_drType = ""; 
					if (_vehicle isKindOf "Air") then {_drType = "Pilot"} else {_drType = "Driver"};
					{
						_seatCount = _x select 0;
						_seatName = _x select 1;
						if (_seatCount > 0) then {
							for "_i" from 0 to (_seatCount - 1) do {
								_picture = switch (_seatName) do {
									case "Pilot": {"\CA\ui\data\i_driver_ca.paa"};
									case "Driver": {"\CA\ui\data\i_driver_ca.paa"};
									case "Gunner": {"\CA\ui\data\i_gunner_ca.paa"};
									case "Commander": {"\CA\ui\data\i_commander_ca.paa"};
									default {""};
								};
								[_vehicle, _row, _id, [format["%1 %2", localize "STR_TSD9_59", _seatName], _picture]] call TSD9_AddPlayerStatsRow;
								__INC(_row);
								__INC(_id);
							};
						};
					} forEach [[_dr, _drType], [_gu, "Gunner"], [_co, "Commander"]];
					for "_i" from 0 to (_ca - 1) do {
						[_vehicle, _row, _id, [format["%1 %2 (%3)", localize "STR_TSD9_59", localize "STR_TSD9_60", 1+_i],"\CA\ui\data\i_cargo_ca.paa"]] call TSD9_AddPlayerStatsRow; 
						__INC(_row);
						__INC(_id);
					};
				};
			};
		};
	};
	while {_row <= _lastRow} do {
		[_row] call TSD9_HideRow;
		__INC(_row);
	};
};

TSD9_ShowCollapseExpandButtons = {
	PARAMS_1(_show);
	ctrlShow [TSD9_IDC_CollapseAllButton, _show];
	ctrlShow [TSD9_IDC_ExpandAllButton, _show];
};

TSD9_DrawPage_MyVehicle = {
	TSD9_Page = "Vehicle";
	_vehicle = vehicle player;
	if (str(TSD9_Vehicle) != "<NULL-OBJECT>" && typeName TSD9_Vehicle == "STRING") then {
		_vehicleNameToFind = TSD9_Vehicle;
		TSD9_Vehicle = objNull;
		[_vehicleNameToFind] call TSD9_GetVehicleByName;
	};
	if (typeName TSD9_Vehicle != "ARRAY") then {
		if (!(isNull TSD9_Vehicle) && ([TSD9_Vehicle] call TSD9_IsVehicle)) then {
			_vehicle = TSD9_Vehicle
		};
	};
	[_vehicle] call TSD9_FillGroups;
	call TSD9_SetTitle;
	ctrlSetFocus (TSD9_IDC_VehicleButton call TSD9_getControl);
	[false] call TSD9_ShowCollapseExpandButtons
};

TSD9_DrawPage_MyGroup = {
	TSD9_Page = "Group";
	[[player]] call TSD9_FillGroups;
	call TSD9_SetTitle;
	ctrlSetFocus (TSD9_IDC_MyGroupButton call TSD9_getControl);
	[false] call TSD9_ShowCollapseExpandButtons;
};

TSD9_DrawPage_Opposition = {
	TSD9_Page = "Opposition";
	[allUnits] call TSD9_FillGroups;
	call TSD9_SetTitle;
	ctrlSetFocus (TSD9_IDC_OppositionButton call TSD9_getControl);
	[true] call TSD9_ShowCollapseExpandButtons;
};

TSD9_DrawPage_MyTeam = {
	TSD9_Page = "Team";
	[allUnits] call TSD9_FillGroups;
	call TSD9_SetTitle;
	ctrlSetFocus (TSD9_IDC_MyTeamButton call TSD9_getControl);
	[true] call TSD9_ShowCollapseExpandButtons;
};

TSD9_DrawPage = {
	switch (format["%1", TSD9_Page]) do {
		case "Vehicle": {[] call TSD9_DrawPage_MyVehicle};
		case "Group": {[] call TSD9_DrawPage_MyGroup};
		case "Opposition": {[] call TSD9_DrawPage_Opposition};
		default {[] call TSD9_DrawPage_MyTeam};
	};  
};

TSD9_FillClosedGroupsWithAllGroups = {
	PARAMS_1(_AllUnits);
	_AllGroups = allGroups;
	TSD9_ClosedGroups = [];
	{TSD9_ClosedGroups set [count TSD9_ClosedGroups, str(_x)]} forEach _AllGroups;
	[] call TSD9_DrawPage;
};

TSD9_CollapseAll = {
	[allUnits] call TSD9_FillClosedGroupsWithAllGroups;
};

TSD9_ExpandAll = {
	TSD9_ClosedGroups = [];
	[] call TSD9_DrawPage;
};

TSD9_SetTitle = {
	_Page = "";
	switch (TSD9_Page) do {
		case "Vehicle": {_Page = localize "STR_TSD9_05"};
		case "Group": {_Page = localize "STR_TSD9_09"};
		case "Opposition": {_Page = localize "STR_TSD9_06"};
		default {_Page = localize "STR_TSD9_07"};
	};  
	ctrlSetText [TSD9_IDC_FrameCaption, format[" %1 - %2 ", localize "STR_TSD9_01", _Page]];
};

TSD9_LocalizeText = {
	if (localize "STR_TSD9_01" == "") then {"Missing STR_TSD9_* stringtable data" call FUNC(KBSideChat)};
	call TSD9_SetTitle;
	call TSD9_ConfigTitleRow;
	ctrlSetText [TSD9_IDC_CloseButton, localize "STR_TSD9_02"];
	buttonSetAction [TSD9_IDC_CloseButton, "closeDialog 0"];
	ctrlSetText [TSD9_IDC_MyTeamButton, localize "STR_TSD9_03"];
	buttonSetAction [TSD9_IDC_MyTeamButton, "[] call TSD9_DrawPage_MyTeam;"];
	ctrlSetText [TSD9_IDC_MyGroupButton, localize "STR_TSD9_04"];
	buttonSetAction [TSD9_IDC_MyGroupButton, "[] call TSD9_DrawPage_MyGroup;"];
	ctrlSetText [TSD9_IDC_VehicleButton, localize "STR_TSD9_05"];
	buttonSetAction [TSD9_IDC_VehicleButton, "[] call TSD9_DrawPage_MyVehicle;"];
	ctrlSetText [TSD9_IDC_OppositionButton, localize "STR_TSD9_06"];
	buttonSetAction [TSD9_IDC_OppositionButton, "[] call TSD9_DrawPage_Opposition;"];
	ctrlSetText [TSD9_IDC_CollapseAllButton, localize "STR_TSD9_64"];
	buttonSetAction [TSD9_IDC_CollapseAllButton, "[] call TSD9_CollapseAll;"];
	ctrlSetText [TSD9_IDC_ExpandAllButton, localize "STR_TSD9_65"];
	buttonSetAction [TSD9_IDC_ExpandAllButton, "[] call TSD9_ExpandAll;"];
};

TSD9_ProcessParameters = {
	private ["_parameters", "_actionParams", "_paramName", "_exists", "_getParamByName", "_default", "_result", "_invalid", "_closeDialog", "_gg"];
	_parameters = _this;
	_actionParams = [];
	if (count _parameters == 4) then  {
		if (typeName (_parameters select 3) == "ARRAY") then {
			_actionParams = _parameters select 3;
		};
	};
	_fn_ParamExists = {
		_paramName = _this select 0;
		_exists = ((_parameters find _paramName) > -1);
		if (!_exists) then {_exists = ((_actionParams find _paramName) > -1)};
		_exists
	};
	_getParamByName =  {
		_paramName = _this select 0;
		_default = _this select 1;
		_result = [_paramName, _parameters, _default] call TSD9_GetParamByName;
		_invalid = false;
		if (typeName _default != typeName _result) then {
			_invalid = true;
		} else {
			if (typeName _result != "OBJECT" || typeName _default != "OBJECT") then {
				_invalid = (_result == _default)
			} else {
				_invalid = ((isNull _default) && (isNull _result))
			};
		};
		if (_invalid) then {
			_result = [_paramName, _actionParams, _default] call TSD9_GetParamByName;
		};

		_result
	};
	if (["HideTeam"] call _fn_ParamExists) then {ctrlShow [TSD9_IDC_MyTeamButton, false]};
	if (["HideGroup"] call _fn_ParamExists) then {ctrlShow [TSD9_IDC_MyGroupButton, false]};
	if (["HideVehicle"] call _fn_ParamExists) then {ctrlShow [TSD9_IDC_VehicleButton, false]};
	if (["HideOpposition"] call _fn_ParamExists) then {ctrlShow [TSD9_IDC_OppositionButton, false]};
	TSD9_Vehicle = objNull;
	TSD9_Page = ["Page", "Team"] call _getParamByName;
	TSD9_HideIcons = (["HideIcons"] call _fn_ParamExists);
	TSD9_DeleteRemovedAI = (["DeleteRemovedAI"] call _fn_ParamExists);
	TSD9_AllowAILeaderSelect = (["AllowAILeaderSelect"] call _fn_ParamExists);
	TSD9_AllowAIRecruitment = (["AllowAIRecruitment"] call _fn_ParamExists);
	TSD9_AllowPlayerRecruitment = (["AllowPlayerRecruitment"] call _fn_ParamExists);
	TSD9_AllowPlayerInvites = (["AllowPlayerInvites"] call _fn_ParamExists);
	TSD9_ShowAIGroups = (["ShowAIGroups"] call _fn_ParamExists);
	TSD9_CloseOnKeyPress = (["CloseOnKeyPress"] call _fn_ParamExists);
	TSD9_Vehicle = ["VehicleObject", objNull] call _getParamByName;
	if (TSD9_CloseOnKeyPress) then {
		_closeDialog = format["closeDialog %1", TSD9_IDD_TeamStatusDialog];
		__disp displaySetEventHandler["KeyDown", _closeDialog];
	};
	call TSD9_LocalizeText;
	while {_row <= _lastRow} do {
		[_row] call TSD9_HideRow;
		__INC(_row);
	};
};

TSD9_getControl = {
	__disp displayCtrl _this;
};
