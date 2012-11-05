// by Xeno
private ["_officer", "_fortress", "_poss", "_ogroup", "_bpos", "_leadero"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[6896.19,11442.8,0]]; // Officer, Teufelsschloss
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "A high enemy officer visits the enemy troops today in Teufelsschloss. He is a personal friend of the enemy leader. Eliminate him!";
	GVAR(current_mission_resolved_text) = "The enemy officer is dead. Good job.";
};

if (isServer) then {
	_officer = switch (GVAR(enemy_side)) do {
		case "EAST": {"RU_Commander"};
		case "WEST": {"USMC_Soldier_Officer"};
		case "GUER": {"GUE_Commander"};
	};
	__Poss
	sleep 2.123;
	_fortress = "Land_Fort_Watchtower" createVehicle _poss;
	__AddToExtraVec(_fortress)
	sleep 2.123;
	__GetEGrp(_ogroup)
	_sm_vehicle = _ogroup createUnit [_officer, _poss, [], 0, "FORM"];
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
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,150,true] spawn FUNC(CreateArmor);
	sleep 2.123;
	["specops", 2, "basic", 2, _poss, 100,true] spawn FUNC(CreateInf);
	sleep 2.123;
	_leadero = leader _ogroup;
	_leadero setRank "COLONEL";
	_ogroup allowFleeing 0;
	_ogroup setbehaviour "AWARE";
	_leadero disableAI "MOVE";
};