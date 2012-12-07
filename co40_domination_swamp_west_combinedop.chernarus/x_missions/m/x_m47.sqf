// by Xeno
private ["_objs", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[13116.6,10437.4,0]]; // index: 47,   Destroy factory building in Berezino, attention, uses nearestObject ID
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "The enemy is producing ammunition in a factory near Berezino. Destroy the main building and the pipelines to stop the production.";
	GVAR(current_mission_resolved_text) = "Good job. The factory is down.";
};

if (isServer) then {
	__Poss
	_objs = nearestObjects [_poss, ["Land_Ind_Expedice_2","Land_Ind_Expedice_1","Land_Ind_Expedice_3"], 50];
	sleep 2.123;
	["specops", 2, "basic", 1, _poss,80,true] spawn FUNC(CreateInf);
	sleep 2.221;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,150,true] spawn FUNC(CreateArmor);
	sleep 5.123;
	[_objs select 0, _objs select 1, _objs select 2] execVM "x_missions\common\x_sidefactory.sqf";
};