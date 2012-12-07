// by Xeno
private ["_xplane", "_hangar", "_poss", "_vehicle"];
#include "x_setup.sqf"

#ifdef __TT__
GVAR(x_sm_pos) = [[9469.29,9980.0,0], [9475.11,10052.3,0]]; // index: 2,   steal plane prototype, Paraiso airfield, second array position armor
#endif
#ifndef __TT__
GVAR(x_sm_pos) = [[4678.83,2510.28,0], [4823.91,2453.85,0]]; //  steal plane prototype, Balota, second array position armor
#endif
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
#ifdef __TT__
	GVAR(current_mission_text) = "The enemy is testing a new protoype plane at the main. Steal it and bring it to the flag at your base.";
	GVAR(current_mission_resolved_text) = "Good job. You got the prototype plane.";
#else
	GVAR(current_mission_text) = "The enemy is testing a new protoype plane at Balota airfield. Steal it and bring it to the flag at your base.";
	GVAR(current_mission_resolved_text) = "Good job. You got the prototype plane.";
#endif
};

if (isServer) then {
	_xplane = if (GVAR(enemy_side) == "EAST") then {"Su34"} else {"F35B"};
	__PossAndOther
	_hangar = "Land_SS_hangar" createvehicle _poss;
	_hangar setDir 300;
	__AddToExtraVec(_hangar)
	sleep 1.0123;
	_vehicle = objNull;
	_vehicle = _xplane createvehicle _poss;
	_vehicle setDir 120;
	sleep 2.123;
	["specops", 1, "basic", 1, _poss,100,true] spawn FUNC(CreateInf);
	sleep 2.221;
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other,1,100,true] spawn FUNC(CreateArmor);
	[_vehicle] execVM "x_missions\common\x_sidesteal.sqf";
	__addDead(_vehicle)
};