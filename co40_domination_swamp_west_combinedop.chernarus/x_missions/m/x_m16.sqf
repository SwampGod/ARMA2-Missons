// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[10895.2,7562.57,0], [10908.1,7569.58,0]]; // index: 16,   Radio tower mount Malinovka
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "There is a radio tower on the top of mount Malinovka. The enemy uses it to command its marine task forces. Simple task, destroy it.";
	GVAR(current_mission_resolved_text) = "Good job. The radio tower on top of mount Malinovka is down.";
};

if (isServer) then {
	__PossAndOther
	_vehicle = createVehicle ["Land_telek1", _poss, [], 0, "NONE"];
	_vehicle setVectorUp [0,0,1];
	_vehicle setPos _poss;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 2.22;
	["shilka", 1, "bmp", 1, "tank", 0, _pos_other,1,110,true] spawn FUNC(CreateArmor);
	sleep 2.333;
	["specops", 1, "basic", 2, _poss,120,true] spawn FUNC(CreateInf);
	__AddToExtraVec(_vehicle)
};