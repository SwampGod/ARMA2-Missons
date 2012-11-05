// by Xeno
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[3319.2,3935.14,0],   [3347.69,3931.31,0], [3409.98,3926.71,0], [3393.92,3988.62,0],[3299.4,3962.64,0],[3300.41,3920.48,0]]; // index: 33,   Capture the flag, Bor
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "We want to provoke the enemy. Find the enemy flag in Bor and bring it back to the flag at your base.";
	GVAR(current_mission_resolved_text) = "Good job. The enemy flag is in our base.";
};

if (isServer) then {
	[GVAR(x_sm_pos)] execVM "x_missions\common\x_sideflag.sqf";
};