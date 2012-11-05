// by Xeno
#include "x_setup.sqf"

// setup global chat logic
if (isNil "x_global_chat_logic") then {x_global_chat_logic = "Logic" createVehicleLocal [0,0,0]};

// display a text message over a global logic chat
// parameters: text (without brackets)
// example: "Hello World!" call XfGlobalChat;
XfGlobalChat = {x_global_chat_logic globalChat _this};

// display a text message over side chat
// parameters: unit, text
// example: [player,"Hello World!"] call XfSideChat;
XfSideChat = {(_this select 0) sideChat (_this select 1)};

XfKBSideChat = {player kbTell [d_kb_logic1,"PL" + str(player),"Dummy",["1","",_this,[]],true]};

// display a text message over group chat
// parameters: unit, text
// example: [player,"Hello World!"] call XfGroupChat;
XfGroupChat = {(_this select 0) groupChat (_this select 1)};

// display a text message over vehicle chat
// parameters: vehicle, text
// example: [vehicle player,"Hello World!"] call XfVehicleChat;
XfVehicleChat = {(_this select 0) vehicleChat (_this select 1)};

// display a text message over HQ sidechat (CROSSROAD)
// parameters: text
// example: "Hello World!" call XfHQChat;
XfHQChat = {[playerSide, "HQ"] sideChat _this};

// removes linebreaks from strings (\n or \N)
// parameters: text
// example: "My nice text\n\nHello World" call XfRemoveLineBreak;
XfRemoveLineBreak = {
	private ["_msg", "_msg_chat_a", "_i", "_c"];
	_msg = _this;
	_msg_chat_a = toArray (_msg);
	for "_i" from 0 to (count _msg_chat_a - 2) do {
		_c = _msg_chat_a select _i;
		if (_c == 92) then {
			if ((_msg_chat_a select (_i + 1)) in [78,110]) then {
				_msg_chat_a set [_i, 32];
				__INC(_i);
				_msg_chat_a set [_i, -1];
			};
		};
	};
	_msg_chat_a = _msg_chat_a - [-1];
	toString (_msg_chat_a)
};

// displays a hint and a chat message, \n get removed for the chat text
// parameters: text (with \n for hints), type of chat ("HQ","SIDE","GLOBAL" or "GROUP")
// example: ["My nice text\n\nHello World", "HQ"] call XHintChatMsg;
XHintChatMsg = {	
	private ["_msg", "_type_chat", "_msg_chat"];
	_msg = _this select 0;
	_type_chat = _this select 1;
	hintSilent _msg;
	_msg_chat = _msg call XfRemoveLineBreak;
	
	_type_chat = toUpper _type_chat;
	switch (_type_chat) do {
		case "HQ": {_msg_chat call XfHQChat};
		case "SIDE": {[player,_msg_chat] call XfSideChat};
		case "GLOBAL": {_msg_chat call XfGlobalChat};
		case "GROUP": {[player,_msg_chat] call XfGroupChat};
	};
};

// handles messages  transfered over the network
XfHandleMessage = {
	private ["_msg","_receiver_type","_receiver","_type"];
	_msg = _this select 0;
	_receiver_type = _this select 1; // "unit", "grp", "all","vec"
	_receiver = _this select 2; // only needed for "unit", "grp", "vec", otherwise objNull
	_type = _this select 3; // "global", "vehicle", "side", "group", "hint", "hq"
	switch (_type) do {
		case "global": {
			switch (_receiver_type) do {
				case "unit": {if (!isNull _receiver) then {if (player == _receiver) then {_msg call XfGlobalChat}}};
				case "grp": {if (!isNull _receiver) then {if (player in units _receiver) then {_msg call XfGlobalChat}}};
				case "all": {_msg call XfGlobalChat};
				case "vec": {if (!isNull _receiver) then {if (player in crew _receiver) then {_msg call XfGlobalChat}}};
			};
		};
		case "vehicle": {
			switch (_receiver_type) do {
				case "unit": {if (!isNull _receiver) then {if (player == crew _receiver) then {[_receiver,_msg] call XfVehicleChat}}};
				case "grp": {if (!isNull _receiver) then {if (player in crew _receiver) then {[_receiver,_msg] call XfVehicleChat}}};
				case "vec": {if (!isNull _receiver) then {if (player in crew _receiver) then {[_receiver,_msg] call XfVehicleChat}}};
			};
		};
		case "side": {
			switch (_receiver_type) do {
				case "unit": {if (!isNull _receiver) then {if (player == _receiver) then {[player,_msg] call XfSideChat}}};
				case "grp": {if (!isNull _receiver) then {if (player in units _receiver) then {[player,_msg] call XfSideChat}}};
				case "all": {[player,_msg] call XfSideChat};
				case "vec": {if (!isNull _receiver) then {if (player in crew _receiver) then {[player,_msg] call XfSideChat}}};
			};
		};
		case "group": {
			switch (_receiver_type) do {
				case "unit": {if (!isNull _receiver) then {if (player == _receiver) then {[player,_msg] call XfGroupChat}}};
				case "grp": {if (!isNull _receiver) then {if (player in units _receiver) then {[player,_msg] call XfGroupChat}}};
				case "all": {[player,_msg] call XfGroupChat};
				case "vec": {if (!isNull _receiver) then {if (player in crew _receiver) then {[player,_msg] call XfGroupChat}}};
			};
		};
		case "hint": {
			switch (_receiver_type) do {
				case "unit": {if (!isNull _receiver) then {if (player == _receiver) then {hintSilent _msg}}};
				case "grp": {if (!isNull _receiver) then {if (player in units _receiver) then {hintSilent _msg}}};
				case "all": {hintSilent _msg};
				case "vec": {if (!isNull _receiver) then {if (player in crew _receiver) then {hintSilent _msg}}};
			};
		};
		case "hq": {
			switch (_receiver_type) do {
				case "unit": {if (!isNull _receiver) then {if (player == _receiver) then {_msg call XfHQChat}}};
				case "grp": {if (!isNull _receiver) then {if (player in units _receiver) then {_msg call XfHQChat}}};
				case "all": {_msg call XfHQChat};
				case "vec": {if (!isNull _receiver) then {if (player in crew _receiver) then {_msg call XfHQChat}}};
			};
		};
	};
};

