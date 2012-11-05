// by Xeno
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[8541.77,14202.3,0]]; // index: 52,   Shot down chopper
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "One of our own choppers was shot down in the northern territories. Find and rescue the crew and bring them back to base. Attention, enemy units are also on the way to the chopper. You have about 15 minutes before they arrive.";
	GVAR(current_mission_resolved_text) = "Good job. The crew is back at base.";
};

if (isServer) then {
	[GVAR(x_sm_pos),time + ((15 * 60) + random 60)]  execVM "x_missions\common\x_sideevac.sqf";
};