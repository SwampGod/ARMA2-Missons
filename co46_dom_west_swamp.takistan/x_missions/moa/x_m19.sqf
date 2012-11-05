// by Xeno
private "_poss";
#include "x_setup.sqf"

x_sm_pos = [[2156.64,431.394,0], [2044.99,7698.44,0],34]; // index: 19,   Convoy Landay to Mulladost, start and end position
x_sm_type = "convoy"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "An enemy convoy is on route from Landay to Mulladost. Find it and destroy it.";
	d_current_mission_resolved_text = "Good job. The convoy is down.";
};

if (isServer) then {
	__PossAndOther
	[_poss, _pos_other, x_sm_pos select 2] execVM "x_missions\common\x_sideconvoy.sqf";
};