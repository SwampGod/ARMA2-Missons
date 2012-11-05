// by Xeno
private ["_xplane", "_hangar", "_poss", "_vehicle"];
#include "x_setup.sqf"

#ifdef __TT__
x_sm_pos = [[9469.29,9980.0,0], [9475.11,10052.3,0]]; // index: 2,   steal plane prototype, Paraiso airfield, second array position armor
#endif
#ifndef __TT__
x_sm_pos = [[5802.57,11293.5,0], [5760.42,11326.9,0]]; //  steal plane prototype, Rasman, second array position armor
#endif
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
#ifdef __TT__
	d_current_mission_text = "The enemy is testing a new protoype plane at the main. Steal it and bring it to the flag at your base.";
	d_current_mission_resolved_text = "Good job. You got the prototype plane.";
#else
	d_current_mission_text = "The enemy is testing a new protoype plane at Rasman airfield. Steal it and bring it to the flag at your base.";
	d_current_mission_resolved_text = "Good job. You got the prototype plane.";
#endif
};

if (isServer) then {
#ifndef __OA__
	_xplane = if (d_enemy_side == "EAST") then {"Su34"} else {"F35B"};
#else
	_xplane = if (d_enemy_side == "EAST") then {"Su25_TK_EP1"} else {"A10_US_EP1"};
#endif
	__PossAndOther
// #ifndef __OA__
	// _hangar = "Land_SS_hangar" createvehicle (_poss);
// #else
	// _hangar = "Land_Mil_hangar_EP1" createvehicle (_poss);
// #endif
	// _hangar setDir 300;
	// __AddToExtraVec(_hangar)
	sleep 1.0123;
	_vehicle = objNull;
	_vehicle = _xplane createvehicle (_poss);
	_vehicle setDir 320;
	sleep 2.123;
	["specops", 1, "basic", 1, _poss,100,true] spawn XCreateInf;
	sleep 2.221;
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other,1,100,true] spawn XCreateArmor;
	[_vehicle] execVM "x_missions\common\x_sidesteal.sqf";
	__addDead(_vehicle)
};