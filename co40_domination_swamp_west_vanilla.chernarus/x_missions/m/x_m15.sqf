// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[4984.69,12586.8,0], [5005.95,12559.2,0]]; // index: 15,   Transformer station in Petrovka
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "There is a transformer station in Petrovka. The enemy uses it for some experiments in a laboratory in Krasnostav. Simple task, destroy it.";
	GVAR(current_mission_resolved_text) = "Good job. The transformer station is down.";
};

if (isServer) then {
	__PossAndOther
	_vehicle = createVehicle ["Land_trafostanica_velka", _poss, [], 0, "NONE"];
	_vehicle setPos _poss;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 2.22;
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other,1,110,true] spawn FUNC(CreateArmor);
	sleep 2.123;
	["specops", 1, "basic", 2, _poss,110,true] spawn FUNC(CreateInf);
	__AddToExtraVec(_vehicle)
};