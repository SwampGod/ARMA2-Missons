// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

x_sm_pos = [[10477.6,7517.24,0], [10467.4,7485.87,0]]; // index: 16,   Radio tower mount Aqtappa
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "There is a radio tower on the top of mount Aqtappa. The enemy uses it to command its marine task forces. Simple task, destroy it.";
	d_current_mission_resolved_text = "Good job. The radio tower on top of mount Aqtappa is down.";
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
	["shilka", 1, "bmp", 1, "tank", 0, _pos_other,1,110,true] spawn XCreateArmor;
	sleep 2.333;
	["specops", 1, "basic", 2, _poss,120,true] spawn XCreateInf;
	__AddToExtraVec(_vehicle)
};