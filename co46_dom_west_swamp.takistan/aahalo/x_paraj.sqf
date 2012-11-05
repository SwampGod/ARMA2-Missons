#include "x_setup.sqf"
private ["_do_exit","_exitj"];

_exitj = false;
if (d_with_ranked) then {
	if (score player < (d_ranked_a select 4)) then {
		(format ["You need %2 points for parajump. Your current score is %1", score player,d_ranked_a select 4]) call XfHQChat;
		_exitj = true;
	} else {
		["d_pas", [player, (d_ranked_a select 4) * -1]] call XNetCallEvent;
	};
};

if (_exitj) exitWith {};

_do_exit = false;
if (d_HALOWaitTime > 0) then {
#ifndef __TT__
	if (position player distance FLAG_BASE < 15) then {
#else
	if (position player distance EFLAG_BASE < 15 || position player distance WFLAG_BASE < 15) then {
#endif
		if (d_next_jump_time > time) then {
			_do_exit = true;
			(format ["You can not jump. You have to wait %1 minutes for your next jump!!!", round ((d_next_jump_time - time)/60)]) call XfHQChat;
		};
	};
};
if (_do_exit) exitWith {};

#ifdef __ACE__
if (!(player hasWeapon "ACE_ParachutePack")) exitWith {"!!!!!!!!!!!! You need a parachute pack first !!!!!!!!!!!" call XfHQChat};
#endif
_ok = createDialog "XD_ParajumpDialog";
d_global_jump_pos = [];
onMapSingleClick "closeDialog 0;d_global_jump_pos = _pos;onMapSingleClick ''";

waitUntil {!dialog || !alive player};
if (alive player) then {
	if (count d_global_jump_pos > 0) then {
		_realpos = [d_global_jump_pos, 200] call XfGetRanJumpPoint;
		[_realpos] execVM 'aahalo\jump.sqf';
	};
} else {
	if (dialog) then {closeDialog 0};
};
sleep 0.512;
onMapSingleClick "";
