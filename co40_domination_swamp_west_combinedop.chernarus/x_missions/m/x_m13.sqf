// by Xeno
private ["_poss", "_fortress", "_newgroup", "_leader"];
#include "x_setup.sqf"

GVAR(x_sm_pos) = [[1079.37,10382.9,0], [1077.04,10420.4,0]]; // index: 13,   Prime Minister,Lopatino
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	GVAR(current_mission_text) = "The enemy prime minister visits some troops near Lopatino. Eliminate him !";
	GVAR(current_mission_resolved_text) = "Good job. The prime minister is dead.";
};

if (isServer) then {
	__PossAndOther
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other,1,0] spawn FUNC(CreateArmor);
	sleep 2.123;
	["specops", 2, "basic", 1, _poss,50] spawn FUNC(CreateInf);
	sleep 2.111;
	_fortress = createVehicle ["Land_Fort_Watchtower", _poss, [], 0, "NONE"];
	_fortress setDir 55;
	_fortress setPos _poss;
	__AddToExtraVec(_fortress)
	sleep 2.123;
	__GetEGrp(_newgroup)
	_sm_vehicle = _newgroup createUnit ["Functionary1", _poss, [], 0, "FORM"];
	if (GVAR(without_nvg) == 0) then {
		if (_sm_vehicle hasWeapon "NVGoggles") then {_sm_vehicle removeWeapon "NVGoggles"};
	};
	_sm_vehicle setVariable ["BIS_noCoreConversations", true];
	__addDeadAI(_sm_vehicle)
#ifndef __TT__
	_sm_vehicle addEventHandler ["killed", {_this call FUNC(KilledSMTargetNormal)}];
#else
	_sm_vehicle addEventHandler ["killed", {_this call FUNC(KilledSMTargetTT)}];
#endif
	sleep 2.123;
	_sm_vehicle setPos position _fortress;
	_leader = leader _newgroup;
	_leader setRank "COLONEL";
	_newgroup allowFleeing 0;
	_newgroup setbehaviour "AWARE";
	_leader disableAI "MOVE";
};