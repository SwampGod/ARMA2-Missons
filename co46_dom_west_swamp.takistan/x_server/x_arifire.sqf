// by Xeno
#include "x_setup.sqf"
private ["_height", "_type", "_radius", "_arix", "_ariy", "_ang", "_posf", "_posb", "_posl", "_posr", "_series", "_x1", "_y1", "_angle", "_strenght", "_i", "_j", "_nos", "_shell", "_xo", "_pos", "_pod", "_obj", "_center_x", "_center_y", "_wp_array", "_ari_target","_ari_avail","_side_arti", "_num_arti", "_aristr", "_topicside", "_topicside2", "_logic"];
if (!isServer) exitWith {};

_ari_type = _this select 0;
_ari_salvos = _this select 1;
_arti_operator = _this select 2;
_side_arti = side _arti_operator;
_ari_target = _this select 3;
_ari_avail = _this select 4;
_num_arti = _this select 5;

if (!(X_JIPH getVariable _ari_avail)) exitWith {};

[_ari_avail,false] call XNetSetJIP;

sleep 9.123;
#ifndef __TT__
_aristr = switch (_num_arti) do {
	case 1: {"first artillery"};
	case 2: {"second artillery"};
};
d_kb_logic1 kbTell [_arti_operator,d_kb_topic_side_arti,"ArtilleryRoger",["1","",_aristr,[]],true];
#else
_topicside = switch (_num_arti) do {
	case 1: {"HQ_ART_W"};
	case 2: {"HQ_ART_E"};
};
_topicside2 = switch (_num_arti) do {
	case 1: {"HQ_W"};
	case 2: {"HQ_E"};
};
_logic = switch (_num_arti) do {
	case 1: {d_hq_logic_en1};
	case 2: {d_hq_logic_ru1};
};
_logic kbTell [_arti_operator,_topicside,"ArtilleryRoger",["1","","artillery",[]],true];
#endif
sleep 1;
#ifndef __TT__
_aristr = switch (_num_arti) do {
	case 1: {"First artillery"};
	case 2: {"Second artillery"};
};
["ArtilleryUnAvailable", _aristr] call XfKBSendMsgAll;
#else
if (__OAVer) then {
	[_topicside2,"ArtilleryUnAvailable", "BeAdvisedArtilleryIsUnavailableAtThisTimeOut"] call XfKBSendMsgAll;
} else {
	[_topicside2,"ArtilleryUnAvailable", "Artillery"] call XfKBSendMsgAll;
};
#endif
sleep 8.54;
#ifndef __TT__
d_kb_logic1 kbTell [_arti_operator,d_kb_topic_side_arti,"ArtilleryExecute",["1","",_aristr,[]],["2","",_ari_type,[]],["3","",str(_ari_salvos),[]],true];
#else
_logic kbTell [_arti_operator,_topicside,"ArtilleryExecute",["1","","Artillery",[]],["2","",_ari_type,[]],["3","",str(_ari_salvos),[]],true];
#endif

_height = 0;
_type = "";
_radius = 30;
_number_shells = 1;

switch (_ari_type) do {
	case "flare": {
		_number_shells = 18;
        _height = 350;
#ifndef __ACE__
		_type = "ARTY_Flare_Medium";
#else
		_type = "ACE_ARTY_Flare_Medium";
#endif
        _radius = 300;
        _arix = getPosASL _ari_target select 0;
        _ariy = getPosASL _ari_target select 1;
		_ang = (_arix - (getPosASL _arti_operator select 0)) atan2 (_ariy - (getPosASL _arti_operator select 1));
        if (abs _ang != _ang) then {angle = _ang + 360};
        _posf = [_arix + _radius * sin(_ang), _ariy + _radius * cos(_ang)];
        _posb = [_arix - _radius * sin(_ang), _ariy - _radius * cos(_ang)];
        _posl = [_arix + _radius * sin(_ang-90), _ariy + _radius * cos(_ang-90)];
        _posr = [_arix + _radius * sin(_ang+90), _ariy + _radius * cos(_ang+90)];
	};
	case "he": {
		_number_shells = 6;
		_height = 150;
#ifndef __ACE__
		_type = if (_side_arti == west) then {"ARTY_Sh_105_HE"} else {"ARTY_Sh_122_HE"};
#else
		_type = if (_side_arti == west) then {"ACE_ARTY_Sh_105_HE"} else {"ACE_ARTY_Sh_122_HE"};
#endif
	};
	case "smoke": {
		_number_shells = 1;
		_height = 1;
#ifndef __ACE__
		_type = "ARTY_SmokeShellWhite";
#else
		_type = "ACE_ARTY_SmokeShellWhite";
#endif
	};
	case "dpicm": {
		_number_shells = 40;
		_height = 150;
		_type = if (_side_arti == west) then {"G_30mm_HE"} else {"G_40mm_HE"};
		_radius = 100;
	};
	case "sadarm": {
		_number_shells = 1;
		_height = 165;
#ifndef __ACE__
		_type = if (_side_arti == west) then {"ARTY_Sh_105_SADARM"} else {"ARTY_Sh_122_SADARM"};
#else
		_type = if (_side_arti == west) then {"ACE_ARTY_Sh_105_SADARM"} else {"ACE_ARTY_Sh_122_SADARM"};
#endif
	};
};

