// by Xeno
private ["_officer", "_poss", "_fortress", "_newgroup", "_bpos", "_leader"];
#include "x_setup.sqf"

x_sm_pos = [[5054.55,6886.71,0], [5051.02,6900.93,0]]; // index: 17,   Officer in mine near Feruz-Abad
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "A high enemy officer arrives today in a mine near Feruz-Abad. He is responsible for the production of biological and chemical weapons. Eliminate him !";
	d_current_mission_resolved_text = "The enemy officer is dead. Good job.";
};

if (isServer) then {
	_officer = d_soldier_officer;
	__PossAndOther
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other,1,110,true] spawn XCreateArmor;
	sleep 2.123;
	["specops", 2, "basic", 1, _poss,70,true] spawn XCreateInf;
	sleep 2.111;
#ifndef __OA__
	_fortress = "Land_Fort_Watchtower" createVehicle _poss;
#else
	_fortress = "Land_Fort_Watchtower_EP1" createVehicle _poss;
#endif
	__AddToExtraVec(_fortress)
	sleep 2.123;
	__GetEGrp(_newgroup)
	_sm_vehicle = _newgroup createUnit [_officer, _poss, [], 0, "FORM"];
	_sm_vehicle setVariable ["BIS_noCoreConversations", true];
	__addDead(_sm_vehicle)
#ifndef __TT__
	_sm_vehicle addEventHandler ["killed", {_this call XKilledSMTargetNormal}];
#else
	_sm_vehicle addEventHandler ["killed", {_this call XKilledSMTargetTT}];
#endif
	sleep 2.123;
	_bpos = position _fortress;
	_sm_vehicle setPos _bpos;
	_leader = leader _newgroup;
	_leader setRank "COLONEL";
	_newgroup allowFleeing 0;
	_newgroup setbehaviour "AWARE";
	_leader disableAI "MOVE";
};