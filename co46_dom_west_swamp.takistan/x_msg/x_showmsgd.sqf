// by Xeno
#include "x_setup.sqf"
private ["_ok", "_ctrl", "_units", "_i", "_ele", "_hour", "_minute", "_strhour", "_strmin"];
disableSerialization;

_ok = createDialog "XD_MsgDialog";

_XD_display = __uiGetVar(XD_MsgDialog);

_ctrl = _XD_display displayCtrl 1005;
_units = if (!ismultiplayer) then {switchableunits} else {playableunits};
d_namep_rarray = [x_player_name];
{if (name _x != x_player_name) then {d_namep_rarray set [count d_namep_rarray, name _x]}} foreach _units;
for "_i" from 0 to (count d_namep_rarray - 1) do {_ctrl lbAdd (d_namep_rarray select _i)};
_ctrl lbSetCurSel 0;

if (count x_pm_add_ar > 0) then {
	for "_i" from (count x_pm_add_ar - 1) to 0 step - 1 do {x_pm_received_ar = [x_pm_received_ar, [(x_pm_add_ar select _i)], 0] call X_fnc_arrayInsert};
	x_pm_add_ar = [];
};

if (count x_pm_received_ar > 50) then {
	for "_i" from 50 to (count x_pm_received_ar - 1) do {x_pm_received_ar set [_i, -1]};
	x_pm_received_ar = x_pm_received_ar - [-1];
};

_ctrl = _XD_display displayCtrl 1030;
for "_i" from 0 to (count x_pm_received_ar - 1) do {
	_ele = x_pm_received_ar select _i;
	_hour = (_ele select 2) select 3;
	_minute = (_ele select 2) select 4;
	_strhour = if (_hour < 10) then {
		"0" + str(_hour)
	} else {
		str(_hour);
	};
	_strmin = if (_minute < 10) then {
		"0" + str(_minute)
	} else {
		str(_minute);
	};
	_ctrl lbAdd format ["%1, %3:%4: %2", _ele select 0, _ele select 1, _strhour, _strmin];
};
_ctrl lbSetCurSel 0;

if (count x_pm_send_ar > 50) then {
	for "_i" from 50 to (count x_pm_send_ar - 1) do {x_pm_send_ar set [_i, -1]};
	x_pm_send_ar = x_pm_send_ar - [-1];
};
x_pm_send_ar_update = false;

_ctrl = _XD_display displayCtrl 1031;
for "_i" from 0 to (count x_pm_send_ar - 1) do {
	_ele = x_pm_send_ar select _i;
	_hour = (_ele select 2) select 3;
	_minute = (_ele select 2) select 4;
	_strhour = if (_hour < 10) then {
		"0" + str(_hour)
	} else {
		str(_hour);
	};
	_strmin = if (_minute < 10) then {
		"0" + str(_minute)
	} else {
		str(_minute);
	};
	_ctrl lbAdd format ["%1, %3:%4: %2", _ele select 0, _ele select 1, _strhour, _strmin];
};
_ctrl lbSetCurSel 0;

[] spawn {
	private ["_ctrl", "_i", "_ele", "_hour", "_minute", "_strhour", "_strmin"];
	disableSerialization;
	_XD_display = __uiGetVar(XD_MsgDialog);
	_ctrl = _XD_display displayCtrl 1005;
	while {dialog} do {
		if (count x_pm_add_ar > 0) then {
			for "_i" from (count x_pm_add_ar - 1) to 0 step - 1 do {x_pm_received_ar = [x_pm_received_ar, [(x_pm_add_ar select _i)], 0] call X_fnc_arrayInsert};
			x_pm_add_ar = [];
			_ctrl = _XD_display displayCtrl 1030;
			lbClear _ctrl;
			for "_i" from 0 to (count x_pm_received_ar - 1) do {
				_ele = x_pm_received_ar select _i;
				_hour = (_ele select 2) select 3;
				_minute = (_ele select 2) select 4;
				_strhour = if (_hour < 10) then {
					"0" + str(_hour)
				} else {
					str(_hour);
				};
				_strmin = if (_minute < 10) then {
					"0" + str(_minute)
				} else {
					str(_minute);
				};
				_ctrl lbAdd format ["%1, %3:%4: %2", _ele select 0, _ele select 1, _strhour, _strmin];
			};
		};
		if (x_pm_send_ar_update) then {
			_ctrl = _XD_display displayCtrl 1031;
			for "_i" from 0 to (count x_pm_send_ar - 1) do {
				_ele = x_pm_send_ar select _i;
				_hour = (_ele select 2) select 3;
				_minute = (_ele select 2) select 4;
				_strhour = if (_hour < 10) then {
					"0" + str(_hour)
				} else {
					str(_hour);
				};
				_strmin = if (_minute < 10) then {
					"0" + str(_minute)
				} else {
					str(_minute);
				};
				_ctrl lbAdd ["%1, %3:%4: %2", _ele select 0, _ele select 1, _strhour, _strmin];
			};
			x_pm_send_ar_update = false;
		};
		sleep 0.3;
	};
};