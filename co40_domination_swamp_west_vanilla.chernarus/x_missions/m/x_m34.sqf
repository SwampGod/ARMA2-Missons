// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[7020.78,7634.42,0]]; // index: 34,   Transformer station near Novy Sobor
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "There is a transformer station in Novy Sobor. The enemy uses it for its communication relais stations. Simple task, destroy it.";
	GVAR(current_mission_resolved_text) = "Good job. The transformer station is down.";
};

if (isServer) then {
	__Poss
	_vehicle = "Land_trafostanica_velka" createvehicle _poss;
	_vehicle setDir 347.852;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 2.22;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,150,true] spawn FUNC(CreateArmor);
	sleep 2.123;
	["specops", 1, "basic", 2, _poss,100,true] spawn FUNC(CreateInf);
	__AddToExtraVec(_vehicle)
};