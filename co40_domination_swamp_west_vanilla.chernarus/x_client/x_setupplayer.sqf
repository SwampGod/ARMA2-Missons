// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_setupplayer.sqf"
#include "x_setup.sqf"
private ["_p", "_pos", "_type", "_weapp", "_magp", "_res", "_taskstr", "_color", "_counterxx", "_text", "_mcol", "_s", "_trigger", "_types", "_action", "_ar", "_tactionar", "_primw", "_muzzles"];

diag_log [diag_frameno, diag_ticktime, time, "Executing Dom x_setupplayer.sqf"];

GVAR(still_in_intro) = true;

#ifndef __A2ONLY__
if !(__TTVer) then {
	_shield = GVAR(ProtectionZone) createVehicleLocal (position FLAG_BASE);
	_shield setDir -211;
	_shield setPos (position FLAG_BASE);
	_shield setObjectTexture [0,"#(argb,8,8,3)color(0,0,0,0,ca)"];
	if (GVAR(ShowBaseSafeZone) == 0) then {
		_shield = GVAR(ProtectionZone) createVehicleLocal (position FLAG_BASE);
		_shield setDir -211;
		_shield setPos [getPosASL FLAG_BASE select 0, getPosASL FLAG_BASE select 1, -28.48];
		_shield setObjectTexture [0,"#(argb,8,8,3)color(0,0,0,0.7,ca)"];
	};
};
#endif

GVAR(current_defend_target) = "";
GVAR(current_defend_idx) = -1;
GVAR(current_attack_target) = "";
GVAR(current_attack_idx) = -1;

__ccppfln(x_client\x_f\x_perframe.sqf);

GVAR(name_pl) = name player;
GVAR(player_faction) = faction player;
GVAR(grp_caller) = objNull;

GVAR(misc_store) = GVAR(HeliHEmpty) createVehicleLocal [0,0,0];

FUNC(GreyText) = {"<t color='#f0bfbfbf'>" + _this + "</t>"};
FUNC(RedText) = {"<t color='#f0ff0000'>" + _this + "</t>"};
FUNC(BlueText) = {"<t color='#f07f7f00'>" + _this + "</t>"}; //olive

#ifdef __ACE__
if (GVAR(WoundsRevTime) != -1) then {ace_wounds_prevtime = GVAR(WoundsRevTime)};
#endif

__pSetVar ["BIS_noCoreConversations", true];

/* for "_i" from 1 to 21 do {
	_mrkr = format ["mt%1", _i];
	_str = "[" + str (markerPos _mrkr) + "," + toString [34] + markerText _mrkr + toString [34] + ",300]";
	if (_i < 21) then {_str = _str + ","};
	_str = _str + " // " + str (_i - 1);
	diag_log _str;
}; */

_p = player;
__pSetVar [QGVAR(alivetimestart), time];
_pos = position _p;
_type = typeOf _p;
GVAR(string_player) = str(player);
GVAR(player_side) = playerSide;
GVAR(player_str_group) = str(group player);
if (GVAR(player_str_group) != "") then {
	_ar = toArray GVAR(player_str_group);
	_ar set [0,-99]; _ar set [1,-99];
	_ar = _ar - [-99];
	GVAR(player_str_group) = toString _ar;
};
// no idea if the following really works and it should never happen!
if (isNull (group player)) then {
	_gside = if ((faction player) in ["USMC","CDF","BIS_US","BIS_CZ","BIS_GER","BIS_BAF","ACE_USAF","ACE_USNAVY"]) then {west} else {east};
	_grpp = createGroup west;
	[player] joinSilent _grpp;
};
if (side (group player) != GVAR(player_side)) then {
	GVAR(player_side) = side (group player);
};

if (GVAR(WithRevive) == 1) then {
	__pSetVar ["xr_pluncon", false];
	
	#ifdef __ACE__
	if (GVAR(WithWounds) == 1) then {
	#endif
	
	#define __shots ["shotBullet","shotShell","shotRocket","shotMissile","shotTimeBomb","shotMine"]
	xr_bscreens = ["xr_ScreenBlood1", "xr_ScreenBlood2","xr_ScreenBlood3"];
	xr_blurr = ppEffectCreate ["dynamicBlur", -12521];
	FUNC(blurr) = {
		xr_blurr ppEffectEnable true;
		xr_blurr ppEffectAdjust [1];
		xr_blurr ppEffectCommit 1;
		sleep 1;
		xr_blurr ppEffectAdjust [0];
		xr_blurr ppEffectCommit 1;
		sleep 1;
		xr_blurr ppEffectEnable false;
	};
	FUNC(playerHD) = {
		private ["_unit", "_part", "_dam", "_injurer", "_ammo", "_ddexit"];
		PARAMS_5(_unit,_part,_dam,_injurer,_ammo);
		if (!alive _unit) exitWith {_dam};
		if (xr_phd_invulnerable) exitWith {0};
		if (GV(_unit,xr_pluncon)) exitWith {0};
		_ddexit = false;
		if (GVAR(no_teamkill) == 0) then {
			if (_dam >= 0.5) then {
				if (isPlayer _injurer) then {
					if (_injurer != _unit && side (group _injurer) == side (group _unit) && getText (configFile >> "CfgAmmo" >> _ammo >> "simulation") in __shots) then {
						if (_part == "") then {
							hint format ["%1 is shooting at you !!!!\n\nNo teamkill system active!", name _injurer];
							[QGVAR(unit_tkr), [_unit,_injurer]] call FUNC(NetCallEvent);
						};
						_ddexit = true;
					};
				};
			};
		};
		if (_ddexit) exitWith {0};
		_dam = _dam * 0.8;
		if (_dam > 0.15 && _part == "") then {
			if (vehicle _unit == _unit) then {
				if (getText (configFile >> "CfgAmmo" >> _ammo >> "simulation") in __shots) then {
					if (!surfaceIsWater (getPosASL _unit)) then {39672 cutRsc ["xr_ScreenDirt","PLAIN"]};
				};
			};
		};
		0 spawn FUNC(blurr);
		39671 cutRsc[xr_bscreens select (floor (random 3)),"PLAIN"];
		_dam
	};
	player removeAllEventHandlers "handleDamage";
	player addEventHandler ["handleDamage", {_this call FUNC(playerHD)}];
	
	#ifdef __ACE__
	};
	#endif
};

if (GVAR(with_ranked)) then {GVAR(sm_p_pos) = nil};

#ifdef __TT__
GVAR(own_side) = if (GVAR(player_side) == east) then {"EAST"} else {"WEST"};
GVAR(side_player_str) = switch (GVAR(player_side)) do {
	case west: {"west"};
	case east: {"east"};
};
GVAR(own_side_trigger) = if (GVAR(player_side) == east) then {"EAST"} else {"WEST"};

GVAR(side_player) = GVAR(player_side);

GVAR(rep_truck) = if (GVAR(own_side) == "WEST") then {GVAR(rep_truck_west)} else {GVAR(rep_truck_east)};

GVAR(create_bike) = switch (true) do {
	case (__OAVer): {if (GVAR(own_side) == "EAST") then {["Old_bike_TK_INS_EP1","Old_bike_TK_INS_EP1"]} else {["ATV_US_EP1","M1030"]}};
	case (__COVer): {if (GVAR(own_side) == "EAST") then {["MMT_Civ","TT650_Civ"]} else {["MMT_USMC","M1030"]}};
};

if (GVAR(with_mgnest)) then {
	GVAR(mg_nest) = switch (true) do {
		case (__OAVer): {if (GVAR(own_side) == "EAST") then {"WarfareBMGNest_PK_TK_EP1"} else {"WarfareBMGNest_M240_US_EP1"}};
		case (__COVer): {if (GVAR(own_side) == "EAST") then {"RU_WarfareBMGNest_PK"} else {"USMC_WarfareBMGNest_M240"}};
	};
};
#endif

#ifdef __CO__
GVAR(the_box) = switch (GVAR(own_side)) do {
	case "GUER": {"LocalBasicAmmunitionBox"};
	case "EAST": {"RUBasicAmmunitionBox"};
	case "WEST": {"USBasicWeaponsBox"};
};
GVAR(the_base_box) = switch (GVAR(own_side)) do {
	case "GUER": {"GuerillaCacheBox"};
	case "EAST": {"RUSpecialWeaponsBox"};
	case "WEST": {"USSpecialWeaponsBox"};
};
#endif
#ifdef __OA__
GVAR(the_box) = switch (GVAR(own_side)) do {
	case "GUER": {"LocalBasicAmmunitionBox"};
	case "EAST": {"TKBasicWeapons_EP1"};
	case "WEST": {"USBasicWeapons_EP1"};
};
GVAR(the_base_box) = switch (GVAR(own_side)) do {
	case "GUER": {"GuerillaCacheBox"};
	case "EAST": {"TKSpecialWeapons_EP1"};
	case "WEST": {"USSpecialWeapons_EP1"};
};
#endif

GVAR(flag_vec) = objNull;

__ccppfln(x_client\x_f\x_playerfuncs.sqf);

if (!isServer) then {execVM "x_bikb\kbinit.sqf"};

if (!X_SPE) then {
#ifndef __TT__
	GVAR(X_DropZone) = __XJIPGetVar(X_DropZone);
#endif
	GVAR(AriTarget) = __XJIPGetVar(GVAR(AriTarget));
	GVAR(AriTarget2) = __XJIPGetVar(GVAR(AriTarget2));
};

[QGVAR(dummy_marker), [0,0,0],"ICON","ColorBlack",[1,1],"",0,"Empty"] call FUNC(CreateMarkerLocal);
[QGVAR(arti_target2), [0,0,0],"ICON","ColorBlue",[1,1],"Ari 2 Target",0,"mil_destroy"] call FUNC(CreateMarkerLocal);
QGVAR(arti_target2) setMarkerPosLocal getPosASL GVAR(AriTarget2);
[QGVAR(arti_target), [0,0,0],"ICON","ColorBlue",[1,1],"Ari 1 Target",0,"mil_destroy"] call FUNC(CreateMarkerLocal);
QGVAR(arti_target) setMarkerPosLocal getPosASL GVAR(AriTarget);
#ifndef __TT__
[QGVAR(drop_zone), [0,0,0],"ICON","ColorBlue",[1,1],"Air Drop Zone",0,"mil_dot"] call FUNC(CreateMarkerLocal);
QGVAR(drop_zone) setMarkerPosLocal getPosASL GVAR(X_DropZone);
#endif

