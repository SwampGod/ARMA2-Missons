// by Xeno
private ["_do_hint","_mis_fname"];
#include "x_setup.sqf"
if (!X_Client) exitWith{};

_do_hint = _this select 0;

if (__XJIPGetVar(current_mission_index) == -1) exitWith {};

x_sm_oldmission_index = __XJIPGetVar(current_mission_index);

#ifdef __DEFAULT__
_mfname = if (__OAVer) then {"moa"} else {"m"};
_mis_fname = format ["x_missions\" + _mfname + "\%2%1.sqf",__XJIPGetVar(current_mission_index),d_mission_filename];
#endif
#ifdef __EVERON__
_mis_fname = format ["x_missions\mev\%2%1.sqf",__XJIPGetVar(current_mission_index),d_mission_filename];
#endif

if (!X_SPE) then {call compile preprocessFileLineNumbers _mis_fname};

sleep 0.01;

if (d_with_ranked) then {
	d_was_at_sm = false;
	d_sm_running = true;
};

if (__XJIPGetVar(current_mission_index) != -1) then {
	_posi_array = x_sm_pos;
	_posione = _posi_array select 0;
	if (x_sm_type != "convoy") then {
		_m_name = format ["XMISSIONM%1", __XJIPGetVar(current_mission_index) + 1];
		[_m_name, _posione,"ICON","ColorRed",[1,1],"Side Mission",0,"hd_destroy"] call XfCreateMarkerLocal;
		if (d_with_ranked) then {
			_posione spawn {
				private ["_posione"];
				_posione = _this;
				while {d_sm_running} do {
					if (player distance _posione < (d_ranked_a select 12)) exitWith {
						d_was_at_sm = true;
						d_sm_running = false;
					};
					sleep 3.012 + random 3;
				};
			};
		};
	} else {
		_m_name = format ["XMISSIONM%1", __XJIPGetVar(current_mission_index) + 1];
		[_m_name, _posione,"ICON","ColorRed",[1,1],"Side Mission, Convoy Start",0,"hd_start"] call XfCreateMarkerLocal;
		_m_name = format ["XMISSIONM2%1", __XJIPGetVar(current_mission_index) + 1];
		_posione = _posi_array select 1;
		[_m_name, _posione,"ICON","ColorRed",[1,1],"Side Mission, Convoy End",0,"mil_pickup"] call XfCreateMarkerLocal;
	};
};

if (_do_hint) then {
	playSound "IncomingChallenge";
	hint  composeText[
		parseText("<t color='#f000ffff' size='1'>" + "New side mission:" + "</t>"), lineBreak,lineBreak,
		d_current_mission_text
	];
};