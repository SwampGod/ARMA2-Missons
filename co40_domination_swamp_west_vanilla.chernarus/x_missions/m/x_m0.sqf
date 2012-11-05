// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[3724.62,14491.7,0]]; // radar tower on Nebelspitze
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "There is a radar tower on the top of mount Nebelspitze. Find it and destroy it.";
	GVAR(current_mission_resolved_text) = "Good job. The radar tower on top of mount Nebelspitze is down.";
};

if (isServer) then {
	__Poss
	_vehicle = createVehicle ["Land_telek1", _poss, [], 0, "NONE"];
	_vehicle setVectorUp [0,0,1];
	_vehicle setPos _poss;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 3.21;
	["specops", 2, "basic", 3, _poss,50,true] spawn FUNC(CreateInf);
	__AddToExtraVec(_vehicle)
};