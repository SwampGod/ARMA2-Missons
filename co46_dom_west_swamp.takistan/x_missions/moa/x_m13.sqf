// by Xeno
private ["_poss", "_fortress", "_newgroup", "_leader"];
#include "x_setup.sqf"

x_sm_pos = [[803.361,10478.5,0], [847.563,10473.5,0]]; // index: 13,   Prime Minister,Nagara
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "The enemy prime minister visits some troops near Nagara. Eliminate him !";
	d_current_mission_resolved_text = "Good job. The prime minister is dead.";
};

if (isServer) then {
	__PossAndOther
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other,1,0] spawn XCreateArmor;
	sleep 2.123;
	["specops", 2, "basic", 1, _poss,50] spawn XCreateInf;
	sleep 2.111;
#ifndef __OA__
	_fortress = "Land_Fort_Watchtower" createVehicle _poss;
	_fortress setDir 55;
#else
	_fortress = "Land_Fort_Watchtower_EP1" createVehicle _poss;
	_fortress setDir 190;
#endif
	__AddToExtraVec(_fortress)
	sleep 2.123;
	__GetEGrp(_newgroup)
#ifndef __OA__
	_sm_vehicle = _newgroup createUnit ["Functionary1", _poss, [], 0, "FORM"];
#else
	_sm_vehicle = _newgroup createUnit ["Functionary1_EP1", _poss, [], 0, "FORM"];
#endif
	_sm_vehicle setVariable ["BIS_noCoreConversations", true];
	__addDead(_sm_vehicle)
#ifndef __TT__
	_sm_vehicle addEventHandler ["killed", {_this call XKilledSMTargetNormal}];
#else
	_sm_vehicle addEventHandler ["killed", {_this call XKilledSMTargetTT}];
#endif
	sleep 2.123;
	_sm_vehicle setPos position _fortress;
	_leader = leader _newgroup;
	_leader setRank "COLONEL";
	_newgroup allowFleeing 0;
	_newgroup setbehaviour "AWARE";
	_leader disableAI "MOVE";
};