#include "x_setup.sqf"

if (d_string_player in d_is_engineer || d_with_ai) then {
	#ifndef __ACE__
	x_sfunc = {
		private ["_objs"];
		if ((vehicle player) == player)then{_objs = nearestObjects [player,["LandVehicle","Air"],5];if (count _objs > 0) then {d_objectID2 = _objs select 0;if (alive d_objectID2) then {if(damage d_objectID2 > 0.05 || fuel d_objectID2<1)then{true}else{false}}else{false}}}else{false};
	};
	#else
	x_sfunc = {
		private ["_objs"];
		if ((vehicle player) == player && player call ace_sys_ruck_fnc_hasRuck)then{_objs = nearestObjects [player,["LandVehicle","Air"],5];if (count _objs > 0) then {d_objectID2 = _objs select 0;if (alive d_objectID2) then {if(damage d_objectID2 > 0.05 || fuel d_objectID2<1)then{true}else{false}}else{false}}}else{false};
	};
	#endif
	x_ffunc = {
		private ["_l","_vUp","_winkel"];
		if ((vehicle player) == player) then {d_objectID1=(position player nearestObject "LandVehicle");if (!alive d_objectID1 || player distance d_objectID1 > 8)then{false}else{_vUp=vectorUp d_objectID1;if((_vUp select 2) < 0 && player distance (position player nearestObject d_rep_truck) < 20)then{true}else{_l=sqrt((_vUp select 0)^2+(_vUp select 1)^2);if(_l != 0)then{_winkel=(_vUp select 2) atan2 _l;if(_winkel < 30 && player distance (position player nearestObject d_rep_truck) < 20)then{true}else{false}}}}} else {false}
	};
};

if (!(__ACEVer) && !(__OAVer)) then {
	XIncomingMissile = {
		private ["_vehicle", "_ammo", "_who", "_missile", "_flare", "_flares"];
		_vehicle = _this select 0;
		if (!isEngineOn _vehicle || isNull (driver _vehicle) || !alive _vehicle) exitWith {};
		_ammo = _this select 1;
		_who = _this select 2;

		_missile = nearestObject [_who,_ammo];

		if (isNull _missile) exitWith {};
		
		[_vehicle, "Dropping Flares..."] call XfVehicleChat;
		["d_flav", _vehicle] call XNetCallEvent;

		if ((random 100) >= 40) then {
			waitUntil {(_missile distance _vehicle) <= 170};
			deletevehicle _missile;
		} else {
			waitUntil {(_missile distance _vehicle) <= 100};
			[_vehicle, "!!! Attention !!! Missile impact..."] call XfVehicleChat;
		};
	};
};

if (d_string_player in d_is_medic) then {
	XMashKilled = {
		private ["_mash","_m_name"];
		_mash = _this select 0;
		_m_name = format ["Mash %1", str(player)];
		deleteMarker _m_name;
		__pSetVar ["d_medtent", []];
		"Your mash was destroyed !!!" call XfGlobalChat;
		if (!isNull _mash) then {deleteVehicle _mash};
		["d_p_o_r", str(player)] call XNetCallEvent;
		__pSetVar ["medic_tent", objNull];
	};
};

if (d_string_player in d_can_use_mgnests) then {
	XMGnestKilled = {
		private ["_mgnest","_m_name"];
		_mgnest = _this select 0;
		_m_name = format ["MG Nest %1", str(player)];
		["d_w_ma",_m_name] call XNetCallEvent;
		__pSetVar ["d_mgnest_pos", []];
		"Your MG nest was destroyed !!!" call XfGlobalChat;
		if (!isNull _mgnest) then {deleteVehicle _mgnest};
		["d_p_o_r", str(player)] call XNetCallEvent;
		__pSetVar ["mg_nest", objNull];
	};
};

if (d_string_player in d_is_engineer) then {
	XFarpKilled = {
		private ["_farp","_m_name"];
		_farp = _this select 0;
		_m_name = format ["FARP %1", str(player)];
		["d_w_ma",_m_name] call XNetCallEvent;
		__pSetVar ["d_farp_pos", []];
		"Your FARP was destroyed !!!" call XfGlobalChat;
		_farpsar = __XJIPGetVar(d_farps); 
		_farpsar = _farpsar - [_farp];
		__XJIPSetVar ["d_farps", _farpsar, true];
		if (!isNull _farp) then {deleteVehicle _farp};
		["d_p_o_r", str(player)] call XNetCallEvent;
		__pSetVar ["d_farp_obj", objNull];
	};
};

