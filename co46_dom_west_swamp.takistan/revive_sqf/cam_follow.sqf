/*
 CAMERA_FOLLOW SCRIPT

 AUGUST 2009 - norrin
 Originally converted by xeno to SQF
*/

#define __setButtons \
if (_no_respawn_points > 0) then {ctrlSetText [1, "Base"]};\
if (_no_respawn_points > 1) then {ctrlSetText [2, "MR 1"]};\
if (_no_respawn_points > 2) then {ctrlSetText [3, "MR 2"]};\
if (_no_respawn_points > 3) then {ctrlSetText [4, _Base_4]}

#define __createDialog \
switch (_no_respawn_points) do {\
	case 1: {_dialog_5 = createDialog "respawn_button_1map"};\
	case 2: {_dialog_5 = createDialog "respawn_button_2map"};\
	case 3: {_dialog_5 = createDialog "respawn_button_3map"};\
	case 4: {_dialog_5 = createDialog "respawn_button_4map"};\
}

#define __createDialog2 \
switch (_no_respawn_points) do {\
	case 0: {_r_dialog_0 = createDialog "rev_cam_dialog";_r_display = findDisplay 99123;_r_display displaySetEventHandler ["Keydown", "_this call CAM_KEY_pressed"]};\
	case 1: {_r_dialog_1 = createDialog "respawn_button_1";_r_display = findDisplay 99124;_r_display displaySetEventHandler ["Keydown", "_this call CAM_KEY_pressed"]};\
	case 2: {_r_dialog_2 = createDialog "respawn_button_2";_r_display = findDisplay 99125;_r_display displaySetEventHandler ["Keydown", "_this call CAM_KEY_pressed"]};\
	case 3: {_r_dialog_3 = createDialog "respawn_button_3";_r_display = findDisplay 99126;_r_display displaySetEventHandler ["Keydown", "_this call CAM_KEY_pressed"]};\
	case 4: {_r_dialog_4 = createDialog "respawn_button_4";_r_display = findDisplay 99127;_r_display displaySetEventHandler ["Keydown", "_this call CAM_KEY_pressed"]};\
}

disableserialization;

private ["_alive_friends","_all_dead_dialog","_allUnits","_c","_camera_friends","_Camera_target","_camx","_camy","_camz","_can_be_revived","_can_be_revived_2","_d","_destroy","_destroy2","_dialog_1","_dialog_2","_display","_distance_to_friend","_e","_f","_follow_cam","_follow_cam_distance","_foo","_friends","_index","_index_friends","_max_box","_name_player","_nearest_friend","_nearest_teammate_dialog","_no_respawn_points","_Object","_pos","_respawn_button_timer","_show_respawn_time","_target"];
_Object = _this select 0;
_pos = _this select 1;
_name_player = r_name_player;
_c = 0;
_d = 0;
_alive_friends = [];
_destroy = false;
_destroy2 = false;
_switch = false;
NORRN_FOCUS_CAM_ON = 0;
NORRN_REVIVE_CAM_TYPE = 0;
NORRN_CAM_NVG = false;
Norrn_helper_list = [];
all_dead_check = false;
_dialog_fade = Norrn_DialogBlink;
_oldtarget = objNull;
_oldCam = -1;

player switchCamera "INTERNAL";
NORRN_REVIVE_cam CameraEffect ["Terminate","Back"];
CamDestroy NORRN_REVIVE_cam;

_all_dead_dialog = NORRN_revive_array select 1;
_nearest_teammate_dialog = NORRN_revive_array select 3;
_follow_cam = NORRN_revive_array select 5;
_goto_revive = NORRN_revive_array select 9;

_no_respawn_points = NORRN_revive_array select 12;
_Base_1 = NORRN_revive_array select 13;
_Base_2 = NORRN_revive_array select 14;
_Base_3 = NORRN_revive_array select 15;
_Base_4 = NORRN_revive_array select 16;

_can_be_revived = NORRN_revive_array select 20;
_can_be_revived_2 = NORRN_revive_array select 21;

_respawn_button_timer = NORRN_revive_array select 25;
_distance_to_friend = NORRN_revive_array select 26;
_follow_cam_distance = NORRN_revive_array select 32;

