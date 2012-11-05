/*
 DRAG BODY SCRIPT
 
 AUGUST 2009 - norrin
*/
private ["_unit","_dragee","_pos","_dir"];
_dragee = _this select 3;
_can_be_revived = NORRN_revive_array select 20;
_can_be_revived_2 = NORRN_revive_array select 21;
_unit = player;

if (isNull _dragee) exitWith {}; 

_dragee setVariable ["NORRN_unit_dragged", true, true]; 
_unit playMove "acinpknlmstpsraswrfldnon";
sleep 2;

["swmstill", _dragee] call RNetCallEvent;

_dragee attachto [_unit,[0.1, 1.01, 0]];
sleep 0.02;
["set180", _dragee] call RNetCallEvent;
r_drag_sqf = true;

player removeAction Norrn_dragAction;
player removeAction Norrn_reviveAction;
NORRN_dropAction = player addAction ["Drop body", "revive_sqf\drop_body.sqf",_dragee, 0, false, true];
sleep 1;

while {r_drag_sqf} do {
	if (!alive _dragee ||!(_dragee getVariable "NORRN_AIunconscious")) exitWith {
		player removeAction NORRN_dropAction;
		detach _dragee;
		["swmnone", _unit] call RNetCallEvent;
		sleep 1;
		r_drag_sqf = false;
	};

	if (!alive _unit) exitWith {
		player removeAction NORRN_dropAction;
		detach _unit;
		_unit switchMove "";
		sleep 1;
		r_drag_sqf = false;
	};
	sleep 0.1;
};
if (alive _dragee && (_dragee getVariable "NORRN_AIunconscious")) then {
	["swmwrfldnon2", _dragee] call RNetCallEvent;
};