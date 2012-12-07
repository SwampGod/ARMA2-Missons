// by Xeno
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[9652.59,10430.2,0],  [9615.56,10447.7,0], [9614.49,10415.9,0], [9651.87,10460.5,0], [9694.1,10429.5,0], [9707.75,10415.2,0], [9686.9,10392.7,0]]; // index: 29,   Tank depot at Cabo Juventudo
GVAR(x_sm_type) = "normal"; // "convoy"

_tank_dirs = [95.394,92.9621,281.765,29,107,194.826];

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "There is an enemy tank depot in a village near Dubrovka. Destroy all tanks there to weaken the enemy troops.";
	GVAR(current_mission_resolved_text) = "Good job. All tanks are down.";
};

if (isServer) then {
	[GVAR(x_sm_pos), _tank_dirs] execVM "x_missions\common\x_sidetanks.sqf";
};