_max_respawns = NORRN_revive_array select 38;
_ally_side_1 = NORRN_revive_array select 42;
_ally_side_2 = NORRN_revive_array select 43;
_follow_cam_team = NORRN_revive_array select 44;
_unc_music = NORRN_revive_array select 46;

_mobile_spawn = NORRN_revive_array select 51;
_mobile_base_start = NORRN_revive_array select 52;

_QG_animation = NORRN_revive_array select 54;
_top_view_height = NORRN_revive_array select 55;
_all_dead_player = NORRN_revive_array select 56;
_all_dead_distance = NORRN_revive_array select 57;

_r_dialog_0 = "";_r_dialog_1 = "";_r_dialog_2 = "";_r_dialog_3 = "";_r_dialog_4 = "";_r_display  = "";

_ally_side_1 = switch (_ally_side_1) do {
	case "EAST": {east};
	case "WEST": {west};
	case "RESISTANCE": {resistance};
	default {sideUnknown};
};
_ally_side_2 = switch (_ally_side_2) do {
	case "EAST": {east};
	case "WEST": {west};
	case "RESISTANCE": {resistance};
	default {sideUnknown};
};

if (_mobile_spawn == 1) then {if(!NORRN_camo_net) then {norrn_button_update = false} else {norrn_button_update = true}};
_show_respawn_time = time + _respawn_button_timer;
showcinemaborder false;

if (_unc_music == 1) then {playMusic "unc_theme"};

NORRN_REVIVE_cam = "camera" CamCreate (getPos _object);
NORRN_REVIVE_cam CamSetTarget _object;
NORRN_REVIVE_cam CameraEffect ["INTERNAL","Back"];
NORRN_REVIVE_cam CamCommit 0.1;

if (_all_dead_dialog == 1) then {
	_f = 0; _e = 0;
	if(_all_dead_player == 0)then {
		{if(!isNull (missionNamespace getVariable _x)) then {_f = _f + 1}} forEach NORRN_player_units;
		{_ur = missionNamespace getVariable _x;if(!isNull _ur && (_ur getVariable "NORRN_unconscious") ||!isNull _ur && (_Object distance _ur) > _all_dead_distance)then {_e = _e + 1}}forEach NORRN_player_units;
	} else {
		{if(isplayer (missionNamespace getVariable _x)) then {_f = _f + 1}} forEach NORRN_player_units;
		{_ur = missionNamespace getVariable _x;if(isplayer _ur && (_ur getVariable "NORRN_unconscious"))then {_e = _e + 1}}forEach NORRN_player_units;
	};
	if (_e == _f && _d == 0) then {all_dead_check = true};
};

titleText ["", "BLACK FADED", 1];
hint "";
titleText ["You are unconscious and waiting to be revived", "BLACK FADED", 0.5];
sleep 4;
waitUntil{!isNull unconscious_body || !(player getVariable "NORRN_unconscious")};
if (!(player getVariable "NORRN_unconscious")) then {_destroy = true};

_angh = 0; _angv = 0;

if (!_destroy) then {
	NORRN_REVIVE_cam CamSetTarget unconscious_body;
	NORRN_REVIVE_cam switchCamera "EXTERNAL";
	NORRN_REVIVE_cam CameraEffect ["Terminate","Back"];

	_NORRN_west = [];
	{_ur = missionNamespace getVariable _x;if (!isNull _ur) then {_NORRN_west set [count _NORRN_west, _ur]}} forEach NORRN_player_units;

	_foo = [];
	_foo set [count _foo, unconscious_body];
	_friends = nearestObjects [unconscious_body, ["CAManBase","AIR","SHIP","LandVehicle"],_follow_cam_distance];
	_friends = allUnits;
	{if ((vehicle _x) isKindOf "AIR" || (vehicle _x) isKindOf "SHIP" || (vehicle _x) isKindOf "LandVehicle") then {if (count (crew _x) == 0) then {_friends = _friends - [_x]}}} forEach _friends;
	{if (side _x == playerSide && (_x distance unconscious_body) < _follow_cam_distance && alive _x && _x in _NORRN_west && !(_x getVariable "NORRN_unconscious") && !(_x getVariable "NORRN_dead")) then {_foo set [count _foo, _x]}}forEach _friends;

	_alive_friends = _foo;
	COUNT_CAM_friends = count _alive_friends;
	_camera_friends = _alive_friends;

	_r_dialog_0 = createDialog "rev_cam_dialog";
	_r_display = findDisplay 99123;
	_r_display displaySetEventHandler ["Keydown", "_this call CAM_KEY_pressed"];
	CAM_KEY_pressed = compile preprocessfile "revive_sqf\CAM_KEY_pressed.sqf";

	_angh = getDir unconscious_body;
	_angv = 45;
	
	sleep 0.5;
	titlecut ["","BLACK IN",1];
};

