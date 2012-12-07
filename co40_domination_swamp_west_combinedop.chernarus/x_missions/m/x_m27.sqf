// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[10135.7,6187.1,0]]; // index: 27,   Radio tower on top of mount Baranchik
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "There is a radio tower on top of mount Baranchik. This is one of the many radio towers that the enemy uses to communicate with its troops. Simple task, destroy it.";
	GVAR(current_mission_resolved_text) = "Good job. The radio tower on top of mount Baranchik is down.";
};

if (isServer) then {
	__Poss
	_vehicle = "Land_telek1" createvehicle _poss;
	_vehicle setVectorUp [0,0,1];
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 2.333;
	["specops", 2, "basic", 2, _poss,120,true] spawn FUNC(CreateInf);
	__AddToExtraVec(_vehicle)
};