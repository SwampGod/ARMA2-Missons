//#define __DEBUG__
#define THIS_FILE "x_netinitclient.sqf"
#include "x_setup.sqf"

FUNC(create_boxNet) = {
	private "_box";
	_box = objNull;
	if (!GVAR(AmmoBoxHandling)) then {
		_box = GVAR(the_box) createVehicleLocal (_this select 0);
		_box setPos (_this select 0);
	} else {
		_box = GVAR(the_box) createVehicleLocal (_this select 1);
		_box setPos (_this select 1);
	};
	player reveal _box;
	_box addAction ["Save gear layout" call FUNC(BlueText), "x_client\x_savelayout.sqf"];
	_box addAction ["Clear gear layout" call FUNC(BlueText), "x_client\x_clearlayout.sqf"];
	_box addEventHandler ["killed",{[QGVAR(r_box), position (_this select 0)] call FUNC(NetCallEvent)}];
	[_box] call FUNC(weaponcargo);
};

#ifndef __TT__
FUNC(jet_service_facNet) = {
	if (__XJIPGetVar(GVAR(jet_serviceH))) then {
		private ["_element", "_pos", "_dir", "_fac"];
		if (GVAR(string_player) in GVAR(is_engineer) || GVAR(with_ai) || GVAR(with_ai_features) == 0) then {[0] spawn FUNC(XFacAction)};
		_element = GVAR(aircraft_facs) select 0;
		_pos = _element select 0;
		_dir = _element select 1;
		_fclass = switch (true) do {
			case (__OAVer): {"Land_vez_ruins"};
			case (__COVer): {"Land_budova2_ruins"};
		};
		_fac = _fclass createVehicleLocal _pos;
		_fac setDir _dir;
		_fac setPos _pos;
	};
};

FUNC(chopper_service_facNet) = {
	if (__XJIPGetVar(GVAR(chopper_serviceH))) then {
		private ["_element", "_pos", "_dir", "_fac"];
		if (GVAR(string_player) in GVAR(is_engineer) || GVAR(with_ai)|| GVAR(with_ai_features) == 0) then {[1] spawn FUNC(XFacAction)};
		_element = GVAR(aircraft_facs) select 1;
		_pos = _element select 0;
		_dir = _element select 1;
		_fclass = switch (true) do {
			case (__OAVer): {"Land_vez_ruins"};
			case (__COVer): {"Land_budova2_ruins"};
		};
		_fac = _fclass createVehicleLocal _pos;
		_fac setDir _dir;
		_fac setPos _pos;
	};
};

FUNC(wreck_repair_facNet) = {
	if (__XJIPGetVar(GVAR(wreck_repairH))) then {
		private ["_element", "_pos", "_dir", "_fac"];
		if (GVAR(string_player) in GVAR(is_engineer) || GVAR(with_ai) || GVAR(with_ai_features) == 0) then {[2] spawn FUNC(XFacAction)};
		_element = GVAR(aircraft_facs) select 2;
		_pos = _element select 0;
		_dir = _element select 1;
		_fclass = switch (true) do {
			case (__OAVer): {"Land_vez_ruins"};
			case (__COVer): {"Land_budova2_ruins"};
		};
		_fac = _fclass createVehicleLocal _pos;
		_fac setDir _dir;
		_fac setPos _pos;
	};
};
#endif

FUNC(ataxiNet) = {
	if (player == (_this select 1)) then {
		switch (_this select 0) do {
			case 0: {"Air taxi is on the way... hold your position!!!" call FUNC(HQChat)};
			case 1: {"Air taxi canceled, you've died !!!" call FUNC(HQChat);GVAR(heli_taxi_available) = true};
			case 2: {"Air taxi damaged or destroyed !!!" call FUNC(HQChat);GVAR(heli_taxi_available) = true};
			case 3: {"Air taxi heading to base in a few seconds !!!" call FUNC(HQChat)};
			case 4: {"Air taxi leaving now, have a nice day !!!" call FUNC(HQChat);GVAR(heli_taxi_available) = true};
			case 5: {"Air taxi starts now !!!" call FUNC(HQChat)};
			case 6: {"Air taxi allmost there, hang on..." call FUNC(HQChat)};
		};
	};
};

