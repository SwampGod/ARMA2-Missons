// by Xeno
#include "x_setup.sqf"
private ["_isadmin", "_display", "_ctrl", "_units", "_index"];
if (!X_Client) exitWith {};

disableSerialization;

_isadmin = player getVariable "d_p_isadmin";
if (isNil "_isadmin") then {_isadmin = false};

if (!_isadmin) exitWith {};

#ifndef __ACE__
d_phd_invulnerable = true;
#else
player setVariable ["ace_w_allow_dam", false];
#endif

createDialog "XD_AdminDialog";
_display = __uiGetVar(D_ADMIN_DLG);

_ctrl = _display displayCtrl 1001;

_units = if (isMultiplayer) then {playableUnits} else {switchableUnits};
lbClear _ctrl;
{
	if (!isNull _x) then {
		_index = _ctrl lbAdd (name _x);
		_ctrl lbSetData [_index, str(_x)];
	};
} forEach _units;

_ctrl lbSetCurSel 0;

d_a_d_p_kicked = nil;
while {alive player && dialog} do {
	if (!isNil "d_a_d_p_kicked") then {
		d_a_d_p_kicked = nil;
		lbClear _ctrl;
		_units = if (isMultiplayer) then {playableUnits} else {switchableUnits};
		{
			if (!isNull _x) then {
				_index = _ctrl lbAdd (name _x);
				_ctrl lbSetData [_index, str(_x)];
			};
		} forEach _units;
		_ctrl lbSetCurSel 0;
	};
	sleep 0.2;
};
#ifndef __ACE__
d_phd_invulnerable = false;
#else
player setVariable ["ace_w_allow_dam", nil];
#endif
sleep 0.5;
deleteMarkerLocal "d_admin_marker";