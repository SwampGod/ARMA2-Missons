// by Xeno
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[7704.97,5188.01,0], [7716.81,5161.65,0], [7705.86,5167.78,0], [7686.79,5177.37,0], [7668.16,5186.41,0], [7639.87,5177.35,0], [7623.4,5178.56,0]]; // index: 31,   Tank depot Mogilevka
GVAR(x_sm_type) = "normal"; // "convoy"

_tank_dirs = [18, 18, 18, 18, 18, 18];

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "There is an enemy tank depot in Mogilevka. Destroy all tanks there to weaken the enemy troops.";
	GVAR(current_mission_resolved_text) = "Good job. All tanks are down.";
};

if (isServer) then {
	[GVAR(x_sm_pos), _tank_dirs] execVM "x_missions\common\x_sidetanks.sqf";
};