[2, QGVAR(recaptured), {_this call FUNC(RecapturedUpdate)}] call FUNC(NetAddEvent);
[2, QGVAR(doarti), {if (alive player && (player distance _this < 50)) then {"Attention. You were spotted by enemy artillery observers. Incoming enemy artillery !!!" call FUNC(HQChat)}}] call FUNC(NetAddEvent);
[2, QGVAR(m_box), {_this call FUNC(create_boxNet)}] call FUNC(NetAddEvent);
[2, QGVAR(r_box), {_nobjs = nearestObjects [_this, [GVAR(the_box)], 10];if (count _nobjs > 0) then {_box = _nobjs select 0;deleteVehicle _box}}] call FUNC(NetAddEvent);
[2, QGVAR(air_box), {_box = GVAR(the_box) createVehicleLocal _this;_box setPos [_this select 0,_this select 1,0];player reveal _box;[_box] call FUNC(weaponcargo);_box addEventHandler ["killed",{deleteVehicle (_this select 0)}]}] call FUNC(NetAddEvent);
// config for sound info is in the game addons but the sound itself doesn't exist!!!
// TODO: find the sound file, maybe arma 1 ?
[2, QGVAR(sm_res_client), {playSound "Notebook";GVAR(side_mission_winner) = _this select 0;if (GVAR(with_ranked)) then {GVAR(sm_running) = false}; (_this select 1) execVM "x_missions\x_sidemissionwinner.sqf"}] call FUNC(NetAddEvent);
[2, QGVAR(target_clear), {playSound "fanfare";_this execVM "x_client\x_target_clear_client.sqf"}] call FUNC(NetAddEvent);
[2, QGVAR(update_target), {execVM "x_client\x_createnexttargetclient.sqf"}] call FUNC(NetAddEvent);
[2, QGVAR(up_m), {[true] spawn FUNC(getsidemissionclient)}] call FUNC(NetAddEvent);
[2, QGVAR(unit_tk), {
	if (GVAR(sub_tk_points) != 0) then {
		[format ["%1 was teamkilled by %2. %2 loses %3 score points!", _this select 0, _this select 1, GVAR(sub_tk_points)], "GLOBAL"] call FUNC(HintChatMsg);
	} else {
		[format ["%1 was teamkilled by %2.", _this select 0, _this select 1], "GLOBAL"] call FUNC(HintChatMsg);
	};
}] call FUNC(NetAddEvent);
[2, QGVAR(unit_tk2), {
	if (GVAR(sub_tk_points) != 0) then {
		[format ["%2 is shooting at %1. %2 loses %3 score points!", _this select 0, _this select 1, GVAR(sub_tk_points)], "GLOBAL"] call FUNC(HintChatMsg);
	} else {
		[format ["%2 is shooting at %1.", _this select 0, _this select 1], "GLOBAL"] call FUNC(HintChatMsg);
	};
}] call FUNC(NetAddEvent);
[2, QGVAR(ataxi), {_this call FUNC(ataxiNet)}] call FUNC(NetAddEvent);
[2, QGVAR(ai_kill), {if ((_this select 0) in (units (group player))) then {if (player == leader (group player)) then {[QGVAR(pas), [player, _this select 1 ]] call FUNC(NetCallEvent)}}}] call FUNC(NetAddEvent);
[2, QGVAR(p_ar), {
#ifdef __DEBUG__
	_uidp = getPlayerUID player;
	_suid = _this select 2;
	__TRACE_2("p_ar","_uidp","_suid");
#endif
	if (getPlayerUID player == (_this select 2)) then {_this call FUNC(player_stuff)};
}] call FUNC(NetAddEvent);
[2, QGVAR(sm_p_pos), {GVAR(sm_p_pos) = _this}] call FUNC(NetAddEvent);
[2, QGVAR(mt_winner), {GVAR(mt_winner) = _this}] call FUNC(NetAddEvent);
[2, QGVAR(n_v), {_this call FUNC(initvec)}] call FUNC(NetAddEvent);
[2, QGVAR(m_l_o), {_this call FUNC(LightObj)}] call FUNC(NetAddEvent);
[2, QGVAR(dpicm), {_pod = "ARTY_SADARM_BURST" createVehicleLocal _this;_pod setPos _this}] call FUNC(NetAddEvent);
[2, QGVAR(artyt), {_this spawn FUNC(ArtyShellTrail)}] call FUNC(NetAddEvent);
[2, QGVAR(mhqdepl), {if (local (_this select 0)) then {(_this select 0) lock (_this select 1)};_this call FUNC(mhqdeplNet)}] call FUNC(NetAddEvent);
[2, QGVAR(w_n), {[format ["Attention!!!\n\n%1 has changed his name...\nIt was %2 before !!!", _this select 0, _this select 1], "GLOBAL"] call FUNC(HintChatMsg)}] call FUNC(NetAddEvent);
[2, QGVAR(tk_an), {
	[format ["%1 was kicked because of team killing, # team kills: %2", _this select 0, _this select 1], "GLOBAL"] call FUNC(HintChatMsg);
	if (serverCommandAvailable "#shutdown") then {serverCommand ("#kick " + (_this select 0))};
}] call FUNC(NetAddEvent);
[2, QGVAR(say2), {if (alive player && (player distance (_this select 0) < (_this select 2))) then {(_this select 0) say3D (_this select 1)}}] call FUNC(NetAddEvent);
[2, QGVAR(em), {if (player == _this) then {endMission "LOSER"}}] call FUNC(NetAddEvent);
[2, QGVAR(ps_an), {
	switch (_this select 1) do {
		case 0: {[format ["%1 was kicked automatically because of too much unnecessary shooting at base", _this select 0], "GLOBAL"] call FUNC(HintChatMsg)};
		case 1: {[format ["%1 was kicked automatically because he has placed a satchel at base", _this select 0], "GLOBAL"] call FUNC(HintChatMsg)};
	};
	if (serverCommandAvailable "#shutdown") then {serverCommand ("#kick " + (_this select 0))};
}] call FUNC(NetAddEvent);
[2, QGVAR(s_p_inf), {GVAR(u_r_inf) = _this}] call FUNC(NetAddEvent);
[2, QGVAR(w_ma), {deleteMarkerLocal _this}] call FUNC(NetAddEvent);
[2, QGVAR(p_o_a), {
	private "_ar";_ar = _this select 1;
#ifdef __TT__
	if (GVAR(player_side) == (_ar select 3)) then {
#endif
	if ((_ar select 0) isKindOf "Mash") then {
		[_ar select 1, getPosASL (_ar select 0),"ICON","ColorBlue",[0.5,0.5],format ["Mash %1", _ar select 2],0,"mil_dot"] call FUNC(CreateMarkerLocal);
	} else {
		if ((_ar select 0) isKindOf "Base_WarfareBVehicleServicePoint") then {
			[_ar select 1, getPosASL (_ar select 0),"ICON","ColorBlue",[0.5,0.5],format ["FARP %1", _ar select 2],0,"mil_dot"] call FUNC(CreateMarkerLocal);
		} else {
			[_ar select 1, getPosASL (_ar select 0),"ICON","ColorBlue",[0.5,0.5],format ["MG Nest %1", _ar select 2],0,"mil_dot"] call FUNC(CreateMarkerLocal);
		};
	};
#ifdef __TT__
	};
#endif
#ifdef __A2ONLY__
	((_this select 1) select 0) addEventhandler ["Killed",{[QGVAR(p_o_a_exe), _this] call FUNC(NetCallEvent)}];
#endif
}] call FUNC(NetAddEvent);
if (GVAR(with_ranked)) then {
	[2, QGVAR(pho), {if (player == _this) then {(format ["You get %1 points for healing other units!", GVAR(ranked_a) select 17]) call FUNC(HQChat)}}] call FUNC(NetAddEvent);
};
#ifdef __ACE__
[2, QGVAR(haha), {if (player == _this) then {call FUNC(DHaha)}}] call FUNC(NetAddEvent);
#endif
[2, QGVAR(p_o_r), {deleteMarkerLocal (_this select 1)}] call FUNC(NetAddEvent);
if (GVAR(engineerfull) == 0 || GVAR(with_ai) || GVAR(with_ai_features) == 0) then {
	[2, QGVAR(farp_e), {if (GVAR(eng_can_repfuel)) then {_this addAction ["Restore repair/refuel capability" call FUNC(BlueText), "x_client\x_restoreeng.sqf"]}}] call FUNC(NetAddEvent);
};
[2, QGVAR(p_o_an), {_this call FUNC(PlacedObjAn)}] call FUNC(NetAddEvent);
#ifdef __TT__
if (GVAR(WithRevive) == 0) then {
	[2, QGVAR(u_k), {format ["%2 was shot uncon by %1. The %3 team gets %4 point.", _this select 0, _this select 1, _this select 2, GVAR(tt_points) select 8] call FUNC(GlobalChat)}] call FUNC(NetAddEvent);
} else {
	[2, QGVAR(u_k), {format ["%1 has killed %2. The %3 team gets %4 point.", _this select 0, _this select 1, _this select 2, GVAR(tt_points) select 8] call FUNC(GlobalChat)}] call FUNC(NetAddEvent);
};
[2, QGVAR(vec_killer), {format ["%1 destroyed a %2 vehicle. The %3 team gets %4 points.", _this select 0, _this select 1, _this select 2, GVAR(tt_points) select 7] call FUNC(GlobalChat)}] call FUNC(NetAddEvent);
[2, QGVAR(r_mark), {if (GVAR(player_side) != (_this select 1)) then {_this spawn {waitUntil {((markerPos (_this select 0)) select 0) != 0};deleteMarkerLocal (_this select 0)}}}] call FUNC(NetAddEvent);
[2, QGVAR(attention), {_this call FUNC(dattention)}] call FUNC(NetAddEvent);
[2, QGVAR(w_m_c), {
	if (!isNil {_this select 3} && !isNil QGVAR(player_side)) then {
		if (GVAR(player_side) == _this select 3) then {
			[_this select 0, _this select 1,"ICON","ColorBlue",[1,1],format ["%1 wreck", _this select 2],0,"mil_triangle"] call FUNC(CreateMarkerLocal)
		}
	}
}] call FUNC(NetAddEvent);
#else
[2, QGVAR(dropansw), {_this call FUNC(dropansw)}] call FUNC(NetAddEvent);
[2, QGVAR(n_jf), {if (GVAR(WithJumpFlags) == 1) then {_this execVM "x_client\x_newflagclient.sqf"}}] call FUNC(NetAddEvent);
[2, QGVAR(jet_sf), {call FUNC(jet_service_facNet)}] call FUNC(NetAddEvent);
[2, QGVAR(chop_sf), {call FUNC(chopper_service_facNet)}] call FUNC(NetAddEvent);
[2, QGVAR(wreck_rf), {call FUNC(wreck_repair_facNet)}] call FUNC(NetAddEvent);
[2, QGVAR(s_b_client), {__XJIPGetVar(GVAR(searchbody)) setVariable [QGVAR(search_id), __XJIPGetVar(GVAR(searchbody)) addAction ["Search body", "x_client\x_searchbody.sqf"]]}] call FUNC(NetAddEvent);
[2, QGVAR(rem_sb_id), {if (!isNil {__XJIPGetVar(GVAR(searchbody)) getVariable QGVAR(search_id)}) then {__XJIPGetVar(GVAR(searchbody)) removeAction (__XJIPGetVar(GVAR(searchbody)) getVariable QGVAR(search_id))}}] call FUNC(NetAddEvent);
[2, QGVAR(intel_upd), {_this call FUNC(intel_updNet)}] call FUNC(NetAddEvent);
[2, QGVAR(w_m_c), {[_this select 0, _this select 1,"ICON","ColorBlue",[1,1],format ["%1 wreck", _this select 2],0,"mil_triangle"] call FUNC(CreateMarkerLocal)}] call FUNC(NetAddEvent);
#endif
[2, QGVAR(smsg), {"Attention... the Scud will launch in a few seconds...." call FUNC(HQChat)}] call FUNC(NetAddEvent);

