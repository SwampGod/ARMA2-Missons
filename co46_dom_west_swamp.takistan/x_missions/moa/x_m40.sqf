// by Xeno
#include "x_setup.sqf"

x_sm_pos = [[8817.35,7138.39,0]]; // index: 40,   Prison camp, Garmarud
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "There is a prison camp in Garmarud. Free the prisoners and bring at least eight prisoners back to your base (only a rescue operator can do that).";
	d_current_mission_resolved_text = "Good job. The prisoners are free.";
};

if (isServer) then {
	[x_sm_pos] execVM "x_missions\common\x_sideprisoners.sqf";
};