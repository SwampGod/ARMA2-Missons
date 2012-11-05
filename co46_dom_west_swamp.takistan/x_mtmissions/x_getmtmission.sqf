// by Xeno
#include "x_setup.sqf"

#define __getPos \
_poss = [_target_array2 select 0, _target_array2 select 2] call XfGetRanPointCircleBig;\
if (isOnRoad _poss) then {_poss = []};\
while {count _poss == 0} do {\
	_poss = [_target_array2 select 0, _target_array2 select 2] call XfGetRanPointCircleBig;\
	if (isOnRoad _poss) then {_poss = []};\
	sleep 0.01;\
}

#define __specops \
__GetEGrp(_newgroup)\
_unit_array = [#specops, d_enemy_side] call x_getunitliste;\
[_poss, (_unit_array select 0), _newgroup,true] spawn x_makemgroup;\
sleep 1.0112;\
_newgroup allowFleeing 0;\
[_newgroup, _poss] spawn BI_fnc_taskDefend

#define __vkilled(ktype) _vehicle addEventHandler [#killed, {_this set [count _this, #ktype]; _this call XfMTSMTargetKilled}]

private ["_man","_newgroup","_poss","_unit_array","_vehicle","_wp_array","_truck","_the_officer","_sec_kind","_fixor"];
if (!isServer) exitWith {};

_fixor = {
	private ["_unit", "_list"];
	_unit = _this;
	while {true} do {
		if (!alive _unit) exitWith {};
		sleep 0.01;
		_list = list d_current_trigger;
		if (("Car" countType _list <= d_car_count_for_target_clear) && ("Tank" countType _list <= d_tank_count_for_target_clear) && ("Man" countType _list <= d_man_count_for_target_clear)) exitWith {};
		sleep 3.219;
	};
	if (alive _unit) then {
		sleep 300 + random 60;
		if (alive _unit) then {
			_unit setDamage 1;
		};
	};
};

_wp_array = _this;

sleep 3.120;
_xx_ran = (count _wp_array) call XfRandomFloor;
_poss = _wp_array select _xx_ran;

_sec_kind = (floor (random 11)) + 1;

__TargetInfo

switch (_sec_kind) do {
	case 1: {
		__GetEGrp(_newgroup)
#ifndef __OA__
		_the_officer = switch (d_enemy_side) do {
			case "EAST": {"RU_Commander"};
			case "WEST": {"USMC_Soldier_Officer"};
			case "GUER": {"GUE_Commander"};
		};
#else
		_the_officer = switch (d_enemy_side) do {
			case "EAST": {"TK_Soldier_Officer_EP1"};
			case "WEST": {"US_Soldier_Officer_EP1"};
			case "GUER": {"TK_GUE_Warlord_EP1"};
		};
#endif
		_vehicle = _newgroup createUnit [_the_officer, _poss, [], 0, "FORM"];
		_svec = sizeOf _the_officer;
		_isFlat = (position _vehicle) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _vehicle];
		if (count _isFlat > 0) then {
			_vehicle setPos _isFlat;
			_poss = _isFlat;
		};
		_vehicle setVariable ["BIS_noCoreConversations", true];
		_vehicle setRank "COLONEL";
		_vehicle setSkill 0.3;
		_vehicle disableAI "MOVE";
		_vehicle spawn _fixor;
#ifndef __TT__
		_iar = __XJIPGetVar(d_searchintel);
		_sum = 0;
		{if (_x == 1) then {__INC(_sum)}} forEach _iar;
		if (_sum < count _iar) then {
			d_intel_unit = _vehicle;
			["d_searchbody", _vehicle] call XNetSetJIP;
			["d_s_b_client"] call XNetCallEvent;
		} else {
			if (!isNull __XJIPGetVar(d_searchbody)) then {["d_searchbody", objNull] call XNetSetJIP};
		};
		sleep 0.1;
#else
		__addDead(_vehicle)
#endif
		__vkilled(gov_dead);
		if (d_with_ai) then {
			if (__RankedVer) then {_vehicle addEventHandler ["killed", {[1,_this select 1] call XAddKillsAI}]};
		};
		sleep 1.0112;
		__specops;
	};
	case 2: {
		__getPos;
		_ctype =
#ifdef __OA__
		"Land_Fort_Watchtower_EP1";
#else
		"Land_vysilac_FM2";
#endif
		_vehicle = createVehicle [_ctype, _poss, [], 0, "NONE"];
		_svec = sizeOf _ctype;
		_isFlat = (position _vehicle) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _vehicle];
		if (count _isFlat > 0) then {
			_vehicle setPos _isFlat;
			_poss = _isFlat;
		};
		_vehicle setVectorUp [0,0,1];
		[_vehicle] execFSM "fsms\xremovevehiextra.fsm";
		__vkilled(radar_down);
		sleep 1.0112;
		__specops;
	};
	case 3: {
#ifndef __OA__
		_truck = switch (d_enemy_side) do {
			case "EAST": {"KamazReammo"};
			case "WEST": {"MtvrReammo"};
			case "GUER": {"V3S_Gue"};
		};
#else
		_truck = switch (d_enemy_side) do {
			case "EAST": {"UralReammo_TK_EP1"};
			case "WEST": {"MtvrReammo_DES_EP1"};
			case "GUER": {"V3S_Reammo_TK_GUE_EP1"};
		};
#endif
		_vehicle = createVehicle [_truck, _poss, [], 0, "NONE"];
		_svec = sizeOf _truck;
		_isFlat = (position _vehicle) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _vehicle];
		if (count _isFlat > 0) then {
			_vehicle setPos _isFlat;
			_poss = _isFlat;
		};
		_vehicle setDir (floor random 360);
		_vehicle lock true;
		__addDead(_vehicle)
		__vkilled(ammo_down);
		sleep 1.0112;
		__specops;;
	};
	case 4: {
#ifndef __OA__
		_truck = switch (d_enemy_side) do {
			case "EAST": {"GAZ_Vodnik_MedEvac"};
			case "WEST": {"HMMWV_Ambulance"};
			case "GUER": {"BMP2_Gue"};
		};
#else
		_truck = switch (d_enemy_side) do {
			case "EAST": {"M113Ambul_TK_EP1"};
			case "WEST": {"HMMWV_Ambulance_DES_EP1"};
			case "GUER": {"M113Ambul_UN_EP1"};
		};
#endif
		_vehicle = createVehicle [_truck, _poss, [], 0, "NONE"];
		_svec = sizeOf _truck;
		_isFlat = (position _vehicle) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _vehicle];
		if (count _isFlat > 0) then {
			_vehicle setPos _isFlat;
			_poss = _isFlat;
		};
		_vehicle setDir (floor random 360);
		_vehicle lock true;
		__addDead(_vehicle)
		#ifndef __TT__
		if (__ACEVer) then {
			[_vehicle] spawn {
				private ["_vehicle"];
				_vehicle = _this select 0;
				waitUntil {!(_vehicle call ace_v_alive)};
				d_side_main_done = true;
				_s = "apc_down" call XfGetSMTargetMessage;
				["sec_kind",0] call XNetSetJIP;
				d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"Dummy",["1","",_s,[]],true];
			};
		} else {
			__vkilled(apc_down);
		};
		#else
		__vkilled(apc_down);
		#endif
		sleep 1.0112;
		__specops;
	};
	case 5: {
		__getPos;
		_vehicle = createVehicle [d_enemy_hq, _poss, [], 0, "NONE"];
		_svec = sizeOf d_enemy_hq;
		_isFlat = (position _vehicle) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _vehicle];
		if (count _isFlat > 0) then {
			_vehicle setPos _isFlat;
			_poss = _isFlat;
		};
		_vehicle setDir (floor random 360);
		_vehicle lock true;
		[_vehicle] execFSM "fsms\xremovevehiextra.fsm";
		__vkilled(hq_down);
		sleep 1.0112;
		__specops;
	};
	case 6: {
		__getPos;
#ifndef __OA__
		_fact = switch (d_enemy_side) do {
			case "EAST": {"RU_WarfareBLightFactory"};
			case "WEST": {"USMC_WarfareBLightFactory"};
			case "GUER": {"Gue_WarfareBLightFactory"};
		};
#else
		_fact = switch (d_enemy_side) do {
			case "EAST": {"TK_WarfareBLightFactory_EP1"};
			case "WEST": {"US_WarfareBLightFactory_EP1"};
			case "GUER": {"TK_GUE_WarfareBLightFactory_EP1"};
		};
#endif
		_vehicle = createVehicle [_fact, _poss, [], 0, "NONE"];
		_svec = sizeOf _fact;
		_isFlat = (position _vehicle) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _vehicle];
		if (count _isFlat > 0) then {
			_vehicle setPos _isFlat;
			_poss = _isFlat;
		};
		_vehicle setDir (floor random 360);
		[_vehicle] execFSM "fsms\xremovevehiextra.fsm";
		__vkilled(light_down);
		sleep 1.0112;
		__specops;
	};
	case 7: {
		__getPos;
#ifndef __OA__
		_fact = switch (d_enemy_side) do {
			case "EAST": {"RU_WarfareBHeavyFactory"};
			case "WEST": {"USMC_WarfareBHeavyFactory"};
			case "GUER": {"Gue_WarfareBHeavyFactory"};
		};
#else
		_fact = switch (d_enemy_side) do {
			case "EAST": {"TK_WarfareBHeavyFactory_EP1"};
			case "WEST": {"US_WarfareBHeavyFactory_EP1"};
			case "GUER": {"TK_GUE_WarfareBHeavyFactory_EP1"};
		};
#endif
		_vehicle = createVehicle [_fact, _poss, [], 0, "NONE"];
		_svec = sizeOf _fact;
		_isFlat = (position _vehicle) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _vehicle];
		if (count _isFlat > 0) then {
			_vehicle setPos _isFlat;
			_poss = _isFlat;
		};
		_vehicle setDir (floor random 360);
		[_vehicle] execFSM "fsms\xremovevehiextra.fsm";
		__vkilled(heavy_down);
		sleep 1.0112;
		__GetEGrp(_newgroup)
		__specops;
	};
	case 8: {
		__getPos;
		_vehicle = createVehicle [d_artillery_radar, _poss, [], 0, "NONE"];
		_svec = sizeOf d_artillery_radar;
		_isFlat = (position _vehicle) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _vehicle];
		if (count _isFlat > 0) then {
			_vehicle setPos _isFlat;
			_poss = _isFlat;
		};
		_vehicle setDir (floor random 360);
		[_vehicle] execFSM "fsms\xremovevehiextra.fsm";
		__vkilled(artrad_down);
		sleep 1.0112;
		__specops;
	};
	case 9: {
		__getPos;
		_vehicle = createVehicle [d_air_radar, _poss, [], 0, "NONE"];
		_svec = sizeOf d_air_radar;
		_isFlat = (position _vehicle) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _vehicle];
		if (count _isFlat > 0) then {
			_vehicle setPos _isFlat;
			_poss = _isFlat;
		};
		_vehicle setDir (floor random 360);
		[_vehicle] execFSM "fsms\xremovevehiextra.fsm";
		__vkilled(airrad_down);
		sleep 1.0112;
		__specops;
	};
	case 10: {
		__GetEGrp(_newgroup)
		_ctype =
#ifndef __OA__
		"Ins_Lopotev";
#else
		"Dr_Hladik_EP1";
#endif
		_vehicle = _newgroup createUnit [_ctype, _poss, [], 0, "FORM"];
		_svec = sizeOf _ctype;
		_isFlat = (position _vehicle) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _vehicle];
		if (count _isFlat > 0) then {
			_vehicle setPos _isFlat;
			_poss = _isFlat;
		};
		_vehicle setVariable ["BIS_noCoreConversations", true];
		_vehicle setRank "COLONEL";
		_vehicle setSkill 0.3;
		_vehicle disableAI "MOVE";
		_vehicle spawn _fixor;
		for "_i" from 1 to 4 do {_vehicle addMagazine "15Rnd_9x19_M9"};
		_vehicle addWeapon "M9";
