// by Xeno
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[12781.8,4453.06,0], [12636.5,4378.36,0],[12819.6,4437.2,0],[12845.8,4440.17,0],[12904,4434.44,0],[12854,4481.98,0]]; // index: 36,   Capture the flag, Tulga
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "Find the enemy flag in Tulga and bring it back to the flag at your base.";
	GVAR(current_mission_resolved_text) = "Good job. The enemy flag is in our base.";
};

if (isServer) then {
	[GVAR(x_sm_pos)] execVM "x_missions\common\x_sideflag.sqf";
};