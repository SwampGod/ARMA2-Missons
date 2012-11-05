// by Xeno
#include "x_setup.sqf"
#define __ctrl(vctrl) _ctrl = _XD_display displayCtrl vctrl
private ["_ctrl","_current_target_name","_ok","_s","_target_array2","_XD_display"];
if (!X_Client) exitWith {};

disableSerialization;

_ok = createDialog "XD_StatusDialog";

_XD_display = __uiGetVar(X_STATUS_DIALOG);

_isadmin = player getVariable "d_p_isadmin";
if (isNil "_isadmin") then {_isadmin = false};

if (!_isadmin) then {
	__ctrl(123123);
	_ctrl ctrlShow false;
};

_target_array2 = [];
_current_target_name = "";

if (__XJIPGetVar(current_target_index) != -1) then {
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
_s = format ["%1 : %2", _points_west, _points_east];
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
_s = format ["%1 : %2", _kill_points_west, _kill_points_east];
_ctrl ctrlSetText _s;
#endif

__ctrl(11002);
_s = switch (true) do {
	case __XJIPGetVar(all_sm_res): {"All missions resolved!"};
	case (__XJIPGetVar(current_mission_index) == -1): {"No new sidemission available..."};
	default {d_current_mission_text};
};
_ctrl ctrlSetText _s;

#ifndef __TT__
_iar = __XJIPGetVar(d_searchintel);
_intels = "";
for "_i" from 0 to (count _iar) - 1 do {
	if ((_iar select _i) == 1) then {
		_intels = switch (_i) do {
			case 0: {"- Codenames for launching saboteur attacks on or base"};
			case 1: {"- Codename for airdrop to provide early warning whenever the enemy sends airdropped troops to the main target"};
			case 2: {"- Codename for attack planes to provide early warning whenever the enemy sends an attack plane to the main target"};
			case 3: {"- Codename for attack helicopters to provide early warning whenever the enemy sends an attack chopper to the main target"};
			case 4: {"- Codename for light attack helicopters to provide early warning whenever the enemy sends a light attack chopper to the main target"};
			case 5: {"- Provide grid information on where the enemy is calling in artillery support."};
			case 6: {"- Ability to track enemy vehicle patrols, but we don't know their configuration. Check the map."};
		};
		_intels = _intels + "\n";
	};
};
if (_intels == "") then {
	_intels = "No intel found yet...";
};
__ctrl(11018);
_ctrl ctrlSetText _intels;
#else
__ctrl(11019);
_ctrl ctrlShow false;
__ctrl(11018);
_ctrl ctrlShow false;
#endif

__ctrl(11003);
_ctrl ctrlSetText _current_target_name;

_s = format ["%1/%2", (count __XJIPGetVar(resolved_targets) + 1), d_MainTargets];
__ctrl(11006);
_ctrl ctrlSetText _s;

__ctrl(11233);
_ctrl ctrlSetText str(score player);

__ctrl(11278);
#ifndef __TT__
_ctrl ctrlSetText format ["%1", __XJIPGetVar(d_campscaptured)];
#else
if (playerSide == west) then {
	_ctrl ctrlSetText format ["%1", __XJIPGetVar(d_campscaptured_w)];
} else {
	_ctrl ctrlSetText format ["%1", __XJIPGetVar(d_campscaptured_e)];
};
#endif

_s = format ["Current cloud level: %1/100, rain: %2/100", round(overcast * 100), round (rain * 100)];
_s = _s + (if (WithWinterWeather == 0) then {if (__XJIPGetVar(d_winterw) == 1) then {". Light snowfall and ground fog."} else {""}} else {""});
if (d_weather == 1) then {_s = format ["Domination dynamic weather system not used. Current cloud level is %1 percent. Current fog level is %2 percent.", round(overcast*100), round(fog*100)]};
__ctrl(11013);
_ctrl ctrlSetText _s;

__ctrl(11009);
if (d_use_teamstatusdialog == 1) then {
	_ctrl ctrlShow false;
} else {
	if (vehicle player == player) then {
		_ctrl ctrlSetText "Team Status";
	} else {
		_ctrl ctrlSetText "Vehicle Status";
	};
};

_s = "";
if (__XJIPGetVar(current_target_index) != -1) then {
	_s = switch (__XJIPGetVar(sec_kind)) do {
		case 1: {
			format ["Find and eliminate the local governor of %1.\n", _current_target_name]
		};
		case 2: {
#ifndef __OA__
			format ["Find the local communication tower in %1 and destroy it.\n", _current_target_name]
#else
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

__ctrl(11007);
_ctrl ctrlSetText _s;

__ctrl(12010);
_ctrl ctrlSetText ((rank player) call XGetRankPic);

__ctrl(11014);
_ctrl ctrlSetText ((rank player) call XGetRankString);

waitUntil {!dialog || !alive player};

if (!alive player) then {closeDialog 0};