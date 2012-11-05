// by Xeno
#include "x_setup.sqf"

x_sm_pos = [[8248.55,7783.13,0],   [8283.4,7785.05,0],[8294.16,7750.21,0],[8262.45,7730.4,0],[8231.78,7741.37,0],[8197.77,7784.9,0]]; // index: 32,   Capture the flag, Imarat
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "This time we want to provoke the enemy. Find the enemy flag in Imarat and bring it back to the flag at your base.";
	d_current_mission_resolved_text = "Good job. The enemy flag is in our base.";
};

if (isServer) then {
	[x_sm_pos] execVM "x_missions\common\x_sideflag.sqf";
};