// by Xeno
#define THIS_FILE "x_showstatus.sqf"
#include "x_setup.sqf"
#define __ctrl(vctrl) _ctrl = _XD_display displayCtrl vctrl
#define __ctrl2(ectrl) (_XD_display displayCtrl ectrl)
private ["_ctrl","_current_target_name","_s","_target_array2","_XD_display"];
if (!X_Client) exitWith {};

disableSerialization;

createDialog "XD_StatusDialog";

_XD_display = __uiGetVar(X_STATUS_DIALOG);

_hxhx = __pGetVar(GVAR(p_isadmin));
if (isNil "_hxhx") then {_hxhx = false};
if (!_hxhx) then {
	__ctrl2(123123) ctrlShow false;
};

_target_array2 = [];
_current_target_name = "";

if (__XJIPGetVar(GVAR(current_target_index)) != -1) then {
	__TargetInfo
} else {
	_current_target_name = "No Target";
};

#ifdef __TT__
__ctrl(11011);
_color = [];
_points_array = __XJIPGetVar(points_array);
_points_west = _points_array select 0;
_points_east = _points_array select 1;
_kill_points_west = _points_array select 2;
_kill_points_east = _points_array select 3;
if (_points_west > _points_east) then {
	_color = [0,0,1,1];
} else {
	if (_points_east > _points_west) then {
		_color = [1,0,0,1];
	} else {
		if (_points_east == _points_west) then {_color = [0,1,0,1]};
	};
};
_ctrl ctrlSetTextColor _color;
_s = str(_points_west) + " : " + str(_points_east);
_ctrl ctrlSetText _s;

__ctrl(11012);
if (_kill_points_west > _kill_points_east) then {
	_color = [0,0,1,1];
} else {
	if (_kill_points_east > _kill_points_west) then {
		_color = [1,0,0,1];
	} else {
		if (_kill_points_east == _kill_points_west) then {
			_color = [0,1,0,1];
		};
	};
};
_ctrl ctrlSetTextColor _color;
_s = str(_kill_points_west) + " : " + str(_kill_points_east);
_ctrl ctrlSetText _s;
#endif

_s = switch (true) do {
	case __XJIPGetVar(all_sm_res): {"All missions resolved!"};
	case (__XJIPGetVar(GVAR(current_mission_index)) == -1): {"No new sidemission available..."};
	default {GVAR(current_mission_text)};
};
__ctrl2(11002) ctrlSetText _s;

if (GVAR(WithRevive) == 1) then {
	__ctrl2(30000) ctrlShow false;
	__ctrl2(30001) ctrlShow false;
} else {
	__ctrl2(30001) ctrlSetText str(__pGetVar(xr_lives));
};

#ifndef __TT__
_iar = __XJIPGetVar(GVAR(searchintel));
_intels = "";
private "_forEachIndex";
if (__A2Ver) then {
	_forEachIndex = 0;
};
{
	if (_x == 1) then {
		_tmp = switch (_forEachIndex) do {
			case 0: {"- Codenames for launching saboteur attacks on or base"};
			case 1: {"- Codename for airdrop to provide early warning whenever the enemy sends airdropped troops to the main target"};
			case 2: {"- Codename for attack planes to provide early warning whenever the enemy sends an attack plane to the main target"};
			case 3: {"- Codename for attack helicopters to provide early warning whenever the enemy sends an attack chopper to the main target"};
			case 4: {"- Codename for light attack helicopters to provide early warning whenever the enemy sends a light attack chopper to the main target"};
			case 5: {"- Provide grid information on where the enemy is calling in artillery support."};
			case 6: {"- Ability to track enemy vehicle patrols, but we don't know their configuration. Check the map."};
		};
		_intels = _intels + _tmp + "\n";
	};
	if (__A2Ver) then {
		__INC(_forEachIndex);
	};
} forEach _iar;
if (_intels == "") then {
	_intels = "No intel found yet...";
};
__ctrl2(11018) ctrlSetText _intels;
#else
__ctrl2(11019) ctrlShow false;
__ctrl2(11018) ctrlShow false;
#endif

__ctrl2(11003) ctrlSetText _current_target_name;

