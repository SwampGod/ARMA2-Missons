// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[6769.79,5603.09,0],[6756,5631.19,0]]; // index: 28,   Radio Tower at bunker near Vyshnoye
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "The enemy has a bunker south of Vyshnoye. Enemy government uses this bunker for emergeny situations. Destroy the radar tower there to cut down the ability for them to communicate.";
	GVAR(current_mission_resolved_text) = "Good job. The radio tower south of Vyshnoye is down.";
};

if (isServer) then {
	__PossAndOther
	_vehicle = "Land_telek1" createvehicle _poss;
	_vehicle setVectorUp [0,0,1];
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 2.22;
	["shilka", 1, "bmp", 0, "tank", 0, _pos_other,1,0,false] spawn FUNC(CreateArmor);
	sleep 2.333;
	["specops", 1, "basic", 2, _poss,80,true] spawn FUNC(CreateInf);
	sleep 2.333;
	["shilka", 0, "bmp", 1, "tank", 1, _pos_other,1,100,true] spawn FUNC(CreateArmor);
	__AddToExtraVec(_vehicle)
};