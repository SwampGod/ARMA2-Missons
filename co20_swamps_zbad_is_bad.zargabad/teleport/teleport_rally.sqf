_telguy = _this select 1;

_telguy setPos [(getMarkerPos "rallyM" select 0)+0,(getMarkerPos "rallyM" select 1)+0,(getMarkerPos "rallyM" select 2)+0];
_telguy setDir markerDir "rallyM";
//playSound "teleport";
