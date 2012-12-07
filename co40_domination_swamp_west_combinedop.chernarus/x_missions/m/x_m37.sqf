// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[4936.54,6269.24,0]]; // index: 37,   Prison, Pogorevka
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "The enemy is building a prison near Pogorevka. Destroy the building so that they can not arrest innocent people.";
	GVAR(current_mission_resolved_text) = "Good job. The prison is destroyed.";
};

if (isServer) then {
	__Poss
	_vehicle = "Land_hospital" createvehicle _poss;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	_vehicle setDir 190;
	sleep 2.132;
	["specops", 1, "basic", 1, _poss,80,true] spawn FUNC(CreateInf);
	sleep 2.234;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,110,true] spawn FUNC(CreateArmor);
	__AddToExtraVec(_vehicle)
};