[2, QGVAR(mqhtn), {[format ["%2 moved to close to the main target (%1 meters), fuel removed to prevent getting to close to the MT!", GVAR(MHQDisableNearMT), _this], "HQ"] call FUNC(HintChatMsg)}] call FUNC(NetAddEvent);

[2, QGVAR(ccso), {playSound "Ui_cc"}] call FUNC(NetAddEvent);

0 spawn {
	sleep 1 + random 3;
	if (isMultiplayer) then {
		[QGVAR(p_a), getPlayerUID player] call FUNC(NetCallEvent);// ask the server for the client score, etc
		waitUntil {!GVAR(still_in_intro)};
		xr_phd_invulnerable = false;
		__pSetVar ["ace_w_allow_dam", nil];
		sleep 2;
		__pSetVar [QGVAR(player_old_rank), "PRIVATE"];
		["player_rank", {call FUNC(PlayerRank)},5.01] call FUNC(addPerFrame);
	} else {
		GVAR(player_autokick_time) = GVAR(AutoKickTime);
		xr_phd_invulnerable = false;
		__pSetVar ["ace_w_allow_dam", nil];
		0 spawn {
			sleep 20;
			if (GVAR(still_in_intro)) then {
				GVAR(still_in_intro) = false;
			};
		};
	};
};

["init_vecs", {{_x call FUNC(initvec)} forEach vehicles;["init_vecs"] call FUNC(removePerFrame)},0] call FUNC(addPerFrame);

if (GVAR(with_ranked)) then {
	// basic rifle at start
	_weapp = "";
	_magp = "";
	switch (GVAR(own_side)) do {
		case "WEST": {
#ifdef __CO__
			_weapp = "M16A4";
#endif
#ifdef __OA__
			_weapp = "M16A2";
#endif
			_magp = "30Rnd_556x45_Stanag";
		};
		case "EAST": {
			_weapp = "AK_74";
			_magp = "30Rnd_545x39_AK";
		};
		case "GUER": {
			_weapp = "M16A4";
			_magp = "30Rnd_556x45_Stanag";
		};
	};
	removeAllWeapons _p;
	for "_i" from 1 to 6 do {_p addMagazine _magp};
	_p addWeapon _weapp;
};

#define __tctn _target_array = GVAR(target_names) select _res;\
_current_target_pos = _target_array select 0;\
_target_name = _target_array select 1;\
_target_radius = _target_array select 2
_taskstr = "d_task%1 = player createSimpleTask ['obj%1'];d_task%1 setSimpleTaskDescription ['Seize %2...','Main Target: Seize %2','Main Target: Seize %2'];d_task%1 settaskstate _objstatus;d_task%1 setSimpleTaskDestination _current_target_pos;";
#define __tmarker [_target_name, _current_target_pos,#ELLIPSE,_color,[_target_radius,_target_radius]] call FUNC(CreateMarkerLocal)
if (GVAR(MissionType) != 2) then {
#ifndef __TT__
	if (count __XJIPGetVar(resolved_targets) > 0) then {
		for "_i" from 0 to (count __XJIPGetVar(resolved_targets) - 1) do {
			if (isNil {__XJIPGetVar(resolved_targets)}) exitWith {};
			if (_i >= count __XJIPGetVar(resolved_targets)) exitWith {};
			_res = __XJIPGetVar(resolved_targets) select _i;
			if (!isNil "_res") then {
				if (_res >= 0) then {
					__tctn;
					_mname = format [QGVAR(target_%1), _res];
					_no = __getMNsVar2(_mname);
					_color = "ColorGreen";
					_objstatus = "Succeeded";
					if (!isNull _no) then {
						_isrec = GV(_no,GVAR(recaptured));
						if (!isNil "_isrec") then {
							_objstatus = "Failed";
							_color = "ColorRed";
							[_target_name, _current_target_pos,"ELLIPSE",_color,[_target_radius,_target_radius],"",0,"Marker","FDiagonal"] call FUNC(CreateMarkerLocal);
						} else {
							__tmarker;
						};
					} else {
						__tmarker;
					};

					call compile format [_taskstr,_res + 2,_target_name];
				};
			};
		};
	};
#else
	if (count __XJIPGetVar(resolved_targets) > 0) then {
		for "_i" from 0 to (count __XJIPGetVar(resolved_targets) - 1) do {
			if (isNil {__XJIPGetVar(resolved_targets)}) exitWith {};
			if (_i == count __XJIPGetVar(resolved_targets)) exitWith {};
			_xres = __XJIPGetVar(resolved_targets) select _i;
			_res = _xres select 0;
			_winner = _xres select 1;
			__tctn;
			_color = switch (_winner) do {
				case 1: {"ColorBlue"};
				case 2: {"ColorRed"};
				case 3: {"ColorGreen"};
			};
			__tmarker;
			call compile format [_taskstr,_res + 2,_target_name];
		};
	};
#endif

	GVAR(current_seize) = "";
	if (__XJIPGetVar(GVAR(current_target_index)) != -1 && !__XJIPGetVar(target_clear)) then {
		__TargetInfo;
		_current_target_pos = _target_array2 select 0;
		GVAR(current_seize) = _current_target_name;
		_target_radius = _target_array2 select 2;	
	#ifndef __TT__
		_color = "ColorRed";
	#else
		_color = "ColorYellow";
	#endif
		[_current_target_name, _current_target_pos,"ELLIPSE",_color,[_target_radius,_target_radius]] call FUNC(CreateMarkerLocal);
		QGVAR(dummy_marker) setMarkerPosLocal _current_target_pos;
		_objstatus = "Created";
		call compile format [(_taskstr + "d_current_task = d_task%1;"), __XJIPGetVar(GVAR(current_target_index)) + 2,_current_target_name];
	};
};

{
	if (typeName _x == "ARRAY") then {
#ifdef __TT__
		if (GVAR(player_side) == (_x select 3)) then {
#endif
		[_x select 0, _x select 1,"ICON","ColorBlue",[1,1],format ["%1 wreck", _x select 2],0,"mil_triangle"] call FUNC(CreateMarkerLocal);
#ifdef __TT__
		};
#endif
	};
} forEach __XJIPGetVar(GVAR(wreck_marker));

if (GVAR(MissionType) != 2) then {
	_counterxx = 0;
	{
		_pos = position _x;
		[format [QGVAR(paraflag%1), _counterxx], _pos,"ICON","ColorYellow",[0.5,0.5],"Parajump",0,"mil_flag"] call FUNC(CreateMarkerLocal);
		
		__INC(_counterxx);
		if (GVAR(jumpflag_vec) == "") then {
			_x addaction ["(Choose Parachute location)" call FUNC(BlueText),"AAHALO\x_paraj.sqf"];
		} else {
			_text = "(Create " + ([GVAR(jumpflag_vec),0] call FUNC(GetDisplayName)) + ")";
			_x addAction [_text call FUNC(BlueText),"x_client\x_bike.sqf",[GVAR(jumpflag_vec),1]];
		};
#ifdef __ACE__
		if (GVAR(jumpflag_vec) == "") then {
			_box = "ACE_RuckBox" createVehicleLocal _pos;
			clearMagazineCargo _box;
			clearWeaponCargo _box;
			_box addweaponcargo ["ACE_ParachutePack",10];
		};
#endif
	} forEach __XJIPGetVar(jump_flags);
};

if (GVAR(MissionType) != 2) then {
	if (!__XJIPGetVar(GVAR(mt_radio_down))) then {
		if (__XJIPGetVar(mt_radio_pos) select 0 != 0) then {
			["main_target_radiotower", __XJIPGetVar(mt_radio_pos),"ICON","ColorBlack",[0.5,0.5],"Radiotower",0,"mil_dot"] call FUNC(CreateMarkerLocal);
		};
	};
};

if (GVAR(MissionType) != 2) then {
	if (count __XJIPGetVar(GVAR(currentcamps)) > 0) then {
		{
			if (!isNull _x) then {
#ifndef __TT__
				_mcol = switch (GV(_x,GVAR(SIDE))) do {
					case "WEST": {if (GVAR(own_side) == "EAST") then {"ColorBlack"} else {"ColorBlue"}};
					case "EAST": {if (GVAR(own_side) == "WEST") then {"ColorBlack"} else {"ColorBlue"}};
				};
#else
				_mcol = switch (GV(_x,GVAR(SIDE))) do {
					case "WEST": {"ColorBlue"};
					case "EAST": {"ColorRed"};
					case "GUER": {"ColorBlack"};
				};
#endif
				[format["dcamp%1",GV(_x,GVAR(INDEX))], getPosASL _x,"ICON",_mcol,[0.5,0.5],"",0,"Strongpoint"] call FUNC(CreateMarkerLocal);
			};
		} forEach __XJIPGetVar(GVAR(currentcamps));
	};
};

