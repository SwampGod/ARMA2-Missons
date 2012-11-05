// by Xeno
#include "x_setup.sqf"
private "_index";

disableSerialization;

_index = lbCurSel (__uiGetVar(X_VEC_DIALOG) displayCtrl 44449);
closeDialog 0;

if (_index < 0) exitWith {};

[0,0,0, [d_create_bike select _index, 0]] execVM "x_client\x_bike.sqf";
