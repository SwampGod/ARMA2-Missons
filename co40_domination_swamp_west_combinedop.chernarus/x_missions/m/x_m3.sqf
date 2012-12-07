// by Xeno
private ["_xtank", "_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[9643.88,13506.9,0], [9639.43,13428.7,0], [9572.01,13385.5,0]]; //  steal tank prototype, Pobeda-Damm, array 2 and 3 = infantry and armor positions
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
#ifndef __TT__
	GVAR(current_mission_text) = "Enemy forces are testing an enhanced tank version at Pobeda-Damm. Your mission is to steal it and bring it to the flag at your base.";
	GVAR(current_mission_resolved_text) = "Good job. You got the enhanced tank version.";
#else
	GVAR(current_mission_text) = "Enemy forces are testing an enhanced tank version at Pobeda-Damm. Your mission is it to destroy that tank.";
	GVAR(current_mission_resolved_text) = "Good job. The enhanced tank version is destroyed.";
#endif
};

if (isServer) then {
	_xtank = switch (GVAR(enemy_side)) do {
		case "EAST": {"T90"};
		case "WEST": {"M1A2_TUSK_MG"};
		case "GUER": {"T72_Gue"};
	};
	__PossAndOther
	_pos_other2 = GVAR(x_sm_pos) select 2;
	_vehicle = objNull;
	_vehicle = _xtank createvehicle _poss;
	_vehicle setDir 240;
#ifndef __TT__
	sleep 2.123;
	["specops", 1, "basic", 1, _pos_other,100,true] spawn FUNC(CreateInf);
	sleep 2.321;
	["shilka", 1, "bmp", 1, "tank", 0, _pos_other2,1,200,true] spawn FUNC(CreateArmor);
	[_vehicle] execVM "x_missions\common\x_sidesteal.sqf";
	__addDead(_vehicle)
#else
	_vehicle addEventHandler ["killed", {_this call FUNC(KilledSMTargetTT)}];
	_vehicle lock true;
	__AddToExtraVec(_vehicle)
	sleep 2.123;
	["specops", 1, "basic", 1, _pos_other,100,true] spawn FUNC(CreateInf);
	sleep 2.321;
	["shilka", 1, "bmp", 1, "tank", 0, _pos_other2,2,200,true] spawn FUNC(CreateArmor);
#endif
};