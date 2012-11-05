// by Xeno
#include "x_setup.sqf"

x_sm_pos = [[2016.32,10699.2,0]]; // Specop camp
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "Intel has got some information about a specops camp near Nur. Find it and eliminate all specops there before they try to sabotage something....";
	d_current_mission_resolved_text = "Good job. The specops are eliminated.";
};

if (isServer) then {
	[x_sm_pos select 0] execVM "x_missions\common\x_sidespecops.sqf";
};