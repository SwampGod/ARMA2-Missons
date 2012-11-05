// by Xeno
private ["_xchopper", "_hangar", "_poss", "_vehicle", "_lvec"];
#include "x_setup.sqf"

x_sm_pos = [[8407.94,12438.6,0], [8467.48,12467.7,0]]; // index: 44,   Steal chopper prototype near mount Klen
x_sm_type = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client) then {
	d_current_mission_text = "The enemy is testing a new protoype chopper near mount Klen. Steal it and bring it to the flag at your base.";
	d_current_mission_resolved_text = "Good job. You got the prototype chopper.";
};

if (isServer) then {
#ifdef __OA__
	_xchopper = (if (d_enemy_side == "EAST") then {"Mi24_D_TK_EP1"} else {"AH64D_EP1"});
#else
	_xchopper = (if (d_enemy_side == "EAST") then {"Ka52Black"} else {"AH1Z"});
#endif
	__PossAndOther
#ifdef __OA__
	_hangar = "Land_Mil_hangar_EP1" createvehicle (_poss);
#else
	_hangar = "Land_SS_hangar" createvehicle (_poss);
#endif
	_hangar setPos _poss;
	_hangar setDir 60;
	__AddToExtraVec(_hangar)
	sleep 1.0123;
	_vehicle = objNull;
	_vehicle = _xchopper createvehicle (_poss);
	_vehicle setPos _poss;
	_vehicle setDir 240;
	sleep 2.123;
	["specops", 1, "basic", 1, _poss,100,true] spawn XCreateInf;
	sleep 2.221;
	["shilka", 1, "bmp", 1, "tank", 1, _pos_other,1,140,true] spawn XCreateArmor;
	sleep 2.543;
	[_vehicle] execVM "x_missions\common\x_sidesteal.sqf";
	__addDead(_vehicle)
#ifdef __ACE__
	if !(__OAVer) then {
		_lvec = "TowingTractor" createvehicle (_poss);
		__addDead(_lvec)
	};
#endif
};