_s = format ["%1/%2", (count __XJIPGetVar(resolved_targets) + 1), GVAR(MainTargets)];
__ctrl2(11006) ctrlSetText _s;

__ctrl2(11233) ctrlSetText str(score player);

__ctrl(11278);
#ifndef __TT__
_ctrl ctrlSetText format ["%1/%2", __XJIPGetVar(GVAR(campscaptured)), count __XJIPGetVar(GVAR(currentcamps))];
#else
if (playerSide == west) then {
	_ctrl ctrlSetText format ["%1/%2", __XJIPGetVar(GVAR(campscaptured_w)), count __XJIPGetVar(GVAR(currentcamps))];
} else {
	_ctrl ctrlSetText format ["%1/%2", __XJIPGetVar(GVAR(campscaptured_e)), count __XJIPGetVar(GVAR(currentcamps))];
};
#endif

_s = format ["Current cloud level: %1/100, rain: %2/100", round(overcast * 100), round (rain * 100)];
_s = _s + (if (GVAR(WithWinterWeather) == 0) then {if (__XJIPGetVar(GVAR(winterw)) == 1) then {". Light snowfall and ground fog."} else {""}} else {""});
if (GVAR(weather) == 1) then {_s = format ["Domination dynamic weather system not used. Current cloud level is %1 percent. Current fog level is %2 percent.", round(overcast * 100), round(fog * 100)]};
__ctrl2(11013) ctrlSetText _s;

__ctrl(11009);
if (GVAR(use_teamstatusdialog) == 1) then {
	_ctrl ctrlShow false;
} else {
	if (vehicle player == player) then {
		_ctrl ctrlSetText "Team Status";
	} else {
		_ctrl ctrlSetText "Vehicle Status";
	};
};

_s = "";
if (__XJIPGetVar(GVAR(current_target_index)) != -1) then {
	_s = switch (__XJIPGetVar(sec_kind)) do {
		case 1: {
			format ["Find and eliminate the local governor of %1.\n", _current_target_name]
		};
		case 2: {
#ifdef __CO__
			format ["Find the local communication tower in %1 and destroy it.\n", _current_target_name]
#endif
#ifdef __OA__
			format ["Find a fortress in %1 and destroy it.\n", _current_target_name]
#endif
		};
		case 3: {
#ifndef __TT__
			format ["Find an enemy ammo truck in %1 and destroy it to cut down ammo supplies.\n", _current_target_name]
#else
			format ["Find an enemy truck in %1 and destroy it.\n", _current_target_name]
#endif
		};
		case 4: {
#ifndef __TT__
			format ["Find a new APC prototype (concealed as medic) in %1 and destroy it.\n", _current_target_name]
#else
			format ["Find a new APC prototype in %1 and destroy it.\n", _current_target_name]
#endif
		};
		case 5: {
			format ["Find the enemy HQ in %1 and destroy it.\n", _current_target_name]
		};
		case 6: {
			format ["Find a light enemy factory in %1 and destroy it.\n", _current_target_name]
		};
		case 7: {
			format ["Find a heavy enemy factory in %1 and destroy it.\n", _current_target_name]
		};
		case 8: {
			format ["Find an enemy artillery radar in %1 and destroy it\n", _current_target_name]
		};
		case 9: {
			format ["Find an enemy anti air radar in %1 and destroy it\n", _current_target_name]
		};
		case 10: {
			format ["Find a collaborateur in %1 and eliminate him\n", _current_target_name]
		};
		case 11: {
			format ["Find a drug dealer who sells drugs to our troops in %1 and eliminate him\n", _current_target_name]
		};
		default {
			"No secondary main target mission available..."
		};
	};
} else {
	_s = "No secondary main target mission available...";
};

__ctrl2(11007) ctrlSetText _s;

__ctrl2(12010) ctrlSetText ((rank player) call FUNC(GetRankPic));

__ctrl2(11014) ctrlSetText ((rank player) call FUNC(GetRankString));

0 spawn {
	waitUntil {!GVAR(showstatus_dialog_open) || !alive player || __pGetVar(xr_pluncon)};
	if (GVAR(showstatus_dialog_open)) then {closeDialog 0};
};