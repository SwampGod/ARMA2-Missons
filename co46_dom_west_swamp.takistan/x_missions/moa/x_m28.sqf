// by Xeno
private ["_vehicle", "_poss"];
#include "x_setup.sqf"

x_sm_pos = [[8663.16,9925.88,0],[8679.68,9967.21,0]]; // index: 28,   Radio Tower at bunker near Sagram
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "The enemy has a bunker near Sagram. Enemy government uses this bunker for emergeny situations. Destroy the radar tower there to cut down the ability for them to communicate.";
	d_current_mission_resolved_text = "Good job. The radio tower near Sagram is down.";
};

if (isServer) then {
	__PossAndOther
#ifdef __OA__
	_vehicle = "Land_Ind_IlluminantTower" createvehicle (_poss);
#else
	_vehicle = "Land_telek1" createvehicle (_poss);
#endif
	_vehicle setVectorUp [0,0,1];
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	sleep 2.22;
	["shilka", 1, "bmp", 0, "tank", 0, _pos_other,1,0,false] spawn XCreateArmor;
	sleep 2.333;
	["specops", 1, "basic", 2, _poss,80,true] spawn XCreateInf;
	sleep 2.333;
	["shilka", 0, "bmp", 1, "tank", 1, _pos_other,1,100,true] spawn XCreateArmor;
	__AddToExtraVec(_vehicle)
};