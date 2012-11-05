// by Xeno
#include "x_setup.sqf"
private ["_index", "_disp"];

disableSerialization;

_disp = __uiGetVar(D_UNLOAD_DIALOG);

_index = lbCurSel (_disp displayCtrl 101115);

if (_index < 0) exitWith {closeDialog 0};

d_cargo_selected_index = _index;

closeDialog 0;