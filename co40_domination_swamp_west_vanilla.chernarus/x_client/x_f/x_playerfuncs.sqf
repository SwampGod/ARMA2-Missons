#define THIS_FILE "x_playerfuncs.sqf"
#include "x_setup.sqf"

if ((GVAR(string_player) in GVAR(is_engineer)) || GVAR(with_ai) || GVAR(with_ai_features) == 0) then {
	#ifndef __ACE__
	FUNC(sfunc) = {
		private "_objs";
		if (vehicle player == player) then {
			_objs = nearestObjects [player, ["LandVehicle","Air"], 7];
			if (count _objs > 0) then {
				GVAR(objectID2) = _objs select 0;
				if (alive GVAR(objectID2)) then {
					(damage GVAR(objectID2) > 0.05 || fuel GVAR(objectID2) < 1)
				} else {
					false
				}
			}
		} else {
			false
		}
	};
	#else
	FUNC(sfunc) = {
		private "_objs";
		if (vehicle player == player && (player call ace_sys_ruck_fnc_hasRuck)) then {
			_objs = nearestObjects [player, ["LandVehicle","Air"], 7];
			if (count _objs > 0) then {
				GVAR(objectID2) = _objs select 0;
				if (alive GVAR(objectID2)) then {
					(damage GVAR(objectID2) > 0.05 || fuel GVAR(objectID2) < 1)
				} else {
					false
				}
			}
		} else {
			false
		}
	};
	#endif
	FUNC(ffunc) = {
		private ["_l","_vUp","_winkel"];
		if (vehicle player == player) then {
			GVAR(objectID1) = position player nearestObject "LandVehicle";
			if (!alive GVAR(objectID1) || player distance GVAR(objectID1) > 8) then {
				false
			} else {
				_vUp = vectorUp GVAR(objectID1);
				if ((_vUp select 2) < 0 && player distance (position player nearestObject GVAR(rep_truck)) < 20) then {
					true
				} else {
					_l=sqrt((_vUp select 0)^2+(_vUp select 1)^2);
					if (_l != 0) then {
						_winkel = (_vUp select 2) atan2 _l;
						(_winkel < 30 && player distance (position player nearestObject GVAR(rep_truck)) < 20)
					}
				}
			}
		} else {
			false
		}
	};
};