sleep 8 + (random 7);

if (_ari_type != "flare") then {
    _center_x = getPosASL _ari_target select 0;
    _center_y = getPosASL _ari_target select 1;
};

#ifndef __TT__
_arti_distance = FLAG_BASE distance [getPosASL _ari_target select 0,getPosASL _ari_target select 1,0];
#else
_flagb = switch (_num_arti) do {
	case 1: {WFLAG_BASE};
	case 2: {EFLAG_BASE};
};
_arti_distance = _flagb distance [getPosASL _ari_target select 0,getPosASL _ari_target select 1,0];
#endif
_travel_time = (_arti_distance / 500) + 5 + random 3;

_enemy_units = [];

for "_series" from 1 to _ari_salvos do {
	_wp_array = [];
	while {count _wp_array < _number_shells} do {
		if (_ari_type == "flare") then {
			{
				_x1 = (_x select 0) - 20 + random 40;
				_y1 = (_x select 1) - 20 + random 40;
				_wp_array set [count _wp_array, [_x1, _y1, _height + random 10]];
				sleep 0.0153;
			} forEach [_posf, _posb, _posl, _posr];
		} else {
			_angle = floor random 360;
			_x1 = _center_x - ((random _radius) * sin _angle);
			_y1 = _center_y - ((random _radius) * cos _angle);
			_wp_array set [count _wp_array, [_x1, _y1, (if (_ari_type == "he") then {_height + random 50} else {_height})]];
			sleep 0.0153;
		};
	};
#ifndef __TT__
	_kbstr = switch (_num_arti) do {
		case 1: {"ArtilleryFirstOTW"};
		case 2: {"ArtillerySecondOTW"};
	};
	d_kb_logic1 kbTell [_arti_operator,d_kb_topic_side_arti,_kbstr,["1","",str(_series),[]],true];
#else
	_logic kbTell [_arti_operator,_topicside,"ArtilleryOTW",["1","",str(_series),[]],true];
#endif
	
	sleep _travel_time;
	["d_say", [_ari_target, "Ari"]] call XNetCallEvent;
#ifndef __TT__
	_kbstr = switch (_num_arti) do {
		case 1: {"ArtilleryFirstSplash"};
		case 2: {"ArtillerySecondSplash"};
	};
	d_kb_logic1 kbTell [_arti_operator,d_kb_topic_side_arti,_kbstr,["1","",str(_series),[]],true];
#else
	_logic kbTell [_arti_operator,_topicside,"ArtillerySplash",["1","",str(_series),[]],true];
#endif
	
	switch (_ari_type) do {
		case "flare": {
			sleep 1;
			for "_i" from 0 to (_number_shells-1) do {
				_shell = createVehicle [_type, [(_wp_array select _i) select 0, (_wp_array select _i) select 1, (_wp_array select _i) select 2], [], 0, "NONE"];
				if (((_i+1) % 4 == 0) && (_i > 1)) then {sleep 18 + (ceil random 5)} else {sleep 0.5 + random 1.5};
			};
		};
		case "he": {
			_soldier_type = switch (d_enemy_side) do {
				case "EAST": {"SoldierEB"};
				case "WEST": {"SoldierWB"};
				case "GUER": {"SoldierGB"};
			};
			_nos = [getPosASL _ari_target select 0,getPosASL _ari_target select 1,0] nearObjects [_soldier_type, _radius];
			{if (!(_x in _enemy_units)) then {_enemy_units set [count _enemy_units, _x]}} forEach _nos;
#ifndef __ACE__
			_trails = getText (configFile >> "CfgAmmo" >> _type >> "ARTY_TrailFX");
			_netshell = getText (configFile >> "CfgAmmo" >> _type >> "ARTY_NetShell");
#else
			_trails = getText (configFile >> "CfgAmmo" >> _type >> "ACE_ARTY_TrailFX");
			_netshell = getText (configFile >> "CfgAmmo" >> _type >> "ACE_ARTY_NetShell");
#endif
			for "_i" from 0 to (_number_shells - 1) do {
				_shell = createVehicle [_type, (_wp_array select _i), [], 0, "NONE"];
				_shell setVelocity [0,0,-150];
				["d_artyt", [getPosASL _shell, _trails, _netshell]] call XNetCallEvent;
				sleep 0.923 + (random 2);
			};
		};
		case "smoke": {
			for "_i" from 0 to (_number_shells - 1) do {
				_shell = createVehicle [_type, (_wp_array select _i), [], 0, "NONE"];
				_shell setVelocity [0,0,-150];
				_xo = ceil random 10;
				sleep 0.923 + (_xo / 10);
			};
		};
		case "dpicm": {
			_soldier_type = switch (d_enemy_side) do {
				case "EAST": {"SoldierEB"};
				case "WEST": {"SoldierWB"};
				case "GUER": {"SoldierGB"};
			};
			_nos = [getPosASL _ari_target select 0,getPosASL _ari_target select 1,0] nearObjects [_soldier_type, _radius];
			{if (!(_x in _enemy_units)) then {_enemy_units set [count _enemy_units, _x]}} forEach _nos;
			_pos = [(getPosASL _ari_target) select 0, (getPosASL _ari_target) select 1, _height];
			["d_dpicm", _pos] call XNetCallEvent;
			sleep 0.5;
			for "_i" from 0 to (_number_shells - 1) do {
				_shell = createVehicle [_type, (_wp_array select _i), [], 0, "NONE"];
				_shell setVelocity [0,0,-80];
				_xo = ceil random 10;
				sleep 0.223 + (_xo / 10);
			};
			sleep 2.132;
		};
		case "sadarm": {
			for "_i" from 0 to (_number_shells - 1) do {
				_shell = createVehicle [_type, (_wp_array select _i), [], 0, "NONE"];
#ifndef __ACE__
				[_shell] spawn BIS_ARTY_F_SadarmDeploy;
#else
				[_shell] spawn ace_sys_bi_arty_fnc_sadarmDeploy;
#endif
				sleep 0.923 + (random 2);
			};
		};
	};
	_wp_array = nil;

	if (_series < _ari_salvos) then {
#ifndef __TT__
		d_kb_logic1 kbTell [_arti_operator,d_kb_topic_side_arti,"ArtilleryReload",["1","",_aristr,[]],true];
#else
		_logic kbTell [_arti_operator,_topicside,"ArtilleryReload",["1","","Artillery",[]],true];
#endif
		sleep (d_arti_reload_time + random 3);
	};
};

