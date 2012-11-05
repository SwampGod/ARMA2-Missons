// by Xeno
private ["_officer", "_ogroup", "_poss", "_leadero"];
#include "x_setup.sqf"

x_sm_pos = [[2811.69,5931.73,0]]; // index: 49,   Officer near Benoma
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
#ifndef __TT__
	d_current_mission_text = "The enemy has a small outpost in a valley near Jilavur. Arrest the officer there and bring him back to the flag at your base to get some vital informations.";
	d_current_mission_resolved_text = "Good job. The officer was arrested.";
#else
	d_current_mission_text = "The enemy has a small outpost in a valley near Jilavur. Eliminate the officer there !!!";
	d_current_mission_resolved_text = "Good job. The officer was killed.";
#endif
};

if (isServer) then {
	_officer = d_soldier_officer;
	__Poss
	sleep 2.111;
	__GetEGrp(_ogroup)
	_sm_vehicle = _ogroup createUnit [_officer, _poss, [], 0, "FORM"];
	_sm_vehicle setVariable ["BIS_noCoreConversations", true];
	__addDead(_sm_vehicle)
#ifndef __TT__
	_sm_vehicle addEventHandler ["killed", {_this call XKilledSMTarget500}];
	removeAllWeapons _sm_vehicle;
#else
	_sm_vehicle addEventHandler ["killed", {_this call XKilledSMTargetTT}];
#endif
	sleep 2.123;
	["specops", 3, "basic", 2, _poss, 100,true] spawn XCreateInf;
	sleep 2.123;
	["shilka", 1, "bmp", 1, "tank", 1, _poss,1,120,true] spawn XCreateArmor;
	sleep 2.123;
	_leadero = leader _ogroup;
	_leadero setRank "COLONEL";
	_ogroup allowFleeing 0;
	_ogroup setbehaviour "AWARE";
	_leadero disableAI "MOVE";
#ifndef __TT__
	[_sm_vehicle] execVM "x_missions\common\x_sidearrest.sqf";
#endif
};