// by Xeno
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[9653.59,6562.56,0],   [9650.71,6579.14,0],[9679.21,6536.92,0],[9623.96,6550.25,0],[9574.8,6549.91,0],[9557.83,6613.66,0]]; // index: 32,   Capture the flag, Shakhovka
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "This time we want to provoke the enemy. Find the enemy flag in Shakhovka and bring it back to the flag at your base.";
	GVAR(current_mission_resolved_text) = "Good job. The enemy flag is in our base.";
};

if (isServer) then {
	[GVAR(x_sm_pos)] execVM "x_missions\common\x_sideflag.sqf";
};