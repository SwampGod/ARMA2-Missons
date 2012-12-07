#define THIS_FILE "x_paraj.sqf"
#include "x_setup.sqf"
private ["_do_exit","_exitj","_realpos", "_jumpobj"];

PARAMS_1(_jumpobj);

if (player distance _jumpobj > 15) exitWith {
	("Oh, you, " + GVAR(name_pl) + ", are trying to cheat... doesn't work anymore...") call FUNC(GlobalChat);
};

_exitj = false;
if (GVAR(with_ranked)) then {
	if (score player < (GVAR(ranked_a) select 4)) then {
		(format ["You need %2 points for parajump. Your current score is %1", score player,GVAR(ranked_a) select 4]) call FUNC(HQChat);
		_exitj = true;
	} else {
		[QGVAR(pas), [player, (GVAR(ranked_a) select 4) * -1]] call FUNC(NetCallEvent);
	};
};

if (_exitj) exitWith {};

_do_exit = false;
if (GVAR(HALOWaitTime) > 0) then {
#ifndef __TT__
	if (position player distance FLAG_BASE < 15) then {
#else
	if (position player distance EFLAG_BASE < 15 || position player distance WFLAG_BASE < 15) then {
#endif
		if (GVAR(next_jump_time) > time) then {
			_do_exit = true;
			(format ["You can not jump. You have to wait %1 minutes for your next jump!!!", round ((GVAR(next_jump_time) - time)/60)]) call FUNC(HQChat);
		};
	};
};
if (_do_exit) exitWith {};

#ifdef __ACE__
if !(player hasWeapon "ACE_ParachutePack") exitWith {"!!!!!!!!!!!! You need a parachute pack first !!!!!!!!!!!" call FUNC(HQChat)};
#endif
GVAR(global_jump_pos) = [];
createDialog "XD_ParajumpDialog";

waitUntil {!GVAR(parajump_dialog_open) || !alive player};
if (alive player) then {
	if (count GVAR(global_jump_pos) > 0) then {
		_realpos = [GVAR(global_jump_pos), 200] call FUNC(GetRanJumpPoint);
		[_realpos] execVM 'AAHALO\jump.sqf';
	};
} else {
	if (GVAR(parajump_dialog_open)) then {closeDialog 0};
};
sleep 0.512;
