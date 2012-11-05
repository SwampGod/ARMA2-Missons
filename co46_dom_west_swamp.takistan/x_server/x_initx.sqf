// by Xeno
#include "x_setup.sqf"
if (!isServer) exitWith{};

d_allunits_add = [];
d_house_pat_grps = [];

__ccppfln(x_server\x_f\x_serverfuncs.sqf);
if (isNil "x_commonfuncs_compiled") then {__ccppfln(x_common\x_f\x_commonfuncs.sqf)};

__cppfln(X_fnc_spawnVehicle,x_server\x_f\fn_spawnvehicle.sqf);
__cppfln(X_fnc_spawnCrew,x_server\x_f\fn_spawncrew.sqf);
__cppfln(BI_fnc_taskDefend,x_server\x_f\fn_taskDefend.sqf);
__cppfln(x_makegroup,x_server\x_makegroup.sqf);
__cppfln(x_vehirespawn,x_server\x_vehirespawn.sqf);
__cppfln(x_vehirespawn2,x_server\x_vehirespawn2.sqf);
__cppfln(x_arifire,x_server\x_arifire.sqf);
__cppfln(x_createpara3x,x_server\x_createpara3x.sqf);
//__cppfln(t_housepatrol,scripts\HousePatrol.sqf);
#ifndef __TT__
__cppfln(x_fackilled,x_server\x_fackilled.sqf);
__cppfln(x_radarkilled,x_server\x_radarkilled.sqf);
#endif
__cppfln(x_markercheck,x_server\x_markercheck.sqf);
__cppfln(BI_fnc_objectMapper,x_server\x_f\fn_objectMapper.sqf);
#ifndef __OA__
__cppfln(x_flares,scripts\flares.sqf);
#endif
#ifdef __TT__
__cppfln(x_checkveckillwest,x_common\x_checkveckillwest.sqf);
__cppfln(x_checkveckilleast,x_common\x_checkveckilleast.sqf);
#endif

execFSM "fsms\NotAliveRemover.fsm";
execFSM "fsms\GroupClean.fsm";
//execFSM "fsms\HPatrol.fsm";

if (count d_with_isledefense > 0) then {execVM "x_server\x_isledefense.sqf"};

#ifndef __TT__
[] spawn {
	if (!isNil "d_with_carrier") then {sleep 20};
	private ["_x_objs", "_x_objs2", "_x_objs3", "_dgrp", "_unit_array", "_radar"];
	_x_objs = [];
	_x_objs2 = [];
	_x_objs3 = [];
	_radar = "";
	_clamshell = if (__OAVer) then {"76n6ClamShell_EP1"} else {"76n6ClamShell"};
	if (d_own_side == "WEST") then {
		_radar = if (__OAVer) then {"US_WarfareBAntiAirRadar_EP1"} else {"USMC_WarfareBAntiAirRadar"};
		_x_objs = if (__OAVer) then {
			[d_base_radar_pos, random 0, ["radar","us_army"], 0, [_clamshell,_radar]] call BI_fnc_objectMapper
		} else {
			[d_base_radar_pos, random 0, ["radar","usmc"], 0, [_clamshell,_radar]] call BI_fnc_objectMapper
		};
	} else {
		_radar = if (__OAVer) then {"TK_WarfareBAntiAirRadar_EP1"} else {"RU_WarfareBAntiAirRadar"};
		_x_objs = if (__OAVer) then {
			[d_base_radar_pos, random 0, ["radar","tk_army"], 0, [_clamshell,_radar]] call BI_fnc_objectMapper
		} else {
			[d_base_radar_pos, random 0, ["radar","ru"], 0, [_clamshell,_radar]] call BI_fnc_objectMapper
		};
	};

	_dgrp = [d_own_side] call x_creategroup;
	_unit_array = ["basic", d_own_side] call x_getunitliste;
	[d_base_radar_pos, (_unit_array select 0), _dgrp,true] call x_makemgroup;
	[_dgrp, d_base_radar_pos] call BI_fnc_taskDefend;

	if (d_own_side == "WEST") then {
		_x_objs2 = if (__OAVer) then {
			[d_base_anti_air1, random 0, ["anti-air","us_army"]] call BI_fnc_objectMapper
		} else {
			[d_base_anti_air1, random 0, ["anti-air","usmc"]] call BI_fnc_objectMapper
		};
	} else {
		_x_objs2 = if (__OAVer) then {
			[d_base_anti_air1, random 0, ["anti-air","tk_army"]] call BI_fnc_objectMapper
		} else {
			[d_base_anti_air1, random 0, ["anti-air","ru"]] call BI_fnc_objectMapper
		};
	};

	_dgrp = [d_own_side] call x_creategroup;
	_unit_array = ["basic", d_own_side] call x_getunitliste;
	[d_base_anti_air1, (_unit_array select 0), _dgrp,true] call x_makemgroup;
	[_dgrp, d_base_anti_air1] call BI_fnc_taskDefend;

	if (d_own_side == "WEST") then {
		_x_objs3 = if (__OAVer) then {
			[d_base_anti_air2, random 0, ["anti-air","us_army"]] call BI_fnc_objectMapper
		} else {
			[d_base_anti_air2, random 0, ["anti-air","usmc"]] call BI_fnc_objectMapper
		};
	} else {
		_x_objs3 = if (__OAVer) then {
			[d_base_anti_air2, random 0, ["anti-air","tk_army"]] call BI_fnc_objectMapper
		} else {
			[d_base_anti_air2, random 0, ["anti-air","ru"]] call BI_fnc_objectMapper
		};
	};

	_dgrp = [d_own_side] call x_creategroup;
	_unit_array = ["basic", d_own_side] call x_getunitliste;
	[d_base_anti_air2, (_unit_array select 0), _dgrp,true] call x_makemgroup;
	[_dgrp, d_base_anti_air2] call BI_fnc_taskDefend;

	{
		_rbox = false;
		if (__RankedVer) then {
			if (_x isKindOf "ReammoBox") then {
				deleteVehicle _x;
				_rbox = true;
			};
		};
		if (!_rbox) then {
			if (!(_x isKindOf _radar)) then {
				__addDead(_x)
				if ((_x isKindOf "HMMWV_Avenger") || (_x isKindOf "2S6M_Tunguska") || (_x isKindOf "ZSU_TK_EP1") || (_x isKindOf "HMMWV_Avenger_DES_EP1") || (_x isKindOf "M6_EP1")) then {
					_dgrp = [d_own_side] call x_creategroup;
					_crew = [_x, _dgrp] call X_fnc_spawnCrew;
				};
			} else {
				_x addEventHandler ["killed", {_this call x_radarkilled}];
			};
		};
	} forEach _x_objs + _x_objs2 + _x_objs3;
};
#endif
