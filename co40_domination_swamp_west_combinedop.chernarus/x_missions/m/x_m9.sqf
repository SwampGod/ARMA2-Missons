// by Xeno
private ["_xchopper", "_randomv", "_poss", "_vehicle"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[12055.5,12620.4,0], [12051.6,12678.6,0], [11963.7,12726.2,0],  [12009.6,12636.6,0]]; // index: 9,   Helicopter Prototype at Krasnostav Airfield
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {	
	GVAR(current_mission_text) = "A new helicopter prototype gets tested on Krasnostav airfield. Destroy it before enemy troops use it.";
	GVAR(current_mission_resolved_text) = "Good job. The helicopter is destroyed.";
};

if (isServer) then {
	_xchopper = (if (GVAR(enemy_side) == "EAST") then {"Ka52Black"} else {"AH1Z"});
	_randomv = floor random 2;
	__PossAndOther
	if (_randomv == 1) then {_poss = GVAR(x_sm_pos) select 3};
	_pos_other2  = GVAR(x_sm_pos) select 2;
	_vehicle = objNull;
	_vehicle = _xchopper createvehicle _poss;
#ifndef __TT__
	_vehicle addEventHandler ["killed", {_this call FUNC(KilledSMTargetNormal)}];
#else
	_vehicle addEventHandler ["killed", {_this call FUNC(KilledSMTargetTT)}];
#endif
	_vehicle setDir 20;
	_vehicle lock true;
	sleep 2.123;
	["specops", 1, "basic", 2, _poss,90,true] spawn FUNC(CreateInf);
	sleep 2.111;
	["shilka", 1, "bmp", 1, "tank", 0, _pos_other2,1,100,true] spawn FUNC(CreateArmor);
};