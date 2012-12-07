#define THIS_FILE "SatellitenBild.sqf"
#include "x_setup.sqf"
private "_exitj";
if (isNil QUOTE(FUNC(satelittenposf))) then {__cppfln(FUNC(satelittenposf),scripts\SatellitenPos.sqf)};

_exitj = false;
if (GVAR(with_ranked)) then {
	if (score player < (GVAR(ranked_a) select 19)) then {
		(format ["You need %2 points for activating sat view. Your current score is %1", score player,GVAR(ranked_a) select 19]) call FUNC(HQChat);
		_exitj = true;
	} else {
		[QGVAR(pas), [player, (GVAR(ranked_a) select 19) * -1]] call FUNC(NetCallEvent);
	};
};
if (_exitj) exitWith {};

getpos Player spawn FUNC(satelittenposf);