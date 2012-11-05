// by Xeno
private "_poss";
#include "x_setup.sqf"

x_sm_pos = [[2093.99,11685.4,0], [10833.5,6304.32,0], 140]; // index: 20,   Convoy Nur to Garmsar, start and end position
x_sm_type = "convoy"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "An enemy convoy is on route from Nur to Garmsar. Find it and destroy it.";
	d_current_mission_resolved_text = "Good job. The convoy is down.";
};

if (isServer) then {
	__PossAndOther
	[_poss, _pos_other, x_sm_pos select 2] execVM "x_missions\common\x_sideconvoy.sqf";
};