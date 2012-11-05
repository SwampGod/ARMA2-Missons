// by Xeno
private ["_poss", "_fortress", "_newgroup", "_officer", "_bpos", "_leader"];
#include "x_setup.sqf"

x_sm_pos = [[3758.49,10887.2,0], [3746.24,10864.5,0]]; // index: 18,   Government member visits Nagara-1-Oilfield
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "A high enemy government member visits Nagara-1-Oilfield today. He wants to take a look at the local oil production in Nagara-1-Oilfield. Eliminate him !";
	d_current_mission_resolved_text = "The government member is dead. Good job.";
};

if (isServer) then {
	__PossAndOther
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other,1,120,true] spawn XCreateArmor;
	sleep 2.123;
	["specops", 2, "basic", 1, _poss,100,true] spawn XCreateInf;
	sleep 2.111;
#ifndef __OA__
	_fortress = "Land_Fort_Watchtower" createVehicle _poss;
#else
	_fortress = "Land_Fort_Watchtower_EP1" createVehicle _poss;
#endif
	__AddToExtraVec(_fortress)
	sleep 2.123;
	__GetEGrp(_newgroup)
	_officer = d_soldier_officer;
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