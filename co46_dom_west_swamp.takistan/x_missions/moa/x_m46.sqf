// by Xeno
private ["_objs", "_poss"];
#include "x_setup.sqf"

x_sm_pos = [[4546.14,9396.79,0]]; // index: 46,   Destroy factory building in Lalezar
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "The enemy is producing ball bearings in a factory in Lalezar. Destroy the fuel tanks to stop the production.";
	d_current_mission_resolved_text = "Good job. The fuel tanks are down.";
};

if (isServer) then {
	__Poss
	_objs = nearestObjects [_poss, ["Land_Ind_TankBig"], 50];
	sleep 2.123;
	["specops", 2, "basic", 1, _poss,80,true] spawn XCreateInf;
	sleep 2.221;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,100,true] spawn XCreateArmor;
	[_objs select 0, _objs select 1, _objs select 2] execVM "x_missions\common\x_sidefactory.sqf";
};