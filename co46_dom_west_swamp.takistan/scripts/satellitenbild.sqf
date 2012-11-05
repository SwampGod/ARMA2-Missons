#include "x_setup.sqf"
if (isNil "d_satelittenposf") then {__cppfln(d_satelittenposf,scripts\SatellitenPos.sqf)};

_exitj = false;
if (d_with_ranked) then {
	if (score player < (d_ranked_a select 19)) then {
		(format ["You need %2 points for activating sat view. Your current score is %1", score player,d_ranked_a select 19]) call XfHQChat;
		_exitj = true;
	} else {
		["d_pas", [player, (d_ranked_a select 19) * -1]] call XNetCallEvent;
	};
};
if (_exitj) exitWith {};

getpos Player spawn d_satelittenposf;