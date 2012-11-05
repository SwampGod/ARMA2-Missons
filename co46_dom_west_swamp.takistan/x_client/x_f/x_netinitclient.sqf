#include "x_setup.sqf"

Xd_create_boxNet = {
	private "_box";
	_box = objNull;
	if (!AmmoBoxHandling) then {
		_box = d_the_box createVehicleLocal (_this select 0);
		_box setPos (_this select 0);
	} else {
		_box = d_the_box createVehicleLocal (_this select 1);
		_box setPos (_this select 1);
	};
	waitUntil {!isNull _box};
	player reveal _box;
#ifndef __REVIVE__
	_box addAction ["Save gear layout" call XBlueText, "x_client\x_savelayout.sqf"];
	_box addAction ["Clear gear layout" call XBlueText, "x_client\x_clearlayout.sqf"];
#endif
	_box addEventHandler ["killed",{["d_r_box", position _this select 0] call XNetCallEvent}];
	[_box] call x_weaponcargo;
};

#ifndef __TT__
Xd_jet_service_facNet = {
	if (__XJIPGetVar(d_jet_serviceH)) then {
		private ["_element", "_pos", "_dir", "_fac"];
		if (d_string_player in d_is_engineer || d_with_ai) then {[0] spawn XFacAction};
		_element = d_aircraft_facs select 0;
		_pos = _element select 0;
		_dir = _element select 1;
		_fclass = if (__OAVer) then {"Land_vez_ruins"} else {"Land_budova2_ruins"};
		_fac = _fclass createVehicleLocal _pos;
		_fac setPos _pos;
		_fac setDir _dir;
	};
};

Xd_chopper_service_facNet = {
	if (__XJIPGetVar(d_chopper_serviceH)) then {
		private ["_element", "_pos", "_dir", "_fac"];
		if (d_string_player in d_is_engineer || d_with_ai) then {[1] spawn XFacAction};
		_element = d_aircraft_facs select 1;
		_pos = _element select 0;
		_dir = _element select 1;
		_fclass = if (__OAVer) then {"Land_vez_ruins"} else {"Land_budova2_ruins"};
		_fac = _fclass createVehicleLocal _pos;
		_fac setPos _pos;
		_fac setDir _dir;
	};
};

Xd_wreck_repair_facNet = {
	if (__XJIPGetVar(d_wreck_repairH)) then {
		private ["_element", "_pos", "_dir", "_fac"];
		if (d_string_player in d_is_engineer || d_with_ai) then {[2] spawn XFacAction};
		_element = d_aircraft_facs select 2;
		_pos = _element select 0;
		_dir = _element select 1;
		_fclass = if (__OAVer) then {"Land_vez_ruins"} else {"Land_budova2_ruins"};
		_fac = _fclass createVehicleLocal _pos;
		_fac setPos _pos;
		_fac setDir _dir;
	};
};
#endif

Xd_ataxiNet = {
	if (player == (_this select 1)) then {
		switch (_this select 0) do {
			case 0: {"Air taxi is on the way... hold your position!!!" call XfHQChat};
			case 1: {"Air taxi canceled, you've died !!!" call XfHQChat;d_heli_taxi_available = true};
			case 2: {"Air taxi damaged or destroyed !!!" call XfHQChat;d_heli_taxi_available = true};
			case 3: {"Air taxi heading to base in a few seconds !!!" call XfHQChat};
			case 4: {"Air taxi leaving now, have a nice day !!!" call XfHQChat;d_heli_taxi_available = true};
			case 5: {"Air taxi starts now !!!" call XfHQChat};
			case 6: {"Air taxi allmost there, hang on..." call XfHQChat};
		};
	};
};

#ifdef __TT__
Xattention = {[format ["%1 reconnected as %3 team member.\nHe played for the %2 team before, attention!!!", _this select 0, str(_this select 1), str(_this select 2)], "GLOBAL"] call XHintChatMsg};
#endif

Xfd_player_stuff = {
	private "_prev_side";
	d_player_autokick_time = _this select 0;
#ifdef __TT__
	_prev_side = _this select 5;
	if (_prev_side != sideUnknown) then {
		if (playerSide != _prev_side) then {
			["d_attention", [name player, _prev_side, playerSide]] call XNetCallEvent;
		};
	};
#endif
	"d_p_ar" call XNetRemoveEvent; // remove event, no longer needed on this client
};

Xd_dropansw = {
	if (player == (_this select 1)) then {
		switch (_this select 0) do {
#ifdef __OA__
			case 0: {"Roger. The drop plane will start in a few moments!!!" call XfHQChat};
#else
			case 0: {"Roger. The chopper will start in a few moments!!!" call XfHQChat};
#endif
			case 1: {"Air drop is on the way... it will take some time!!!" call XfHQChat};
			case 2: {"Air drop allmost there, stand by!!!" call XfHQChat};
			case 3: {"Air drop vehicle damaged or destroyed !!!" call XfHQChat};
			case 4: {"Air cargo dropped!!!" call XfHQChat};
		};
	};
};

Xd_mhqdeplNet = {
	private ["_mhq", "_isdeployed", "_name", "_vside"];
	_mhq = _this select 0;
	_isdeployed = _this select 1;
	_name = _mhq getVariable "d_vec_name";
	if (isNil "_name") exitWith {};
#ifdef __TT__
	_vside = _mhq getVariable "d_side";
	if (isNil "_vside") exitWith {};
	if (playerSide != _vside) exitWith {};
#endif
	_m = _mhq getVariable "d_marker";
	if (_isdeployed) then {
		(format ["%1 deployed", _name]) call XfHQChat;
		if (!isNil "_m") then {_m setMarkerTextLocal ((_mhq getVariable "d_marker_text") + " (Deployed)")};
	} else {
		(format ["%1 undeployed", _name]) call XfHQChat;
		if (!isNil "_m") then {_m setMarkerTextLocal (_mhq getVariable "d_marker_text")};
	};
};

#ifndef __TT__
Xd_intel_updNet = {
	switch (_this select 0) do {
		case 0: {
			format ["%1 has found new intel. We have learned the codename for enemy saboteurs, and can provide information when they are launching a saboteur attack on the base.", _this select 1] call XfHQChat
		};
		case 1: {
			format ["%1 has found new intel. We have learned the enemy codename for airdrop, and can provide early warning whenever the enemy sends airdropped troops to the main target.", _this select 1] call XfHQChat
		};
		case 2: {
			format ["%1 has found new intel. We have learned the enemy codename for attack plane, and can provide early warning whenever the enemy sends an attack plane to the main target.", _this select 1] call XfHQChat
		};
		case 3: {
			format ["%1 has found new intel. Intel will now be given whenever the enemy sends an attack helicopter to support the main target.", _this select 1] call XfHQChat
		};
		case 4: {
			format ["%1 has found new intel. We have learned the enemy codename for transport chopper, and can provide early warning whenever the enemy sends a transport chopper to support the main target.", _this select 1] call XfHQChat
		};
		case 5: {
			format ["%1 has found new intel. We can now provide grid information on where the enemy is calling in artillery support.", _this select 1] call XfHQChat
		};
		case 6: {
			format ["%1 has found new intel. We are now able to track enemy vehicle patrols, but we don't know their configuration. Check the map.", _this select 1] call XfHQChat
		};
	};
};
#endif