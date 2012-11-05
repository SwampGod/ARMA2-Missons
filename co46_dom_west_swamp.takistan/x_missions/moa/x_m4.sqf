// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

x_sm_pos = [[9418.08,10004,0], [9395.76,10003.9,0], [9406.75,10035,0]]; // index: 4,   Water tower (chemical weapons) factory in Sagram
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "The enemy is producing chemical weapons in a factory in Sagram. Find the container that has some of the chemical for the production and destroy it.";
	d_current_mission_resolved_text = "Good job. The container is destroyed.";
};

if (isServer) then {
	__PossAndOther
	_pos_other2 = x_sm_pos select 2;
#ifndef __OA__
	_vehicle = "Misc_Cargo1B_military" createvehicle (_poss);
#else
	_vehicle = "Land_Misc_Cargo1Eo_EP1" createvehicle (_poss);
#endif
	_vehicle setDir 210;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 2.123;
	["specops", 1, "basic", 1, _pos_other,80,true] spawn XCreateInf;
	sleep 2.123;
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other2,1,100,true] spawn XCreateArmor;
	__AddToExtraVec(_vehicle)
};