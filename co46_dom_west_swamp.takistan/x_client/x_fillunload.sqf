// by Xeno
#include "x_setup.sqf"
private ["_control", "_pic", "_index"];
disableSerialization;
_control = __uiGetVar(D_UNLOAD_DIALOG) displayCtrl 101115;
lbClear _control;

{
	_pic = getText (configFile >> "cfgVehicles" >> _x >> "picture");
	_index = _control lbAdd ([_x,0] call XfGetDisplayName);
	_control lbSetPicture [_index, _pic];
	_control lbSetColor [_index, [1, 1, 0, 0.8]];
} forEach d_current_truck_cargo_array;

_control lbSetCurSel 0;