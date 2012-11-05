// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[1236.22,14668.1,0]]; // index: 38,   Biological weapons near Grozovoy Pass
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "The enemy is producing biological weapons near Grozovoy Pass. Find the watertower that is needed for the production and destroy it.";
	GVAR(current_mission_resolved_text) = "Good job. The water tower is down.";
};

if (isServer) then {
	__Poss
	_vehicle = "Land_Farm_WTower" createvehicle _poss;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 2.123;
	["specops", 1, "basic", 2, _poss,150,true] spawn FUNC(CreateInf);
	sleep 2.123;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,100,true] spawn FUNC(CreateArmor);
	__AddToExtraVec(_vehicle)
};