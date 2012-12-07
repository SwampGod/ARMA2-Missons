// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[13072.2,7071.04,0], [12980.7,7066.64,0], [12956.8,7196.31,0]]; // index: 4,   Water tower (chemical weapons) factory near Solnichniy
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "The enemy is producing chemical weapons in a factory Solnichniy. Find the container that has some of the chemical for the production and destroy it.";
	GVAR(current_mission_resolved_text) = "Good job. The container is destroyed.";
};

if (isServer) then {
	__PossAndOther
	_pos_other2 = GVAR(x_sm_pos) select 2;
	_vehicle = "Misc_Cargo1B_military" createvehicle _poss;
	_vehicle setDir 255;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 2.123;
	["specops", 1, "basic", 1, _pos_other,80,true] spawn FUNC(CreateInf);
	sleep 2.123;
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other2,1,100,true] spawn FUNC(CreateArmor);
	__AddToExtraVec(_vehicle)
};