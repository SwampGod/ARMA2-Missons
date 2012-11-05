// by Xeno
#include "x_setup.sqf"
private ["_s","_str"];
if (!X_Client) exitWith {};

disableSerialization;

d_still_in_intro = true;

enableRadio false;
showCinemaBorder false;

_dlg = createDialog "X_RscAnimatedLetters";
_XD_display = __uiGetVar(X_ANIM_LETTERS);
_control = _XD_display displayCtrl 66666;
_control ctrlShow false;
_line = 0;
i = 0;

#ifdef __OA__
_arrow_over_head = "Sign_arrow_down_large_EP1" createVehicleLocal [position player select 0, position player select 1, 2.2];
_arrow_over_head setPos [position player select 0, position player select 1, 2.2];
_arrow_over_head spawn {
	private ["_dir", "_arr"];
	_dir = 0;
	_arr = _this;
	while {!isNull _arr} do {
		_arr setDir _dir;
		_dir = _dir + 1;
		if (_dir == 360) then {_dir = 0};
		sleep 0.005;
	};
};
#endif

"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [6];
"dynamicBlur" ppEffectCommit 0;
"dynamicBlur" ppEffectAdjust [0.0];
"dynamicBlur" ppEffectCommit 15;

#ifndef __OA__
playMusic "TheUnit";
#else
playMusic "TheUnit";
#endif

if (daytime > 19.75 || daytime < 4.15) then {camUseNVG true};

#ifndef __TT__
d_intro_color = switch (d_own_side) do {case "WEST": {[0.85,0.88,1,1]};case "EAST": {[1,0.36,0.34,1]};case "GUER": {[1,1,0,1]};};
_camstart = camstart;
#endif
#ifdef __TT__
d_intro_color = if (playerSide == west) then {[0.85,0.88,1,1]} else {[1,0.36,0.34,1]};
_camstart = if (playerSide == west) then {camstart} else {camstart_east};
#endif

_camera = "camera" camCreate [(position _camstart select 0), (position _camstart select 1) + 1, 120];
#ifndef __CARRIER__
_camera camSetTarget [(position player select 0), (position player select 1) , 1.5];
#else
_camera camSetTarget [(position LHD_Center select 0), (position LHD_Center select 1) , 1.5];
#endif
_camera camSetFov 0.7;
_camera cameraEffect ["INTERNAL", "Back"];
_camera camCommit 1;
waitUntil {camCommitted _camera};

#ifndef __TT__
_str = "One Team - " + d_version_string;
_start_pos = 5;
_str2 = "";
if (__ReviveVer) then {if (_str2 != "") then {_str2 = _str2 + " REVIVE"} else {_str2 = _str2 + "REVIVE"}};
if (__ACEVer) then {if (_str2 != "") then {_str2 = _str2 + " ACE"} else {_str2 = _str2 + "ACE"}};
if (d_with_ai) then {if (_str2 != "") then {_str2 = _str2 + " AI"} else {_str2 = _str2 + "AI"}};
if (__RankedVer) then {if (_str2 != "") then {_str2 = _str2 + " RA"} else {_str2 = _str2 + "RA"}};
if (__WoundsVer) then {if (_str2 != "") then {_str2 = _str2 + " WOUNDS"} else {_str2 = _str2 + "WOUNDS"}};
if (__MANDOVer) then {if (_str2 != "") then {_str2 = _str2 + " MANDO"} else {_str2 = _str2 + "MANDO"}};
_sarray = toArray (_str2);
_start_pos2 = switch (count _sarray) do {
	case 2: {11};
	case 3: {11};
	case 4: {10};
	case 5: {10};
	case 6: {9};
	case 7: {9};
	case 8: {8};
	case 9: {8};
	case 10: {8};
	case 11: {7};
	case 12: {6};
	case 13: {5};
	case 14: {5};
	case 15: {4};
	case 16: {3};
	default {1};
};
#else
_str = "Two Teams";
_str2 = "";
_sarray = [];
_start_pos = 8;
#endif

