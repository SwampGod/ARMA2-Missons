// by Xeno
private "_poss";
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[4535.17,4439.5,0], [11274.6,5495.05,0],140]; // index: 22,   Convoy Kozlovka to Msta, start and end position
GVAR(x_sm_type) = "convoy"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "An enemy convoy is on route from Kozlovka to Msta. Find it and destroy it.";
	GVAR(current_mission_resolved_text) = "Good job. The convoy is down.";
};

if (isServer) then {
	__PossAndOther
	[_poss, _pos_other, GVAR(x_sm_pos) select 2] execVM "x_missions\common\x_sideconvoy.sqf";
};