XfPlacedObjAn = {
	if (str(player) == _this) then {
		if (d_player_is_medic) then {
			_m_name = format ["Mash %1", _this];
			["d_w_ma",_m_name] call XNetCallEvent;
			__pSetVar ["d_medtent", []];
			_medic_tent = __pGetVar(medic_tent);
			if (!isNil "_medic_tent") then {if (!isNull _medic_tent) then {deleteVehicle _medic_tent}};
			__pSetVar ["medic_tent", objNull];
			"Your mash was destroyed !!!" call XfGlobalChat;
		};
		if (d_player_can_build_mgnest) then {
			_m_name = format ["MG Nest %1", _this];
			["d_w_ma",_m_name] call XNetCallEvent;
			__pSetVar ["d_mgnest_pos", []];
			_mg_nest = __pGetVar(mg_nest);
			if (!isNil "_mg_nest") then {if (!isNull _mg_nest) then {deleteVehicle _mg_nest}};
			__pSetVar ["mg_nest", objNull];
			"Your MG nest was destroyed !!!" call XfGlobalChat;
		};
		if (d_eng_can_repfuel) then {
			_m_name = format ["FARP %1", _this];
			["d_w_ma",_m_name] call XNetCallEvent;
			__pSetVar ["d_farp_pos", []];
			_farp = __pGetVar(d_farp_obj);
			if (!isNil "_farp") then {if (!isNull _farp) then {deleteVehicle _farp}};
			__pSetVar ["d_farp_obj", objNull];
			"Your FARP was destroyed !!!" call XfGlobalChat;
		};
	};
};
#ifndef __TT__
XRecapturedUpdate = {
	private ["_index","_target_array", "_target_name", "_targetName","_state"];
	_index = _this select 0;_state = _this select 1;
	_target_array = d_target_names select _index;
	_target_name = _target_array select 1;
	switch (_state) do {
		case 0: {
			_target_name setMarkerColorLocal "ColorRed";
			_target_name setMarkerBrushLocal "FDiagonal";
			hint composeText[
				parseText("<t color='#f0ff0000' size='2'>" + "Attention:" + "</t>"), lineBreak,
				parseText("<t size='1'>" + format ["Enemy mobile forces have recaptured %1!!!", _target_name] + "</t>")
			];
			format ["Attention!!! Enemy mobile forces have recaptured %1!!!", _target_name] call XfHQChat;
		};
		case 1: {
			_target_name setMarkerColorLocal "ColorGreen";
			_target_name setMarkerBrushLocal "Solid";
			hint composeText[
				parseText("<t color='#f00000ff' size='2'>" + "Good work!" + "</t>"), lineBreak,
				parseText("<t size='1'>" + format ["You have captured %1 again!!!", _target_name] + "</t>")
			];
		};
	};
};
#endif
XPlayerRank = {
	private ["_score","_d_player_old_score","_d_player_old_rank"];
	_score = score player;
	_d_player_old_score = __pGetVar(d_player_old_score);
	if (isNil "_d_player_old_score") then {_d_player_old_score = 0};
	_d_player_old_rank = __pGetVar(d_player_old_rank);
	if (isNil "_d_player_old_rank") then {_d_player_old_rank = "PRIVATE"};
	if (_score < (d_points_needed select 0) && _d_player_old_rank != "PRIVATE") exitWith {
		if (_d_player_old_score >= (d_points_needed select 0)) then {(format ["You were degraded from %1 to Private !!!",_d_player_old_rank]) call XfHQChat};
		_d_player_old_rank = "PRIVATE";
		player setRank _d_player_old_rank;
		__pSetVar ["d_player_old_rank", _d_player_old_rank];
		__pSetVar ["d_player_old_score", _score];
	};
	if (_score < (d_points_needed select 1) && _score >= (d_points_needed select 0) && _d_player_old_rank != "CORPORAL") exitWith {
		if (_d_player_old_score < (d_points_needed select 1)) then {
			"You were promoted to Corporal, congratulations !!!" call XfHQChat;
			playSound "fanfare";
		} else {
			(format ["You were degraded from %1 to Corporal !!!",_d_player_old_rank]) call XfHQChat;
		};
		_d_player_old_rank = "CORPORAL";
		player setRank _d_player_old_rank;
		__pSetVar ["d_player_old_score", _score];
		__pSetVar ["d_player_old_rank", _d_player_old_rank];
	};
	if (_score < (d_points_needed select 2) && _score >= (d_points_needed select 1) && _d_player_old_rank != "SERGEANT") exitWith {
		if (_d_player_old_score < (d_points_needed select 2)) then {
			"You were promoted to Sergeant, congratulations !!!" call XfHQChat;
			playSound "fanfare";
		} else {
			(format ["You were degraded from %1 to Sergeant !!!",_d_player_old_rank]) call XfHQChat;
		};
		_d_player_old_rank = "SERGEANT";
		player setRank _d_player_old_rank;
		__pSetVar ["d_player_old_score", _score];
		__pSetVar ["d_player_old_rank", _d_player_old_rank];
	};
	if (_score < (d_points_needed select 3) && _score >= (d_points_needed select 2) && _d_player_old_rank != "LIEUTENANT") exitWith {
		if (_d_player_old_score < (d_points_needed select 3)) then {
			"You were promoted to Lieutenant, congratulations !!!" call XfHQChat;
			playSound "fanfare";
		} else {
			(format ["You were degraded from %1 to Lieutenant !!!",_d_player_old_rank]) call XfHQChat;
		};
		_d_player_old_rank = "LIEUTENANT";
		player setRank _d_player_old_rank;
		__pSetVar ["d_player_old_score", _score];
		__pSetVar ["d_player_old_rank", _d_player_old_rank];
	};
	if (_score < (d_points_needed select 4) && _score >= (d_points_needed select 3) && _d_player_old_rank != "CAPTAIN") exitWith {
		if (_d_player_old_score < (d_points_needed select 4)) then {
			"You were promoted to Captain, congratulations !!!" call XfHQChat;
			playSound "fanfare";
		} else {
			(format ["You were degraded from %1 to Captain !!!",_d_player_old_rank]) call XfHQChat;
		};
		_d_player_old_rank = "CAPTAIN";
		player setRank _d_player_old_rank;
		__pSetVar ["d_player_old_score", _score];
		__pSetVar ["d_player_old_rank", _d_player_old_rank];
	};
	if (_score < (d_points_needed select 5) && _score >= (d_points_needed select 4) && _d_player_old_rank != "MAJOR") exitWith {		
		if (_d_player_old_score < (d_points_needed select 4)) then {
			"You were promoted to Major, congratulations !!!" call XfHQChat;
			playSound "fanfare";
		} else {
			(format ["You were degraded from %1 to Major !!!",_d_player_old_rank]) call XfHQChat;
		};
		_d_player_old_rank = "MAJOR";
		player setRank _d_player_old_rank;
		__pSetVar ["d_player_old_score", _score];
		__pSetVar ["d_player_old_rank", _d_player_old_rank];
	};
	if (_score >= (d_points_needed select 5) && _d_player_old_rank != "COLONEL") exitWith {
		_d_player_old_rank = "COLONEL";
		player setRank _d_player_old_rank;
		"You were promoted to Colonel, congratulations !!!" call XfHQChat;
		playSound "fanfare";
		__pSetVar ["d_player_old_score", _score];
		__pSetVar ["d_player_old_rank", _d_player_old_rank];
	};
};

