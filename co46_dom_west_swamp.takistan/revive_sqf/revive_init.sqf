/*
  REVIVE_INIT SCRIPT

© JULY 2009 - norrin
*/
_JIP_spawn_dialog = NORRN_revive_array select 2;
_no_respawn_points = NORRN_revive_array select 12;
_Base_1 = NORRN_revive_array select 13;
_Base_2 = NORRN_revive_array select 14;
_Base_3 = NORRN_revive_array select 15;
_Base_4 = NORRN_revive_array select 16;
_time_b4_JIP_spawn_dialog = NORRN_revive_array select 17;
_max_respawns = NORRN_revive_array select 38;
_mobile_spawn = NORRN_revive_array select 51;

[] execVM "revive_sqf\trigger_mkr.sqf";

r_event_holder = "HeliHEmpty" createVehicleLocal [0,0,0];

RNetAddEvent = {
	private "_a";
	_a = switch (_this select 0) do {
		case 0: {true};
		case 1: {if (isServer) then {true} else {false}};
		case 2: {if (X_Client) then {true} else {false}};
	};
	if (_a) then {r_event_holder setVariable [_this select 1, _this select 2]};
};

RNetCallEvent = {
	r_n_e_gl = _this; publicVariable "r_n_e_gl";
	_this call RNetRunEvent;
};

RNetRunEvent = {
	private ["_ea", "_pa"];
	_ea = r_event_holder getVariable (_this select 0);
	if (!isNil "_ea") then {
		_pa = _this select 1;
		if (isNil "_pa") then {
			call _ea;
		} else {
			_pa call _ea;
		};
	};
};

[0, "swmnone", {_this switchmove ""}] call RNetAddEvent;
[0, "swmunc", {_this switchmove r_unc_animation}] call RNetAddEvent;
[0, "swmdead", {_this switchmove "Deadstate"}] call RNetAddEvent;
[0, "swmcarryup", {_this switchmove "ainjpfalmstpsnonwrfldnon_carried_up"}] call RNetAddEvent;
[0, "swmwrfldnon", {_this switchmove "acinpknlmstpsraswrfldnon_acinpercmrunsraswrfldnon"}] call RNetAddEvent;
[0, "swmwrfldnon2", {_this switchmove "ainjppnemstpsnonwrfldnon"}] call RNetAddEvent;
[0, "swmstill", {_this switchmove "ainjppnemstpsnonwrfldb_still"}] call RNetAddEvent;
[0, "set180", {_this setDir 180}] call RNetAddEvent;
[0, "set170", {_this setDir 170}] call RNetAddEvent;
[0, "joingrpnull", {if (local _this) then {[_this] join grpNull}}] call RNetAddEvent;
[0, "moveair", {if (local (_this select 0)) then {(_this select 0) doMove (position (_this select 1))}}] call RNetAddEvent;
[2, "hintcall", {hint format ["%1 has called for help \nCheck map if markers are enabled for wounded players position", _this]}] call RNetAddEvent;
[0, "moveprot", {if (local (_this select 0)) then {(_this select 0) doMove [((getPos (_this select 1)) select 0) + 5, ((getPos (_this select 1)) select 1) + 5, ((getPos (_this select 1)) select 2)]}}] call RNetAddEvent;
[0, "domoveself", {if (local _this) then {_this doMove (getPos _this)}}] call RNetAddEvent;
[0, "runload", {if (local _this) then {[_this] execVM "revive_sqf\load_wounded\load_wounded.sqf"}}] call RNetAddEvent;
[0, "swmkia", {_this switchmove "kia_hmmwv_driver"}] call RNetAddEvent;
[0, "playhealed", {_this playMove "AmovPpneMstpSnonWnonDnon_healed"}] call RNetAddEvent;
[0, "swmhealed", {_this switchmove "AmovPpneMstpSnonWnonDnon_healed"}] call RNetAddEvent;
[0, "tripple", {_this switchMove "AmovPpneMstpSnonWnonDnon_healed"; _this allowDamage false; _this setCaptive true}] call RNetAddEvent;
[0, "swmrollback", {_this switchmove "ainjppnemstpsnonwrfldnon_rolltoback"}] call RNetAddEvent;
[0, "double", {_this switchMove "AmovPpneMstpSnonWnonDnon_healed"; _this setCaptive false}] call RNetAddEvent;
[2, "globalchat", {server globalChat format ["%1 has been revived by %2", _this select 0, _this select 1]}] call RNetAddEvent;
[0, "allowdam", {_this allowDamage true}] call RNetAddEvent;
[0, "r_say", {(_this select 0) say3D (_this select 1)}] call RNetAddEvent;
[0, "r_setcap", {(_this select 0) setCaptive (_this select 1)}] call RNetAddEvent;

"r_n_e_gl" addPublicVariableEventHandler {(_this select 1) call RNetRunEvent};

sleep 0.1;

no_base_1 = false;
no_base_2 = false;
no_base_3 = false;
no_base_4 = false;

no_base_1b = false;
no_base_2b = false;
no_base_3b = false;
no_base_4b = false;
if (_max_respawns == 2000) exitWith {};
onConnect = true;

sleep 5;

if (!isNull player && _JIP_spawn_dialog == 1 && time > _time_b4_JIP_spawn_dialog && animationState player != "AmovPpneMstpSnonWnonDnon_healed") then {
	titleText ["Choose spawn point or press escape to close dialog and start at current position","PLAIN", 0.5]; 

	if (_mobile_spawn == 1) then {
		if (NORRN_camo_net) then {
			_no_respawn_points = NORRN_revive_array select 12;
			_Base_1 = NORRN_revive_array select 13;
			_Base_2 = NORRN_revive_array select 14;
			_Base_3 = NORRN_revive_array select 15;
			_Base_4 = NORRN_revive_array select 16;
		} else {
			_no_respawn_points = NORRN_revive_array select 12;
			_no_respawn_points = _no_respawn_points - 1;
			_Base_1 = NORRN_revive_array select 14;
			_Base_2 = NORRN_revive_array select 15;
			_Base_3 = NORRN_revive_array select 16;
		};
	};

	switch (_no_respawn_points) do {
		case 1: {_dialog_1 = createDialog "respawn_button_1b";ctrlSetText [1, "Base"];};
		case 2: {_dialog_1 = createDialog "respawn_button_2b";ctrlSetText [1, "Base"];ctrlSetText [2, "MR 1"];};
		case 3: {_dialog_1 = createDialog "respawn_button_3b";ctrlSetText [1, "Base"];ctrlSetText [2, "MR 1"];ctrlSetText [3, "MR 3"];};
		case 4: {_dialog_1 = createDialog "respawn_button_4b";ctrlSetText [1, "Base"];ctrlSetText [2, "MR 1"];ctrlSetText [3, "MR 3"];ctrlSetText [4, _Base_4];};
	};
};