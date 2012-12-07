// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[1339.03,5830,0], [1271.66,5898.85,0], [1362.3,5702.23,0]]; // index: 6,   Hangar near Zelegonorsk
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "The enemy is building a hangar near Zelegonorsk. Funny thing is, there is no airfield near that position. So, destroy that hangar before we really know what it is for.";
	GVAR(current_mission_resolved_text) = "Good job. The hangar is down.";
};

if (isServer) then {
	__PossAndOther
	_pos_other2 = GVAR(x_sm_pos) select 2;
	_vehicle = "Land_SS_hangar" createvehicle _poss;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	_vehicle setDir 190;
	sleep 2.123;
	["specops", 1, "basic", 1, _pos_other,90,true] spawn FUNC(CreateInf);
	sleep 2.012;
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other2,1,80,true] spawn FUNC(CreateArmor);
	__AddToExtraVec(_vehicle)
};