// by Xeno
#define THIS_FILE "x_chop_hud.sqf"
#include "x_setup.sqf"
private ["_state", "_vec", "_hud", "_control", "_chopttype", "_hudoff", "_nobjects", "_nearest", "_dummy", "_chdispx", "_nx", "_ny", "_px", "_py", "_control2", "_angle", "_a", "_b", "_dif", "_chdispx2", "_controlxx","_distvstr"];

sleep 1.012;

_X_Chopper_Welcome = {};

disableSerialization;

if (GVAR(show_chopper_welcome)) then {
	GVAR(rsc_end) = true;
	
	GVAR(xxvllist) = [];

	_X_Chopper_Welcome = {
		private ["_state", "_vec", "_welcome_str1", "_welcome_str2", "_welcome_str3", "_welcome_str4", "_end_welcome", "_hud", "_control"];
		disableSerialization;
		GVAR(rsc_end) = false;
		PARAMS_2(_state,_vec);
		_welcome_str1 = "Welcome on board, " + GVAR(name_pl) + "!";

		switch (_state) do {
			case 1: {
				_welcome_str2 = "This is the wreck lift chopper.";
				_welcome_str3 = "Remember, it can only lift wrecks.";
			};
			case 0: {
				_welcome_str2 = "This is a normal lift chopper.";
				_welcome_str3 = "It can lift allmost any vehicle except wrecks.";
			};
			default {
				_welcome_str2 = "This is a normal chopper.";
				_welcome_str3 = "It is not able to lift anything.";
			};
		};
		
		_ttyp = toUpper (typeOf _vec);
		if (count GVAR(xxvllist) == 0) then {
			{GVAR(xxvllist) set [count GVAR(xxvllist), toUpper _x]} forEach GVAR(check_ammo_load_vecs);
		};
		_welcome_str4 = if (_ttyp in GVAR(xxvllist)) then {
			 "It is able to load an ammobox."
		} else {
			"It is NOT able to load an ammobox."
		};
		
		_end_welcome = time + 14;
		67322 cutRsc ["chopper_hud", "PLAIN"];
		_hud = __uiGetVar(DCHOP_HUD);
		#define __CTRL(A) (_hud displayCtrl A)
		while {vehicle player != player && alive player && player == driver _vec} do {
			__CTRL(64438) ctrlSetText _welcome_str1;
			__CTRL(64439) ctrlSetText _welcome_str2;
			__CTRL(64440) ctrlSetText _welcome_str3;
			__CTRL(64441) ctrlSetText _welcome_str4;
			if (time >= _end_welcome) exitWith {};
			sleep 0.431;
		};
		67322 cutRsc ["Default", "PLAIN",1];
		GVAR(rsc_end) = true;
	};
};

_ui_forward = "\CA\ui\data\ui_tankdir_forward_ca.paa";
_ui_back = "\CA\ui\data\ui_tankdir_back_ca.paa";
_ui_left = "\CA\ui\data\ui_tankdir_left_ca.paa";
_ui_right = "\CA\ui\data\ui_tankdir_right_ca.paa";
_ui_tohigh = "\CA\ui\data\tankdir_turret_ca.paa";
_ui_ok = "\CA\ui\data\ui_tankdir_tower_ca.paa";

_distvstr = "Dist to vec: %1";
_typestr = "Type: %1";
_liftstr = "Lifting %1";
_distgrstr = "Dist attached to ground: %1";

#define __CTRL2(B) (_chdispx displayCtrl B)
#define __CTRL3(B) (_chdispx2 displayCtrl B)

