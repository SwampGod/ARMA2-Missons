// by Xeno
private ["_xchopper", "_randomv", "_poss", "_vehicle"];
#include "x_setup.sqf"

x_sm_pos = [[5843.75,11336.1,0], [5755.54,11334.7,0], [5793.14,11357.5,0],  [5800.14,11296.1,0]]; // index: 9,   Helicopter Prototype at Rasman Airfield
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {	
	d_current_mission_text = "A new helicopter prototype gets tested on Rasman airfield. Destroy it before enemy troops use it.";
	d_current_mission_resolved_text = "Good job. The helicopter is destroyed.";
};

if (isServer) then {
#ifndef __OA__
	_xchopper = (if (d_enemy_side == "EAST") then {"Ka52Black"} else {"AH1Z"});
#else
	_xchopper = (if (d_enemy_side == "EAST") then {"Mi24_D_TK_EP1"} else {"AH64D_EP1"});
#endif
	_randomv = floor random 2;
	__PossAndOther
	if (_randomv == 1) then {_poss = x_sm_pos select 3};
	_pos_other2  = x_sm_pos select 2;
	_vehicle = objNull;
	_vehicle = _xchopper createvehicle (_poss);
	__addDead(_vehicle)
#ifndef __TT__
	_vehicle addEventHandler ["killed", {_this call XKilledSMTargetNormal}];
#else
	_vehicle addEventHandler ["killed", {_this call XKilledSMTargetTT}];
#endif
	_vehicle setDir 320;
	_vehicle lock true;
	sleep 2.123;
	["specops", 1, "basic", 2, _poss,90,true] spawn XCreateInf;
	sleep 2.111;
	["shilka", 1, "bmp", 1, "tank", 0, _pos_other2,1,100,true] spawn XCreateArmor;
};