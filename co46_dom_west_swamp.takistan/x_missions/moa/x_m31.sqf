// by Xeno
#include "x_setup.sqf"

x_sm_pos = [[10527,10989.8,0], [10527,10989.8,0], [10502.5,11002.5,0], [10488,10963.6,0.0], [10480.9,10999.9,0], [10573.1,10965.7,0], [10562.3,10921.5,0]]; // index: 31,   Tank depot Zavarak
x_sm_type = "normal"; // "convoy"

_tank_dirs = [295, 311, 227, 216, 144, 220];

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "There is an enemy tank depot in Zavarak. Destroy all tanks there to weaken the enemy troops.";
	d_current_mission_resolved_text = "Good job. All tanks are down.";
};

if (isServer) then {
	[x_sm_pos, _tank_dirs] execVM "x_missions\common\x_sidetanks.sqf";
};