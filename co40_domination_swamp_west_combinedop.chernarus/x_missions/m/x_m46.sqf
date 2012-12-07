// by Xeno
private ["_objs", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[6482.19,2484.12,0]]; // index: 46,   Destroy factory building in Chernogorsk, attention, uses nearestObject ID
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "The enemy is producing ball bearings in a factory in Chernogorsk. Destroy the main building and the two chimneys to stop the production.";
	GVAR(current_mission_resolved_text) = "Good job. The factory is down.";
};

if (isServer) then {
	__Poss
	_objs = nearestObjects [_poss, ["Land_Ind_Pec_03a","Land_Ind_MalyKomin"], 50];
	sleep 2.123;
	["specops", 2, "basic", 1, _poss,80,true] spawn FUNC(CreateInf);
	sleep 2.221;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,100,true] spawn FUNC(CreateArmor);
	[_objs select 0, _objs select 1, _objs select 2] execVM "x_missions\common\x_sidefactory.sqf";
};