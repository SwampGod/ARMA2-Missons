// by Xeno
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[2147.28,12924.8,0]]; // Specop camp
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "Intel has got some information about a specops camp in the north. Find it and eliminate all specops there before they try to sabotage something....";
	GVAR(current_mission_resolved_text) = "Good job. The specops are eliminated.";
};

if (isServer) then {
	[GVAR(x_sm_pos) select 0] execVM "x_missions\common\x_sidespecops.sqf";
};