// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[6979.58,2425.28,0]]; // train in Chernogorsk
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "Intel reports about a train with vital military equipment leaving Chernogorsk habour soon. Find the train and destroy it!";
	GVAR(current_mission_resolved_text) = "Good job. The train is down...";
};

if (isServer) then {
	_train1 = "Land_loco_742_blue" createvehicle [6976.36,2422.87,0];
	_train1 setDir 51.991;
	_train2 = "Land_wagon_box" createvehicle [6966.26,2415.06,0];
	_train2 setDir 51.991;
	_train3 = "Land_wagon_flat" createvehicle [6954.63,2405.98,0];
	_train3 setDir 51.991;
	_train4 = "Land_wagon_tanker" createvehicle [6943,2396.9,0];
	_train4 setDir 51.991;
	[GVAR(x_sm_pos) select 0, [_train1,_train2,_train3,_train4]] execVM "x_missions\common\x_sidetrains.sqf";
};