XGetRankIndex = {["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"] find (toUpper (_this))};

XGetRankString = {
	switch (toUpper(_this)) do {
		case "PRIVATE": {"Private"};
		case "CORPORAL": {"Corporal"};
		case "SERGEANT": {"Sergeant"};
		case "LIEUTENANT": {"Lieutenant"};
		case "CAPTAIN": {"Captain"};
		case "MAJOR": {"Major"};
		case "COLONEL": {"Colonel"};
	}
};

XGetRankFromScore = {
	if (_this < (d_points_needed select 0)) exitWith {"Private"};
	if (_this < (d_points_needed select 1)) exitWith {"Corporal"};
	if (_this < (d_points_needed select 2)) exitWith {"Sergeant"};
	if (_this < (d_points_needed select 3)) exitWith {"Lieutenant"};
	if (_this < (d_points_needed select 4)) exitWith {"Captain"};
	if (_this < (d_points_needed select 5)) then {"Major"} else {"Colonel"}
};

XGetRankPic = {
	switch (toUpper(_this)) do {
		case "PRIVATE": {"\CA\warfare2\Images\rank_private.paa"};
		case "CORPORAL": {"\CA\warfare2\Images\rank_corporal.paa"};
		case "SERGEANT": {"\CA\warfare2\Images\rank_sergeant.paa"};
		case "LIEUTENANT": {"\CA\warfare2\Images\rank_lieutenant.paa"};
		case "CAPTAIN": {"\CA\warfare2\Images\rank_captain.paa"};
		case "MAJOR": {"\CA\warfare2\Images\rank_major.paa"};
		case "COLONEL": {"\CA\warfare2\Images\rank_colonel.paa"};
	}
};

