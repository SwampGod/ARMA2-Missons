// by Xeno
private ["_objs", "_poss", "_building"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[10387.6,2191.64,0]]; // index: 45,   Destroy bank building in Elektrozavodsk,
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "The enemy has all its gold in a bank in Elektrozavodsk. Destroy the building so that they can't pay their weapon shipments anymore.";
	GVAR(current_mission_resolved_text) = "Good job. The bank building is down.";
};

if (isServer) then {
	__Poss
	_objs = nearestObjects [_poss, ["Land_HouseBlock_B5"], 30];
	_building = _objs select 0;
#ifndef __TT__
	_building addEventHandler ["killed", {_this call FUNC(KilledSMTargetNormal)}];
#else
	_building addEventHandler ["killed", {_this call FUNC(KilledSMTargetTT)}];
#endif
	sleep 2.123;
	["specops", 2, "basic", 1, _poss,80,true] spawn FUNC(CreateInf);
	sleep 2.221;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,150,true] spawn FUNC(CreateArmor);
};