FUNC(PlacedObjAn) = {
	if (GVAR(string_player) == _this) then {
		if (GVAR(player_is_medic)) then {
			_m_name = "Mash " + _this;
			[QGVAR(w_ma),_m_name] call FUNC(NetCallEvent);
			__pSetVar [QGVAR(medtent), []];
			_medic_tent = __pGetVar(medic_tent);
			if (!isNil "_medic_tent") then {if (!isNull _medic_tent) then {deleteVehicle _medic_tent}};
			__pSetVar ["medic_tent", objNull];
			"Your mash was destroyed !!!" call FUNC(GlobalChat);
		};
		if (GVAR(player_can_build_mgnest)) then {
			_m_name = "MG Nest " + _this;
			[QGVAR(w_ma),_m_name] call FUNC(NetCallEvent);
			__pSetVar [QGVAR(mgnest_pos), []];
			_mg_nest = __pGetVar(mg_nest);
			if (!isNil "_mg_nest") then {if (!isNull _mg_nest) then {deleteVehicle _mg_nest}};
			__pSetVar ["mg_nest", objNull];
			"Your MG nest was destroyed !!!" call FUNC(GlobalChat);
		};
		if (GVAR(eng_can_repfuel)) then {
			_m_name = "FARP " + _this;
			[QGVAR(w_ma),_m_name] call FUNC(NetCallEvent);
			__pSetVar [QGVAR(farp_pos), []];
			_farp = __pGetVar(GVAR(farp_obj));
			if (!isNil "_farp") then {if (!isNull _farp) then {deleteVehicle _farp}};
			__pSetVar [QGVAR(farp_obj), objNull];
			"Your FARP was destroyed !!!" call FUNC(GlobalChat);
		};
	};
};
#ifndef __TT__
FUNC(RecapturedUpdate) = {
	private ["_index","_target_array", "_target_name", "_targetName","_state"];
	PARAMS_2(_index,_state);
	_target_array = GVAR(target_names) select _index;
	_target_name = _target_array select 1;
	switch (_state) do {
		case 0: {
			_target_name setMarkerColorLocal "ColorRed";
			_target_name setMarkerBrushLocal "FDiagonal";
			hint composeText[
				parseText("<t color='#f0ff0000' size='2'>" + "Attention:" + "</t>"), lineBreak,
				parseText("<t size='1'>" + format ["Enemy mobile forces have recaptured %1!!!", _target_name] + "</t>")
			];
			format ["Attention!!! Enemy mobile forces have recaptured %1!!!", _target_name] call FUNC(HQChat);
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
FUNC(PlayerRank) = {
	private ["_score","_d_player_old_score","_d_player_old_rank"];
	_score = score player;
	_d_player_old_score = __pGetVar(GVAR(player_old_score));
	if (isNil "_d_player_old_score") then {_d_player_old_score = 0};
	_d_player_old_rank = __pGetVar(GVAR(player_old_rank));
	if (isNil "_d_player_old_rank") then {_d_player_old_rank = "PRIVATE"};
	if (_score < (GVAR(points_needed) select 0) && _d_player_old_rank != "PRIVATE") exitWith {
		if (_d_player_old_score >= (GVAR(points_needed) select 0)) then {(format ["You were degraded from %1 to Private !!!",_d_player_old_rank]) call FUNC(HQChat)};
		_d_player_old_rank = "PRIVATE";
		player setRank _d_player_old_rank;
		__pSetVar [QGVAR(player_old_rank), _d_player_old_rank];
		__pSetVar [QGVAR(player_old_score), _score];
	};
	if (_score < (GVAR(points_needed) select 1) && _score >= (GVAR(points_needed) select 0) && _d_player_old_rank != "CORPORAL") exitWith {
		if (_d_player_old_score < (GVAR(points_needed) select 1)) then {
			"You were promoted to Corporal, congratulations !!!" call FUNC(HQChat);
			playSound "fanfare";
		} else {
			(format ["You were degraded from %1 to Corporal !!!",_d_player_old_rank]) call FUNC(HQChat);
		};
		_d_player_old_rank = "CORPORAL";
		player setRank _d_player_old_rank;
		__pSetVar [QGVAR(player_old_score), _score];
		__pSetVar [QGVAR(player_old_rank), _d_player_old_rank];
	};
	if (_score < (GVAR(points_needed) select 2) && _score >= (GVAR(points_needed) select 1) && _d_player_old_rank != "SERGEANT") exitWith {
		if (_d_player_old_score < (GVAR(points_needed) select 2)) then {
			"You were promoted to Sergeant, congratulations !!!" call FUNC(HQChat);
			playSound "fanfare";
		} else {
			(format ["You were degraded from %1 to Sergeant !!!",_d_player_old_rank]) call FUNC(HQChat);
		};
		_d_player_old_rank = "SERGEANT";
		player setRank _d_player_old_rank;
		__pSetVar [QGVAR(player_old_score), _score];
		__pSetVar [QGVAR(player_old_rank), _d_player_old_rank];
	};
	if (_score < (GVAR(points_needed) select 3) && _score >= (GVAR(points_needed) select 2) && _d_player_old_rank != "LIEUTENANT") exitWith {
		if (_d_player_old_score < (GVAR(points_needed) select 3)) then {
			"You were promoted to Lieutenant, congratulations !!!" call FUNC(HQChat);
			playSound "fanfare";
		} else {
			(format ["You were degraded from %1 to Lieutenant !!!",_d_player_old_rank]) call FUNC(HQChat);
		};
		_d_player_old_rank = "LIEUTENANT";
		player setRank _d_player_old_rank;
		__pSetVar [QGVAR(player_old_score), _score];
		__pSetVar [QGVAR(player_old_rank), _d_player_old_rank];
	};
	if (_score < (GVAR(points_needed) select 4) && _score >= (GVAR(points_needed) select 3) && _d_player_old_rank != "CAPTAIN") exitWith {
		if (_d_player_old_score < (GVAR(points_needed) select 4)) then {
			"You were promoted to Captain, congratulations !!!" call FUNC(HQChat);
			playSound "fanfare";
		} else {
			(format ["You were degraded from %1 to Captain !!!",_d_player_old_rank]) call FUNC(HQChat);
		};
		_d_player_old_rank = "CAPTAIN";
		player setRank _d_player_old_rank;
		__pSetVar [QGVAR(player_old_score), _score];
		__pSetVar [QGVAR(player_old_rank), _d_player_old_rank];
	};
	if (_score < (GVAR(points_needed) select 5) && _score >= (GVAR(points_needed) select 4) && _d_player_old_rank != "MAJOR") exitWith {		
		if (_d_player_old_score < (GVAR(points_needed) select 4)) then {
			"You were promoted to Major, congratulations !!!" call FUNC(HQChat);
			playSound "fanfare";
		} else {
			(format ["You were degraded from %1 to Major !!!",_d_player_old_rank]) call FUNC(HQChat);
		};
		_d_player_old_rank = "MAJOR";
		player setRank _d_player_old_rank;
		__pSetVar [QGVAR(player_old_score), _score];
		__pSetVar [QGVAR(player_old_rank), _d_player_old_rank];
	};
	if (_score >= (GVAR(points_needed) select 5) && _d_player_old_rank != "COLONEL") exitWith {
		_d_player_old_rank = "COLONEL";
		player setRank _d_player_old_rank;
		"You were promoted to Colonel, congratulations !!!" call FUNC(HQChat);
		playSound "fanfare";
		__pSetVar [QGVAR(player_old_score), _score];
		__pSetVar [QGVAR(player_old_rank), _d_player_old_rank];
	};
};

FUNC(GetRankIndex) = {["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"] find (toUpper (_this))};

FUNC(GetRankString) = {
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

FUNC(GetRankFromScore) = {
	if (_this < (GVAR(points_needed) select 0)) exitWith {"Private"};
	if (_this < (GVAR(points_needed) select 1)) exitWith {"Corporal"};
	if (_this < (GVAR(points_needed) select 2)) exitWith {"Sergeant"};
	if (_this < (GVAR(points_needed) select 3)) exitWith {"Lieutenant"};
	if (_this < (GVAR(points_needed) select 4)) exitWith {"Captain"};
	if (_this < (GVAR(points_needed) select 5)) then {"Major"} else {"Colonel"}
};

FUNC(GetRankPic) = {
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
	FUNC(BaseEnemies) = {
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
	
	FUNC(XFacAction) = {
		private ["_num","_thefac","_element","_posf","_facid","_exit_it"];
		PARAMS_1(_num);
		_thefac = switch (_num) do {
			case 0: {QGVAR(jet_serviceH)};
			case 1: {QGVAR(chopper_serviceH)};
			case 2: {QGVAR(wreck_repairH)};
		};
		waitUntil {(sleep 0.521 + (random 0.3));(X_JIPH getVariable _thefac)};
		_element = GVAR(aircraft_facs) select _num;
		_posf = _element select 0;
		sleep 0.543;
		_facid = -1;
		_exit_it = false;
		while {!_exit_it} do {
			sleep 0.432;
			switch (_num) do {
				case 0: {if (__XJIPGetVar(GVAR(jet_s_reb))) then {_exit_it = true}};
				case 1: {if (__XJIPGetVar(GVAR(chopper_s_reb))) then {_exit_it = true}};
				case 2: {if (__XJIPGetVar(GVAR(wreck_s_reb))) then {_exit_it = true}};
			};
			if (!_exit_it) then {
				if (player distance _posf < 14 && (X_JIPH getVariable _thefac) && _facid == -1) then {
					if (alive player) then {
						_facid = player addAction ["Rebuild Support Building" call FUNC(RedText),"x_client\x_rebuildsupport.sqf",_num];
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

FUNC(ProgBarCall) = {
	private ["_captime", "_wf", "_curcaptime", "_disp", "_control", "_backgroundControl", "_maxWidth", "_position", "_newval"];
	PARAMS_1(_wf);
	disableSerialization;
	_captime = _wf getVariable QGVAR(CAPTIME);
	_curcaptime = _wf getVariable QGVAR(CURCAPTIME);
	_curside = _wf getVariable QGVAR(SIDE);
	_disp = __uiGetVar(DPROGBAR);
	_control = _disp displayCtrl 3800;
	_backgroundControl = _disp displayCtrl 3600;
	_maxWidth = (ctrlPosition _backgroundControl select 2) - 0.01;
	_position = ctrlPosition _control;
	_newval = if (_curside != GVAR(own_side_trigger)) then {(_maxWidth * _curcaptime / _captime) max 0.02} else {_maxWidth};
	_position set [2, _newval];
	_r = 1 - (_newval * 2.777777);
	_g = _newval * 2.777777;
	_control ctrlSetPosition _position;
	//_control ctrlSetBackgroundColor (if !(_wf getVariable QGVAR(STALL)) then {[0.543, 0.5742, 0.4102, 0.8]} else {[1, 1, 0, 0.8]});
	_control ctrlSetBackgroundColor (if !(_wf getVariable QGVAR(STALL)) then {[_r, _g, 0, 0.8]} else {[1, 1, 0, 0.8]});
	_control ctrlCommit 3;
};

FUNC(ArtyShellTrail) = {
	private ["_shpos", "_trails", "_ns", "_sh", "_trail"];
	PARAMS_3(_shpos,_trails,_ns);
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

FUNC(ParaExploitHandler) = {
	if (animationState player == "halofreefall_non") then {
		if ((_this select 4) isKindOf "TimeBombCore") then {
			deleteVehicle (_this select 6);
			player addMagazine (_this select 5);
		};
	};
};

#ifdef __ACE__
FUNC(DHaha) = {
	private ["_endtime", "_oldident"];
	_endtime = __pGetVar(GVAR(HAHA_END));
	if (isNil "_endtime") then {_endtime = -1};
	if (time < _endtime) exitWith {
		_endtime = _endtime + 600;
		__pSetVar [QGVAR(HAHA_END), _endtime];
	};
	_endtime = time + 600;
	__pSetVar [QGVAR(HAHA_END), _endtime];
	_oldident = __pGetVar(ACE_Identity);
	["ace_sys_goggles_setident2", [player, "ACE_GlassesHaHa"]] call CBA_fnc_globalEvent;
	[_oldident] spawn {
		private ["_oldident", "_curident"];
		PARAMS_1(_oldident);
		while {time < __pGetVar(GVAR(HAHA_END))} do {
			if (alive player) then {
				_curident = __pGetVar(ACE_Identity);
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

FUNC(LightObj) = {
	private "_light";
	_light = "#lightpoint" createVehicleLocal [0,0,0];
	_light setLightBrightness 1;
	_light setLightAmbient[0.2, 0.2, 0.2];
	_light setLightColor[0.01, 0.01, 0.01];
	_light lightAttachObject [_this, [0,0,0]];
};