if (__XJIPGetVar(all_sm_res)) then {GVAR(current_mission_text) = "All missions resolved!"} else {[false] spawn FUNC(getsidemissionclient)};

if (GVAR(without_nvg) == 1) then {
	#define __paddweap(xweap) if (!(_p hasWeapon #xweap)) then {_p addWeapon #xweap}
	__paddweap(NVGoggles);
} else {
	if (player hasWeapon "NVGoggles") then {player removeWeapon "NVGoggles"};
	execFSM "fsms\RemoveGoogles.fsm";
};
_weapop = weapons player;
if (!("Binocular_Vector" in _weapop) && !("Laserdesignator" in _weapop)) then {
	__paddweap(Binocular);
};
__paddweap(ItemGPS);

#ifndef __ACE__
// TODO: Check if time is still correct
if (daytime > 19.75 || daytime < 4.15) then {_p action ["NVGoggles",_p]};
#endif

__cppfln(FUNC(x_playerspawn),x_client\x_playerspawn.sqf);

if (GVAR(with_ai)) then {
#ifndef __A2ONLY__
	player addMPEventHandler ["MPKilled", {_this call FUNC(x_checkkill)}];
#else
	player addEventHandler ["Killed", {[QGVAR(callPPE), _this] call FUNC(NetCallEvent)}];
#endif
} else {
	__cppfln(FUNC(x_dlgopen),x_client\x_open.sqf);
	if !(__TTVer) then {
		#ifndef __A2ONLY__
			player addMPEventHandler ["MPKilled", {_this call FUNC(x_checkkill)}];
		#else
			player addEventHandler ["Killed", {[QGVAR(callPPE), _this] call FUNC(NetCallEvent)}];
		#endif
	} else {
		if (GVAR(player_side) == west) then {
			#ifndef __A2ONLY__
				player addMPEventHandler ["MPKilled", {_this call FUNC(x_checkkillwest)}];
			#else
				player addEventHandler ["Killed", {[QGVAR(callPPW), _this] call FUNC(NetCallEvent)}];
			#endif
		} else {
			#ifndef __A2ONLY__
				player addMPEventHandler ["MPKilled", {_this call FUNC(x_checkkilleast)}];
			#else
				player addEventHandler ["Killed", {[QGVAR(callPPE), _this] call FUNC(NetCallEvent)}];
			#endif
		};
	};
};

xr_use_dom_opendlg = false;
FUNC(prespawned) = {
	if (GVAR(WithMHQTeleport) == 0) then {
		if (!isNil QUOTE(FUNC(x_dlgopen))) then {
			if (GVAR(WithRevive) == 0) then {
				//if (xr_max_lives == -1) then {
				//	call FUNC(x_dlgopen);
				//} else {
					if (__pGetVar(xr_lives) > -1) then {
						if (xr_use_dom_opendlg) then {
							call FUNC(x_dlgopen);
							xr_use_dom_opendlg = false;
						};
					};
				//};
			} else {
				call FUNC(x_dlgopen);
			};
		};
	};
	[1, _this] call FUNC(x_playerspawn);
};

#ifndef __A2ONLY__
player addEventHandler ["respawn", {_this call FUNC(prespawned)}];
#else
player addEventHandler ["killed", {
	0 spawn {
		private "_oldbody";
		_oldbody = player;
		waitUntil {alive player};
		[player, _oldbody] call FUNC(prespawned);
	};
}];
#endif

if (count __XJIPGetVar(GVAR(ammo_boxes)) > 0) then {
	private ["_box_pos", "_boxnew", "_boxscript"];
	{
		if (typeName _x == "ARRAY") then {
			_box_pos = _x select 0;
#ifndef __TT__
			if ((_x select 1) != "") then {[_x select 1, _box_pos,"ICON","ColorBlue",[0.5,0.5],"Ammo",0,"mil_marker"] call FUNC(CreateMarkerLocal)};
#else
			if ((_x select 1) != "" && GVAR(player_side) == (_x select 2)) then {[_x select 1, _box_pos,"ICON","ColorBlue",[0.5,0.5],"Ammo",0,"mil_marker"] call FUNC(CreateMarkerLocal)};
#endif
			_boxnew = GVAR(the_box) createVehicleLocal _box_pos;
			_boxnew setPos _box_pos;
			_boxnew addAction ["Save gear layout" call FUNC(BlueText), "x_client\x_savelayout.sqf"];
			_boxnew addAction ["Clear gear layout" call FUNC(BlueText), "x_client\x_clearlayout.sqf"];
			[_boxnew] call FUNC(weaponcargo);
			_boxnew addEventHandler ["killed",{[QGVAR(r_box), position (_this select 0)] call FUNC(NetCallEvent);deleteVehicle (_this select 0)}];
		};
	} forEach __XJIPGetVar(GVAR(ammo_boxes));
};

GVAR(player_can_call_drop) = 0;
GVAR(player_can_call_arti) = 0;
_scriptarti = "x_client\x_artillery.sqf";
_scriptdrop = "x_client\x_calldrop.sqf";
_scripttrench = "x_client\x_trench.sqf";
_callvecari1 = {
	GVAR(vec_ari1_id) = -8877;
	[_pos, [0, 0, 0, false],["NONE", "PRESENT", true], ["vehicle player != player && !((vehicle player) isKindOf 'BIS_Steerable_Parachute') && !((vehicle player) isKindOf 'ParachuteBase')", "d_ari1_vehicle = vehicle player;if (d_vec_ari1_id == -8877) then {d_vec_ari1_id = d_ari1_vehicle addAction ['Call Artillery' call d_fnc_GreyText, 'x_client\x_artillery.sqf',[1,D_AriTarget],-1,false]}", "if (d_vec_ari1_id != -8877) then {d_ari1_vehicle removeAction d_vec_ari1_id;d_vec_ari1_id = -8877}"]] call FUNC(CreateTrigger);
};
_callvecari2 = {
	GVAR(vec_ari1_id) = -8877;
	[_pos, [0, 0, 0, false], ["NONE", "PRESENT", true], ["vehicle player != player && !((vehicle player) isKindOf 'BIS_Steerable_Parachute') && !((vehicle player) isKindOf 'ParachuteBase')", "d_ari1_vehicle = vehicle player;if (d_vec_ari1_id == -8877) then {d_vec_ari1_id = d_ari1_vehicle addAction ['Call Artillery' call d_fnc_GreyText, 'x_client\x_artillery.sqf',[2,D_AriTarget2],-1,false]}", "if (d_vec_ari1_id != -8877) then {d_ari1_vehicle removeAction d_vec_ari1_id;d_vec_ari1_id = -8877}"]] call FUNC(CreateTrigger);
};
_callvecdrop = {
	GVAR(vec_drop_id) = -8877;
	[_pos, [0, 0, 0, false], ["NONE", "PRESENT", true], ["vehicle player != player && !((vehicle player) isKindOf 'BIS_Steerable_Parachute') && !((vehicle player) isKindOf 'ParachuteBase')", "d_drop_vehicle = vehicle player;if (d_vec_drop_id == -8877) then {d_vec_drop_id = d_drop_vehicle addAction ['Call Drop' call d_fnc_GreyText, 'x_client\x_calldrop.sqf',[],-1,false]}", "if (d_vec_drop_id != -8877) then {d_drop_vehicle removeAction d_vec_drop_id;d_vec_drop_id = -8877}"]] call FUNC(CreateTrigger);
};

__cppfln(FUNC(call_artillery),x_client\x_artillery.sqf);
__cppfln(FUNC(call_drop),x_client\x_calldrop.sqf);
__cppfln(FUNC(spawn_mash),x_client\x_mash.sqf);
__cppfln(FUNC(spawn_mgnest),x_client\x_mgnest.sqf);

__cppfln(FUNC(3DCredits),scripts\fn_3dcredits.sqf);
__cppfln(FUNC(DirIndicator),scripts\fn_dirindicator.sqf);
__cppfln(FUNC(Sandstorm),scripts\fn_sandstorm.sqf);

#ifndef __TT__
["Vehicle Service Point<br/><t size='0.6'>Only for vehicles</t>", position GVAR(vecre_trigger), 30, 0] spawn FUNC(3DCredits);
["Plane Service Point<br/><t size='0.6'>Only for planes</t>", position GVAR(jet_trigger), 30, 0] spawn FUNC(3DCredits);
["Chopper Service Point<br/><t size='0.6'>Only for choppers</t>", position GVAR(chopper_trigger), 30, 0] spawn FUNC(3DCredits);
["Wreck Repair Point<br/><t size='0.6'>Only for wrecks</t>", position GVAR(wreck_rep), 30, 0] spawn FUNC(3DCredits);
if (isNil QGVAR(with_carrier)) then {
	["Ammobox load point<br/><t size='0.6'>Load ammoboxes</t>", position AMMOLOAD, 30, 0] spawn FUNC(3DCredits);
};
#else
if (GVAR(player_side) == west) then {
	["Vehicle Service Point<br/><t size='0.6'>Only for vehicles</t>", position GVAR(vecre_trigger), 30, 0] spawn FUNC(3DCredits);
	["Plane Service Point<br/><t size='0.6'>Only for planes</t>", position GVAR(jet_trigger), 30, 0] spawn FUNC(3DCredits);
	["Chopper Service Point<br/><t size='0.6'>Only for choppers</t>", position GVAR(chopper_trigger), 30, 0] spawn FUNC(3DCredits);
	["Wreck Repair Point<br/><t size='0.6'>Only for wrecks</t>", position GVAR(wreck_rep), 30, 0] spawn FUNC(3DCredits);
	["Ammobox load point<br/><t size='0.6'>Load ammoboxes</t>", position AMMOLOAD, 30, 0] spawn FUNC(3DCredits);
} else {
	["Vehicle Service Point<br/><t size='0.6'>Only for vehicles</t>", position GVAR(vecre_trigger2), 30, 0] spawn FUNC(3DCredits);
	["Plane Service Point<br/><t size='0.6'>Only for planes</t>", position GVAR(jet_trigger2), 30, 0] spawn FUNC(3DCredits);
	["Chopper Service Point<br/><t size='0.6'>Only for choppers</t>", position GVAR(chopper_triggerR), 30, 0] spawn FUNC(3DCredits);
	["Wreck Repair Point<br/><t size='0.6'>Only for wrecks</t>", position GVAR(wreck_rep2), 30, 0] spawn FUNC(3DCredits);
	["Ammobox load point<br/><t size='0.6'>Load ammoboxes</t>", position AMMOLOAD2, 30, 0] spawn FUNC(3DCredits);
};
#endif

