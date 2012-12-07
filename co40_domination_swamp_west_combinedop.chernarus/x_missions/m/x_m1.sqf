// by Xeno
private ["_officer", "_fortress", "_poss", "_ogroup", "_bpos", "_leadero"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[11256.2,4294.15,0], [11075.9,4119.91,0]]; // Officer, Rog, second array = position Shilka
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "A high enemy officer arrives today in a ruin called Rog. He is responsible for the death of many civilians. Eliminate him!";
	GVAR(current_mission_resolved_text) = "The enemy officer is dead. Good job.";
};

if (isServer) then {
	_officer = switch (GVAR(enemy_side)) do {
		case "EAST": {"RU_Commander"};
		case "WEST": {"USMC_Soldier_Officer"};
		case "GUER": {"GUE_Commander"};
	};
	__PossAndOther
	["shilka", 1, "", 0, "", 0, _pos_other,1,0,false] call FUNC(CreateArmor);
	sleep 2.123;
	_fortress = createVehicle ["Land_Fort_Watchtower", _poss, [], 0, "NONE"];
	_fortress setDir -133.325;
	_fortress setPos _poss;
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
	sleep 2.123;
	["specops", 2, "basic", 2, _poss, 100,true] call FUNC(CreateInf);
	sleep 2.123;
	_leadero = leader _ogroup;
	_leadero setRank "COLONEL";
	_ogroup allowFleeing 0;
	_ogroup setbehaviour "AWARE";
	_leadero disableAI "MOVE";
};