while {true} do {
	waitUntil {sleep 0.218;alive player};
	waitUntil {sleep 0.221;vehicle player != player};
	_vec = vehicle player;
	while {vehicle player != player} do {
		if (player == driver _vec) then {
			if (_vec isKindOf "Helicopter" && !(_vec isKindOf "ParachuteBase") && !(_vec isKindOf "BIS_Steerable_Parachute")) then {
				_chopttype = GV(_vec,GVAR(choppertype));
				if (isNil "_chopttype") then {_chopttype = -1};
				if (GVAR(show_chopper_welcome)) then {
					if (_chopttype > -1) then {
						[_chopttype,_vec] spawn _X_Chopper_Welcome;
						sleep 0.321;
						waitUntil {GVAR(rsc_end)};
					};
				};
				if (_chopttype in [0,1]) then {
					if (isNil {GV(_vec,GVAR(Vehicle_Attached))}) then {_vec setVariable [QGVAR(Vehicle_Attached), false]};
					_search_height = 0;
					_lift_height = 0;
					_possible_types = GV(_vec,GVAR(lift_types));
					if (_chopttype == 1) then {
						_search_height = 70;
						_lift_height = 50;
					} else {
						_search_height = 50;
						_lift_height = 50;
					};
					_hudoff = true;
					while {vehicle player != player && alive player && player == driver _vec} do {
						if (GVAR(chophud_on)) then {
							_hudoff = false;
							_nobjects = nearestObjects [_vec, ["LandVehicle","Air"],_search_height];
							_nearest = objNull;
							if (count _nobjects > 0) then {
								_dummy = _nobjects select 0;
								if (_dummy == _vec) then {
									if (count _nobjects > 1) then {_nearest = _nobjects select 1};
								} else {
									_nearest = _dummy;
								};
								_lift_height = 11;
							};
							
							private "_marp";
							_marp = GV(_nearest,GVAR(WreckMaxRepair));
							if (isNil "_marp") then {_marp = GVAR(WreckMaxRepair)};
							_check_cond = if (_chopttype == 1) then {
								 (!isNull _nearest && damage _nearest >= 1 && ((typeof _nearest) in _possible_types) && _marp > 0)
							} else {
								(!isNull _nearest && ((typeof _nearest) in _possible_types) && (position _vec) select 2 > 2.5)
							};
							
							sleep 0.001;
							
							if (_check_cond) then {
								67321 cutRsc ["chopper_lift_hud", "PLAIN"];
								_chdispx = __uiGetVar(DCHOP_LIFT_HUD);
								__CTRL2(64440) ctrlSetText (if (_chopttype == 1) then {"Wreck Lift Chopper"} else {"Lift Chopper"});
								
								_type_name = [typeof _nearest,0] call FUNC(GetDisplayName);
								__CTRL2(64438) ctrlSetText (if !(GV(_vec,GVAR(Vehicle_Attached))) then {format [_typestr, _type_name]} else {format [_liftstr, _type_name]});
								__CTRL2(64439) ctrlSetText (if (getText (configFile >> "CfgVehicles" >> typeof _nearest >> "picture") != "picturestaticobject") then {
									 getText (configFile >> "CfgVehicles" >> typeof _nearest >> "picture")
								} else {
									""
								});
								
								if !(GV(_vec,GVAR(Vehicle_Attached))) then {
									__CTRL2(64441) ctrlSetText format [_distvstr, _vec distance _nearest];
									_nearest_pos = position _nearest;
									_pos_vec = position _vec;
									_nx = _nearest_pos select 0;_ny = _nearest_pos select 1;_px = _pos_vec select 0;_py = _pos_vec select 1;
									if ((_px <= _nx + 10 && _px >= _nx - 10) && (_py <= _ny + 10 && _py >= _ny - 10) && (_pos_vec select 2 < _lift_height)) then {
										__CTRL2(64448) ctrlSetText _ui_ok;
									} else {
										__CTRL2(64442) ctrlSetText (if ((position _vec) select 2 >= _lift_height) then {"Too high"} else {""});
										__CTRL2(64447) ctrlSetText _ui_tohigh;
										_angle = 0; _a = ((_nearest_pos select 0) - (_pos_vec select 0));_b = ((_nearest_pos select 1) - (_pos_vec select 1));
										if (_a != 0 || _b != 0) then {_angle = _a atan2 _b}; 
										
										_dif = _angle - direction _vec;
										if (_dif < 0) then {_dif = 360 + _dif};
										if (_dif > 180) then {_dif = _dif - 360};
										_angle = _dif;
										__CTRL2(64444) ctrlSetText (if (_angle >= -70 && _angle <= 70) then {_ui_forward} else {""});
										__CTRL2(64446) ctrlSetText (if (_angle >= 20 && _angle <= 160) then {_ui_right} else {""});
										__CTRL2(64443) ctrlSetText (if (_angle <= -110 || _angle >= 110) then {_ui_back} else {""});
										__CTRL2(64445) ctrlSetText (if (_angle <= -20 && _angle >= -160) then {_ui_left} else {""});
										sleep 0.001;
									};
								} else {
									__CTRL2(64441) ctrlSetText format [_distgrstr, (position _nearest) select 2];
									__CTRL2(64442) ctrlSetText "Attached";
									sleep 0.001;
								};
							} else {
								67321 cutRsc ["Default", "PLAIN"];
								67322 cutRsc ["chopper_lift_hud2", "PLAIN"];
								_chdispx2 = __uiGetVar(DCHOP_HUD2);
								__CTRL3(61422) ctrlSetText (switch (_chopttype) do {
									case 1: {"Wreck Lift Chopper"};
									case 0: {"Lift Chopper"};
								});
							};
						} else {
							if (!_hudoff) then {
								_hudoff = true;
								67321 cutRsc ["Default", "PLAIN"];
								67322 cutRsc ["Default", "PLAIN"];
							};
						};
						sleep 0.231;
					};
					67321 cutRsc ["Default", "PLAIN"];
					67322 cutRsc ["Default", "PLAIN"];
				} else {
					67322 cutRsc ["chopper_lift_hud2", "PLAIN"];
					_chdispx2 = __uiGetVar(DCHOP_HUD2);
					__CTRL3(61422) ctrlSetText "Normal Chopper";
					while {vehicle player != player && alive player && player == driver _vec} do {
						sleep 0.421;
					};
					67322 cutRsc ["Default", "PLAIN"];
				};
			};
		};
		sleep 0.432;
	};
	waitUntil {sleep 0.189; vehicle player == player};	
};