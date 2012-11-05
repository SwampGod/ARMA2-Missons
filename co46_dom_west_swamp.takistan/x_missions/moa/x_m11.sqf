// by Xeno
private ["_officer", "_fortress", "_poss", "_ogroup", "_bpos", "_leadero"];
#include "x_setup.sqf"

x_sm_pos = [[12262.3,4803.05,0]]; // Find and eliminate Nib Nedal in the region around mount Bamjahan
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "A terrorist leader called Nib Nedal hides somewhere near mount Bamjahan. Your task is to find him and eliminate him!";
	d_current_mission_resolved_text = "The terrorist leader is dead. Good job.";
};

if (isServer) then {
	_officer = "TK_INS_Warlord_EP1";
	__PossAndOther
	_newpos = [_poss, 400] call XfGetRanPointCircle;
	__GetEGrp(_ogroup)
	_sm_vehicle = _ogroup createUnit [_officer, _newpos, [], 0, "FORM"];
	_sm_vehicle setVariable ["BIS_noCoreConversations", true];
	__addDead(_sm_vehicle)
#ifndef __TT__
	_sm_vehicle addEventHandler ["killed", {_this call XKilledSMTargetNormal}];
#else
	_sm_vehicle addEventHandler ["killed", {_this call XKilledSMTargetTT}];
#endif
	sleep 2.123;
	["specops", 1, "basic", 0, _newpos, 0,true] spawn XCreateInf;
	sleep 2.123;
	_leadero = leader _ogroup;
	_leadero setRank "COLONEL";
	_ogroup allowFleeing 0;
	_ogroup setbehaviour "AWARE";
	_leadero disableAI "MOVE";
};