// by Xeno
private ["_xarti", "_vehicle", "_poss"];
#include "x_setup.sqf"

x_sm_pos = [[4005.41,6913.99,0], [4023.56,6910.64,0]]; // index: 10,   Artillery at top of mount Sanginakt
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "There is a artillery cannon on top of mount Sanginakt. Destroy it before enemy troops use it to attack Feruz-Abad.";
	d_current_mission_resolved_text = "Good job. The artillery cannon is destroyed.";
};

if (isServer) then {
#ifndef __OA__
	_xarti = switch (d_enemy_side) do {
		case "EAST": {"D30_RU"};
		case "WEST": {"M119"};
		case "GUER": {"D30_Ins"};
	};
#else
	_xarti = switch (d_enemy_side) do {
		case "EAST": {"D30_TK_EP1"};
		case "WEST": {"M119_US_EP1"};
		case "GUER": {"D30_TK_GUE_EP1"};
	};
#endif
	__PossAndOther
	_vehicle = objNull;
	_vehicle = _xarti createvehicle (_poss);
	__addDead(_vehicle)
#ifndef __TT__
	_vehicle addEventHandler ["killed", {_this call XKilledSMTargetNormal}];
#else
	_vehicle addEventHandler ["killed", {_this call XKilledSMTargetTT}];
#endif
	_vehicle lock true;
	sleep 2.21;
	["specops", 1, "basic", 2, _poss,0] spawn XCreateInf;
	sleep 2.045;
	["shilka", 1, "bmp", 1, "tank", 0, _pos_other,1,0] spawn XCreateArmor;
};