XsFixHeadBug = {
	private ["_dir","_pos","_vehicle", "_posasl"];
	_unit = _this;
	if (vehicle _unit != _unit) exitWith {hintSilent "Not possible in a vehicle..."};
	titleCut ["... Fixing head bug ...","black faded", 0];
	_pos = position _unit;
	if (surfaceIsWater _pos) then {_posasl = getPosASL _unit};
	_dir = direction _unit;
#ifndef __OA__
	_vehicle = "UAZ_RU" createVehicleLocal _pos;
#else
	_vehicle = "UAZ_Unarmed_TK_EP1" createVehicleLocal _pos;
#endif
	if (surfaceIsWater _pos) then {_vehicle setPosASL _posasl};
	_unit moveincargo _vehicle;
	waitUntil {vehicle _unit != _unit};
	unassignVehicle _unit;
	_unit action ["Eject",vehicle _unit];
	waitUntil {vehicle _unit == _unit};
	deleteVehicle _vehicle;
	if (surfaceIsWater _pos) then {_unit setPosASL _posasl} else {_unit setPos _pos};
	_unit setDir _dir;
	titleCut["", "BLACK IN", 2];
};

XTaskHint = {
	private ["_task", "_status", "_params"];
	if (count _this < 2) exitWith {};
	_task = _this select 0;
	_status = _this select 1;

	_params = switch (true) do {
		case (_status == "created"): {[localize "str_taskNew", [1,1,1,1], "taskNew"]};
		case ((_status == "current") || (_status == "assigned")): {[localize "str_taskSetCurrent", [1,1,1,1], "taskCurrent"]};
		case (_status == "succeeded"): {[localize "str_taskAccomplished", [0.600000,0.839215,0.466666,1.000000], "taskDone"]};
		case (_status == "failed"): {[localize "str_taskFailed", [0.972549,0.121568,0.000000,1.000000], "taskFailed"]};
		case (_status == "canceled"): {[localize "str_taskCancelled", [0.750000,0.750000,0.750000,1.000000], "taskFailed"]};
	};

	taskHint [format [(_params select 0) + "\n%1", (taskDescription _task) select 1], (_params select 1), (_params select 2)];
};

XfGetRanJumpPoint = {
	private ["_center", "_radius", "_angle", "_r", "_x1", "_y1"];
	_center = _this select 0;_radius = _this select 1;
	_center_x = _center select 0;_center_y = _center select 1;
	_angle = floor (random 360);
	_r = random _radius;
	if (_r < 50) then {_r = 50};
	_x1 = _center_x - ((random _r) * sin _angle);
	_r = random _radius;
	if (_r < 50) then {_r = 50};
	_y1 = _center_y - ((random _r) * cos _angle);
	[_x1, _y1, 0]
};

XHandleHeal = {
	private ["_healed", "_healer"];
	_healed = _this select 0;
	_healer = _this select 1;
	if (alive _healed && alive _healer) then {
		if (_healed != _healer) then {
			_healer spawn {
				private "_healer";
				_healer = _this;
				sleep 3;
				["d_pas", [_healer, d_ranked_a select 17]] call XNetCallEvent;
				["d_pho", _healer] call XNetCallEvent;
			};
		};
	};
	false
};