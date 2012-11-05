// by Xeno
private "_poss";
#include "x_setup.sqf"

x_sm_pos = [[5532.28,11980.4,0]]; // index: 50,   Artillery base
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "Finally we've found the enemy artillery base. If you can destroy all artillery guns the artillery observers at main targets have nothing to call in artillery strikes anymore.";
	d_current_mission_resolved_text = "Good job. All artillery guns are down. No artillery observers will appear at main targets anymore.";
};

if (isServer) then {
	__Poss
	[_poss] execVM "x_missions\common\x_sidearti.sqf";
};