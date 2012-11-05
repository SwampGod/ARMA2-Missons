// by Xeno
#include "x_setup.sqf"

x_sm_pos = [[11637.4,9225.68,0],  [11637.4,9225.68,0], [11636.1,9256.33,0], [11680.2,9243.59,0], [11682.1,9197.33,0], [11659.4,9183.29,0], [11686,9156.49,0]]; // index: 29,   Tank depot at Cabo Juventudo
x_sm_type = "normal"; // "convoy"

_tank_dirs = [80,80,163,169,178,175];

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "There is an enemy tank depot near Ravanay. Destroy all tanks there to weaken the enemy troops.";
	d_current_mission_resolved_text = "Good job. All tanks are down.";
};

if (isServer) then {
	[x_sm_pos, _tank_dirs] execVM "x_missions\common\x_sidetanks.sqf";
};

if (true) exitWith {};