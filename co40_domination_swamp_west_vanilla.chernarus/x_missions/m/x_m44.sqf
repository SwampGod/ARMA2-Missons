// by Xeno
private ["_xchopper", "_hangar", "_poss", "_vehicle", "_lvec"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[11475.5,11326.4,0], [11492.6,11370.3,0]]; // index: 44,   Steal chopper prototype near mount Klen
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "The enemy is testing a new protoype chopper near mount Klen. Steal it and bring it to the flag at your base.";
	GVAR(current_mission_resolved_text) = "Good job. You got the prototype chopper.";
};

if (isServer) then {
	_xchopper = (if (GVAR(enemy_side) == "EAST") then {"Ka52Black"} else {"AH1Z"});
	__PossAndOther
	_hangar = "Land_SS_hangar" createvehicle _poss;
	_hangar setDir 90;
	__AddToExtraVec(_hangar)
	sleep 1.0123;
	_vehicle = objNull;
	_vehicle = _xchopper createvehicle _poss;
	_vehicle setDir 270;
	sleep 2.123;
	["specops", 1, "basic", 1, _poss,100,true] spawn FUNC(CreateInf);
	sleep 2.221;
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other,1,140,true] spawn FUNC(CreateArmor);
	sleep 2.543;
	[_vehicle] execVM "x_missions\common\x_sidesteal.sqf";
	__addDead(_vehicle)
	_lvec = "TowingTractor" createvehicle _poss;
	__addDead(_lvec)
};