__pSetVar [QGVAR(trench), objNull];
__pSetVar [QGVAR(trenchid), -9999];
if (GVAR(with_ai) || GVAR(with_ai_features) == 0) then {
	if (GVAR(with_ai)) then {
		execVM "x_client\x_recruitsetup.sqf";
		
		_grpp = group player;
		_leader = leader _grpp;
		if (!isPlayer _leader || player == _leader) then {
			{
				if (!isPlayer _x) then {
					if (vehicle _x == _x) then {
						deleteVehicle _x;
					} else {
						moveOut _x;
						_x spawn {
							waitUntil {sleep 0.331;vehicle _this == _this};
							deleteVehicle _this;
						};
					};
				};
			} forEach units _grpp;
		};
	};

	if !(__ACEVer) then {
		GVAR(player_can_call_arti) = 1;
		GVAR(player_can_call_drop) = 1;
		__pSetVar [QGVAR(ari1), _p addAction ["Call Artillery" call FUNC(GreyText), _scriptarti,[1,GVAR(AriTarget)],-1,false,false,"","vehicle _target == _target && position _target select 2 < 10"]];
		__pSetVar [QGVAR(dropaction), _p addAction ["Call Drop" call FUNC(GreyText), _scriptdrop,[],-1,false,false,"","vehicle _target == _target && position _target select 2 < 10"]];
		call _callvecari1;
		call _callvecdrop;
	} else {
		[1] execVM "x_client\x_artiradiocheckold.sqf";
		execVM "x_client\x_dropradiocheckold.sqf";
	};
	__pSetVar [QGVAR(trenchid), _p addAction ["Create Trench" call FUNC(GreyText), _scripttrench, [], -1, false, false, "", "vehicle _target == _target && isNull (_target getVariable 'd_trench')"]];
	_p addRating 20000;
} else {
	if (GVAR(string_player) in GVAR(can_use_artillery)) then {
		if !(__ACEVer) then {
			if (GVAR(string_player) == "RESCUE") then {
				GVAR(player_can_call_arti) = 1;
				__pSetVar [QGVAR(ari1), _p addAction ["Call Artillery" call FUNC(GreyText), _scriptarti,[1,GVAR(AriTarget)],-1,false,false,"","vehicle _target == _target && position _target select 2 < 10"]];
				call _callvecari1;
			};
			if (GVAR(string_player) == "RESCUE2") then {
				GVAR(player_can_call_arti) = 2;
				__pSetVar [QGVAR(ari1), _p addAction ["Call Artillery" call FUNC(GreyText), _scriptarti,[2,GVAR(AriTarget2)],-1,false,false,"","vehicle _target == _target && position _target select 2 < 10"]];
				call _callvecari2;
			};
		} else {
			GVAR(player_can_call_arti) = switch (GVAR(string_player)) do {
				case "RESCUE": {1};
				case "RESCUE2": {2};
				default {0};
			};
			if (GVAR(player_can_call_arti) == 0) exitWith {};
			[GVAR(player_can_call_arti)] execVM "x_client\x_artiradiocheckold.sqf";
		};
	} else {
		#ifndef __A2ONLY__
		enableEngineArtillery false;
		#endif
	};
	if (GVAR(string_player) in GVAR(can_call_drop_ar)) then {
		if (__ACEVer) then {
			execVM "x_client\x_dropradiocheckold.sqf";
		} else {
			GVAR(player_can_call_drop) = 1;
			__pSetVar [QGVAR(dropaction), _p addAction ["Call Drop" call FUNC(GreyText), _scriptdrop,[],-1,false,false,"","vehicle _target == _target && position _target select 2 < 10"]];
		};
	};
	if (GVAR(player_can_call_arti) == 0 && !(GVAR(string_player) in GVAR(is_engineer))) then {
		__pSetVar [QGVAR(trenchid), _p addAction ["Create Trench" call FUNC(GreyText), _scripttrench, [], -1, false, false, "", "vehicle _target == _target && isNull (_target getVariable 'd_trench')"]];
	};
};

_respawn_marker = "";
#define __dml_w deleteMarkerLocal #respawn_west
#define __dml_e deleteMarkerLocal #respawn_east
#define __dml_g deleteMarkerLocal #respawn_guerrila
switch (GVAR(own_side)) do {
	case "GUER": {
		_respawn_marker = "respawn_guerrila";
		__dml_w;
		__dml_e;
	};
	case "WEST": {
		_respawn_marker = "respawn_west";
		__dml_g;
		__dml_e;
	};
	case "EAST": {
		_respawn_marker = "respawn_east";
		__dml_w;
		__dml_g;
	};
};

#define __rmsmpl _respawn_marker setMarkerPosLocal
if (__TTVer) then {
	if (GVAR(player_side) == west) then {
		__rmsmpl markerPos "base_spawn_1";
	} else {
		__rmsmpl markerPos "base_spawn_2";
	};
} else {
	if (!isNil QGVAR(with_carrier)) then {
		"base_spawn_1" setMarkerPosLocal [markerPos "base_spawn_1" select 0, markerPos "base_spawn_1" select 1, 15.9];
		__rmsmpl [markerPos "base_spawn_1" select 0, markerPos "base_spawn_1" select 1, 15.9];
	} else {
		__rmsmpl markerPos "base_spawn_1";
	};
};
// if there ever will be a carrier version who knows... if (!isNil QGVAR(with_carrier)) then {"base_spawn_1" setMarkerPosLocal [markerPos "base_spawn_1" select 0, markerPos "base_spawn_1" select 1, 15.9]};

__pSetVar [QGVAR(ass), _p addAction ["Show Status" call FUNC(GreyText), "x_client\x_showstatus.sqf",[],-1,false]];

__pSetVar [QGVAR(pbp_id), -9999];
GVAR(backpack_helper) = [];
__pSetVar [QGVAR(custom_backpack), []];
__pSetVar [QGVAR(player_backpack), []];
if (GVAR(WithBackpack)) then {
	GVAR(prim_weap_player) = primaryWeapon _p;
	_s = ([GVAR(prim_weap_player),1] call FUNC(GetDisplayName)) + " to Backpack";
	if (GVAR(prim_weap_player) != "" && GVAR(prim_weap_player) != " ") then {
		__pSetVar [QGVAR(pbp_id), _p addAction [_s call FUNC(GreyText), "x_client\x_backpack.sqf",[],-1,false]];
	};
	// No Weapon fix for backpack
	[_pos, [0, 0, 0, false], ["NONE", "PRESENT", true], ["primaryWeapon player != d_prim_weap_player && primaryWeapon player != ' ' && !dialog","call {d_prim_weap_player = primaryWeapon player;_id = player getVariable 'd_pbp_id';if (_id != -9999 && count (player getVariable 'd_player_backpack') == 0) then {player removeAction _id;player setVariable ['d_pbp_id', -9999]};if ((player getVariable 'd_pbp_id' == -9999) && count (player getVariable 'd_player_backpack') == 0 && d_prim_weap_player != '' && d_prim_weap_player != ' ') then {player setVariable ['d_pbp_id', player addAction [format ['%1 to Backpack', [d_prim_weap_player,1] call d_fnc_GetDisplayName] call d_fnc_GreyText, 'x_client\x_backpack.sqf',[],-1,false]]}}",""]] call FUNC(CreateTrigger);
};

#ifndef __TT__
GVAR(base_trigger) = createTrigger["EmptyDetector" ,GVAR(base_array) select 0];
GVAR(base_trigger) setTriggerArea [GVAR(base_array) select 1, GVAR(base_array) select 2, GVAR(base_array) select 3, true];
#else
_dbase_a = if (GVAR(player_side) == west) then {GVAR(base_array) select 0} else {GVAR(base_array) select 1};
GVAR(base_trigger) = createTrigger["EmptyDetector" ,_dbase_a select 0];
GVAR(base_trigger) setTriggerArea [_dbase_a select 1, _dbase_a select 2, _dbase_a select 3, true];
#endif
GVAR(base_trigger) setTriggerActivation [GVAR(own_side_trigger), "PRESENT", true];
GVAR(base_trigger) setTriggerStatements["this", "", ""];

// special triggers for engineers, AI version, everybody can repair and flip vehicles
GVAR(eng_can_repfuel) = false;
if (GVAR(string_player) in GVAR(is_engineer) || GVAR(with_ai) || GVAR(with_ai_features) == 0) then {
	GVAR(eng_can_repfuel) = true;

	if (GVAR(engineerfull) == 0 || GVAR(with_ai) || GVAR(with_ai_features) == 0) then {
#ifndef __TT__
		GVAR(engineer_trigger) = createTrigger["EmptyDetector" ,GVAR(base_array) select 0];
		GVAR(engineer_trigger) setTriggerArea [GVAR(base_array) select 1, GVAR(base_array) select 2, GVAR(base_array) select 3, true];
#else
		_dbase_a = if (playerSide == west) then {GVAR(base_array) select 0} else {GVAR(base_array) select 1};
		GVAR(engineer_trigger) = createTrigger["EmptyDetector" ,_dbase_a select 0];
		GVAR(engineer_trigger) setTriggerArea [_dbase_a select 1, _dbase_a select 2, _dbase_a select 3, true];
#endif
		GVAR(engineer_trigger) setTriggerActivation [GVAR(own_side_trigger), "PRESENT", true];
		GVAR(engineer_trigger) setTriggerStatements["!d_eng_can_repfuel && player in thislist", "d_eng_can_repfuel = true;'Engineer repair/refuel capability restored.' call d_fnc_GlobalChat", ""];
	};
	
	if (GVAR(with_ranked)) then {GVAR(last_base_repair) = -1};
	
	[_pos, [0, 0, 0, false], ["NONE", "PRESENT", true], ["call d_fnc_ffunc", "actionID1=player addAction ['Unflip Vehicle' call d_fnc_GreyText, 'scripts\unflipVehicle.sqf',[d_objectID1],-1,false];", "player removeAction actionID1"]] call FUNC(CreateTrigger);
	
	if (GVAR(engineerfull) == 0 || GVAR(with_ai) || GVAR(with_ai_features) == 0) then {
		_trigger = createTrigger["EmptyDetector" ,_pos];
		_trigger setTriggerArea [0, 0, 0, true];
		_trigger setTriggerActivation ["NONE", "PRESENT", true];
#ifndef __ENGINEER_OLD__
		_trigger setTriggerStatements["call d_fnc_sfunc", "d_actionID6 = player addAction ['Analyze Vehicle' call d_fnc_GreyText, 'x_client\x_repanalyze.sqf',[],-1,false];d_actionID2 = player addAction ['Repair/Refuel Vehicle' call d_fnc_GreyText, 'x_client\x_repengineer.sqf',[],-1,false]", "player removeAction d_actionID6;player removeAction d_actionID2"];
#else
		_trigger setTriggerStatements["call d_fnc_sfunc", "d_actionID2 = player addAction ['Repair/Refuel Vehicle' call d_fnc_GreyText, 'x_client\x_repengineer_old.sqf',[],-1,false]", "player removeAction d_actionID2"];
#endif
	};
	
	__pSetVar [QGVAR(is_engineer),true];
	__pSetVar [QGVAR(farp_pos), []];
	__pSetVar [QGVAR(farpaction), _p addAction ["Build FARP" call FUNC(GreyText),"x_client\x_farp.sqf",[],-1,false,true,"","count (player getVariable 'd_farp_pos') == 0"]];
	
	if (GVAR(engineerfull) == 0 || GVAR(with_ai) || GVAR(with_ai_features) == 0) then {
		{_x addAction ["Restore repair/refuel capability" call FUNC(BlueText), "x_client\x_restoreeng.sqf"]} forEach (__XJIPGetVar(GVAR(farps)));
	};
};

