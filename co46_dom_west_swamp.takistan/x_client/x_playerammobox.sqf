// by Xeno
#include "x_setup.sqf"
private ["_box","_box_array"];

_box_array = [];

#ifndef __TT__
_box_array = d_player_ammobox_pos;
#else
if (playerSide == west) then {
	_box_array = d_player_ammobox_pos select 0;
} else {
	_box_array = d_player_ammobox_pos select 1;
};
#endif

_box = d_the_base_box createVehicleLocal (_box_array select 0);
_box setDir (_box_array select 1);
#ifndef __CARRIER__
_box setPos (_box_array select 0);
#else
_box setPosASL (_box_array select 0);
#endif
player reveal _box;
#ifndef __REVIVE__
_box addAction ["Save gear layout" call XBlueText, "x_client\x_savelayout.sqf"];
_box addAction ["Clear gear layout" call XBlueText, "x_client\x_clearlayout.sqf"];
#endif

[_box] call x_weaponcargo;

d_player_ammobox_pos = nil;

[_box,_box_array] execFSM "fsms\PlayerAmmobox.fsm";
