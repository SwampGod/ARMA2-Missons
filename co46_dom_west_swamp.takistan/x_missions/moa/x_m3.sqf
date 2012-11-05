// by Xeno
private ["_xtank", "_vehicle", "_poss"];
#include "x_setup.sqf"

x_sm_pos = [[9430.12,4718.19,0], [9445.49,4702.11,0], [9432.81,4673.5,0]]; //  steal tank prototype, Timurkalay, array 2 and 3 = infantry and armor positions
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
#ifndef __TT__
	d_current_mission_text = "Enemy forces are testing an enhanced tank near Timurkalay. Your mission is to steal it and bring it to the flag at your base.";
	d_current_mission_resolved_text = "Good job. You got the enhanced tank version.";
#else
	d_current_mission_text = "Enemy forces are testing an enhanced tank version near Timurkalay. Your mission is it to destroy that tank.";
	d_current_mission_resolved_text = "Good job. The enhanced tank version is destroyed.";
#endif
};

if (isServer) then {
#ifndef __OA__
	_xtank = switch (d_enemy_side) do {
		case "EAST": {"T90"};
		case "WEST": {"M1A2_TUSK_MG"};
		case "GUER": {"T72_Gue"};
	};
#else
	_xtank = switch (d_enemy_side) do {
		case "EAST": {"T72_TK_EP1"};
		case "WEST": {"M1A2_US_TUSK_MG_EP1"};
		case "GUER": {"T55_TK_GUE_EP1"};
	};
#endif
	__PossAndOther
	_pos_other2 = x_sm_pos select 2;
	_vehicle = objNull;
	_vehicle = _xtank createvehicle (_poss);
	_vehicle setDir 172;
#ifndef __TT__
	sleep 2.123;
	["specops", 1, "basic", 1, _pos_other,100,true] spawn XCreateInf;
	sleep 2.321;
	["shilka", 1, "bmp", 1, "tank", 0, _pos_other2,1,200,true] spawn XCreateArmor;
	[_vehicle] execVM "x_missions\common\x_sidesteal.sqf";
	__addDead(_vehicle)
#else
	_vehicle addEventHandler ["killed", {_this call XKilledSMTargetTT}];
	_vehicle lock true;
	__AddToExtraVec(_vehicle)
	sleep 2.123;
	["specops", 1, "basic", 1, _pos_other,100,true] spawn XCreateInf;
	sleep 2.321;
	["shilka", 1, "bmp", 1, "tank", 0, _pos_other2,2,200,true] spawn XCreateArmor;
#endif
};