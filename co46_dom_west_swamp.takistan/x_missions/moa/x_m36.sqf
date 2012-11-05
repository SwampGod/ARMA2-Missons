// by Xeno
#include "x_setup.sqf"

x_sm_pos = [[6166.86,5623.85,0], [6188.98,5644.13,0],[6164.26,5688.67,0],[6107.55,5660.74,0],[6123.37,5614.48,0],[6117.23,5555.66,0]]; // index: 36,   Capture the flag, Anar
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "Find the enemy flag in Anar and bring it back to the flag at your base.";
	d_current_mission_resolved_text = "Good job. The enemy flag is in our base.";
};

if (isServer) then {
	[x_sm_pos] execVM "x_missions\common\x_sideflag.sqf";
};