1cutRsc ["XDomLabel","PLAIN",2];
2 cutRsc ["XDomAward","PLAIN",2];
3 cutRsc ["XDomTwo", "PLAIN",2];
4 cutRsc ["XA2Logo","PLAIN",2];
#ifdef __CARRIER__
1365 cutRsc ["XCarrierTitel","PLAIN",2];
#endif
[_start_pos, _str, 5] execVM "IntroAnim\animateLettersX.sqf";__INC(_line); waitUntil {i == _line};
if (count _sarray > 0) then {[_start_pos2, _str2, 6] execVM "IntroAnim\animateLettersX.sqf";__INC(_line); waitUntil {i == _line}};
if (d_SidemissionsOnly == 0) then {
	[4, "Sidemissions Only", 4] execVM "IntroAnim\animateLettersX.sqf";__INC(_line); waitUntil {i == _line};
};

_camera camSetTarget player;
#ifndef __CARRIER__
_camera camSetPos [(position player select 0), (position player select 1) , 2];
#else
_camera camSetPos [(position player select 0), (position player select 1) , 12];
#endif
_camera camCommit 12;

[] spawn {
	private ["_control", "_posdom", "_control2", "_pos", "_oldy"];
	disableSerialization;
	sleep 3;
	_control = __uiGetVar(XDomLabel) displayCtrl 50;
	_posdom = ctrlPosition _control;
	_control ctrlSetPosition [(_posdom select 0) - 0.08, _posdom select 1];
	_control ctrlCommit 0.3;
	waitUntil {ctrlCommitted _control};
	_control2 = __uiGetVar(XDomTwo) displayCtrl 50;
	_pos = ctrlPosition _control2;
	_control2 ctrlSetPosition [0.69, _pos select 1];
	_control2 ctrlCommit 0.5;
	waitUntil {ctrlCommitted _control2};
	0 cutRsc ["D_Lightning1","PLAIN"];
	11 cutRsc ["D_Eyeflare","PLAIN"];
	sleep 0.1;
	playSound "DThunder";
};

sleep 6;
[] spawn {
	private ["_control", "_endtime", "_r", "_a"];
	disableSerialization;
	_control = __uiGetVar(X_ANIM_LETTERS) displayCtrl 66666;
	_control ctrlShow true;
	_endtime = time + 10;
	_r = 0;_a = 0.008;
	while {_endtime > time} do {
		_control ctrlSetTextColor [_r,_r,_r,_r];
		_r = _r + _a;
		if (_r >= 1) then {
			_r = 1;
		} else {
			if (_r < 0) then {_r = 0};
		};
		if (_r == 1) then {
			_a = -0.008;
			sleep 3;
		};
		sleep .01;
	};
	_control ctrlShow false;
};
waitUntil {camCommitted _camera};
#ifdef __OA__
deleteVehicle _arrow_over_head;
#endif
player cameraEffect ["terminate","back"];
camDestroy _camera;
closeDialog 0;

enableRadio true;
"dynamicBlur" ppEffectEnable false;

d_still_in_intro = false;

if (d_reserverd_slot != "") then {
	if (str(player) == d_reserverd_slot) then {
		execVM "x_client\x_reserverdslot.sqf";
	};
};

sleep 5;
#ifndef __OA__
22 cutRsc ["D_SayHello","PLAIN"];
_control = __uiGetVar(D_SayHello) displayCtrl 50;
_control ctrlSetText format ["Welcome to Domination! 2, %1...\n\n                        Have a nice time!", name player];
#else
["Welcome to Domination! 2", name player, "Have a nice time"] spawn BI_fnc_infoText;
#endif
sleep 5;
#ifndef __ACE__
if (!isNil {__pGetVar(d_p_ev_hd)}) then {d_phd_invulnerable = false};
#else
player setVariable ["ace_w_allow_dam", nil];
#endif