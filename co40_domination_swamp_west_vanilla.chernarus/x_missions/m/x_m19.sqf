// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[10841.9,2695.45,0]]; // train in Elektrozavodsk
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "An enemy train is waiting in Elektrozavodsk for loading tanks and fuel. Find the train and destroy it!";
	GVAR(current_mission_resolved_text) = "Good job. The train is down...";
};

if (isServer) then {
	_train1 = "Land_loco_742_blue" createvehicle [10841.9,2695.45,0];
	_train1 setDir 20.7776;
	_train2 = "Land_wagon_box" createvehicle [10837.3,2683.54,0];
	_train2 setDir 20.7776;
	_train3 = "Land_wagon_flat" createvehicle [10832.1,2669.75,0];
	_train3 setDir 20.7776;
	_train4 = "Land_wagon_tanker" createvehicle [10826.8,2655.96,0];
	_train4 setDir 20.7776;
	[GVAR(x_sm_pos) select 0, [_train1,_train2,_train3,_train4]] execVM "x_missions\common\x_sidetrains.sqf";
};