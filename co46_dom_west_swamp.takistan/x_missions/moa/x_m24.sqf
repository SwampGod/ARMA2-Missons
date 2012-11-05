// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

x_sm_pos = [[3790.3,8941.19,0]]; // index: 24,   Fuel station in camp near Gospandi
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "The enemy uses a fuelstation located near Gospandi to refuel its vehicles. Simple task, destroy it to cut down fuel supplies.";
	d_current_mission_resolved_text = "Good job. The fuelstation is down.";
};

if (isServer) then {
	__Poss
#ifndef __OA__
	_vehicle = "Land_A_FuelStation_Build" createvehicle (_poss);
#else
	_vehicle = "Land_Ind_FuelStation_Build_EP1" createvehicle (_poss);
#endif
	_vehicle setDir 300;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 2.22;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,120,true] spawn XCreateArmor;
	sleep 2.123;
	["specops", 1, "basic", 2, _poss,110,true] spawn XCreateInf;
	__AddToExtraVec(_vehicle)
};