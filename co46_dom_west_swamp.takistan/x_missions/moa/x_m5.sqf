// by Xeno
private ["_xtank", "_vehicle", "_poss"];
#include "x_setup.sqf"

x_sm_pos = [[5037.56,6886.49,0]]; //  destroy power generator in mine near Feruz-Abad
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "The enemy has a uran mine near Feruz-Abad. Your task: destroy the containers with mining equipment to prevent further mining!";
	d_current_mission_resolved_text = "Good job. You have destroyed the containers.";
};

if (isServer) then {
	__PossAndOther
	_vehicle = "Land_Misc_Cargo2E_EP1" createvehicle (_poss);
	_vehicle setDir 120;
#ifndef __TT__
	[_vehicle] execFSM "fsms\XCheckSMHardTarget.fsm";
#else
	[_vehicle] execFSM "fsms\XCheckSMHardTargetTT.fsm";
#endif
	__AddToExtraVec(_vehicle)
	sleep 2.123;
	["specops", 2, "basic", 3, _poss,100,true] spawn XCreateInf;
	sleep 2.321;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,150,true] spawn XCreateArmor;
};