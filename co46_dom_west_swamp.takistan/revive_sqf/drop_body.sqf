/*
 DROP BODY SCRIPT

 JUNE 2009 - norrin
*/
_dragee = _this select 3;

player removeAction NORRN_dropAction;
NORRN_remove_drag = true;
r_drag_sqf = false;
_unit = player;

detach _unit;
detach _dragee;

["swmunc", _dragee] call RNetCallEvent;
["swmnone", _unit] call RNetCallEvent;

NORRN_Dragged_body = objNull;
_dragee setVariable ["NORRN_unit_dragged", false, true];