#ifndef __TT__
if (isNil "d_with_carrier") then {
	XBaseEnemies = {
		private "_status";
		_status = _this select 0;
		switch (_status) do {
			case 0: {
				hint composeText[
					parseText("<t color='#f0ff0000' size='2'>" + "DANGER:" + "</t>"), lineBreak,
					parseText("<t size='1'>" + "Enemy troops in your base." + "</t>")
				];
			};
			case 1: {
				hint composeText[
					parseText("<t color='#f00000ff' size='2'>" + "CLEAR:" + "</t>"), lineBreak,
					parseText("<t size='1'>" + "No more enemies in your base." + "</t>")
				];
			};
		};
	};
	
	XFacAction = {
		private ["_num","_thefac","_element","_posf","_facid","_exit_it"];
		_num = _this select 0;
		_thefac = switch (_num) do {
			case 0: {"d_jet_serviceH"};
			case 1: {"d_chopper_serviceH"};
			case 2: {"d_wreck_repairH"};
		};
		waitUntil {(sleep 0.521 + (random 0.3));(X_JIPH getVariable _thefac)};
		_element = d_aircraft_facs select _num;
		_posf = _element select 0;
		sleep 0.543;
		_facid = -1;
		_exit_it = false;
		while {!_exit_it} do {
			sleep 0.432;
			switch (_num) do {
				case 0: {if (__XJIPGetVar(d_jet_s_reb)) then {_exit_it = true}};
				case 1: {if (__XJIPGetVar(d_chopper_s_reb)) then {_exit_it = true}};
				case 2: {if (__XJIPGetVar(d_wreck_s_reb)) then {_exit_it = true}};
			};

			if (!_exit_it) then {
				if (player distance _posf < 14 && (X_JIPH getVariable _thefac) && _facid == -1) then {
					if (alive player) then {
						_facid = player addAction ["Rebuild Support Building" call XRedText,"x_client\x_rebuildsupport.sqf",_num];
					};
				} else {
					if (_facid != -1) then {
						if (player distance _posf > 13 || !(X_JIPH getVariable _thefac)) then {
							player removeAction _facid;
							_facid = -1;
						};
					};
				};
			} else {
				if (_facid != -1) then {player removeAction _facid};
			};
		};
	};
};
#endif

XProgBarCall = {
	private ["_captime", "_wf", "_curcaptime", "_disp", "_control", "_backgroundControl", "_maxWidth", "_position"];
	_wf = _this select 0;
	disableSerialization;
	_captime = _wf getVariable "D_CAPTIME";
	_curcaptime = _wf getVariable "D_CURCAPTIME";
	_curside = _wf getVariable "D_SIDE";
	_disp = __uiGetVar(DPROGBAR);
	_control = _disp displayCtrl 3800;
	_backgroundControl = _disp displayCtrl 3600;
	_maxWidth = (ctrlPosition _backgroundControl select 2) - 0.02;
	_position = ctrlPosition _control;	
	_position set [2, if (_curside != d_own_side_trigger) then {(_maxWidth * _curcaptime / _captime) max 0.01} else {_maxWidth}];
	_control ctrlSetPosition _position;
	_control ctrlCommit 3;
};

