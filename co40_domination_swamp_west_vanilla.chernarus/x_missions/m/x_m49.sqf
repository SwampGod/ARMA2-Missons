// by Xeno
private ["_officer", "_ogroup", "_poss", "_leadero"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[9275.57,4911.55,0]]; // index: 49,   Officer near Benoma
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
#ifndef __TT__
	GVAR(current_mission_text) = "The enemy has a small outpost in a valley near Staroye. Arrest the officer there and bring him back to the flag at your base to get some vital informations.";
	GVAR(current_mission_resolved_text) = "Good job. The officer was arrested.";
#else
	GVAR(current_mission_text) = "The enemy has a small outpost in a valley near Staroye. Eliminate the officer there !!!";
	GVAR(current_mission_resolved_text) = "Good job. The officer was killed.";
#endif
};

if (isServer) then {
	_officer = switch (GVAR(enemy_side)) do {
		case "EAST": {"RU_Commander"};
		case "WEST": {"USMC_Soldier_Officer"};
		case "GUER": {"GUE_Commander"};
	};
	__Poss
	sleep 2.111;
	__GetEGrp(_ogroup)
	_sm_vehicle = _ogroup createUnit [_officer, _poss, [], 0, "FORM"];
	if (GVAR(without_nvg) == 0) then {
		if (_sm_vehicle hasWeapon "NVGoggles") then {_sm_vehicle removeWeapon "NVGoggles"};
	};
	_sm_vehicle setVariable ["BIS_noCoreConversations", true];
	__addDeadAI(_sm_vehicle)
#ifndef __TT__
	_sm_vehicle addEventHandler ["killed", {_this call FUNC(KilledSMTarget500)}];
	removeAllWeapons _sm_vehicle;
#else
	_sm_vehicle addEventHandler ["killed", {_this call FUNC(KilledSMTargetTT)}];
#endif
	sleep 2.123;
	["specops", 3, "basic", 2, _poss, 100,true] spawn FUNC(CreateInf);
	sleep 2.123;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,120,true] spawn FUNC(CreateArmor);
	sleep 2.123;
	_leadero = leader _ogroup;
	_leadero setRank "COLONEL";
	_ogroup allowFleeing 0;
	_ogroup setbehaviour "AWARE";
	_leadero disableAI "MOVE";
#ifndef __TT__
	[_sm_vehicle] execVM "x_missions\common\x_sidearrest.sqf";
#endif
};