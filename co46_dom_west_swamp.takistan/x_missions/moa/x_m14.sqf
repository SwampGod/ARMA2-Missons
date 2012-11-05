// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

x_sm_pos = [[2264.76,8591.31,0], [2241.81,8565.53,0]]; // index: 14,   Radio tower at mount Jabal os Saraj
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "There is a radio tower on the top of mount Jabal os Saraj. The enemy uses it to command its armored troops. Simple task, destroy it.";
	d_current_mission_resolved_text = "Good job. The radio tower on the top of mount Jabal os Saraj is down.";
};

if (isServer) then {
	__PossAndOther
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
	sleep 2.22;
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other,1,110,true] spawn XCreateArmor;
	sleep 2.333;
	["specops", 1, "basic", 2, _poss,70,true] spawn XCreateInf;
	__AddToExtraVec(_vehicle)
};