sleep 2;

_arti_operator addScore ({!alive _x} count _enemy_units);
_enemy_units = nil;
sleep 0.5;

#ifndef __TT__
d_kb_logic1 kbTell [_arti_operator,d_kb_topic_side_arti,"ArtilleryComplete",["1","",_aristr,[]],true];
#else
_logic kbTell [_arti_operator,_topicside,"ArtilleryComplete",["1","","Artillery",[]],true];
#endif

#ifndef __TT__
[_ari_salvos, _ari_type, _ari_avail,_aristr] spawn {
#else
[_ari_salvos, _ari_type, _ari_avail,_aristr,_topicside2] spawn {
#endif
	private ["_ari_salvos", "_ari_type", "_ari_avail", "_topicside2"];
	_ari_salvos = _this select 0;
	_ari_type = _this select 1;
	_ari_avail = _this select 2;
	_aristr = _this select 3;
#ifdef __TT__
	_topicside2 = _this select 4;
#endif
	sleep (d_arti_available_time + ((_ari_salvos - 1) * 200)) + (random 60) + (if (d_SidemissionsOnly == 1) then {if (_ari_type == "sadarm") then {180} else {0}} else {300});
	[_ari_avail,true] call XNetSetJIP;
#ifndef __TT__
	["ArtilleryAvailable", _aristr] call XfKBSendMsgAll;
#else
	if (__OAVer) then {
		[_topicside2,"ArtilleryAvailable", "ArtilleryAvailableTransmitTargetLocationOver"] call XfKBSendMsgAll;
	} else {
		[_topicside2,"ArtilleryAvailable", "Artillery"] call XfKBSendMsgAll;
	};
#endif
};