GVAR(there_are_enemies_atbase) = false;
#ifndef __TT__
// Enemy at base
if (isNil QGVAR(with_carrier)) then {
	"enemy_base" setMarkerPosLocal (GVAR(base_array) select 0);
	"enemy_base" setMarkerDirLocal (GVAR(base_array) select 3);
	[GVAR(base_array) select 0, [GVAR(base_array) select 1, GVAR(base_array) select 2, GVAR(base_array) select 3, true], [GVAR(enemy_side), "PRESENT", true], ["'Man' countType thislist > 0 || 'Tank' countType thislist > 0 || 'Car' countType thislist > 0", "[0] call d_fnc_BaseEnemies;'enemy_base' setMarkerSizeLocal [d_base_array select 1,d_base_array select 2];d_there_are_enemies_atbase = true", "[1] call d_fnc_BaseEnemies;'enemy_base' setMarkerSizeLocal [0,0];d_there_are_enemies_atbase = false"]] call FUNC(CreateTrigger);
	[GVAR(base_array) select 0, [(GVAR(base_array) select 1) + 300, (GVAR(base_array) select 2) + 300, GVAR(base_array) select 3, true], [GVAR(enemy_side), "PRESENT", true], ["'Man' countType thislist > 0 || 'Tank' countType thislist > 0 || 'Car' countType thislist > 0", "hint 'Enemy units near your base'", ""]] call FUNC(CreateTrigger);
};
#endif

// Show status vehicle trigger, add action to player vehicle
GVAR(vec_showstat_id) = -8876;
[_pos, [0, 0, 0, false], ["NONE", "PRESENT", true],["vehicle player != player && !((vehicle player) isKindOf 'BIS_Steerable_Parachute') && !((vehicle player) isKindOf 'ParachuteBase')", "d_vec_showstat = vehicle player;if (d_vec_showstat_id == -8876) then {d_vec_showstat_id = d_vec_showstat addAction ['Show Status' call d_fnc_GreyText, 'x_client\x_showstatus.sqf',[],-1,false]}", "if (d_vec_showstat_id != -8876) then {d_vec_showstat removeAction d_vec_showstat_id;d_vec_showstat_id = -8876}"]] call FUNC(CreateTrigger);

GVAR(player_can_build_mgnest) = false;
if (GVAR(with_mgnest)) then {
	if (GVAR(string_player) in GVAR(can_use_mgnests)) then {
		GVAR(player_can_build_mgnest) = true;
		__pSetVar [QGVAR(mgnest_pos), []];
		__pSetVar [QGVAR(mgnestaction), _p addAction ["Build MG Nest" call FUNC(GreyText),"x_client\x_mgnest.sqf",[],-1,false,true,"","count (player getVariable 'd_mgnest_pos') == 0"]];
	};
};

GVAR(player_is_medic) = false;
if (GVAR(string_player) in GVAR(is_medic)) then {
	if (GVAR(with_medtent)) then {
		GVAR(player_is_medic) = true;
		__pSetVar [QGVAR(medtent), []];
		__pSetVar [QGVAR(medicaction), _p addAction ["Build Mash" call FUNC(GreyText),"x_client\x_mash.sqf",[],-1,false,true,"","count (player getVariable 'd_medtent') == 0"]];
	};
};

// TODO: Remove those ?
if (!isNil QGVAR(action_menus_type)) then {
	if (count GVAR(action_menus_type) > 0) then {
		{
			_types = _x select 0;
			if (count _types > 0) then {
				if (_type in _types) then { 
					_action = _p addAction [(_x select 1) call FUNC(GreyText),_x select 2,[],-1,false];
					_x set [3, _action];
				};
			} else {
				_action = _p addAction [(_x select 1) call FUNC(GreyText),_x select 2,[],-1,false];
				_x set [3, _action];
			};
		} forEach GVAR(action_menus_type);
	};
};
if (!isNil QGVAR(action_menus_unit)) then {
	if (count GVAR(action_menus_unit) > 0) then {
		{
			_types = _x select 0;
			_ar = _x;
			if (count _types > 0) then {
				{
					private "_pc";
					_pc = __getMNsVar(_x);
					if (_p ==  _pc) exitWith { 
						_action = _p addAction [(_ar select 1) call FUNC(GreyText),_ar select 2,[],-1,false];
						_ar set [3, _action];
					};
				} forEach _types
			} else {
				_action = _p addAction [(_x select 1) call FUNC(GreyText),_x select 2,[],-1,false];
				_x set [3, _action];
			};
		} forEach GVAR(action_menus_unit);
	};
};

if (!isNil QGVAR(action_menus_vehicle)) then {
	if (count GVAR(action_menus_vehicle) > 0) then {execVM "x_client\x_vecmenus.sqf"};
};

#ifndef __TT__
if (isNil QGVAR(with_carrier) && GVAR(MissionType) != 2) then {
	if (GVAR(string_player) in GVAR(is_engineer) || GVAR(with_ai) || GVAR(with_ai_features) == 0) then {
		if (__XJIPGetVar(GVAR(jet_serviceH)) && !__XJIPGetVar(GVAR(jet_s_reb))) then {
			[0] spawn FUNC(XFacAction);
		};
		if (__XJIPGetVar(GVAR(chopper_serviceH)) && !__XJIPGetVar(GVAR(chopper_s_reb))) then {
			[1] spawn FUNC(XFacAction);
		};
		if (__XJIPGetVar(GVAR(wreck_repairH)) && !__XJIPGetVar(GVAR(wreck_s_reb))) then {
			[2] spawn FUNC(XFacAction);
		};
	};

#define __facset _pos = _element select 0;\
_dir = _element select 1;\
_fac = "Land_budova2_ruins" createVehicleLocal _pos;\
_fac setDir _dir
#define __facset2 _pos = _element select 0;\
_dir = _element select 1;\
_fac = "Land_vez_ruins" createVehicleLocal _pos;\
_fac setDir _dir
	if (__XJIPGetVar(GVAR(jet_serviceH)) && !__XJIPGetVar(GVAR(jet_s_reb))) then {
		_element = GVAR(aircraft_facs) select 0;
		switch (true) do {
			case (__COVer): {__facset};
			case (__OAVer): {__facset2};
		};
	};
	if (__XJIPGetVar(GVAR(chopper_serviceH)) && !__XJIPGetVar(GVAR(chopper_s_reb))) then {
		_element = GVAR(aircraft_facs) select 1;
		switch (true) do {
			case (__COVer): {__facset};
			case (__OAVer): {__facset2};
		};
	};
	if (__XJIPGetVar(GVAR(wreck_repairH)) && !__XJIPGetVar(GVAR(wreck_s_reb))) then {
		_element = GVAR(aircraft_facs) select 2;
		switch (true) do {
			case (__COVer): {__facset};
			case (__OAVer): {__facset2};
		};
	};
};
#endif

if (count GVAR(only_pilots_can_fly) > 0) then {
	if !(GVAR(string_player) in GVAR(only_pilots_can_fly)) then {
		execFSM "fsms\HandleAircraft.fsm";
	};
};

if (GVAR(WithJumpFlags) == 0) then {GVAR(ParaAtBase) = 1};

_tactionar = ["Teleport" call FUNC(GreyText),"x_client\x_teleport.sqf"];
#ifndef __TT__
if (GVAR(WithMHQTeleport) == 0) then {
	FLAG_BASE addAction _tactionar;
};
if (GVAR(with_ai) || (GVAR(ParaAtBase) == 0)) then {
	FLAG_BASE addaction ["(Choose Parachute location)" call FUNC(GreyText),"AAHALO\x_paraj.sqf"];
};
#else
if (GVAR(WithMHQTeleport) == 0) then {
	(if (GVAR(own_side) == "WEST") then {WFLAG_BASE} else {EFLAG_BASE}) addAction _tactionar;
};
#endif

if (GVAR(ParaAtBase) == 1) then {
	_s = QGVAR(Teleporter);
	_sn = "Teleporter";
#ifndef __TT__
	_s setMarkerTextLocal _sn;
#else
	if (GVAR(own_side) == "WEST") then {
		_s setMarkerTextLocal _sn;
	} else {
		QGVAR(teleporter_1) setMarkerTextLocal _sn;
	};
#endif
};

