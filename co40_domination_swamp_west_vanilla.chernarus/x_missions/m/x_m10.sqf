// by Xeno
private ["_xarti", "_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[6599.02,3409.95,0], [6616.04,3410.23,0]]; // index: 10,   Artillery at top of mount Vysota
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "There is a artillery cannon on top of mount Vysota. Destroy it before enemy troops use it to attack Chernogorsk.";
	GVAR(current_mission_resolved_text) = "Good job. The artillery cannon is destroyed.";
};

if (isServer) then {
	_xarti = switch (GVAR(enemy_side)) do {
		case "EAST": {"D30_RU"};
		case "WEST": {"M119"};
		case "GUER": {"D30_Ins"};
	};
	__PossAndOther
	_vehicle = objNull;
	_vehicle = createVehicle [_xarti, _poss, [], 0, "NONE"];
	_vehicle setPos _poss;
#ifndef __TT__
	_vehicle addEventHandler ["killed", {_this call FUNC(KilledSMTargetNormal)}];
#else
	_vehicle addEventHandler ["killed", {_this call FUNC(KilledSMTargetTT)}];
#endif
	_vehicle lock true;
	sleep 2.21;
	["specops", 1, "basic", 2, _poss,0] spawn FUNC(CreateInf);
	sleep 2.045;
	["shilka", 1, "bmp", 1, "tank", 0, _pos_other,1,0] spawn FUNC(CreateArmor);
};