#ifndef __TT__
		_iar = __XJIPGetVar(d_searchintel);
		_sum = 0;
		{if (_x == 1) then {__INC(_sum)}} forEach _iar;
		if (_sum < count _iar) then {
			d_intel_unit = _vehicle;
			["d_searchbody", _vehicle] call XNetSetJIP;
			["d_s_b_client"] call XNetCallEvent;
		} else {
			if (!isNull __XJIPGetVar(d_searchbody)) then {["d_searchbody", objNull] call XNetSetJIP};
		};
		sleep 0.1;
#else
		__addDead(_vehicle)
#endif
		__vkilled(lopo_dead);
		if (d_with_ai) then {
			if (__RankedVer) then {_vehicle addEventHandler ["killed", {[1,_this select 1] call XAddKillsAI}]};
		};
		sleep 1.0112;
		__specops;
	};
	case 11: {
		__GetEGrp(_newgroup)
		_ctype =
#ifndef __OA__
		"Rocker3";
#else
		"CIV_EuroMan01_EP1";
#endif
		_vehicle = _newgroup createUnit [_ctype, _poss, [], 0, "FORM"];
		_svec = sizeOf _ctype;
		_isFlat = (position _vehicle) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _vehicle];
		if (count _isFlat > 0) then {
			_vehicle setPos _isFlat;
			_poss = _isFlat;
		};
		_vehicle setVariable ["BIS_noCoreConversations", true];
		_vehicle setRank "COLONEL";
		_vehicle setSkill 0.3;
		_vehicle spawn _fixor;
		_vehicle disableAI "MOVE";
		for "_i" from 1 to 4 do {_vehicle addMagazine "15Rnd_9x19_M9"};
		_vehicle addWeapon "M9";