#ifdef __ACE__
if !(__TTVer) then {
	{
		_element = _x;
		_box = (_element select 0) createVehicleLocal (_element select 1);
		_box setDir (_element select 2);
		_box setPos (_element select 1);
		player reveal _box;
		[_box, _element select 1, _element select 2, _element select 0] spawn {
			private ["_box","_boxname","_pos","_dir"];
			PARAMS_4(_box,_pos,_dir,_boxname);
			while {true} do {
				sleep 1500 + random 500;
				if (!isNull _box) then {deleteVehicle _box};
				_box = _boxname createVehicleLocal _pos;
				_box setDir _dir;
				_box setPos _pos;
				player reveal _box;
			};
		};
	} forEach GVAR(ace_boxes);
} else {
	_element = GVAR(ace_boxes) select (switch (GVAR(player_side)) do {case east: {1};case west: {0};});
	_box = (_element select 0) createVehicleLocal (_element select 1);
	_box setDir (_element select 2);
	_box setPos (_element select 1);
	player reveal _box;
	[_box, _element select 1, _element select 2, _element select 0] spawn {
		private ["_box","_boxname","_pos","_dir"];
		PARAMS_4(_box,_pos,_dir,_boxname);
		while {true} do {
			sleep 1500 + random 500;
			if (!isNull _box) then {deleteVehicle _box};
			_box = _boxname createVehicleLocal _pos;
			_box setDir _dir;
			_box setPos _pos;
			player reveal _box;
		};
	};
};
GVAR(ace_boxes) = nil;
GVAR(pos_ace_boxes) = nil;
#endif

if (!GVAR(AmmoBoxHandling)) then {
	[AMMOLOAD] execFSM "fsms\AmmoLoad.fsm";
#ifdef __TT__
	[AMMOLOAD2] execFSM "fsms\AmmoLoad.fsm";
#endif
};

if (!GVAR(with_ranked)) then {
	if (GVAR(AutoKickTime) > 0 && GVAR(MissionType) != 2) then {execFSM "fsms\AutoKick.fsm"};
} else {
	execVM "x_client\x_playerveccheck.sqf";
#ifndef __ACE__
	player addEventHandler ["handleHeal", {_this call FUNC(HandleHeal)}];
#else
	if (GVAR(string_player) in GVAR(is_medic)) then {execVM "x_client\x_mediccheck.sqf"};
#endif
	execVM "x_client\x_playervectrans.sqf";
};

if (GVAR(with_ai) || GVAR(with_ai_features) == 0) then {
	GVAR(heli_taxi_available) = true;
	_trigger = createTrigger ["EmptyDetector", _pos];
	_trigger setTriggerText "Call in Air Taxi";
	_trigger setTriggerActivation ["HOTEL", "PRESENT", true];
	_trigger setTriggerStatements ["this", "0 = [] execVM 'x_client\x_airtaxi.sqf'",""];
};

GVAR(vec_end_time) = -1;

if (GVAR(WithRepStations) == 0) then {execFSM "fsms\RepStation.fsm"};

if (isMultiplayer) then {
	0 spawn {
		sleep (0.5 + random 2);
		[QGVAR(p_varn), [getPlayerUID player,GVAR(string_player),GVAR(player_side)]] call FUNC(NetCallEvent);
	};
};

#ifdef __TT__
	if (GVAR(player_side) == east) then {
		QGVAR(arti_target) setMarkerAlphaLocal 0;
		QGVAR(arti_target2) setMarkerTextLocal "Ari Target";
	} else {
		QGVAR(arti_target2) setMarkerAlphaLocal 0;
		QGVAR(arti_target) setMarkerTextLocal "Ari Target";
	};
#endif

// brrr, sqs
[] exec "\ca\modules\Clouds\data\scripts\BIS_CloudSystem.sqs";

if (GVAR(LimitedWeapons)) then {
	GVAR(poss_weapons) = [];
	for "_i" from 0 to (count GVAR(limited_weapons_ar) - 2) do {
		_ar = GVAR(limited_weapons_ar) select _i;
		if (GVAR(string_player) in (_ar select 0)) exitWith {GVAR(poss_weapons) =+ _ar select 1};
	};
	if (count GVAR(poss_weapons) == 0) then {GVAR(poss_weapons) =+ (GVAR(limited_weapons_ar) select (count GVAR(limited_weapons_ar) - 1)) select 1};
	execFSM "fsms\LimitWeapons.fsm";
	GVAR(limited_weapons_ar) = nil;
};

execVM "x_msg\x_playernamehud.sqf";

if (GVAR(MissionType) != 2) then {
	execFSM "fsms\CampDialog.fsm";
};

if (GVAR(with_ai)) then {
	0 spawn {
		while {true} do {
			waitUntil {sleep 0.272;alive player};
			if (player != leader (group player) && !__pGetVar(xr_pluncon)) then {
				if (count GVAR(current_ai_units) > 0) then {
					GVAR(current_ai_units) = [];
					GVAR(current_ai_num) = 0;
				};
			};
			if (__pGetVar(xr_pluncon)) then {
				waitUntil {sleep 0.332;!__pGetVar(xr_pluncon) || !alive player};
			};
			sleep 1.212;
		};
	};
};

execFSM "fsms\IsAdmin.fsm";

_primw = primaryWeapon _p;
if (_primw != "") then {
	_p selectWeapon _primw;
	_muzzles = getArray(configFile >>"cfgWeapons" >> _primw >> "muzzles");
	_p selectWeapon (_muzzles select 0);
};

#ifndef __TT__
if (GVAR(MissionType) != 2) then {
	_sb = __XJIPGetVar(GVAR(searchbody));
	if (!isNull _sb) then {
		if (isNil {GV(_sb,GVAR(search_body))}) then {_sb setVariable [QGVAR(search_id), _sb addAction ["Search body", "x_client\x_searchbody.sqf"]]};
	};
};
#endif

player addEventHandler ["fired", {_this call FUNC(ParaExploitHandler)}];

#ifdef __ACE__
if ("ACE_Earplugs" in items player) then {
	__pSetVar [QGVAR(earwear), true];
} else {
	__pSetVar [QGVAR(earwear), false];
};
0 spawn {
	while {true} do {
		if (alive player) then {
			if (!__pGetVar(GVAR(earwear))) then {
				if ("ACE_Earplugs" in items player || __pGetVar(ACE_EarWear)) then {
					__pSetVar [QGVAR(earwear), true];
				};
			} else {
				if (__pGetVar(GVAR(earwear))) then {
					if (!("ACE_Earplugs" in items player) && !__pGetVar(ACE_EarWear)) then {
						__pSetVar [QGVAR(earwear), false];
					};
				};
			};
		};
		sleep 0.5;
	};
};
#endif

if (isNil QGVAR(with_carrier)) then {
	__pSetVar [QGVAR(p_f_b), 0];
	
	FUNC(KickPlayerBaseFired) = {
        private "_num";
        if !(serverCommandAvailable "#shutdown") then {
			if (player in (list GVAR(player_base_trig))) then {
				private "_ta";
				_ta = _this select 4;
				if (_ta isKindOf "TimeBombCore" || _ta == "ACE_PipebombExplosion") then {
					if (count _this > 6) then {
						deleteVehicle (_this select 6);
					};
					if (GVAR(kick_base_satchel) == 0) then {
						[QGVAR(p_f_b_k), [player, GVAR(name_pl),1]] call FUNC(NetCallEvent);
					} else {
						[QGVAR(p_bs), [player, GVAR(name_pl),1]] call FUNC(NetCallEvent);
					};
				} else {
					if (!GVAR(there_are_enemies_atbase)) then {
						if !(getText(configFile >> "CfgAmmo" >> _ta >> "simulation") in ["shotSmoke", "shotIlluminating", "shotNVGMarker", "shotCM"]) then {
							_num = __pGetVar(GVAR(p_f_b));
							__INC(_num);
							__pSetVar [QGVAR(p_f_b), _num];
							if !(player in (list GVAR(player_base_trig2))) then {
								if (GVAR(player_kick_shootingbase) != 1000) then {
									if (_num >= GVAR(player_kick_shootingbase)) then {
										if (isNil {__pGetVar(GVAR(pfbk_announced))}) then {
											[QGVAR(p_f_b_k), [player, GVAR(name_pl),0]] call FUNC(NetCallEvent);
											__pSetVar [QGVAR(pfbk_announced), true];
										};
									} else {
										hint "Stop shooting at base or you will get kicked automatically...";
									};
								} else {
									if (_num >= GVAR(player_kick_shootingbase)) then {
										[QGVAR(p_bs), [player, GVAR(name_pl),0]] call FUNC(NetCallEvent);
									};
								};
							};
						};
					};
				};
			} else {
				__pSetVar [QGVAR(p_f_b), 0];
			};
		};
	};

#ifndef __TT__
	GVAR(player_base_trig) = createTrigger["EmptyDetector" ,GVAR(base_array) select 0];
	GVAR(player_base_trig) setTriggerArea [GVAR(base_array) select 1, GVAR(base_array) select 2, GVAR(base_array) select 3, true];
#else
	_dbase_a = if (GVAR(player_side) == west) then {GVAR(base_array) select 0} else {GVAR(base_array) select 1};
	GVAR(player_base_trig) = createTrigger["EmptyDetector" ,_dbase_a select 0];
	GVAR(player_base_trig) setTriggerArea [_dbase_a select 1, _dbase_a select 2, _dbase_a select 3, true];
#endif
	GVAR(player_base_trig) setTriggerActivation [GVAR(own_side_trigger), "PRESENT", true];
	GVAR(player_base_trig) setTriggerStatements["this", "", ""];

#ifndef __TT__
	GVAR(player_base_trig2) = createTrigger["EmptyDetector" ,position FLAG_BASE];
#else
	_dbase_a = if (GVAR(player_side) == west) then {position WFLAG_BASE} else {position EFLAG_BASE};
	GVAR(player_base_trig2) = createTrigger["EmptyDetector" ,_dbase_a];
#endif
	GVAR(player_base_trig2) setTriggerArea [25, 25, 0, false];
	GVAR(player_base_trig2) setTriggerActivation [GVAR(own_side_trigger), "PRESENT", true];
	GVAR(player_base_trig2) setTriggerStatements["this", "", ""];
	
	player addEventHandler ["fired", {_this call FUNC(KickPlayerBaseFired)}];
};

if (GVAR(no_3rd_person) == 0) then {
	execFSM "fsms\3rdperson.fsm";
};

GVAR(msg_hud_array) = [];
FUNC(AddHudMsg) = {
	GVAR(msg_hud_array) set [count GVAR(msg_hud_array), _this];
};

