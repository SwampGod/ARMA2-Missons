// by Xeno
private "_poss";
#include "x_setup.sqf"

x_sm_pos = [[9793.86,11158.9,0], [573.262,2835.7,0],182]; // index: 21,   Convoy Zavarak to Chaman, start and end position
x_sm_type = "convoy"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "An enemy convoy is on route from Zavarak to Chaman. Find it and destroy it.";
	d_current_mission_resolved_text = "Good job. The convoy is down.";
};

if (isServer) then {
	__PossAndOther
	[_poss, _pos_other, x_sm_pos select 2] execVM "x_missions\common\x_sideconvoy.sqf";
};