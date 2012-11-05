// by Xeno
#define THIS_FILE "x_setupserver.sqf"
#include "x_setup.sqf"
if (!isServer) exitWith {};

_pos = [0,0,0];

#ifndef __A2ONLY__
if !(__TTVer) then {
	// very secret extra thingie...,
	_shield = GVAR(ProtectionZone) createVehicleLocal (position FLAG_BASE);
	_shield setDir -211;
	_shield setPos (position FLAG_BASE);
	_shield setObjectTexture [0,"#(argb,8,8,3)color(0,0,0,0,ca)"];
	_trig = createTrigger["EmptyDetector" ,position FLAG_BASE];
	_trig setTriggerArea [25, 25, 0, false];
	_trig setTriggerActivation [GVAR(enemy_side), "PRESENT", true];
	_trig setTriggerStatements ["this", "thislist call {{_x setDamage 1} forEach _this}", ""];
};
#endif

_mpos = markerPos QGVAR(island_marker);
_mpos set [2,0];
if (str(_mpos) != "[0,0,0]") then {
	_msize = markerSize QGVAR(island_marker);
	GVAR(island_center) = [_msize select 0, _msize select 1, 300];
};
GVAR(island_x_max) = (GVAR(island_center) select 0) * 2;
GVAR(island_y_max) = (GVAR(island_center) select 1) * 2;

GVAR(last_bonus_vec) = "";

[_pos, [0, 0, 0, false], ["NONE", "PRESENT", true], [QGVAR(side_mission_resolved), "call d_fnc_SideMissionResolved", ""]] call FUNC(CreateTrigger);

// check mr
__cppfln(FUNC(checktransport),x_server\x_checktransport.sqf);

#ifdef __TT__
__cppfln(FUNC(checktransport2),x_server\x_checktransport2.sqf);
#endif

if (!GVAR(AmmoBoxHandling)) then {
	execfsm "fsms\Boxhandling.fsm";
} else {
	GVAR(check_boxes) = [];
	execVM "x_server\x_boxhandling_old.sqf";
};

#ifdef __TT__
execfsm "fsms\TTPoints.fsm";
#endif

if (GVAR(with_ai)) then {execVM "x_server\x_delaiserv.sqf"};

// start air AI (KI=AI) after some time
#ifndef __TT__
if (GVAR(MissionType) != 2) then {
	0 spawn {
		sleep 924;
		["KA",GVAR(number_attack_choppers)] execVM "x_server\x_airki.sqf";
		sleep 801.123;
		["SU",GVAR(number_attack_planes)] execVM "x_server\x_airki.sqf";
	};
};
#endif

if (GVAR(MissionType) in [0,2]) then {
	0 spawn {
		private ["_waittime","_num_p"];
		sleep 20;
			if (GVAR(MissionType) != 2) then {
			_waittime = 200 + random 10;
			_num_p = call FUNC(PlayersNumber);
			if (_num_p > 0) then {
				{
					if (_num_p <= (_x select 0)) exitWith {
						_waittime = (_x select 1) + random 10;
					}
				} forEach GVAR(time_until_next_sidemission);
			};
			sleep _waittime;
		} else {
			sleep 15;
		};
		execVM "x_missions\x_getsidemission.sqf";
	};
};

#ifndef __TT__
if (GVAR(WithRecapture) == 0 && GVAR(MissionType) != 2) then {execFSM "fsms\Recapture.fsm"};

if (!GVAR(no_sabotage) && (isNil QGVAR(with_carrier)) && GVAR(MissionType) != 2) then {execFSM "fsms\Infilrate.fsm"};
#endif

#ifndef __TT__
GVAR(air_bonus_vecs) = 0;
GVAR(land_bonus_vecs) = 0;

{
	_vecclass = toUpper (getText(configFile >> "CfgVehicles" >> _x >> "vehicleClass"));
	if (_vecclass == "AIR") then {
		__INC(GVAR(air_bonus_vecs));
	} else {
		__INC(GVAR(land_bonus_vecs));
	};
} foreach GVAR(sm_bonus_vehicle_array);

if (isNil QGVAR(with_carrier)) then {
	[GVAR(base_array) select 0, [GVAR(base_array) select 1, GVAR(base_array) select 2, GVAR(base_array) select 3, true], [GVAR(enemy_side), "PRESENT", true], ["'Man' countType thislist > 0 || 'Tank' countType thislist > 0 || 'Car' countType thislist > 0", "d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,'BaseUnderAtack',true]", ""]] call FUNC(CreateTrigger);
};
#endif

if (GVAR(MissionType) == 2) then {
	0 spawn {
		waitUntil {sleep 0.344;__XJIPGetVar(all_sm_res)};
		sleep 10;
		[QGVAR(the_end),true] call FUNC(NetSetJIP);
	};
};

__ccppfln(x_servercustomcode.sqf);