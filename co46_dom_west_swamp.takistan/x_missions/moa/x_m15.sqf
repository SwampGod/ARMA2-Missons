// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

x_sm_pos = [[4003.52,6911.95,0]]; // radar tower on Sanginakt
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "There is a radar tower on the top of mount Sanginakt. Find it and destroy it.";
	d_current_mission_resolved_text = "Good job. The radar tower on top of mount Sanginakt is down.";
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