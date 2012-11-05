// by Xeno
#include "x_setup.sqf"
private ["_speed_str", "_fuel_str", "_dam_str", "_dir_str", "_gendirlist", "_welcome_message", "_vec", "_welcome_str", "_vec_msg1", "_struct_text", "_endtime", "_type_name", "_vec_string", "_vdir", "_gendir", "_dstr", "_count", "_control", "_type_weap", "_dirtmp"];
_speed_str = "Speed: %1 km/h";
_fuel_str =  "Fuel: %1";
_dam_str =   "Dam: %1";
_dir_str =   "Dir: %1 (%2)";
_gendirlist = ["N","N-NE","NE","E-NE","E","E-SE","SE","S-SE","S","S-SW","SW","W-SW","W","W-NW","NW","N-NW","N"];

disableSerialization;

_welcome_message = {
	private ["_vec"];
	_vec = _this select 0;
	_vtype = _this select 1;
	_welcome_str = format ["Welcome on board, %1", name player];
	_vec_msg1 = "";
	if (_vtype == "MHQ") then {
		_vec_msg1 = "This is a mobile respawn vehicle. You can load or drop an ammocrate, and if deployed you can use it to respawn, teleport, create a vehicle or satellite view.";
	} else {
		if (_vtype == "Engineer") then {
			_vec_msg1 = "This is an engineer salvage truck. You can load static weapons and unload them.";
		};
	};
	_struct_text = composeText[parseText("<t color='#f0a7ff31' size='1'>" + _welcome_str + "</t>"), lineBreak,lineBreak,_vec_msg1];
	_endtime = time + 8;
	hintSilent _struct_text;
	while {vehicle player != player && alive player && time < _endtime} do {
		sleep 0.321;
		hintSilent _struct_text;
	};
	hintSilent "";
};

while {true} do {
	waitUntil {sleep (0.2 + random 0.2);vehicle player != player};
	_vec = vehicle player;
	if (_vec isKindOf "LandVehicle" && !(_vec isKindOf "StaticWeapon")) then {
		if (d_show_vehicle_welcome == 0) then {
			_vtype = _vec getVariable "d_vec_type";
			if (!isNil "_vtype") then {
				if (_vtype == "MHQ" || _vtype == "Engineer") then {
					[_vec, _vtype] spawn _welcome_message;
				};
			};
		};
		while {vehicle player != player} do {
			if (player == driver _vec || player == gunner _vec || player == commander _vec) then {
				_type_name = [typeOf _vec,0] call XfGetDisplayName;
				_vec_string = format ["Vec: %1", _type_name];
				67327 cutRsc ["xvehicle_hud", "PLAIN"];
				_disp = __uiGetVar(DVEC_HUD);
				while {vehicle player != player && alive player && player == driver _vec} do {
					_control = _disp displayCtrl 64432;
					_control ctrlSetText _vec_string;
					_control = _disp displayCtrl 64433;
					_control ctrlSetText format [_speed_str, round (speed _vec)];
					_control = _disp displayCtrl 64434;
					_control ctrlSetText format [_fuel_str, round (fuel _vec * 100)];
					_control = _disp displayCtrl 64435;
					_control ctrlSetText format [_dam_str, round (damage _vec * 100)];
					_vdir = round (direction _vec);
					_gendir = _gendirlist select (round (_vdir/22.5));
					_control = _disp displayCtrl 64436;
					_control ctrlSetText format [_dir_str, _vdir, _gendir];
					sleep 0.331;
				};
				67327 cutRsc["DOM_RscNothing", "PLAIN",1];
			};
			sleep 0.532;
		};
	} else {
		if (_vec isKindOf "StaticWeapon" && !(_vec isKindOf "ACE_SpottingScope") && !(_vec isKindOf "StaticATWeapon")) then {
			while {vehicle player != player} do {
				if (player == gunner _vec) then {
					_type_name = [typeOf _vec,0] call XfGetDisplayName;
					_vec_string = format ["Vec: %1", _type_name];
					_type_weap = (getArray(configFile>>"CfgVehicles" >> (typeOf _vec) >> "Turrets" >> "MainTurret" >> "weapons")) select 0;
					67327 cutRsc ["xvehicle_hud", "PLAIN"];
					_disp = __uiGetVar(DVEC_HUD);
					while {vehicle player != player && alive player && player == gunner _vec} do {
						_control = _disp displayCtrl 64432;
						_control ctrlSetText _vec_string;
						_control = _disp displayCtrl 64433;
						_control ctrlSetText format [_dam_str, round (damage _vec * 100)];
						_control = _disp displayCtrl 64434;
						_dirtmp = round(((_vec weaponDirection _type_weap) select 0) atan2 ((_vec weaponDirection _type_weap) select 1));
						if (_dirtmp < 0) then {_dirtmp = _dirtmp + 360};
						_gendir = _gendirlist select (round (_dirtmp/22.5));
						_control ctrlSetText format [_dir_str, _dirtmp, _gendir];
						_control = _disp displayCtrl 64435;
						_control ctrlSetText "";
						_control = _disp displayCtrl 64436;
						_control ctrlSetText "";
						sleep 0.331;
					};
					67327 cutRsc["DOM_RscNothing", "PLAIN",1];
				};
				sleep 0.532;
			};
		};
	};
	waitUntil {sleep (0.2 + random 0.2);vehicle player == player};	
};

if (true) exitWith {};
