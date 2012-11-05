// by Xeno
private ["_poss", "_fortress", "_newgroup", "_officer", "_bpos", "_leader"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[13077,10094.4,0], [13063.8,10129.3,0]]; // index: 18,   Government member visit in Berezino shipyard
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "A high enemy government member visits Berezino today. He wants to take a look at the local ship production in the Berezino shipyard. Eliminate him !";
	GVAR(current_mission_resolved_text) = "The government member is dead. Good job.";
};

if (isServer) then {
	__PossAndOther
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other,1,120,true] spawn FUNC(CreateArmor);
	sleep 2.123;
	["specops", 2, "basic", 1, _poss,100,true] spawn FUNC(CreateInf);
	sleep 2.111;
	_fortress = createVehicle ["Land_Fort_Watchtower", _poss, [], 0, "NONE"];
	_fortress setPos _poss;
	__AddToExtraVec(_fortress)
	sleep 2.123;
	__GetEGrp(_newgroup)
	_officer = switch (GVAR(enemy_side)) do {
		case "EAST": {"RU_Commander"};
		case "WEST": {"USMC_Soldier_Officer"};
		case "GUER": {"GUE_Commander"};
	};
	_sm_vehicle = _newgroup createUnit [_officer, _poss, [], 0, "FORM"];
	if (GVAR(without_nvg) == 0) then {
		if (_sm_vehicle hasWeapon "NVGoggles") then {_sm_vehicle removeWeapon "NVGoggles"};
	};
	_sm_vehicle setVariable ["BIS_noCoreConversations", true];
	__addDeadAI(_sm_vehicle)
#ifndef __TT__
	_sm_vehicle addEventHandler ["killed", {_this call FUNC(KilledSMTargetNormal)}];
#else
	_sm_vehicle addEventHandler ["killed", {_this call FUNC(KilledSMTargetTT)}];
#endif
	sleep 2.123;
	_bpos = position _fortress;
	_sm_vehicle setPos _bpos;
	_leader = leader _newgroup;
	_leader setRank "COLONEL";
	_newgroup allowFleeing 0;
	_newgroup setbehaviour "AWARE";
	_leader disableAI "MOVE";
};