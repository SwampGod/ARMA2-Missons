#define THIS_FILE "x_update_target.sqf"
#include "x_setup.sqf"
private ["_target","_display","_textctrl","_text","_end_pos"];

PARAMS_1(_target);

disableSerialization;

_display = __uiGetVar(X_TELE_DIALOG);
_textctrl = _display displayCtrl 100110;

if (GVAR(x_loop_end)) exitWith {};

_text = "";
_text2 = "";
_end_pos = position player;
#ifndef __TT__
switch (_target) do {
	case 0: {
		switch (GVAR(tele_dialog)) do {
			case 0: {
				_text = "Respawn at Base";
				GVAR(beam_target) = 0;
				_end_pos = position FLAG_BASE;
			};
			case 1: {
				_text = "Teleport to Mobile Respawn One";
				GVAR(beam_target) = 1;
				_end_pos = position MRR1;
			};
			case 2: {
				_text = "Teleport to Base";
				GVAR(beam_target) = 0;
				_end_pos = position FLAG_BASE;
			};
		};
	};
	case 1: {
		_text = switch (GVAR(tele_dialog)) do {
			case 0: {"Respawn at Mobile Respawn One"};
			case 1: {"Teleport to Mobile Respawn One"};
			case 2: {"Teleport to Mobile Respawn One"};
		};
		GVAR(beam_target) = 1;
		_end_pos = position MRR1;
	};
	case 2: {
		_text = switch (GVAR(tele_dialog)) do {
			case 0: {"Respawn at Mobile Respawn Two"};
			case 1: {"Teleport to Mobile Respawn Two"};
			case 2: {"Teleport to Mobile Respawn Two"};
		};
		GVAR(beam_target) = 2;
		_end_pos = position MRR2;
	};
};
#endif
#ifdef __TT__
switch (_target) do {
	case 0: {
		switch (GVAR(tele_dialog)) do {
			case 0: {
				_text = "Respawn at Base";
				GVAR(beam_target) = 0;
				_end_pos = if (GVAR(player_side) == west) then {position WFLAG_BASE} else {position EFLAG_BASE};
			};
			case 1: {
				_text = "Teleport to Mobile Respawn One";
				GVAR(beam_target) = 1;
				_end_pos = if (GVAR(player_side) == west) then {position MRR1} else {position MRRR1};
			};
			case 2: {
				_text = "Teleport to Base";
				GVAR(beam_target) = 0;
				_end_pos = if (GVAR(player_side) == west) then {position WFLAG_BASE} else {position EFLAG_BASE};
			};
		};
	};
	case 1: {
		_text = switch (GVAR(tele_dialog)) do {
			case 0: {"Respawn at Mobile Respawn One"};
			case 1: {"Teleport to Mobile Respawn One"};
			case 2: {"Teleport to Mobile Respawn One"};
		};
		GVAR(beam_target) = 1;
		_end_pos = if (GVAR(player_side) == west) then {position MRR1} else {position MRRR1};
	};
	case 2: {
		_text = switch (GVAR(tele_dialog)) do {
			case 0: {"Respawn at Mobile Respawn Two"};
			case 1: {"Teleport to Mobile Respawn Two"};
			case 2: {"Teleport to Mobile Respawn Two"};
		};
		GVAR(beam_target) = 2;
		_end_pos = if (GVAR(player_side) == west) then {position MRR2} else {position MRRR2};
	};
};
#endif

_textctrl ctrlSetText _text;

_ctrlmap = _display displayCtrl 100104;
ctrlMapAnimClear _ctrlmap;

_start_pos = position player;
_ctrlmap ctrlmapanimadd [0.0, 1.00, _start_pos];
_ctrlmap ctrlmapanimadd [1.2, 1.00, _end_pos];
_ctrlmap ctrlmapanimadd [0.5, 0.30, _end_pos];
ctrlmapanimcommit _ctrlmap;