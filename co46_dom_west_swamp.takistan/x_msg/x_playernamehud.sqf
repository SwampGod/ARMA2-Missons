// by Xeno
#include "x_setup.sqf"
private ["_display", "_groupcolor", "_othercolor", "_units", "_index", "_control", "_targetPos", "_position", "_col"];

if (!local player) exitwith {};

#define IDCPLAYER 5200

disableSerialization;

x_pm_received_ar = [];
x_pm_send_ar = [];
x_pm_add_ar = [];
x_player_name = name player;
x_pm_send_ar_update = false;

XSendMsgSysMsg = {
	private "_xctrl";
	disableSerialization;
	_xx_display = __uiGetVar(XD_MsgDialog);
	_xctrl = _xx_display displayCtrl 1010;
	if (ctrlText (_xx_display displayCtrl 1201) != "") then {
		if (x_player_name != ctrlText _xctrl) then {
			["x_msg_net", [ctrlText _xctrl,x_player_name,ctrlText (_xx_display displayCtrl 1201)]] call XNetCallEvent;
			("Message sent to: " + ctrlText _xctrl) call XfGlobalChat;
		} else {
			"Message stored" call XfGlobalChat;
		};
		_one_ele = [ctrlText _xctrl, ctrlText (_xx_display displayCtrl 1201), date];
		x_pm_send_ar = [x_pm_send_ar, [_one_ele], 0] call X_fnc_arrayInsert;
		x_pm_send_ar_update = true;
	} else {
		"NO TEXT TO SENT OR STORE" call XfGlobalChat
	};
};

[2, "x_msg_net", {if (x_player_name == _this select 0) then {x_pm_add_ar set [count x_pm_add_ar, [_this select 1, _this select 2, date]];playSound "IncomingChallenge";(format ["You have received a message from %1.", _this select 1]) call XfGlobalChat}}] call XNetAddEvent;

if (isNil "d_blockspacebarscanning") then {d_blockspacebarscanning = 1};
if (d_BlockSpacebarScanning == 0) then {
	X_KeyboardHandlerKeyDown = {if ((_this select 1) == 57) then {true} else {false}};
	waitUntil {!isNull (findDisplay 46)};
	(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call X_KeyboardHandlerKeyDown"];
};

if (d_show_playernames == 0) exitWith {
	x_show_pname_hud = false;
	d_show_player_namesx = 0;
};

5 cutrsc["PlayerNameHud","PLAIN"];

_groupcolor = [0.7,0.7,0,1];
_othercolor = [0.2,0.2,1,1];

if (isNil "x_show_pname_hud") then {
	x_show_pname_hud = if (cadetmode) then {false} else {true};
	d_show_player_namesx = if (x_show_pname_hud) then {1} else {0};
};
if (isNil "d_show_player_namesx") then {d_show_player_namesx = 0};

sleep 10;

#ifndef __TT__
waitUntil {!isNil "d_player_entities"};
_units = d_player_entities;
waitUntil {!isNil {d_misc_store getVariable (d_player_entities select ((count d_player_entities) - 1))}};
#else
waitUntil {!isNil "d_entities_tt"};
_units = d_entities_tt;
waitUntil {!isNil {d_misc_store getVariable (d_entities_tt select ((count d_entities_tt) - 1))}};
#endif
while {true} do {
	if (x_show_pname_hud && !visibleMap) then {
		{
			_u = missionNamespace getVariable _x;
			if (!isNil "_u") then {
				if (!isNull _u && _u != player && alive player && alive _u && player distance _u <= 50) then {
					_ua = d_misc_store getVariable _x;
					_index = _ua select 0;
					_control = __uiGetVar(X_PHUD) displayCtrl (IDCPLAYER + _index);
					if (isNil "_control") exitWith {};
					if (!surfaceiswater (position _u)) then {
						_targetPos = getPosATL _u;
						_targetPos set [2 , (_targetPos select 2) + 1.9];
					} else {
						_targetPos = getPosASL _u;
						_targetPos set [2 , (_targetPos select 2) + 1.2];
					};

					_position = worldToScreen _targetPos;

					if ((count _position) != 0) then {
						_control ctrlShow true;
						_control ctrlSetPosition _position;
						private "_tex";
						_tex = switch (d_show_player_namesx) do {
							case 1: {name _u};
							case 2: {_ua select 1};
							case 3: {str(9 - round(9 * damage _u))};
							default {"Error"};
						};
						if (isNil "_tex") then {_tex = "Error"};
						_control ctrlSetText _tex;
#ifndef __TT__
						_col = if (group _u == group player) then {_groupcolor} else {_othercolor};
						_control ctrlSetTextColor _col;
#else
						_control ctrlSetTextColor _groupcolor;
#endif
					} else {
						_control ctrlShow false;
					};
					_control ctrlCommit 0;
					waituntil {ctrlCommitted _control};
				} else {
					_ua = d_misc_store getVariable _x;
					if (!isNil "_ua") then {
						_index = _ua select 0;
						_control = __uiGetVar(X_PHUD) displayCtrl (IDCPLAYER + _index);
						if (isNil "_control") exitWith {};
						_control ctrlShow false;
						_control ctrlCommit 0;
						waituntil {ctrlCommitted _control};
					};
				};
			} else {
				_ua = d_misc_store getVariable _x;
				if (!isNil "_ua") then {
					_index = _ua select 0;
					_control = __uiGetVar(X_PHUD) displayCtrl (IDCPLAYER + _index);
					if (isNil "_control") exitWith {};
					_control ctrlShow false;
					_control ctrlCommit 0;
					waituntil {ctrlCommitted _control};
				};
			};
		} foreach _units;
	};
	sleep 0.01;
	
	if (!x_show_pname_hud || visibleMap) then {
		{
			_ua = d_misc_store getVariable _x;
			if (!isNil "_ua") then {
				_index = _ua select 0;
				_control = __uiGetVar(X_PHUD) displayCtrl (IDCPLAYER + _index);
				_control ctrlShow false;
				_control ctrlCommit 0;
				waituntil {ctrlCommitted _control};
			};
		} foreach _units;
		waituntil {sleep 0.23;x_show_pname_hud};
	};
};