#ifndef __TT__
		_iar = __XJIPGetVar(d_searchintel);
		_sum = 0;
		{if (_x == 1) then {__INC(_sum)}} forEach _iar;
		if (_sum < count _iar) then {
			d_intel_unit = _vehicle;
			["d_searchbody", _vehicle] call XNetSetJIP;
			["d_s_b_client"] call XNetCallEvent;
		} else {
			if (!isNull __XJIPGetVar(d_searchbody)) then {["d_searchbody", objNull] call XNetSetJIP};
		};
		sleep 0.1;
#else
		__addDead(_vehicle)
#endif
		__vkilled(dealer_dead);
		if (d_with_ai) then {
			if (__RankedVer) then {_vehicle addEventHandler ["killed", {[1,_this select 1] call XAddKillsAI}]};
		};
		sleep 1.0112;
		__specops;
	};
};

["sec_kind",_sec_kind] call XNetSetJIP;
_s = "";
if (__XJIPGetVar(current_target_index) != -1) then {
	_s = (switch (_sec_kind) do {
		case 1: {
			format ["Find and eliminate the local governor of %1", _current_target_name]
		};
		case 2: {
#ifndef __OA__
			format ["Find the local communication tower in %1 and destroy it", _current_target_name]
#else
			format ["Find a fortress in %1 and destroy it", _current_target_name]
#endif
		};
		case 3: {
			#ifndef __TT__
			format ["Find an enemy ammo truck in %1 and destroy it to cut down ammo supplies", _current_target_name]
			#else
			format ["Find an enemy truck in %1 and destroy it", _current_target_name]
			#endif
		};
		case 4: {
			#ifndef __TT__
			format ["Find a new APC prototype (concealed as medic) in %1 and destroy it", _current_target_name]
			#else
			format ["Find a new APC prototype in %1 and destroy it", _current_target_name]
			#endif
		};
		case 5: {
			format ["Find the enemy HQ in %1 and destroy it", _current_target_name]
		};
		case 6: {
			format ["Find a light enemy factory in %1 and destroy it", _current_target_name]
		};
		case 7: {
			format ["Find a heavy enemy factory in %1 and destroy it", _current_target_name]
		};
		case 8: {
			format ["Find an enemy artillery radar in %1 and destroy it", _current_target_name]
		};
		case 9: {
			format ["Find an enemy anti air radar in %1 and destroy it", _current_target_name]
		};
		case 10: {
			format ["Find a collaborateur in %1 and eliminate him", _current_target_name]
		};
		case 11: {
			format ["Find a drug dealer who sells drugs to our troops in %1 and eliminate him", _current_target_name]
		};
	});
} else {
	_s = "No Secondary Main Target Mission available";
};
#ifndef __TT__
d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TellSecondaryMTM",["1","",_s,[]],true];
#else
d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","TellSecondaryMTM",["1","",_s,[]],true];
d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","TellSecondaryMTM",["1","",_s,[]],true];
#endif