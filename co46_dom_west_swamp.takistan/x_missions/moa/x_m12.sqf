// by Xeno
private ["_officer", "_newgroup", "_poss", "_fortress", "_bpos", "_leader"];
#include "x_setup.sqf"

x_sm_pos = [[4630.23,12310,0], [4673.13,12293.8,0]]; // index: 12,   Officer at Lake Charsu
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "A high enemy officer makes holidays at Lake Charsu. Eliminate him !";
	d_current_mission_resolved_text = "Good job. The enemy officer is dead.";
};

if (isServer) then {
	_officer = d_soldier_officer;
	__PossAndOther
	["shilka", 1, "bmp", 1, "tank", 0, _pos_other,1,0] spawn XCreateArmor;
	sleep 2.123;
	__GetEGrp(_newgroup)
#ifndef __OA__
	_fortress = "Land_Fort_Watchtower" createVehicle _poss;
#else
	_fortress = "Land_Fort_Watchtower_EP1" createVehicle _poss;
#endif
	_fortress setDir 180;
	__AddToExtraVec(_fortress)
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
	sleep 2.123;
	_leader = leader _newgroup;
	_leader setRank "COLONEL";
	_newgroup allowFleeing 0;
	_newgroup setbehaviour "AWARE";
	_leader disableAI "MOVE";
	sleep 2.123;
	["specops", 2, "basic", 1, _poss,0] spawn XCreateInf;
};