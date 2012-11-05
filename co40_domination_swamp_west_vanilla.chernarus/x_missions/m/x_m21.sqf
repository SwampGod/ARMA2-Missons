// by Xeno
private "_poss";
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[8828.15,11857.7,0], [9152.35,3899.26,0],286]; // index: 21,   Convoy Gvozdno to Pusta, start and end position
GVAR(x_sm_type) = "convoy"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "An enemy convoy is on route from Gvozdno to Pusta. Find it and destroy it.";
	GVAR(d_current_mission_resolved_text) = "Good job. The convoy is down.";
};

if (isServer) then {
	__PossAndOther
	[_poss, _pos_other, GVAR(x_sm_pos) select 2] execVM "x_missions\common\x_sideconvoy.sqf";
};