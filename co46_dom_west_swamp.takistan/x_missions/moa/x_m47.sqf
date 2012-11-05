// by Xeno
private ["_objs", "_poss"];
#include "x_setup.sqf"

x_sm_pos = [[3289.84,11254.8,0]]; // index: 47,   Destroy oil pumps
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "The enemy has some very productive oil pumps near Nagara-1-Oilfield. Destroy the pumps there to cut down the enemy fuel supllies.";
	d_current_mission_resolved_text = "Good job. The oil pumps are down.";
};

if (isServer) then {
	__Poss
	_objs = nearestObjects [_poss, ["Land_Ind_Oil_Pump_EP1"], 120];
	sleep 2.123;
	["specops", 2, "basic", 1, _poss,80,true] spawn XCreateInf;
	sleep 2.221;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,150,true] spawn XCreateArmor;
	sleep 5.123;
	[_objs select 0, _objs select 1, _objs select 2] execVM "x_missions\common\x_sidefactory.sqf";
};