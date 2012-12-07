// by Xeno
private ["_officer", "_poss", "_fortress", "_newgroup", "_bpos", "_leader"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[13350.1,12877.3,0], [13359.6,12895.4,0]]; // index: 17,   Officer in Olsha
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "A high enemy officer arrives today in Olsha. He is responsible for the production of biological and chemical weapons. Eliminate him !";
	GVAR(current_mission_resolved_text) = "The enemy officer is dead. Good job.";
};

if (isServer) then {
	_officer = switch (GVAR(enemy_side)) do {
		case "EAST": {"RU_Commander"};
		case "WEST": {"USMC_Soldier_Officer"};
		case "GUER": {"GUE_Commander"};
	};
	__PossAndOther
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other,1,110,true] spawn FUNC(CreateArmor);
	sleep 2.123;
	["specops", 2, "basic", 1, _poss,70,true] spawn FUNC(CreateInf);
	sleep 2.111;
	_fortress = createVehicle ["Land_Fort_Watchtower", _poss, [], 0, "NONE"];
	_fortress setPos _poss;
	__AddToExtraVec(_fortress)
	sleep 2.123;
	__GetEGrp(_newgroup)
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