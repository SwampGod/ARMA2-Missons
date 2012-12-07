// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[3616.66,3779.89,0]]; // index: 24,   Fuel station in camp near Bor
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "The enemy uses a fuelstation located near Bor to refuel its vehicles. Simple task, destroy it to cut down fuel supplies.";
	GVAR(current_mission_resolved_text) = "Good job. The fuelstation is down.";
};

if (isServer) then {
	__Poss
	_vehicle = "Land_A_FuelStation_Build" createvehicle _poss;
	_vehicle setDir 40;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 2.22;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,120,true] spawn FUNC(CreateArmor);
	sleep 2.123;
	["specops", 1, "basic", 2, _poss,110,true] spawn FUNC(CreateInf);
	__AddToExtraVec(_vehicle)
};