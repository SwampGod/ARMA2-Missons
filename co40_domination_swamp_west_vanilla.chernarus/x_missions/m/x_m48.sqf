// by Xeno
private "_poss";
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[2270.01,5253.18,0]]; // index: 48,   Transformer station near Zelenogorsk, attention, uses nearestObject ID
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "There is a huge transformer station near Zelenogorsk. Destroy the three transfomers to cut down the electrical power.";
	GVAR(current_mission_resolved_text) = "Good job. The transformer station is destroyed.";
};

if (isServer) then {
	__Poss
	[_poss] execVM "x_missions\common\x_sidetrafo.sqf";
};