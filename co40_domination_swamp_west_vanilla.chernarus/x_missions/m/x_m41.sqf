// by Xeno
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[12275.7,10915.1,0]]; // index: 41,   Prison camp, Khelm
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "There is a prison camp in Khelm. Free the prisoners and bring at least eight prisoners back to your base (only a rescue operator can do that).";
	GVAR(current_mission_resolved_text) = "Good job. The prisoners are free.";
};

if (isServer) then {
	[GVAR(x_sm_pos)] execVM "x_missions\common\x_sideprisoners.sqf";
};