// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

x_sm_pos = [[8036.37,6174.79,0]]; // radar tower on Gur Dur
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "There is a radar tower on the top of mount Gur Dur. Find it and destroy it.";
	d_current_mission_resolved_text = "Good job. The radar tower on top of mount Gur Dur is down.";
};

if (isServer) then {
	__Poss
#ifdef __OA__
	_vehicle = "Land_Ind_IlluminantTower" createvehicle (_poss);
#else
	_vehicle = "Land_telek1" createvehicle (_poss);
#endif
	_vehicle setVectorUp [0,0,1];
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 3.21;
	["specops", 2, "basic", 3, _poss,50,true] spawn XCreateInf;
	__AddToExtraVec(_vehicle)
};