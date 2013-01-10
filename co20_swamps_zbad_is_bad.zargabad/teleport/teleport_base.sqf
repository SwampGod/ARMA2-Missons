_teleporter = _this select 1;

_teleporter setPos [(getMarkerPos "Base Camp" select 0)+0,(getMarkerPos "Base Camp" select 1)+0,(getMarkerPos "Base Camp" select 2)+0];
_teleporter setDir markerDir "Base Camp";
//playSound "teleport";