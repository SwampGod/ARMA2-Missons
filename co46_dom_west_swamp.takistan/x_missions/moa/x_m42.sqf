// by Xeno
private ["_officer", "_ogroup", "_poss", "_leadero"];
#include "x_setup.sqf"

x_sm_pos = [[2135.88,10716.5,0]]; // index: 42,   Officer in forrest near Nur
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
#ifndef __TT__
	d_current_mission_text = "An enemy officer is on a walk in a forrest near Nur. This is a good chance to arrest him and bring him to your base.";
	d_current_mission_resolved_text = "Good job.s The officer was arrested.";
#else
	d_current_mission_text = "An enemy officer is on a walk in a forrest near Nur. Simple task, eliminate him !!!";
	d_current_mission_resolved_text = "Good job.s The officer was killed.";
#endif
};

if (isServer) then {
	_officer = d_soldier_officer;
	__PossAndOther
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
	_leadero = leader _ogroup;
	_leadero setRank "COLONEL";
	_ogroup setbehaviour "AWARE";
	_leadero disableAI "MOVE";
#ifndef __TT__
	[_sm_vehicle] execVM "x_missions\common\x_sidearrest.sqf";
#endif
};