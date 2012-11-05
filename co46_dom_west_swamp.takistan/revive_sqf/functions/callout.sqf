// Norrn_CallOut
// © October 2009 - norrin
private ["_ran", "_unconscious_body"];

if ((NORRN_revive_array select 6) == 1) then {
	_unconscious_body = _this select 0;
	_ran = floor (random count commentsBrian);
	["r_say", [_unconscious_body, commentsBrian select _ran]] call RNetCallEvent;
};

20 + ceil(random 10);