// by Xeno
private "_poss";
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[11855.2,7330.4,0], [2529.62,6358.53,0], 300]; // index: 20,   Convoy Orlovets to Sosnovka, start and end position
GVAR(x_sm_type) = "convoy"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "An enemy convoy is on route from Orlovets to Sosnovka. Find it and destroy it.";
	GVAR(current_mission_resolved_text) = "Good job. The convoy is down.";
};

if (isServer) then {
	__PossAndOther
	[_poss, _pos_other, GVAR(x_sm_pos) select 2] execVM "x_missions\common\x_sideconvoy.sqf";
};