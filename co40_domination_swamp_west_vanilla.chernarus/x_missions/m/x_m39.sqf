// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[3717.11,5985.61,0]]; // index: 39,   Secret container in huge radio tower on mount Grüner Berg
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "In the huge radio tower on top of mount Green Mountain is a IED, it looks like an ammobox. Your job is it to destroy the IED.";
	GVAR(current_mission_resolved_text) = "Good job. The IED got destroyed.";
};

if (isServer) then {
	__Poss
	_vehicle = "LocalBasicAmmunitionBox" createvehicle _poss;
	_vehicle setPosASL [3717.11,5985.61,422.656];
	_vehicle setDir 227;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 2.22;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,110,false] spawn FUNC(CreateArmor);
	sleep 2.333;
	["specops", 1, "basic", 2, _poss,120,true] spawn FUNC(CreateInf);
	__AddToExtraVec(_vehicle)
};