XfArtyShellTrail = {
	private ["_shpos", "_trails", "_ns", "_sh", "_trail"];
	_shpos = _this select 0;
	_trails = _this select 1;
	_ns = _this select 2;
	if (_trails != "") then {
		_sh = _ns createVehicleLocal [_shpos select 0, _shpos select 1, 150];
		_sh setPosASL _shpos;
		_sh setVelocity [0,0,-150];
		_trail = [_sh] call compile preprocessFile _trails;
		waitUntil {isNull _sh};
		sleep 1;
		deleteVehicle _trail;
	};
};

#ifndef __ACE__
XfHitEffect = {
	private ["_unit", "_dam", "_part"];
	_unit = _this select 0;
	_dam = _this select 2;
	if (!alive _unit) exitWith {_dam};
	if (d_BloodDirtScreen == 1) exitWith {if (d_phd_invulnerable) then {false} else {_dam}};
	if (__ReviveVer) exitWith {_dam};
	if (_dam <= 0.1) exitWith {_dam};
	_part = _this select 1;
	switch (_part) do {
		case "head_hit": {_dam = _dam * 0.8};
		case "body": {_dam = _dam * 0.6};
		case "hands": {_dam = _dam * 0.4};
		case "legs": {_dam = _dam * 0.4};
		default {_dam = _dam * 0.6};
	};
	if (_part == "") then {
		if (vehicle _unit == _unit) then {
			if ((getText (configFile >> "CfgAmmo" >> (_this select 4) >> "simulation")) in ["shotBullet","shotShell","shotRocket","shotMissile","shotTimeBomb","shotMine"]) then {
				if (!surfaceIsWater (position _unit)) then {39672 cutRsc["D_ScreenDirt","PLAIN"]};
			};
		};
		39671 cutRsc[format ["D_ScreenBlood%1", ceil (random 3)],"PLAIN"];
	};
	if (d_phd_invulnerable) then {false} else {_dam}
};
#endif

XParaExploitHandler = {
	private ["_ammo", "_no"];
	_ammo = _this select 4;
	if (_ammo isKindOf "PipeBomb") then {
		if (animationState player == "halofreefall_non") then {
			_no = nearestObject [[getPosASL player select 0, getPosASL player select 1, 0], _ammo];
			if (!isNull _no) then {
				deleteVehicle _no;
				player addMagazine _ammo;
			};
		};
	};
};

#ifdef __ACE__
XfDHaha = {
	private ["_endtime", "_oldident"];
	_endtime = player getVariable "D_HAHA_END";
	if (isNil "_endtime") then {_endtime = -1};
	if (time < _endtime) exitWith {
		_endtime = _endtime + 600;
		player setVariable ["D_HAHA_END", _endtime];
	};
	_endtime = time + 600;
	player setVariable ["D_HAHA_END", _endtime];
	_oldident = player getVariable "ACE_Identity";
	["ace_sys_goggles_setident2", [player, "ACE_GlassesHaHa"]] call CBA_fnc_globalEvent;
	[_oldident] spawn {
		private ["_oldident", "_curident"];
		_oldident = _this select 0;
		while {time < (player getVariable "D_HAHA_END")} do {
			if (alive player) then {
				_curident = player getVariable "ACE_Identity";
				if (_curident != "ACE_GlassesHaHa") then {
					["ace_sys_goggles_setident2", [player, "ACE_GlassesHaHa"]] call CBA_fnc_globalEvent;
				};
			};
			sleep 1;
		};
		["ace_sys_goggles_setident2", [player, _oldident]] call CBA_fnc_globalEvent;
	};
};
#endif

XfLightObj = {
	private "_light";
	_light = "#lightpoint" createVehicleLocal [0,0,0];
	_light setLightBrightness 1;
	_light setLightAmbient[0.2, 0.2, 0.2];
	_light setLightColor[0.01, 0.01, 0.01];
	_light lightAttachObject [_this, [0,0,0]];
};