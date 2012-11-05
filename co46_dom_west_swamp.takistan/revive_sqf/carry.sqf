/*
 CARRY BODY SCRIPT

 JUNE 2009 - norrin
*/
private ["_unit","_dragee","_pos","_dir"];
_dragee = _this select 3;
_can_be_revived = NORRN_revive_array select 20;
_can_be_revived_2 = NORRN_revive_array select 21;
_unit = player;
r_carry_sqf = true;
r_drag_sqf = false;

_unit removeAction Norrn_carryAction;
if (isNull _dragee) exitWith {};
_dragee setVariable ["NORRN_unit_dragged", true, true];
detach _dragee;
sleep 1.5;
["swmcarryup", _dragee] call RNetCallEvent;
["swmwrfldnon", _unit] call RNetCallEvent;
sleep 10;
_dragee attachto [_unit,[-0.2, 0.2, 0]];

while {r_carry_sqf} do {
	_anim_name = animationstate _unit;
	if (!(_dragee getVariable "NORRN_AIunconscious")) exitWith {
		detach _dragee;
		["swmnone", _unit] call RNetCallEvent;
		player removeAction Norrn_dropAction;
		r_carry_sqf = false;
	};

	if (!alive _unit || _anim_name != "acinpknlmstpsraswrfldnon_acinpercmrunsraswrfldnon" && _anim_name != "acinpercmstpsraswrfldnon" && _anim_name != "acinpercmrunsraswrfldf") exitWith {
		player removeAction NORRN_dropAction;
		detach _dragee;
		["swmunc", _dragee] call RNetCallEvent;
		r_carry_sqf = false;
	};
	sleep 0.1;
};
if (alive _dragee && (_dragee getVariable "NORRN_AIunconscious")) then {
	["swmwrfldnon2", _dragee] call RNetCallEvent;
};