// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[6223.51,4626.85,0]]; // index: 8,   Radio tower near Nadezhdino
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "There is a radio tower on the top of a mountain near Nadezhdino. The enemy uses it to communicate. Simple task, destroy it.";
	GVAR(current_mission_resolved_text) = "Good job. The radio tower on top of a mountain near Nadezhdino is down.";
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
	sleep 2.22;
	["specops", 1, "basic", 2, _poss,0] spawn FUNC(CreateInf);
};