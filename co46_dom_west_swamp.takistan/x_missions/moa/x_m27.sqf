// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

x_sm_pos = [[1622.09,2341.54,0]]; // index: 27,   Radio tower on top of mountain near Chaman
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "There is a radio tower on top of a mountain near Chaman. This is one of the many radio towers that the enemy uses to communicate with its troops. Simple task, destroy it.";
	d_current_mission_resolved_text = "Good job. The radio tower on top of a mountain near Chaman is down.";
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
	sleep 2.333;
	["specops", 2, "basic", 2, _poss,120,true] spawn XCreateInf;
	__AddToExtraVec(_vehicle)
};