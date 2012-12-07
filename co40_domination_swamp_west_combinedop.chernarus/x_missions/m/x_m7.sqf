// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[8076.35,9290.81,0], [8097.9,9234.6,0]]; // index: 7,   Training facility near Gorka
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "There is an enemy training facility near Gorka. Destroy the main building to cut down their possibilities to train new soldiers.";
	GVAR(current_mission_resolved_text) = "Good job. The main building of the training facility is destroyed.";
};

if (isServer) then {
	__PossAndOther
	_vehicle = "Land_Barrack2" createvehicle _poss;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	_vehicle setDir 270;
	sleep 2.132;
	["specops", 1, "basic", 1, _poss,80,true] spawn FUNC(CreateInf);
	sleep 2.234;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,110,true] spawn FUNC(CreateArmor);
	__AddToExtraVec(_vehicle)
};