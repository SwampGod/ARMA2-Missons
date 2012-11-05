// by Xeno
#include "x_setup.sqf"
if (player distance (_this select 0) > 20) exitWith {
	"You are too far away from the FARP..." call XfGlobalChat;
};
if (!d_eng_can_repfuel) then {
	d_eng_can_repfuel = true;
	"Engineer repair/refuel capability restored." call XfGlobalChat;
};