while {!_destroy} do {
	_e = 0; _f = 0;
	if (isNull unconscious_body || !alive unconscious_body) exitWith {_destroy = true};
	if (!(player getVariable "NORRN_unconscious")) exitWith {_destroy = true};
	if (mission_Over) exitWith {sleep 5; _destroy = true};
	if (!alive player) exitWith {titleText ["","BLACK FADED",10];_destroy2 = true};

	_cam_angle = lbCurSel 10004;
	_cam_focus = lbCurSel 10005;
	
	if (_all_dead_dialog == 1) then {
		if(_all_dead_player == 0)then {
			{if(!isNull (missionNamespace getVariable _x)) then {_f = _f + 1}} forEach NORRN_player_units;
			{_ur = missionNamespace getVariable _x;if(!isNull _ur && (_ur getVariable "NORRN_unconscious") ||!isNull _ur && (_Object distance _ur) > _all_dead_distance)then {_e = _e + 1}}forEach NORRN_player_units;
		} else {
			{if(isplayer (missionNamespace getVariable _x)) then {_f = _f + 1}} forEach NORRN_player_units;
			{_ur = missionNamespace getVariable _x;if(isplayer _ur && (_ur getVariable "NORRN_unconscious"))then {_e = _e + 1}}forEach NORRN_player_units;
		};
		if (_e == _f && !NORRN_r_time_expire) then {all_dead_check = true};
	};

	_NORRN_west = [];
	{_ur = missionNamespace getVariable _x;if (!isNull _ur && player != _ur) then {_NORRN_west set [count _NORRN_west, _ur]}} forEach NORRN_player_units;
	_nearest_friend = 1;
	{if ((unconscious_body distance _x) <= _distance_to_friend) then {_nearest_friend = _nearest_friend + 1}}forEach _NORRN_west;

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

	if (_d == 0 && _dialog_fade != Norrn_DialogBlink && !NORRN_r_time_expire) then {
		_switch = true;
		closedialog 0;
		_r_display closedisplay 10004;
		_r_display closedisplay 10005;
		waitUntil {!dialog};
		_r_dialog_0 = createDialog "rev_cam_dialog";  _r_display = findDisplay 99123;_r_display displaySetEventHandler ["Keydown", "_this call CAM_KEY_pressed"];
		_dialog_fade = Norrn_DialogBlink;
	};

	if (time >= _show_respawn_time && _d == 0 && !NORRN_r_time_expire || _nearest_teammate_dialog == 1 && _nearest_friend == 1 && _d == 0 && !NORRN_r_time_expire ||
			time >= _show_respawn_time && !NORRN_r_time_expire && _dialog_fade != Norrn_DialogBlink || _nearest_teammate_dialog == 1 && _nearest_friend == 1 && !NORRN_r_time_expire && _dialog_fade != Norrn_DialogBlink) then {
		_switch = true;
		closedialog 0;
		_r_display closedisplay 10004;
		_r_display closedisplay 10005;
		waitUntil {!dialog};
		_d = 1;
		__createDialog2;
		__setButtons;
		_dialog_fade = Norrn_DialogBlink;	
	};

	if (NORRN_r_time_expire && _d < 2 || _all_dead_dialog == 1 && all_dead_check && _d < 2 && !NORRN_r_time_expire) then {
		unconscious_body setVariable ["NORRN_AIunconscious", false, true];
		if (_all_dead_dialog == 1 && all_dead_check && _d < 2) then {
			["swmdead", unconscious_body] call RNetCallEvent;
			if (_unconscious_markers == 1) then {deleteMarker format["%1 is down", player]};
			titleText ["\n\n\n\n\n\n\n\n\n\nAll players are unconscious. Choose a marker for respawn", "BLACK FADED", 10];
			NORRN_r_time_expire = true;
		};
		if (!isNull unconscious_body) then {NORRN_FOCUS_CAM_ON = 0; unconscious_body switchCamera "EXTERNAL"};
		sleep 2;
		closedialog 0;
		__createDialog;
		__setButtons;
		_d = 2;
	};

	if (_mobile_spawn == 1) then {
		if (NORRN_r_time_expire && NORRN_camo_net && !norrn_button_update || NORRN_r_time_expire && !NORRN_camo_net && norrn_button_update) then {
			closedialog 0;
			waitUntil {!dialog};
			__createDialog;
			__setButtons;
			if (!NORRN_camo_net) then {norrn_button_update = false} else {norrn_button_update = true};
			NORRN_OK_diag_off = true;
		};

		if (NORRN_camo_net && _d == 1 && !norrn_button_update && !NORRN_r_time_expire|| !NORRN_camo_net && _d == 1 && norrn_button_update && !NORRN_r_time_expire)then {
			_switch = true;
			closedialog 0;
			_r_display closedisplay 10004;
			_r_display closedisplay 10005;
			waitUntil {!dialog};
			__createDialog2;
			__setButtons;

			if (!NORRN_camo_net) then {norrn_button_update = false} else {norrn_button_update = true};
		};
	};

	{if (alive _x) then {if  (name _x == "Error: No unit") then {COUNT_CAM_friends = COUNT_CAM_friends - 50}}}forEach _camera_friends;
	
	if (_c == 0 ) then {
		_foo = [];
		_allUnits = [];

		_friends = allUnits;
		{if ((vehicle _x) isKindOf "AIR" || (vehicle _x) isKindOf "SHIP" || (vehicle _x) isKindOf "LandVehicle") then {if (count (crew _x) == 0) then {_friends set [count _friends, _x]}}} forEach _friends;
		_foo set [count _foo, unconscious_body];

		if (_follow_cam_team == 0) then {
			{if ((_x distance unconscious_body) < _follow_cam_distance && (side _x) == _ally_side_1 && alive _x &&  !(_x getVariable "NORRN_unconscious") && !(_x getVariable "NORRN_dead") || (_x distance unconscious_body) < _follow_cam_distance && (side _x) == _ally_side_2 && alive _x && !(_x getVariable "NORRN_unconscious") && !(_x getVariable "NORRN_dead")) then {_foo set [count _foo, _x]}}forEach _friends;
		} else {
			{if (alive _x && (unconscious_body distance _x) <= _follow_cam_distance && !(_x getVariable "NORRN_unconscious") && !(_x getVariable "NORRN_dead")) then {_foo set [count _foo, _x]}}forEach _NORRN_west;
		};

		if (count _foo != COUNT_CAM_friends) then {_alive_friends = _foo; COUNT_CAM_friends = count _alive_friends};
		_camera_friends = _alive_friends;
	};

	if (count _alive_friends > 0) then {
		while {!alive _target} do {
			NORRN_FOCUS_CAM_ON = (NORRN_FOCUS_CAM_ON - 1) max 0;
			_target = vehicle (_alive_friends select NORRN_FOCUS_CAM_ON);
			lbSetCurSel [10005, NORRN_FOCUS_CAM_ON];
			sleep 0.01;
		};
	};

	lbClear 10004;
	if (_follow_cam == 1) then {
		_index = lbAdd[10004, "3rd Person"];
		_index = lbAdd[10004, "Top Down"];
		_index = lbAdd[10004, "Front Side"];
		_index = lbAdd[10004, "1st Person"];
		_index = lbAdd[10004, "Follow/Free"];
	} else {
		_index = lbAdd[10004, "Follow"];
	};

	lbClear 10005;
	if (_follow_cam == 1) then {{if (alive _x) then {_index_friends = lbAdd[10005, name _x]}} forEach _camera_friends};

	if (!_switch) then {
		lbSetCurSel [10004, lbCurSel 10004];
		lbSetCurSel [10005, lbCurSel 10005];
	} else {
		lbSetCurSel [10004, _cam_angle];
		lbSetCurSel [10005, _cam_focus];
		_switch = false;
	};

	NORRN_REVIVE_CAM_TYPE = lbCurSel 10004;
	NORRN_FOCUS_CAM_ON = lbCurSel 10005;

	switch (true) do {
		case (_follow_cam == 0 && NORRN_REVIVE_CAM_TYPE == 0): {
			unconscious_body switchCamera "EXTERNAL";
			NORRN_REVIVE_cam CameraEffect ["Terminate","Back"];
		};
		case (_follow_cam == 1): {
			if (!dialog) then {
				if (!isNull unconscious_body) then {_target = unconscious_body; NORRN_REVIVE_cam camsettarget _target;NORRN_REVIVE_cam cameraeffect ["internal", "back"];NORRN_REVIVE_cam camsetrelpos [-3, +1, (_max_box select 2) +1];NORRN_REVIVE_cam camcommit 1};
			} else {
				if (!all_dead_check && !NORRN_r_time_expire) then {_target = vehicle(_alive_friends select NORRN_FOCUS_CAM_ON)};
			};
			switch (NORRN_REVIVE_CAM_TYPE) do {
				case 0: {if (_target != _oldTarget || NORRN_REVIVE_CAM_TYPE != _oldCam) then {_oldTarget = _target; _oldCam = NORRN_REVIVE_CAM_TYPE; if (_target == player) then {unconscious_body switchCamera "EXTERNAL";} else {_target switchCamera "EXTERNAL"};NORRN_REVIVE_cam CameraEffect ["Terminate","Back"];}};
				case 1: {if (_target == player) then {NORRN_REVIVE_cam camsettarget unconscious_body;} else {NORRN_REVIVE_cam camsettarget _target}; _oldCam = NORRN_REVIVE_CAM_TYPE; NORRN_REVIVE_cam cameraeffect ["internal", "back"];NORRN_REVIVE_cam camsetrelpos [0, -2, OFPEC_range_to_unit];NORRN_REVIVE_cam camcommit 0.005};
				case 2: {if (_target == player) then {NORRN_REVIVE_cam camsettarget unconscious_body;} else {NORRN_REVIVE_cam camsettarget _target}; _oldCam = NORRN_REVIVE_CAM_TYPE; NORRN_REVIVE_cam cameraeffect ["internal", "back"];NORRN_REVIVE_cam camsetrelpos [-1.5, 3, 0.2];NORRN_REVIVE_cam camSetFov 1.1; NORRN_REVIVE_cam camcommit 0.005};
				case 3: {if (_target != _oldTarget || NORRN_REVIVE_CAM_TYPE != _oldCam) then {_oldTarget = _target; _oldCam = NORRN_REVIVE_CAM_TYPE; if (_target == player) then {unconscious_body switchCamera "INTERNAL";} else {_target switchCamera "INTERNAL"};NORRN_REVIVE_cam CameraEffect ["Terminate","Back"]}};
			};
		};
	};

	_c = _c + 1;
	if (_c == 400) then {_c = 0};

	if (dialog && !NORRN_r_time_expire || dialog && _all_dead_dialog == 1 && !all_dead_check && !NORRN_r_time_expire) then {
		_lives = _max_respawns - (player getVariable "NORRN_lives_used");
		_cam_hint0 = format ["Lives remaining: %1", _lives];
		ctrlSetText [10, _cam_hint0];

		_target = _alive_friends select (lbCurSel 10005);
		_follow_unit = "";

		if (NORRN_FOCUS_CAM_ON == 0) then {
			_follow_unit =  r_name_player;
		} else {
			if (alive _target) then {_follow_unit = name _target};
		};
		_cam_hint1 = format ["Camera following: %1", _follow_unit];
		ctrlSetText [11, _cam_hint1];

		_unit_distance = round (unconscious_body distance _target);
		_cam_hint2 = format ["Distance to camera: %1 m", _unit_distance];
		ctrlSetText [12, _cam_hint2];

		ctrlSetText [13, "The following units have been"];
		ctrlSetText [14, "notified that you need help:"];
		_list_helper = [];
		{if (!isNull _x && alive _x) then {_list_helper set [count _list_helper, (name _x)]}}forEach Norrn_helper_list;
		_cam_hint5 = if ((count _list_helper) == 0) then {"None"} else {format ["%1", _list_helper]};
		ctrlSetText [15, _cam_hint5];

		_rev = objNull;
		_rev = player getVariable "NORRN_AIReviver";
		if (_goto_revive == 0 && (count Norrn_helper_list) > 0) then {_rev = Norrn_helper_list select 0};
		if (_goto_revive == 1 && (count Norrn_helper_list) > 0) then {
			if (((Norrn_helper_list select 0) distance unconscious_body) < (_rev distance unconscious_body)) then {_rev = (Norrn_helper_list select 0)};
		};
		_cam_hint6 = if (isNull _rev || !alive _rev) then {"Current reviver: None"} else {format ["Current reviver: %1", name _rev]};
		ctrlSetText [16, _cam_hint6];

		_cam_hint7 = if (isNull _rev) then {"Distance to reviver: N/A"} else {format ["Distance to reviver: %1 m", round(unconscious_body distance _rev)]};
		ctrlSetText [17, _cam_hint7];

		_cam_hint8 = if (Norrn_DialogBlink == 20) then {"Dialog Fade: On"} else {"Dialog Fade: Off"};
		ctrlSetText [18, _cam_hint8];

		_cam_hint9 = if (!NORRN_CAM_NVG) then {"Free camera NVG: Off"} else {"Free camera NVG: On"};
		ctrlSetText [19, _cam_hint9];

	};

	if (_follow_cam == 1 && NORRN_REVIVE_CAM_TYPE == 4) then {
		_target = _alive_friends select NORRN_FOCUS_CAM_ON;
		_oldCam = NORRN_REVIVE_CAM_TYPE;
		if (_target == player) then {_target = unconscious_body; NORRN_REVIVE_cam camsettarget _target;} else {NORRN_REVIVE_cam camsettarget _target};
		NORRN_REVIVE_cam cameraeffect ["internal", "back"];

		if (OFPEC_MouseButtons select 1) then {
			if (((OFPEC_MouseCoord select 0) >= 0) && ((OFPEC_MouseCoord select 0) <= 1) &&
				((OFPEC_MouseCoord select 1) >= 0) && ((OFPEC_MouseCoord select 1) <= 1)) then {
				_deltah = (0.5 - (OFPEC_MouseCoord select 0))*10/0.2;
				_deltav = (0.5 - (OFPEC_MouseCoord select 1))*10/0.2;
				_angv = (_angv + _deltav);
				_angh = (_angh + _deltah);
				_angv = _angv max 0;
				_angv = _angv min 89;
			};
		};
		_free_pos = [(getPosASL _target select 0) + sin(_angh)*OFPEC_range_to_unit, (getPosASL _target select 1) + cos(_angh)*OFPEC_range_to_unit, (getpos _target select 2) + OFPEC_range_to_unit*sin(_angv)];
		NORRN_REVIVE_cam camSetPos _free_pos;
		NORRN_REVIVE_cam camCommit 0.5;
	};
	sleep 0.01;
};

if (_destroy || _destroy2) exitWith {
	if (_destroy) then {sleep 0};
	camUseNVG false;
	closeDialog 4;
	closeDialog 3;
	closeDialog 2;
	closeDialog 1;
	closeDialog 0;
	if (_unc_music == 1) then {playMusic ""};
	if (mission_Over) then {titletext ["Mission Failed - all players are unconscious","BLACK", 4]; sleep 1};
	player switchCamera "INTERNAL";
	NORRN_REVIVE_cam CameraEffect ["Terminate","Back"];
	CamDestroy NORRN_REVIVE_cam;
	deleteVehicle _Object;
};

//Last edited 16/08/09