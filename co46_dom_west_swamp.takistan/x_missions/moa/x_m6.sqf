// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

x_sm_pos = [[6582.69,6785.74,0], [6578.13,6827.25,0], [6574.29,6856.23,0]]; // index: 6,   Hangar near Falar
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "The enemy is building a hangar near Falar. Funny thing is, there is no airfield near that position. So, destroy that hangar before we really know what it is for.";
	d_current_mission_resolved_text = "Good job. The hangar is down.";
};

if (isServer) then {
	__PossAndOther
	_pos_other2 = x_sm_pos select 2;
#ifndef __OA__
	_vehicle = "Land_SS_hangar" createvehicle (_poss);
#else
	_vehicle = "Land_Mil_hangar_EP1" createvehicle (_poss);
#endif
	_vehicle setPos _poss;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	_vehicle setDir 354;
	sleep 2.123;
	["specops", 1, "basic", 1, _pos_other,90,true] spawn XCreateInf;
	sleep 2.012;
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other2,1,80,true] spawn XCreateArmor;
	__AddToExtraVec(_vehicle)
};