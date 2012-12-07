// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[13699.1,2970.27,0], [13711.9,2914.49,0]]; // index: 11,   Lighthouse on Isle Skalisty
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "There is a lighthouse on Isle Skalisty. Enemy ships use it to find their way to the Chernarus south coast, destroy it.";
	GVAR(current_mission_resolved_text) = "Good job. The lighthouse is destroyed.";
};

if (isServer) then {
	__PossAndOther
	_vehicle = createVehicle ["Land_majak2", _poss, [], 0, "NONE"];
	_vehicle setPos _poss;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 2.022;
	["specops", 1, "basic", 1, _poss,100,true] spawn FUNC(CreateInf);
	sleep 2.123;
	["shilka", 0, "bmp", 1, "tank", 1, _poss,1,110,true] spawn FUNC(CreateArmor);
	__AddToExtraVec(_vehicle)
};