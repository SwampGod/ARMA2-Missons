// by Xeno
private ["_officer", "_fortress", "_poss", "_ogroup", "_bpos", "_leadero"];
#include "x_setup.sqf"

x_sm_pos = [[4099.93,11785.60], [4111.78,12188.6,0]]; // Officer, Shamali, second array = position Shilka
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "A high enemy officer arrives today in Shamali. He is responsible for the death of many civilians. Eliminate him!";
	d_current_mission_resolved_text = "The enemy officer is dead. Good job.";
};

if (isServer) then {
	_officer = d_soldier_officer;
	__PossAndOther
	["shilka", 1, "", 0, "", 0, _pos_other,1,0,false] spawn XCreateArmor;
	sleep 2.123;
#ifndef __OA__
	_fortress = "Land_Fort_Watchtower" createVehicle _poss;
	_fortress setDir -133.325;
#else
	_fortress = "Land_Fort_Watchtower_EP1" createVehicle _poss;
	_fortress setDir 85;
#endif
	__AddToExtraVec(_fortress)
	sleep 2.123;
	__GetEGrp(_ogroup)
	_sm_vehicle = _ogroup createUnit [_officer, _poss, [], 0, "FORM"];
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
	["specops", 2, "basic", 2, _poss, 100,true] spawn XCreateInf;
	sleep 2.123;
	_leadero = leader _ogroup;
	_leadero setRank "COLONEL";
	_ogroup allowFleeing 0;
	_ogroup setbehaviour "AWARE";
	_leadero disableAI "MOVE";
};