#ifdef __TT__
FUNC(dattention) = {[format ["%1 reconnected as %3 team member.\nHe played for the %2 team before, attention!!!", _this select 0, str(_this select 1), str(_this select 2)], "GLOBAL"] call FUNC(HintChatMsg)};
#endif

FUNC(player_stuff) = {
	__TRACE_1("player_stuff","_this");
	GVAR(player_autokick_time) = _this select 0;
#ifdef __TT__
	private "_prev_side";
	_prev_side = _this select 5;
	if (_prev_side != sideUnknown) then {
		if (GVAR(player_side) != _prev_side) then {
			[QGVAR(attention), [GVAR(name_pl), _prev_side, GVAR(player_side)]] call FUNC(NetCallEvent);
		};
	};
#endif
	QGVAR(p_ar) call FUNC(NetRemoveEvent); // remove event, no longer needed on this client
	
	if (GVAR(WithRevive) == 0) then {
		if ((_this select 8) == -1 && xr_max_lives != -1) then {
			0 spawn {
				waitUntil {!GVAR(still_in_intro)};
				__TRACE("player_stuff, calling park_player");
				[false] spawn xr_fnc_park_player;
			};
		};
	};
};

FUNC(dropansw) = {
	if (player == (_this select 1)) then {
		switch (_this select 0) do {
			case 0: {"Roger. The drop aircraft will start in a few moments!!!" call FUNC(HQChat)};
			case 1: {"Air drop is on the way... it will take some time!!!" call FUNC(HQChat)};
			case 2: {"Air drop allmost there, stand by!!!" call FUNC(HQChat)};
			case 3: {"Air drop vehicle damaged or destroyed !!!" call FUNC(HQChat)};
			case 4: {"Air cargo dropped!!!" call FUNC(HQChat)};
		};
	};
};

FUNC(mhqdeplNet) = {
	private ["_mhq", "_isdeployed", "_name", "_vside"];
	PARAMS_2(_mhq,_isdeployed);
	_name = GV(_mhq,GVAR(vec_name));
	if (isNil "_name") exitWith {};
#ifdef __TT__
	_vside = GV(_mhq,GVAR(side));
	if (isNil "_vside") exitWith {};
	if (GVAR(player_side) != _vside) exitWith {};
#endif
	_m = GV(_mhq,GVAR(marker));
	if (_isdeployed) then {
		(_name + " deployed") call FUNC(HQChat);
		if (!isNil "_m") then {_m setMarkerTextLocal ((GV(_mhq,GVAR(marker_text))) + " (Deployed)")};
	} else {
		(_name + " undeployed") call FUNC(HQChat);
		if (!isNil "_m") then {_m setMarkerTextLocal (GV(_mhq,GVAR(marker_text)))};
	};
};

#ifndef __TT__
FUNC(intel_updNet) = {
	switch (_this select 0) do {
		case 0: {
			format ["%1 has found new intel. We have learned the codename for enemy saboteurs, and can provide information when they are launching a saboteur attack on the base.", _this select 1] call FUNC(HQChat)
		};
		case 1: {
			format ["%1 has found new intel. We have learned the enemy codename for airdrop, and can provide early warning whenever the enemy sends airdropped troops to the main target.", _this select 1] call FUNC(HQChat)
		};
		case 2: {
			format ["%1 has found new intel. We have learned the enemy codename for attack plane, and can provide early warning whenever the enemy sends an attack plane to the main target.", _this select 1] call FUNC(HQChat)
		};
		case 3: {
			format ["%1 has found new intel. Intel will now be given whenever the enemy sends an attack helicopter to support the main target.", _this select 1] call FUNC(HQChat)
		};
		case 4: {
			format ["%1 has found new intel. We have learned the enemy codename for transport aircraft, and can provide early warning whenever the enemy sends a transport aircraft to support the main target.", _this select 1] call FUNC(HQChat)
		};
		case 5: {
			format ["%1 has found new intel. We can now provide grid information on where the enemy is calling in artillery support.", _this select 1] call FUNC(HQChat)
		};
		case 6: {
			format ["%1 has found new intel. We are now able to track enemy vehicle patrols, but we don't know their configuration. Check the map.", _this select 1] call FUNC(HQChat)
		};
	};
};
#endif