GVAR(last_hud_msgs) = [];
FUNC(HudDispMsgEngine) = {
	while {true} do {
		waitUntil {count GVAR(msg_hud_array) > 0 && alive player && !GVAR(msg_hud_shown) && !__pGetVar(xr_pluncon)};
		[GVAR(msg_hud_array) select 0] spawn FUNC(HudDispMsg);
		GVAR(last_hud_msgs) set [count GVAR(last_hud_msgs), GVAR(msg_hud_array) select 0];
		if (count GVAR(last_hud_msgs) > 20) then {
			GVAR(last_hud_msgs) set [0,-1];
			GVAR(last_hud_msgs) = GVAR(last_hud_msgs) - [-1];
		};
		GVAR(msg_hud_array) set [0,-1];
		GVAR(msg_hud_array) = GVAR(msg_hud_array) - [-1];
	};
};

0 spawn FUNC(HudDispMsgEngine);

GVAR(msg_hud_shown) = false;
FUNC(HudDispMsg) = {
	// TODO: Length should depend on message size
	private ["_msg", "_hud", "_control", "_cpos", "_control2", "_cpos2", "_endtime"];
	PARAMS_1(_msg);
	if (GVAR(msg_hud_shown)) exitWith {};
	GVAR(msg_hud_shown) = true;
	disableSerialization;
	89643 cutRsc [QGVAR(message_hud),"PLAIN"];
	_hud = __uiGetVar(DMESSAGE_HUD);
	_control = _hud displayCtrl 1000;
	_cpos = ctrlPosition _control;
	_control ctrlSetPosition [_cpos select 0, SafeZoneY + SafeZoneH - 0.07, _cpos select 2, _cpos select 3];
	_control2 = _hud displayCtrl 1001;
	_control2 ctrlSetText _msg;
	_cpos2 = ctrlPosition _control2;
	_control2 ctrlSetPosition [_cpos2 select 0, SafeZoneY + SafeZoneH - 0.068, _cpos2 select 2, _cpos2 select 3];
	_control ctrlCommit 0.5;
	_control2 ctrlCommit 0.5;
	_endtime = time + 19;
	waitUntil {time > _endtime || !alive player || __pGetVar(xr_pluncon)};
	_control ctrlSetPosition _cpos;
	_control2 ctrlSetPosition _cpos2;
	_control ctrlCommit 0.5;
	_control2 ctrlCommit 0.5;
	GVAR(msg_hud_shown) = false;
};

__ccppfln(x_client\x_marker.sqf);

if (GVAR(vechud_on) == 0) then {execVM "x_client\x_vec_hud.sqf"};

if (GVAR(WithChopHud)) then {execVM "x_client\x_chop_hud.sqf"};

__ccppfln(x_client\x_playerammobox.sqf);

0 spawn {
	waitUntil {sleep 0.123;!isNil {__XJIPGetVar(GVAR(overcast))}};
	GVAR(lastovercast) = __XJIPGetVar(GVAR(overcast));
	0 setOvercast GVAR(lastovercast);
	if (GVAR(weather) == 0 && GVAR(FastTime) == 0) then {
		execFSM "fsms\WeatherClient.fsm";
		if (GVAR(WithWinterWeather) == 0) then {execVM "scripts\weather_winter.sqf"};
	} else {
		if (GVAR(FastTime) > 0) then {GVAR(weather) = 1};
	};
};

#ifndef __A2ONLY__
if (GVAR(without_vec_ti) == 0) then {
	0 spawn {
		while {true} do {
			waitUntil {sleep 0.412;alive player};
			waitUntil {sleep 0.512;vehicle player != player};
			(vehicle player) disableTIEquipment true;
			waitUntil {sleep 0.489;vehicle player == player};
		};
	};
};
#endif

#ifndef __ACE__
if (!isClass (configFile >> "CfgPatches" >> "ace_main")) then {
	GVAR(mag_check_open) = false;
	__pSetVar [QGVAR(lastgdfcheck), -1];
	FUNC(KeyDownGDF) = {
		private "_ret";
		_ret = false;
		if (_this select 1 == 34 && (_this select 2)) then {
			if (!alive player) exitWith {};
			if (__pGetVar(xr_pluncon)) exitWith {};
			if (time - __pGetVar(GVAR(lastgdfcheck)) < 1) exitWith {_ret = true};
			if (GVAR(mag_check_open)) exitWith {_ret = true};
			GVAR(mag_check_open) = true;
			135923 cutRsc ["d_RscGearFast","PLAIN DOWN"];
			__pSetVar [QGVAR(lastgdfcheck), time];
			_ret = true;
		};
		_ret
	};

	(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call d_fnc_KeyDownGDF"];
};

GVAR(rscCrewTextShownTimeEnd) = -1;
FUNC(MouseWheelRec) = {
	private ["_ct", "_role", "_rpic", "_t", "_ctrl", "_dospawn"];
	if (!alive player || __pGetVar(xr_pluncon)) exitWith {false};
	_ct = if (vehicle player == player) then {
		cursorTarget
	} else {
		vehicle player
	};
	if (isNull _ct) exitWith {false};
	if (_ct distance player > 30) exitWith {false};
	if (!(_ct isKindOf "Car") && !(_ct isKindOf "Tank") && !(_ct isKindOf "Air")) exitWith {false};
	if (_ct isKindOf "ParachuteBase") exitWith {false};
	if (getNumber(configFile >> "CfgVehicles" >> typeOf _ct >> "isBicycle") == 1) exitWith {false};
	if ((_ct call FUNC(GetAliveCrew)) == 0) exitWith {false};
	if (player countFriendly (crew _ct) == 0) exitWith {false};
	
	_ar_P = [];
	_ar_AI = [];

	{
		if (alive _x) then {
			if (isPlayer _x) then {
				_ar_P set [count _ar_P, _x];
			} else {
				_ar_AI set [count _ar_AI, _x];
			};
		};
		sideFriendly
	} foreach (crew _ct);

	_s_p = "";
	if (count _ar_P > 0) then {
		_s_p = "<t align='left'>";
		{
			_role = assignedVehicleRole _x;
			if (count _role > 0) then {
				private "_rpic";
				if (commander _ct == _x) then {
					_rpic = "\ca\ui\data\i_commander_ca.paa";
				} else {
					if (driver _ct == _x) then {
						_rpic = "\ca\ui\data\i_driver_ca.paa";
					} else {
						_rpic = switch (toUpper (_role select 0)) do {
							case "TURRET": {"\ca\ui\data\i_gunner_ca.paa"};
							default {"\CA\ui\data\i_cargo_ca.paa"};
						};
					};
				};
				_s_p = _s_p + "<img image='" + _rpic + "'/> " + (name _x) + "<br/>";
			};
		} foreach _ar_P;
		_s_p = _s_p + "</t>";
	};

	_s_ai = "";
	if (count _ar_AI > 0) then {
		_s_ai = "<t align='left'>";
		{
			_role = assignedVehicleRole _x;
			if (count _role > 0) then {
				private "_rpic";
				if (commander _ct == _x) then {
					_rpic = "\ca\ui\data\i_commander_ca.paa";
				} else {
					if (driver _ct == _x) then {
						_rpic = "\ca\ui\data\i_driver_ca.paa";
					} else {
						_rpic = switch (toUpper (_role select 0)) do {
							case "DRIVER": {"\ca\ui\data\i_driver_ca.paa"};
							case "TURRET": {"\ca\ui\data\i_gunner_ca.paa"};
							default {"\CA\ui\data\i_cargo_ca.paa"};
						};
					};
				};
				_s_ai = _s_ai + "<img image='" + _rpic + "'/> " + (name _x) + " (AI)" + "<br/>";
			};
		} foreach _ar_AI;
		_s_ai = _s_ai + "</t>";
	};

	_t = "<t size='0.6'><t align='left'>Crew " + ([typeOf _ct, 0] call FUNC(GetDisplayName)) + ":</t>" + "<br/>" + _s_p + _s_ai + "</t>";
	121282 cutRsc [QGVAR(rscCrewText), "PLAIN"];
	_ctrl = __uiGetVar(GVAR(rscCrewText)) displayCtrl 9999;
	_ctrl ctrlSetStructuredText parseText _t;
	_ctrl ctrlCommit 0;
	_dospawn = GVAR(rscCrewTextShownTimeEnd) == -1;
	GVAR(rscCrewTextShownTimeEnd) = time + 5;
	if (_dospawn) then {
		0 spawn {
			private "_vecp";
			_vecp = vehicle player;
			waitUntil {sleep 0.221;time > GVAR(rscCrewTextShownTimeEnd) || !alive player || __pGetVar(xr_pluncon) || vehicle player != _vecp};
			121282 cutRsc ["Default", "PLAIN"];
			GVAR(rscCrewTextShownTimeEnd) = -1;
		};
	};
};

(findDisplay 46) displayAddEventHandler ["MouseZChanged", "_this call d_fnc_MouseWheelRec"];
#endif

if (GVAR(MHQDisableNearMT) != 0) then {
	0 spawn {
		private ["_vec", "_vt", "_ti"];
		while {true} do {
			waitUntil {sleep 0.226;alive player};
			waitUntil {sleep 0.226;vehicle player != player};
			_vec = vehicle player;
			_vt = GV(_vec,GVAR(vec_type));
			if (isNil "_vt") then {_vt = ""};
			if (_vt == "MHQ") then {
				while {_vec == vehicle player} do {
					if (fuel _vec != 0) then {
						_ti = __XJIPGetVar(GVAR(current_target_index));
						if (_ti != -1) then {
							_current_target_pos = (GVAR(target_names) select _ti) select 0;
							if (_vec distance _current_target_pos <= GVAR(MHQDisableNearMT)) then {
								_vec setFuel 0;
								[QGVAR(mqhtn), GV(_vec,GVAR(vec_name))] call FUNC(NetCallEvent);
							};
						};
					};
					sleep 0.531;
				};
			} else {
				waitUntil {sleep 0.226;vehicle player == player};
			};
		};
	};
};

#ifndef __ACE__
if (GVAR(WithRevive) == 0) then {
	__ccppfln(x_revive.sqf);
};
#else
if (GVAR(WithRevive) == 0 && GVAR(WithWounds) == 1) then {
	__ccppfln(x_revive.sqf);
};
#endif

__ccppfln(x_clientcustomcode.sqf);

#ifdef __OLD_INTRO__
execVM "x_client\x_intro_old.sqf";
#else
if (isMultiplayer) then {execVM "x_client\x_intro.sqf"};
#endif

// if one of those guys with a small penis can make it on a server and tries to disable user input...
0 spawn {
	while {true} do {
		disableUserInput false;
		sleep 0.863;
	};
};

diag_log [diag_frameno, diag_ticktime, time, "Dom x_setupplayer.sqf processed"];
