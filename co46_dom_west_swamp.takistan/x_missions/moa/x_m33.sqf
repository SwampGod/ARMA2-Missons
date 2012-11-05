// by Xeno
#include "x_setup.sqf"

x_sm_pos = [[6091.83,1160.42,0],   [6110.48,1142.65,0], [6056.48,1176.8,0], [6008.47,1170.24,0],[6023.41,1209.14,0],[6101.76,1206.12,0]]; // index: 33,   Capture the flag, Huzrutimam
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "We want to provoke the enemy. Find the enemy flag in Huzrutimam and bring it back to the flag at your base.";
	d_current_mission_resolved_text = "Good job. The enemy flag is in our base.";
};

if (isServer) then {
	[x_sm_pos] execVM "x_missions\common\x_sideflag.sqf";
};