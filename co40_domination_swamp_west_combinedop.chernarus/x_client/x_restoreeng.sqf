// by Xeno
#define THIS_FILE "x_restoreeng.sqf"
#include "x_setup.sqf"
if (player distance (_this select 0) > 20) exitWith {
	"You are too far away from the FARP..." call FUNC(GlobalChat);
};
if (!GVAR(eng_can_repfuel)) then {
	GVAR(eng_can_repfuel) = true;
	"Engineer repair/refuel capability restored." call FUNC(GlobalChat);
};