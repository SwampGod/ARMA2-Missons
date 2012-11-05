#include "x_setup.sqf"
#define __ctrl(valc) _ctrl = _display displayCtrl valc
private ["_display", "_ctrl", "_typepos", "_nobs"];
if (!X_Client) exitWith {};

if (d_beam_target < 0) exitWith{};

if (x_loop_end) exitWith {};

x_loop_end = true;

if (vehicle player != player) then {unassignVehicle player};

disableSerialization;
_display = __uiGetVar(X_TELE_DIALOG);
__ctrl(100102);
_ctrl ctrlEnable false;
__ctrl(100107);
_ctrl ctrlEnable false;
__ctrl(100108);
_ctrl ctrlEnable false;
__ctrl(100109);
_ctrl ctrlEnable false;
__ctrl(100112);
_ctrl ctrlShow true;

d_last_telepoint = d_beam_target;
_global_pos = [];
_global_dir = 180;
_typepos = 0;
switch (d_beam_target) do {
	case 0: {
#ifndef __REVIVE__
		_global_pos = markerPos format ["respawn_%1", d_side_player_str];
#else
		_global_pos = markerPos "base_spawn_1";
#endif
	};
	case 1: {
#ifndef __TT__
		_global_pos = MRR1 modelToWorld [0,-5,0];
		_global_dir = direction MRR1;
#else
		_global_pos = if (playerSide == west) then {MRR1 modelToWorld [0,-5,0]} else {MRRR1 modelToWorld [0,-5,0]};
		_global_dir = if (playerSide == west) then {direction MRR1} else {direction MRRR1};
#endif
		_typepos = 1;
	};
	case 2: {
#ifndef __TT__
		_global_pos = MRR2 modelToWorld [0,-5,0];
		_global_dir = direction MRR2;
#else
		_global_pos = if (playerSide == west) then {MRR2 modelToWorld [0,-5,0]} else {MRRR2 modelToWorld [0,-5,0]};
		_global_dir = if (playerSide == west) then {direction MRR2} else {direction MRRR2};
#endif
		_typepos = 1;
	};
};
d_beam_target = -1;
if (_typepos == 1) then {
	player setPosATL [_global_pos select 0, _global_pos select 1, 0];
	player setDir _global_dir;
} else {
#ifdef __CARRIER__
	player setPosASL [_global_pos select 0, _global_pos select 1, 15.9];
#else
	player setPos _global_pos;
#endif
	player setDir _global_dir;
};
sleep 2;
closeDialog 0;

titletext ["", "BLACK IN"];

_nobs = if (__OAVer) then {
	nearestObjects [player, ["USBasicWeapons_EP1","USSpecialWeapons_EP1","TKBasicWeapons_EP1","TKSpecialWeapons_EP1","LocalBasicAmmunitionBox","M1133_MEV_EP1","BMP2_HQ_TK_EP1"], 30]
} else {
	nearestObjects [player, ["USSpecialWeaponsBox","USBasicWeaponsBox","RUBasicAmmunitionBox","RUSpecialWeaponsBox","LocalBasicAmmunitionBox","LAV25_HQ","BTR90_HQ"], 30]
};
{player reveal _x} forEach _nobs;

if (d_with_ai) then {if (alive player) then {[] execVM "x_client\x_moveai.sqf"}};