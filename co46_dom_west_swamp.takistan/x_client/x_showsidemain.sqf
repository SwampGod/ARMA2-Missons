// by Xeno
#include "x_setup.sqf"
if (!X_Client) exitWith {};

disableSerialization;

_which = _this select 0;

if (_which == 1 && __XJIPGetVar(current_target_index) == -1) exitWith {};
if (_which == 0 && (__XJIPGetVar(all_sm_res) || __XJIPGetVar(current_mission_index) == -1)) exitWith {};

_display = __uiGetVar(X_STATUS_DIALOG);

_ctrlmap = _display displayCtrl 11010;
ctrlMapAnimClear _ctrlmap;

#ifndef __TT__
_start_pos = position FLAG_BASE;
#else
_start_pos = if (playerSide == west) then {position WFLAG_BASE} else {position EFLAG_BASE};
#endif
_end_pos = [];
_exit_it = false;

_markername = "";
switch (_which) do {
	case 0: {
		_markername = format ["XMISSIONM%1", __XJIPGetVar(current_mission_index) + 1];
		_end_pos = markerPos _markername;
		if (str(_end_pos) == "[0,0,0]") then {_exit_it = true};
	};
	case 1: {
		_end_pos = markerPos "dummy_marker";
		_markername = (d_target_names select __XJIPGetVar(current_target_index)) select 1;
	};
};

if (_exit_it) exitWith {};

_dsmd = __pGetVar(d_sidemain_m_do);
if (isNil "_dsmd") then {_dsmd = []};
if (!(_markername in _dsmd)) then {
	_dsmd set [count _dsmd, _markername];
	__pSetVar ["d_sidemain_m_do", _dsmd];
	_markername spawn {
		private ["_m", "_a", "_aas"];
		_m = _this; _a = 1; _aas = -0.06;
		while {dialog && alive player} do {
			_m setMarkerAlphaLocal _a;
			_a = _a + _aas;
			if (_a < 0.4) then {_a = 0.4; _aas = _aas * -1};
			if (_a > 1.3) then {_a = 1.3; _aas = _aas * -1};
			sleep .1;
		};
		_m setMarkerAlphaLocal 1;
		__pSetVar ["d_sidemain_m_do",[]];
	};
};

_ctrlmap ctrlmapanimadd [0.0, 1.00, _start_pos];
_ctrlmap ctrlmapanimadd [1.2, 1.00, _end_pos];
_ctrlmap ctrlmapanimadd [0.5, 0.30, _end_pos];
ctrlmapanimcommit _ctrlmap;