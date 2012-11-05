// by Xeno
#include "x_setup.sqf"
private ["_i", "_mrkr", "_str", "_p", "_pos", "_type", "_nobjs", "_box", "_pod", "_weapp", "_magp", "_res", "_taskstr", "_objstatus", "_no", "_color", "_xres", "_winner", "_counterxx", "_text", "_mcol", "_boxnew", "_boxscript", "_scriptarti", "_scriptdrop", "_callvecari1", "_callvecari2", "_callvecdrop", "_script", "_artinum", "_s", "_id", "_trigger", "_types", "_action", "_ar", "_pc", "_element", "_dir", "_fac", "_tactionar", "_boxname", "_aiunitslist", "_one", "_primw", "_muzzles"];

#ifdef __OA__
if !(__TTVer) then {
	// very secret extra thingie..., TODO: add for TT
	_shield = "ProtectionZone_Ep1" createVehicleLocal (position FLAG_BASE);
	_shield setPos (position FLAG_BASE);
	_shield setDir -211;
	_shield setObjectTexture [0,"#(argb,8,8,3)color(0,0,0,0,ca)"];
};
#endif

waitUntil {X_INIT};

sleep 1;

#ifdef __OA__
removeBackpack player;
#endif

d_name_pl = name player;
d_player_faction = faction player;
d_grp_caller = objNull;

d_misc_store = "HeliHEmpty" createVehicleLocal [0,0,0];

XGreyText = {"<t color='#f0bfbfbf'>" + _this + "</t>"};
XRedText = {"<t color='#f0ff0000'>" + _this + "</t>"};
XBlueText = {"<t color='#f07f7f00'>" + _this + "</t>"}; //olive

#ifdef __WOUNDS__
if (WoundsRevTime != -1) then {ace_wounds_prevtime = WoundsRevTime};
#endif

__pSetVar ["BIS_noCoreConversations", true];

[] spawn {
	waitUntil {!isNil {__XJIPGetVar(d_overcast)}};
	d_lastovercast = __XJIPGetVar(d_overcast);
	0 setOvercast d_lastovercast;
	if (d_weather == 0 && d_FastTime == 1) then {
		execFSM "fsms\WeatherClient.fsm";
		if (WithWinterWeather == 0) then {execVM "scripts\weather_winter.sqf"};
	} else {
		if (d_FastTime == 0) then {d_weather = 1};
	};
};

/* for "_i" from 1 to 21 do {
	_mrkr = format ["mt%1", _i];
	_str = "[" + str (markerPos _mrkr) + "," + toString [34] + markerText _mrkr + toString [34] + ",300]";
	if (_i < 21) then {_str = _str + ","};
	_str = _str + " // " + str (_i - 1);
	diag_log _str;
}; */

_p = player;
_pos = position _p;
_type = typeOf _p;
d_string_player = str(player);

if (d_with_ranked) then {d_sm_p_pos = nil};

#ifdef __TT__
d_own_side = if (playerSide == east) then {"EAST"} else {"WEST"};
d_side_player_str = switch (playerSide) do {
	case west: {"west"};
	case east: {"east"};
};
d_own_side_trigger = if (playerSide == east) then {"EAST"} else {"WEST"};

d_side_player = playerSide;

d_rep_truck = if (__OAVer) then {
	if (d_own_side == "WEST") then {"MtvrRepair_DES_EP1"} else {"UralRepair_TK_EP1"}
} else {
	if (d_own_side == "WEST") then {"MtvrRepair"} else {"KamazRepair"}
};

d_create_bike = if (__OAVer) then {
	if (d_own_side == "EAST") then {["Old_bike_TK_INS_EP1","Old_bike_TK_INS_EP1"]} else {["ATV_US_EP1","M1030"]}
} else {
	if (d_own_side == "EAST") then {["MMT_Civ","TT650_Civ"]} else {["MMT_USMC","M1030"]}
};

if (d_with_mgnest) then {
	d_mg_nest = if (__OAVer) then {
		if (d_own_side == "EAST") then {"WarfareBMGNest_PK_TK_EP1"} else {"WarfareBMGNest_M240_US_EP1"}
	} else {
		if (d_own_side == "EAST") then {"RU_WarfareBMGNest_PK"} else {"USMC_WarfareBMGNest_M240"}
	}
};
#endif

#ifndef __OA__
d_the_box = switch (d_own_side) do {
	case "GUER": {"USBasicWeaponsBox"};
	case "EAST": {"USBasicWeaponsBox"};
	case "WEST": {"USBasicWeaponsBox"};
};
d_the_base_box  = switch (d_own_side) do {
	case "GUER": {"GuerillaCacheBox"};
	case "EAST": {"RUSpecialWeaponsBox"};
	case "WEST": {"USSpecialWeaponsBox"};
};
#else
d_the_box = switch (d_own_side) do {
	case "GUER": {"USBasicWeapons_EP1"};
	case "EAST": {"USBasicWeapons_EP1"};
	case "WEST": {"USBasicWeapons_EP1"};
};
d_the_base_box  = switch (d_own_side) do {
	case "GUER": {"USSpecialWeapons_EP1"};
	case "EAST": {"USSpecialWeapons_EP1"};
	case "WEST": {"USSpecialWeapons_EP1"};
};
#endif

#ifndef __ACE__
if (!d_with_ranked) then {
	if (__OAVer) then {
		__cppfln(x_weaponcargo,x_client\x_weaponcargo_oa.sqf);
	} else {
		__cppfln(x_weaponcargo,x_client\x_weaponcargo.sqf);
	};
} else {
	if (__OAVer) then {
		__cppfln(x_weaponcargo,x_client\x_weaponcargor_oa.sqf);
	} else {
		__cppfln(x_weaponcargo,x_client\x_weaponcargor.sqf);
	};
};
#else
if (!d_with_ranked) then {
	if !(__OAVer) then {
		__cppfln(x_weaponcargo,x_client\x_weaponcargo_ace.sqf);
	} else {
		__cppfln(x_weaponcargo,x_client\x_weaponcargo_oa_ace.sqf);
	};
} else {
	if !(__OAVer) then {
		__cppfln(x_weaponcargo,x_client\x_weaponcargor_ace.sqf);
	} else {
		__cppfln(x_weaponcargo,x_client\x_weaponcargor_oa_ace.sqf);
	};
};
#endif

#ifdef __OA__
if (d_halo_jumptype == 0 && !(__ACEVer)) then {
	bis_fnc_halo = compile preprocessFileLineNumbers "AAHALO\Scripts\fn_halo.sqf";
	bis_fnc_dirto = compile preprocessFileLineNumbers "ca\modules\functions\geometry\fn_dirto.sqf";
};
#endif


d_flag_vec = objNull;

__ccppfln(x_client\x_f\x_playerfuncs.sqf);
if (isNil "x_commonfuncs_compiled") then {__ccppfln(x_common\x_f\x_commonfuncs.sqf)};
__ccppfln(x_client\x_f\x_clientfuncs.sqf);

__ccppfln(x_client\x_f\x_netinitclient.sqf);

__cppfln(x_checktrucktrans,x_client\x_checktrucktrans.sqf);
__cppfln(x_checkhelipilot,x_client\x_checkhelipilot.sqf);
__cppfln(x_checkhelipilot_wreck,x_client\x_checkhelipilot_wreck.sqf);
__cppfln(x_checkhelipilotout,x_client\x_checkhelipilotout.sqf);
__cppfln(x_checkenterer,x_client\x_checkenterer.sqf);
__cppfln(x_checkdriver,x_client\x_checkdriver.sqf);
__cppfln(BI_fnc_infoText,x_client\x_f\fn_infoText.sqf);

#ifdef __TT__
if (isNil "x_checkveckillwest") then {
	__cppfln(x_checkveckillwest,x_common\x_checkveckillwest.sqf);
	__cppfln(x_checkveckilleast,x_common\x_checkveckilleast.sqf);
};
#endif

__cppfln(x_getsidemissionclient,x_missions\x_getsidemissionclient.sqf);
__cppfln(x_initvec,x_client\x_initvec.sqf);
#ifndef __OA__
if (isNil "x_flares") then {__cppfln(x_flares,scripts\flares.sqf)};
#endif

if (!isServer) then {execVM "x_bikb\kbinit.sqf"};

if (!X_SPE) then {
#ifndef __TT__
	X_DropZone = __XJIPGetVar(X_DropZone);
#endif
	D_AriTarget = __XJIPGetVar(D_AriTarget);
	D_AriTarget2 = __XJIPGetVar(D_AriTarget2);
};

["dummy_marker", [0,0,0],"ICON","ColorBlack",[1,1],"",0,"Empty"] call XfCreateMarkerLocal;
["arti_target2", [0,0,0],"ICON","ColorBlue",[1,1],"Ari 2 Target",0,"mil_destroy"] call XfCreateMarkerLocal;
"arti_target2" setMarkerPosLocal getPosASL D_AriTarget2;
["arti_target", [0,0,0],"ICON","ColorBlue",[1,1],"Ari 1 Target",0,"mil_destroy"] call XfCreateMarkerLocal;
"arti_target" setMarkerPosLocal getPosASL D_AriTarget;
#ifndef __TT__
["x_drop_zone", [0,0,0],"ICON","ColorBlue",[1,1],"Air Drop Zone",0,"mil_dot"] call XfCreateMarkerLocal;
"x_drop_zone" setMarkerPosLocal getPosASL X_DropZone;
#endif

[4, "d_dam", {(_this select 0) allowDamage (_this select 1)}] call XNetAddEvent;
[2, "recaptured", {_this call XRecapturedUpdate}] call XNetAddEvent;
[2, "doarti", {if (alive player && (player distance _this < 50)) then {"Attention. You were spotted by enemy artillery observers. Incoming enemy artillery !!!" call XfHQChat}}] call XNetAddEvent;
[2, "d_m_box", {_this spawn Xd_create_boxNet}] call XNetAddEvent;
[2, "d_r_box", {_nobjs = nearestObjects [_this, [d_the_box], 10];if (count _nobjs > 0) then {_box = _nobjs select 0;deleteVehicle _box}}] call XNetAddEvent;
[2, "d_air_box", {_box = d_the_box createVehicleLocal _this;_box setPos [_this select 0,_this select 1,0];player reveal _box;[_box] call x_weaponcargo;_box addEventHandler ["killed",{deleteVehicle (_this select 0)}]}] call XNetAddEvent;
[2, "sm_res_client", {playSound "info";d_side_mission_winner = _this select 0;if (d_with_ranked) then {d_sm_running = false}; (_this select 1) execVM "x_missions\x_sidemissionwinner.sqf"}] call XNetAddEvent;
[2, "target_clear", {playSound "fanfare";_this execVM "x_client\x_target_clear_client.sqf"}] call XNetAddEvent;
[2, "update_target", {playSound "info";execVM "x_client\x_createnexttargetclient.sqf"}] call XNetAddEvent;
[2, "d_up_m", {[true] spawn x_getsidemissionclient}] call XNetAddEvent;
[2, "unit_tk", {[format ["%2 was killed by %1. %1 loses %3 score points!", _this select 0, _this select 1, d_sub_tk_points], "GLOBAL"] call XHintChatMsg}] call XNetAddEvent;
[2, "d_ataxi", {_this call Xd_ataxiNet}] call XNetAddEvent;
[2, "d_ai_kill", {if ((_this select 0) in (units (group player))) then {if (player == leader (group player)) then {["d_pas", [player, (_this select 1)]] call XNetCallEvent}}}] call XNetAddEvent;
[2, "d_p_ar", {if (getPlayerUID player == (_this select 2)) then {_this spawn Xfd_player_stuff}}] call XNetAddEvent;
[2, "d_sm_p_pos", {d_sm_p_pos = _this}] call XNetAddEvent;
[2, "mt_winner", {d_mt_winner = _this}] call XNetAddEvent;
[2, "d_n_v", {_this call x_initvec}] call XNetAddEvent;
[2, "d_m_l_o", {_this call XfLightObj}] call XNetAddEvent;
[2, "d_dpicm", {_pod = "ARTY_SADARM_BURST" createVehicleLocal _this;_pod setPos _this}] call XNetAddEvent;
[2, "d_artyt", {_this spawn XfArtyShellTrail}] call XNetAddEvent;
[2, "d_mhqdepl", {_this call Xd_mhqdeplNet}] call XNetAddEvent;
[2, "d_w_n", {[format ["Attention!!!\n\n%1 has changed his name...\nIt was %2 before !!!", _this select 0, _this select 1], "GLOBAL"] call XHintChatMsg}] call XNetAddEvent;
[2, "d_tk_an", {[format ["%1 was kicked because of team killing, # team kills: %2", _this select 0, _this select 1], "GLOBAL"] call XHintChatMsg}] call XNetAddEvent;
[2, "d_ps_an", {
	switch (_this select 1) do {
		case 0: {[format ["%1 was kicked automatically because of too much unnecessary shooting at base", _this select 0], "GLOBAL"] call XHintChatMsg};
		case 1: {[format ["%1 was kicked automatically because he has placed a satchel at base", _this select 0], "GLOBAL"] call XHintChatMsg};
	}
}] call XNetAddEvent;
[2, "d_s_p_inf", {d_u_r_inf = _this}] call XNetAddEvent;
[2, "d_w_ma", {deleteMarkerLocal _this}] call XNetAddEvent;
[2, "d_p_o_a", {
	private "_ar";_ar = _this select 1;
#ifdef __TT__
	if (playerSide == (_ar select 3)) then {
#endif
	if ((_ar select 0) isKindOf "Mash") then {
		[_ar select 1, position (_ar select 0),"ICON","ColorBlue",[0.5,0.5],format ["Mash %1", _ar select 2],0,"mil_dot"] call XfCreateMarkerLocal;
	} else {
		if ((_ar select 0) isKindOf "Base_WarfareBVehicleServicePoint") then {
			[_ar select 1, position (_ar select 0),"ICON","ColorBlue",[0.5,0.5],format ["FARP %1", _ar select 2],0,"mil_dot"] call XfCreateMarkerLocal;
		} else {
			[_ar select 1, position (_ar select 0),"ICON","ColorBlue",[0.5,0.5],format ["MG Nest %1", _ar select 2],0,"mil_dot"] call XfCreateMarkerLocal;
		};
	};
#ifdef __TT__
	};
#endif
}] call XNetAddEvent;
[2, "d_pho", {if (player == _this) then {(format ["You get %1 points for healing other units!", d_ranked_a select 17]) call XfHQChat}}] call XNetAddEvent;
#ifdef __ACE__
[2, "d_haha", {if (player == _this) then {[] call XfDHaha}}] call XNetAddEvent;
#endif
[2, "d_p_o_r", {deleteMarkerLocal (_this select 1)}] call XNetAddEvent;
[2, "d_farp_e", {if (d_eng_can_repfuel) then {_this addAction ["Restore repair/refuel capability" call XBlueText, "x_client\x_restoreeng.sqf"]}}] call XNetAddEvent;
#ifdef __TT__
[2, "d_u_k", {[format ["%1 has killed %2. The %3 team gets %4 point.", _this select 0, _this select 1, _this select 2, d_tt_points select 8], "GLOBAL"] call XHintChatMsg}] call XNetAddEvent;
[2, "vec_killer", {[format ["%1 destroyed a %2 vehicle. The %3 team gets %4 points.", _this select 0, _this select 1, _this select 2, (d_tt_points select 7)], "GLOBAL"] call XHintChatMsg}] call XNetAddEvent;
[2, "d_r_mark", {if (playerSide != (_this select 1)) then {_this spawn {waitUntil {((markerPos (_this select 0)) select 0) != 0};deleteMarkerLocal (_this select 0)}}}] call XNetAddEvent;
[2, "d_attention", {[] call Xattention}] call XNetAddEvent;
[2, "d_w_m_c", {if (playerSide == _this select 3) then {[_this select 0, _this select 1,"ICON","ColorBlue",[1,1],format ["%1 wreck", _this select 2],0,"mil_triangle"] call XfCreateMarkerLocal}}] call XNetAddEvent;
#else
[2, "d_dropansw", {_this call Xd_dropansw}] call XNetAddEvent;
[2, "d_n_jf", {if (WithJumpFlags == 1) then {_this execVM "x_client\x_newflagclient.sqf"}}] call XNetAddEvent;
[2, "d_jet_sf", {[] call Xd_jet_service_facNet}] call XNetAddEvent;
[2, "d_chop_sf", {[] call Xd_chopper_service_facNet}] call XNetAddEvent;
[2, "d_wreck_rf", {[] call Xd_wreck_repair_facNet}] call XNetAddEvent;
[2, "d_p_o_an", {[] call XfPlacedObjAn}] call XNetAddEvent;
[2, "d_s_b_client", {__XJIPGetVar(d_searchbody) setVariable ["d_search_id", __XJIPGetVar(d_searchbody) addAction ["Search body", "x_client\x_searchbody.sqf"]]}] call XNetAddEvent;
[2, "d_rem_sb_id", {if (!isNil {__XJIPGetVar(d_searchbody) getVariable "d_search_id"}) then {__XJIPGetVar(d_searchbody) removeAction (__XJIPGetVar(d_searchbody) getVariable "d_search_id")}}] call XNetAddEvent;
[2, "d_intel_upd", {_this call Xd_intel_updNet}] call XNetAddEvent;
[2, "d_w_m_c", {[_this select 0, _this select 1,"ICON","ColorBlue",[1,1],format ["%1 wreck", _this select 2],0,"mil_triangle"] call XfCreateMarkerLocal}] call XNetAddEvent;
#endif
#ifndef __ACE__
[2, "d_bi_a_v", {[_this] call BIS_ARTY_F_initVehicle}] call XNetAddEvent;
#endif
#ifdef __REVIVE__
[2, "d_del_m", {deleteMarkerLocal (format ["%1 is down", _this])}] call XNetAddEvent;
#endif
#ifdef __MANDO__
[2, "d_man_r", {_this setVariable ["mando_source_level", 100]}] call XNetAddEvent;
#endif
[2, "d_smsg", {"Attention... the Scud will launch in a few seconds...." call XfHQChat}] call XNetAddEvent;

[] spawn {
	sleep 1 + random 3;
	if (isMultiplayer) then {
		["d_p_a", getPlayerUID player] call XNetCallEvent;// ask the server for the client score, etc
		waitUntil {!d_still_in_intro};
#ifndef __ACE__
		d_phd_invulnerable = false;
#else
		player setVariable ["ace_w_allow_dam", nil];
#endif
		sleep 2;
		[] spawn {
			__pSetVar ["d_player_old_rank", "PRIVATE"];
			while {true} do {call XPlayerRank;sleep 5.01};
		};
	} else {
		d_player_autokick_time = AutoKickTime;
#ifndef __ACE__
		d_phd_invulnerable = false;
#else
		player setVariable ["ace_w_allow_dam", nil];
#endif
	};
};

[] spawn {
	sleep 2;
	{_x call x_initvec;sleep 0.01} forEach vehicles
};

if (d_with_ranked) then {
	// basic rifle at start
	_weapp = "";
	_magp = "";
	switch (d_own_side) do {
		case "WEST": {
#ifndef __OA__
			_weapp = "M16A4";
#else
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

#define __tctn _target_array = d_target_names select _res;\
_current_target_pos = _target_array select 0;\
_target_name = _target_array select 1;\
_target_radius = _target_array select 2
_taskstr = "task%1 = player createSimpleTask ['obj%1'];task%1 setSimpleTaskDescription ['Seize %2...','Main Target: Seize %2','Main Target: Seize %2'];task%1 settaskstate _objstatus;task%1 setSimpleTaskDestination _current_target_pos;";
#define __tmarker [_target_name, _current_target_pos,#ELLIPSE,_color,[_target_radius,_target_radius]] call XfCreateMarkerLocal
if (d_SidemissionsOnly == 1) then {
#ifndef __TT__
	for "_i" from 0 to (count __XJIPGetVar(resolved_targets) - 1) do {
		_res =  __XJIPGetVar(resolved_targets) select _i;
		__tctn;
		_no = _current_target_pos nearestObject "HeliHEmpty";
		_color = "ColorGreen";
		_objstatus = "Succeeded";
		if (!isNull _no) then {
			if (direction _no > 355) then {
				_objstatus = "Failed";
				_color = "ColorRed";
				[_target_name, _current_target_pos,"ELLIPSE",_color,[_target_radius,_target_radius],"",0,"Marker","FDiagonal"] call XfCreateMarkerLocal;
			} else {
				__tmarker;
			};
		} else {
			__tmarker;
		};
		call compile format [_taskstr,_res + 2,_target_name];
	};
#else
	for "_i" from 0 to (count __XJIPGetVar(resolved_targets) - 1) do {
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
#endif

	d_current_seize = "";
	if (__XJIPGetVar(current_target_index) != -1 && !__XJIPGetVar(target_clear)) then {
		__TargetInfo;
		_current_target_pos = _target_array2 select 0;
		d_current_seize = _current_target_name;
		_target_radius = _target_array2 select 2;	
	#ifndef __TT__
		_color = "ColorRed";
	#else
		_color = "ColorYellow";
	#endif
		[_current_target_name, _current_target_pos,"ELLIPSE",_color,[_target_radius,_target_radius]] call XfCreateMarkerLocal;
		"dummy_marker" setMarkerPosLocal _current_target_pos;
		_objstatus = "Created";
		call compile format [(_taskstr + "d_current_task = task%1;"), __XJIPGetVar(current_target_index) + 2,_current_target_name];
	};
};

{
	if (typeName _x == "ARRAY") then {
#ifdef __TT__
		if (playerSide == (_x select 3)) then {
#endif
		[(_x select 0), (_x select 1),"ICON","ColorBlue",[1,1],format ["%1 wreck", (_x select 2)],0,"mil_triangle"] call XfCreateMarkerLocal;
#ifdef __TT__
		};
#endif
	};
} forEach __XJIPGetVar(d_wreck_marker);

if (d_vechud_on == 0) then {execVM "x_client\x_vec_hud.sqf"};

if (WithChopHud) then {execVM "x_client\x_chop_hud.sqf"};

execVM "x_client\x_playerammobox.sqf";

if (d_SidemissionsOnly == 1) then {
	_counterxx = 0;
	{
		_pos = position _x;
		[format ["d_paraflag%1", _counterxx], _pos,"ICON","ColorYellow",[0.5,0.5],"Parajump",0,"mil_flag"] call XfCreateMarkerLocal;
		
		_counterxx = _counterxx + 1;
		if (d_jumpflag_vec == "") then {
			_x addaction ["(Choose Parachute location)" call XBlueText,"aahalo\x_paraj.sqf"];
		} else {
			_text = format ["(Create %1)",d_jumpflag_vec];
			_x addAction [_text call XBlueText,"x_client\x_bike.sqf",[d_jumpflag_vec,1]];
		};
#ifdef __ACE__
		if (d_jumpflag_vec == "") then {
			_box = "ACE_RuckBox" createVehicleLocal _pos;
			clearMagazineCargo _box;
			clearWeaponCargo _box;
			_box addweaponcargo ["ACE_ParachutePack",10];
		};
#endif
	} forEach __XJIPGetVar(jump_flags);
};

if (d_SidemissionsOnly == 1) then {
	if (!__XJIPGetVar(d_mt_radio_down)) then {if (__XJIPGetVar(mt_radio_pos) select 0 != 0) then {["main_target_radiotower", __XJIPGetVar(mt_radio_pos),"ICON","ColorBlack",[0.5,0.5],"Radiotower",0,"mil_dot"] call XfCreateMarkerLocal}};
};

if (d_SidemissionsOnly == 1) then {
	if (count __XJIPGetVar(d_currentcamps) > 0) then {
		{
			if (!isNull _x) then {
#ifndef __TT__
				_mcol = switch (_x getVariable "D_SIDE") do {
					case "WEST": {if (d_own_side == "EAST") then {"ColorBlack"} else {"ColorBlue"}};
					case "EAST": {if (d_own_side == "WEST") then {"ColorBlack"} else {"ColorBlue"}};
				};
#else
				_mcol = switch (_x getVariable "D_SIDE") do {
					case "WEST": {"ColorBlue"};
					case "EAST": {"ColorRed"};
					case "GUER": {"ColorBlack"};
				};
#endif
				[format["dcamp%1",_x getVariable "D_INDEX"], position _x,"ICON",_mcol,[0.5,0.5],"",0,"Strongpoint"] call XfCreateMarkerLocal;
			};
		} forEach __XJIPGetVar(d_currentcamps);
	};
};

if (__XJIPGetVar(all_sm_res)) then {d_current_mission_text="All missions resolved!"} else {[false] spawn x_getsidemissionclient};

#define __paddweap(xweap) if (!(_p hasWeapon #xweap)) then {_p addWeapon #xweap}
__paddweap(NVGoggles);
#ifdef __OA__
_weapop = weapons player;
if (!("Binocular_Vector" in _weapop) && !("Laserdesignator" in _weapop)) then {
#endif
__paddweap(Binocular);
#ifdef __OA__
};
#endif
__paddweap(ItemGPS);

#ifndef __ACE__
if (daytime > 19.75 || daytime < 4.15) then {_p action ["NVGoggles",_p]};
#endif

__cppfln(x_playerspawn,x_client\x_playerspawn.sqf);

if (__ReviveVer || d_with_ai || !d_with_respawn_dialog_after_death) then {
	__cppfln(x_checkkill,x_client\x_checkkill.sqf);
	player addEventHandler ["killed", {_this spawn x_checkkill}];
} else {
	__cppfln(x_dlgopen,x_client\x_open.sqf);
#ifndef __TT__
	__cppfln(x_checkkill,x_client\x_checkkill.sqf);
	player addEventHandler ["killed", {_this spawn x_checkkill}];
#else
	if (playerSide == west) then {
		__cppfln(x_checkkillwest,x_client\x_checkkillwest.sqf);
		player addEventHandler ["killed", {_this spawn x_checkkillwest}];
	} else {
		__cppfln(x_checkkilleast,x_client\x_checkkilleast.sqf);
		player addEventHandler ["killed", {_this spawn x_checkkilleast}];
	};
#endif
};

if (count __XJIPGetVar(d_ammo_boxes) > 0) then {
	private ["_box_pos", "_boxnew", "_boxscript"];
	{
		if (typeName _x == "ARRAY") then {
			_box_pos = _x select 0;
#ifndef __TT__
			if ((_x select 1) != "") then {[(_x select 1), _box_pos,"ICON","ColorBlue",[0.5,0.5],"Ammo",0,"mil_marker"] call XfCreateMarkerLocal};
#else
			if ((_x select 1) != "" && playerSide == (_x select 2)) then {[(_x select 1), _box_pos,"ICON","ColorBlue",[0.5,0.5],"Ammo",0,"mil_marker"] call XfCreateMarkerLocal};
#endif
			_boxnew = d_the_box createVehicleLocal _box_pos;
			_boxnew setPos _box_pos;
#ifndef __REVIVE__
			_boxnew addAction ["Save gear layout" call XBlueText, "x_client\x_savelayout.sqf"];
			_boxnew addAction ["Clear gear layout" call XBlueText, "x_client\x_clearlayout.sqf"];
#endif
			[_boxnew] call x_weaponcargo;
			_boxnew addEventHandler ["killed",{["d_r_box", position _this select 0] call XNetCallEvent;deleteVehicle (_this select 0)}];
		};
	} forEach __XJIPGetVar(d_ammo_boxes);
};

d_player_can_call_drop = false;
d_player_can_call_arti = false;

_scriptarti = "x_client\x_artillery.sqf";
_scriptdrop = "x_client\x_calldrop.sqf";
_callvecari1 = {
	d_vec_ari1_id = -8877;
	[_pos, [0, 0, 0, false],["NONE", "PRESENT", true], ["vehicle player != player && !((vehicle player) isKindOf 'BIS_Steerable_Parachute') && !((vehicle player) isKindOf 'ParachuteBase')", "d_ari1_vehicle = vehicle player;if (d_vec_ari1_id == -8877) then {d_vec_ari1_id = d_ari1_vehicle addAction ['Call Artillery' call XGreyText, 'x_client\x_artillery.sqf',[1,D_AriTarget],-1,false]}", "if (d_vec_ari1_id != -8877) then {d_ari1_vehicle removeAction d_vec_ari1_id;d_vec_ari1_id = -8877}"]] call XfCreateTrigger;
};
_callvecari2 = {
	d_vec_ari1_id = -8877;
	[_pos, [0, 0, 0, false], ["NONE", "PRESENT", true], ["vehicle player != player && !((vehicle player) isKindOf 'BIS_Steerable_Parachute') && !((vehicle player) isKindOf 'ParachuteBase')", "d_ari1_vehicle = vehicle player;if (d_vec_ari1_id == -8877) then {d_vec_ari1_id = d_ari1_vehicle addAction ['Call Artillery' call XGreyText, 'x_client\x_artillery.sqf',[2,D_AriTarget2],-1,false]}", "if (d_vec_ari1_id != -8877) then {d_ari1_vehicle removeAction d_vec_ari1_id;d_vec_ari1_id = -8877}"]] call XfCreateTrigger;
};
_callvecdrop = {
	d_vec_drop_id = -8877;
	[_pos, [0, 0, 0, false], ["NONE", "PRESENT", true], ["vehicle player != player && !((vehicle player) isKindOf 'BIS_Steerable_Parachute') && !((vehicle player) isKindOf 'ParachuteBase')", "d_drop_vehicle = vehicle player;if (d_vec_drop_id == -8877) then {d_vec_drop_id = d_drop_vehicle addAction ['Call Drop' call XGreyText, 'x_client\x_calldrop.sqf',[],-1,false]}", "if (d_vec_drop_id != -8877) then {d_drop_vehicle removeAction d_vec_drop_id;d_vec_drop_id = -8877}"]] call XfCreateTrigger;
};

if (d_with_ai) then {
	[] spawn {
		waitUntil {!isNil {__XJIPGetVar(D_AI_HUT)}};
		_D_AI_HUT = __XJIPGetVar(D_AI_HUT);
		_D_AI_HUT allowDamage false;
		player reveal _D_AI_HUT;
		_script = "x_client\x_addsoldier.sqf";
		#define __aiadda _D_AI_HUT addAction
#ifdef __OA__
		__aiadda ["Recruit Soldier" call XBlueText,_script,"%1_Soldier_EP1"];
		__aiadda ["Recruit AT Soldier" call XBlueText,_script,"%1_Soldier_AT_EP1"];
		__aiadda ["Recruit Medic" call XBlueText,_script,"%1_Soldier_Medic_EP1"];
		__aiadda ["Recruit MG Gunner" call XBlueText,_script,"%1_Soldier_MG_EP1"];
		__aiadda ["Recruit Grenadier" call XBlueText,_script,"%1_Soldier_GL_EP1"];
		__aiadda ["Recruit Sniper" call XBlueText,_script,"%1_Soldier_Sniper_EP1"];
		__aiadda ["Recruit AA Soldier" call XBlueText,_script,"%1_Soldier_AA_EP1"];
		__aiadda ["Recruit Specop" call XBlueText,_script,"Specop"];
#else
		__aiadda ["Recruit Soldier" call XBlueText,_script,"%1_Soldier"];
		__aiadda ["Recruit AT Soldier" call XBlueText,_script,"%1_Soldier_AT"];
		__aiadda ["Recruit Medic" call XBlueText,_script,"%1_Soldier_Medic"];
		__aiadda ["Recruit MG Gunner" call XBlueText,_script,"%1_Soldier_MG"];
		if (d_own_side in ["WEST","GUER"]) then {
			__aiadda ["Recruit Sniper" call XBlueText,_script,"%1_SoldierS_Sniper"];
		} else {
			__aiadda ["Recruit Sniper" call XBlueText,_script,"%1_Soldier_Sniper"];
		};
		__aiadda ["Recruit AA Soldier" call XBlueText,_script,"%1_Soldier_AA"];
		__aiadda ["Recruit Specop" call XBlueText,_script,"Specop"];
#endif
		__aiadda ["Dismiss AI" call XRedText,"x_client\x_dismissai.sqf"];
		_marker_name = "Recruit_x";
		[_marker_name, position _D_AI_HUT,"ICON","ColorYellow",[0.5,0.5],"Recruit Barracks",0,"mil_dot"] call XfCreateMarkerLocal;
	};

	if (!(__ACEVer)) then {
		d_player_can_call_arti = true;
		d_player_can_call_drop = true;
		__pSetVar ["d_ari1", _p addAction ["Call Artillery" call XGreyText, _scriptarti,[1,D_AriTarget],-1,false]];
		__pSetVar ["d_dropaction", _p addAction ["Call Drop" call XGreyText, _scriptdrop,[],-1,false]];
		call _callvecari1;
		call _callvecdrop;
	} else {
		[1] execVM "x_client\x_artiradiocheck.sqf";
		execVM "x_client\x_dropradiocheck.sqf";
	};
	_p addRating 20000;

	["d_p_group", group player] call XNetCallEvent;
} else {
	if (d_string_player in d_can_use_artillery) then {
		if (!(__ACEVer)) then {
			if (d_string_player == "RESCUE") then {
				d_player_can_call_arti = true;
				__pSetVar ["d_ari1", _p addAction ["Call Artillery" call XGreyText, _scriptarti,[1,D_AriTarget],-1,false]];
				call _callvecari1;
			};
			if (d_string_player == "RESCUE2") then {
				d_player_can_call_arti = true;
				__pSetVar ["d_ari1", _p addAction ["Call Artillery" call XGreyText, _scriptarti,[2,D_AriTarget2],-1,false]];
				call _callvecari2;
			};
		} else {
			_artinum = switch (d_string_player) do {
				case "RESCUE": {1};
				case "RESCUE2": {2};
				default {0};
			};
			if (_artinum == 0) exitWith {};
			[_artinum] execVM "x_client\x_artiradiocheck.sqf";
		};
	};
	if (d_string_player in d_can_call_drop) then {
		d_player_can_call_drop = true;
		if (!(__ACEVer)) then {
			__pSetVar ["d_dropaction", _p addAction ["Call Drop" call XGreyText, _scriptdrop,[],-1,false]];
			call _callvecdrop;
		} else {
			execVM "x_client\x_dropradiocheck.sqf";
		};
	};
};

#ifndef __REVIVE__
_respawn_marker = "";
#define __dml_w deleteMarkerLocal #respawn_west
#define __dml_e deleteMarkerLocal #respawn_east
#define __dml_g deleteMarkerLocal #respawn_guerrila
switch (d_own_side) do {
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
	if (playerSide == west) then {
		__rmsmpl markerPos "base_spawn_1";
	} else {
		__rmsmpl markerPos "base_spawn_2";
	};
} else {
	if (!isNil "d_with_carrier") then {
		"base_spawn_1" setMarkerPosLocal [markerPos "base_spawn_1" select 0, markerPos "base_spawn_1" select 1, 15.9];
		__rmsmpl [markerPos "base_spawn_1" select 0, markerPos "base_spawn_1" select 1, 15.9];
	} else {
		__rmsmpl markerPos "base_spawn_1";
	};
};
#else
if (!isNil "d_with_carrier") then {"base_spawn_1" setMarkerPosLocal [markerPos "base_spawn_1" select 0, markerPos "base_spawn_1" select 1, 15.9]};
#endif

__pSetVar ["d_ass", _p addAction ["Show Status" call XGreyText, "x_client\x_showstatus.sqf",[],-1,false]];

__pSetVar ["d_pbp_id", -9999];
d_backpack_helper = [];
__pSetVar ["d_custom_backpack", []];
__pSetVar ["d_player_backpack", []];
if (WithBackpack) then {
	d_prim_weap_player = primaryWeapon _p;
	_s = format ["%1 to Backpack", [d_prim_weap_player,1] call XfGetDisplayName];
	if (d_prim_weap_player != "" && d_prim_weap_player != " ") then {
		__pSetVar ["d_pbp_id", _p addAction [_s call XGreyText, "x_client\x_backpack.sqf",[],-1,false]];
	};
	// No Weapon fix for backpack
	[_pos, [0, 0, 0, false], ["NONE", "PRESENT", true], ["primaryWeapon player != d_prim_weap_player && primaryWeapon player != ' ' && !dialog","call {d_prim_weap_player = primaryWeapon player;_id = player getVariable 'd_pbp_id';if (_id != -9999 && count (player getVariable 'd_player_backpack') == 0) then {player removeAction _id;player setVariable ['d_pbp_id', -9999]};if ((player getVariable 'd_pbp_id' == -9999) && count (player getVariable 'd_player_backpack') == 0 && d_prim_weap_player != '' && d_prim_weap_player != ' ') then {player setVariable ['d_pbp_id', player addAction [format ['%1 to Backpack', [d_prim_weap_player,1] call XfGetDisplayName] call XGreyText, 'x_client\x_backpack.sqf',[],-1,false]]}}",""]] call XfCreateTrigger;
};

#ifndef __TT__
d_base_trigger = createTrigger["EmptyDetector" ,d_base_array select 0];
d_base_trigger setTriggerArea [d_base_array select 1, d_base_array select 2, d_base_array select 3, true];
#else
_dbase_a = if (playerSide == west) then {d_base_array select 0} else {d_base_array select 1};
d_base_trigger = createTrigger["EmptyDetector" ,_dbase_a select 0];
d_base_trigger setTriggerArea [_dbase_a select 1, _dbase_a select 2, d_base_array select 3, true];
#endif
d_base_trigger setTriggerActivation [d_own_side_trigger, "PRESENT", true];
d_base_trigger setTriggerStatements["this", "", ""];

// special triggers for engineers, AI version, everybody can repair and flip vehicles
d_eng_can_repfuel = false;
if (d_string_player in d_is_engineer || d_with_ai) then {
	d_eng_can_repfuel = true;
#ifndef __TT__
	d_engineer_trigger = createTrigger["EmptyDetector" ,d_base_array select 0];
	d_engineer_trigger setTriggerArea [d_base_array select 1, d_base_array select 2, d_base_array select 3, true];
#else
	_dbase_a = if (playerSide == west) then {d_base_array select 0} else {d_base_array select 1};
	d_engineer_trigger = createTrigger["EmptyDetector" ,_dbase_a select 0];
	d_engineer_trigger setTriggerArea [_dbase_a select 1, _dbase_a select 2, d_base_array select 3, true];
#endif
	d_engineer_trigger setTriggerActivation [d_own_side_trigger, "PRESENT", true];
	d_engineer_trigger setTriggerStatements["!d_eng_can_repfuel && player in thislist", "d_eng_can_repfuel = true;'Engineer repair/refuel capability restored.' call XfGlobalChat;", ""];
	
	if (d_with_ranked) then {d_last_base_repair = -1};
	
	[_pos, [0, 0, 0, false], ["NONE", "PRESENT", true], ["call x_ffunc", "actionID1=player addAction ['Unflip Vehicle' call XGreyText, 'scripts\unflipVehicle.sqf',[d_objectID1],-1,false];", "player removeAction actionID1"]] call XfCreateTrigger;
	
	_trigger = createTrigger["EmptyDetector" ,_pos];
	_trigger setTriggerArea [0, 0, 0, true];
	_trigger setTriggerActivation ["NONE", "PRESENT", true];
#ifndef __ENGINEER_OLD__
	_trigger setTriggerStatements["call x_sfunc", "actionID6 = player addAction ['Analyze Vehicle' call XGreyText, 'x_client\x_repanalyze.sqf',[],-1,false];actionID2 = player addAction ['Repair/Refuel Vehicle' call XGreyText, 'x_client\x_repengineer.sqf',[],-1,false]", "player removeAction actionID6;player removeAction actionID2"];
#else
	_trigger setTriggerStatements["call x_sfunc", "actionID2 = player addAction ['Repair/Refuel Vehicle' call XGreyText, 'x_client\x_repengineer_old.sqf',[],-1,false]", "player removeAction actionID2"];
#endif
	__pSetVar ["d_is_engineer",true];
	__pSetVar ["d_farp_pos", []];
	__pSetVar ["d_farpaction", _p addAction ["Build FARP" call XGreyText, "x_client\x_farp.sqf",[],-1,false]];
	
	{_x addAction ["Restore repair/refuel capability" call XBlueText, "x_client\x_restoreeng.sqf"]} forEach (__XJIPGetVar(d_farps));
};

#ifndef __TT__
// Enemy at base
if (isNil "d_with_carrier") then {
	d_there_are_enemies_atbase = false;
	"enemy_base" setMarkerPosLocal (d_base_array select 0);
	"enemy_base" setMarkerDirLocal (d_base_array select 3);
	[d_base_array select 0, [d_base_array select 1, d_base_array select 2, d_base_array select 3, true], [d_enemy_side, "PRESENT", true], ["'Man' countType thislist > 0 || 'Tank' countType thislist > 0 || 'Car' countType thislist > 0", "[0] call XBaseEnemies;'enemy_base' setMarkerSizeLocal [d_base_array select 1,d_base_array select 2];d_there_are_enemies_atbase = true", "[1] call XBaseEnemies;'enemy_base' setMarkerSizeLocal [0,0];d_there_are_enemies_atbase = false"]] call XfCreateTrigger;

	switch (true) do {
		case (worldName == "chernarus"): {
			[[4541.21,10302.4,0], [1200, 600, 60, true], [d_enemy_side, "PRESENT", true], ["'Man' countType thislist > 0 || 'Tank' countType thislist > 0 || 'Car' countType thislist > 0", "hint 'Enemy units near your base'", ""]] call XfCreateTrigger;
		};
		case (worldName == "Takistan"): {
			[[8024.99,1910.05,0], [900, 600, -28.3, true], [d_enemy_side, "PRESENT", true], ["'Man' countType thislist > 0 || 'Tank' countType thislist > 0 || 'Car' countType thislist > 0", "hint 'Enemy units near your base'", ""]] call XfCreateTrigger;
		};
	};
};
#endif

// Show status vehicle trigger, add action to player vehicle
d_vec_showstat_id = -8876;
[_pos, [0, 0, 0, false], ["NONE", "PRESENT", true],["vehicle player != player && !((vehicle player) isKindOf 'BIS_Steerable_Parachute') && !((vehicle player) isKindOf 'ParachuteBase')", "d_vec_showstat = vehicle player;if (d_vec_showstat_id == -8876) then {d_vec_showstat_id = d_vec_showstat addAction ['Show Status' call XGreyText, 'x_client\x_showstatus.sqf',[],-1,false]}", "if (d_vec_showstat_id != -8876) then {d_vec_showstat removeAction d_vec_showstat_id;d_vec_showstat_id = -8876}"]] call XfCreateTrigger;

d_player_is_medic = false;
if (d_string_player in d_is_medic) then {
	d_player_is_medic = true;
	__pSetVar ["d_medicaction", _p addAction ["Build Mash" call XGreyText, "x_client\x_mash.sqf",[],-1,false]];
	__pSetVar ["d_medtent", []];
};

d_player_can_build_mgnest = false;
if (d_with_mgnest) then {
	if (d_string_player in d_can_use_mgnests) then {
		d_player_can_build_mgnest = true;
		__pSetVar ["d_mgnest_pos", []];
		__pSetVar ["d_mgnestaction", _p addAction ["Build MG Nest" call XGreyText, "x_client\x_mgnest.sqf",[],-1,false]];
	};
};

execVM "x_client\x_marker.sqf";

if (!isNil "d_action_menus_type") then {
	if (count d_action_menus_type > 0) then {
		{
			_types = _x select 0;
			if (count _types > 0) then {
				if (_type in _types) then { 
					_action = _p addAction [(_x select 1) call XGreyText,_x select 2,[],-1,false];
					_x set [3, _action];
				};
			} else {
				_action = _p addAction [(_x select 1) call XGreyText,_x select 2,[],-1,false];
				_x set [3, _action];
			};
		} forEach d_action_menus_type;
	};
};
if (!isNil "d_action_menus_unit") then {
	if (count d_action_menus_unit > 0) then {
		{
			_types = _x select 0;
			_ar = _x;
			if (count _types > 0) then {
				{
					private "_pc";
					_pc = __getMNsVar(_x);
					if (_p ==  _pc) exitWith { 
						_action = _p addAction [(_ar select 1) call XGreyText,_ar select 2,[],-1,false];
						_ar set [3, _action];
					};
				} forEach _types
			} else {
				_action = _p addAction [(_x select 1) call XGreyText,_x select 2,[],-1,false];
				_x set [3, _action];
			};
		} forEach d_action_menus_unit;
	};
};

if (!isNil "d_action_menus_vehicle") then {
	if (count d_action_menus_vehicle > 0) then {execVM "x_client\x_vecmenus.sqf"};
};

#ifndef __TT__
if (isNil "d_with_carrier" && d_SidemissionsOnly == 1) then {
	if (d_string_player in d_is_engineer || d_with_ai) then {
		if (__XJIPGetVar(d_jet_serviceH) && !__XJIPGetVar(d_jet_s_reb)) then {
			[0] spawn XFacAction;
		};
		if (__XJIPGetVar(d_chopper_serviceH) && !__XJIPGetVar(d_chopper_s_reb)) then {
			[1] spawn XFacAction;
		};
		if (__XJIPGetVar(d_wreck_repairH) && !__XJIPGetVar(d_wreck_s_reb)) then {
			[2] spawn XFacAction;
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
	if (__XJIPGetVar(d_jet_serviceH) && !__XJIPGetVar(d_jet_s_reb)) then {
		_element = d_aircraft_facs select 0;
		if !(__OAVer) then {
			__facset;
		} else {
			__facset2;
		};
	};
	if (__XJIPGetVar(d_chopper_serviceH) && !__XJIPGetVar(d_chopper_s_reb)) then {
		_element = d_aircraft_facs select 1;
		if !(__OAVer) then {
			__facset;
		} else {
			__facset2;
		};
	};
	if (__XJIPGetVar(d_wreck_repairH) && !__XJIPGetVar(d_wreck_s_reb)) then {
		_element = d_aircraft_facs select 2;
		if !(__OAVer) then {
			__facset;
		} else {
			__facset2;
		};
	};
};
#endif

#ifndef __ACE__
execFSM "fsms\airincoming.fsm";
#endif

if (WithJumpFlags == 0) then {ParaAtBase = 1};

_tactionar = ["Teleport" call XGreyText,"x_client\x_teleport.sqf"];
#ifndef __TT__
if (d_WithMHQTeleport == 0) then {
	FLAG_BASE addAction _tactionar;
};
if (d_with_ai || (ParaAtBase == 0)) then {
	FLAG_BASE addaction ["(Choose Parachute location)" call XGreyText,"aahalo\x_paraj.sqf"];
};
#else
if (d_WithMHQTeleport == 0) then {
	(if (d_own_side == "WEST") then {WFLAG_BASE} else {EFLAG_BASE}) addAction _tactionar;
};
#endif

if (ParaAtBase == 1) then {
	_s = "Teleporter";
#ifndef __TT__
	_s setMarkerTextLocal _s;
#else
	if (d_own_side == "WEST") then {
		_s setMarkerTextLocal _s;
	} else {
		"teleporter_1" setMarkerTextLocal _s;
	};
#endif
};

#ifdef __ACE__
if (!(__TTVer)) then {
	for "_i" from 0 to (count d_ace_boxes) - 1 do {
		_element = d_ace_boxes select _i;
		_box = (_element select 0) createVehicleLocal (_element select 1);
		player reveal _box;
		_box setDir (_element select 2);
		_box setPos (_element select 1);
		[_box, (_element select 1), (_element select 2), (_element select 0)] spawn {
			private ["_box","_boxname","_pos","_dir"];
			_box = _this select 0;
			_pos = _this select 1;
			_dir = _this select 2;
			_boxname = _this select 3;
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
} else {
	_element = d_ace_boxes select (switch (playerSide) do {case east: {1};case west: {0};});
	_box = (_element select 0) createVehicleLocal (_element select 1);
	player reveal _box;
	_box setDir (_element select 2);
	_box setPos (_element select 1);
	[_box, (_element select 1), (_element select 2), (_element select 0)] spawn {
		private ["_box","_boxname","_pos","_dir"];
		_box = _this select 0;
		_pos = _this select 1;
		_dir = _this select 2;
		_boxname = _this select 3;
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
d_ace_boxes = nil;
d_pos_ace_boxes = nil;
#endif

if (!AmmoBoxHandling) then {
	[AMMOLOAD] execFSM "fsms\ammoload.fsm";
#ifdef __TT__
	[AMMOLOAD2] execFSM "fsms\ammoload.fsm";
#endif
};

if (!d_with_ranked) then {
	if (AutoKickTime > 0 && d_SidemissionsOnly == 1) then {execFSM "fsms\autokick.fsm"};
} else {
	execVM "x_client\x_playerveccheck.sqf";
#ifndef __ACE__
	player addEventHandler ["handleHeal", {_this call XHandleHeal}];
#else
	if (d_string_player in d_is_medic) then {execVM "x_client\x_mediccheck.sqf"};
#endif
	execVM "x_client\x_playervectrans.sqf";
};

if (d_with_ai) then {
	d_heli_taxi_available = true;
	_trigger = createTrigger ["EmptyDetector", _pos];
	_trigger setTriggerText "Call in Air Taxi";
	_trigger setTriggerActivation ["HOTEL", "PRESENT", true];
	_trigger setTriggerStatements ["this", "xhandle = [] execVM ""x_client\x_airtaxi.sqf""",""];
};

d_vec_end_time = -1;

if (WithRepStations == 0) then {execFSM "fsms\repstation.fsm"};

if (isMultiplayer) then {
	[] spawn {
		sleep (0.5 + random 2);
#ifndef __TT__
		["d_p_varn", [getPlayerUID player,d_string_player]] call XNetCallEvent;
#else
		["d_p_varn", [getPlayerUID player,d_string_player,playerSide]] call XNetCallEvent;
#endif
	};
};

#ifdef __TT__
	if (playerSide == east) then {
		"arti_target" setMarkerAlphaLocal 0;
		"arti_target2" setMarkerTextLocal "Ari Target";
	} else {
		"arti_target2" setMarkerAlphaLocal 0;
		"arti_target" setMarkerTextLocal "Ari Target";
	};
#endif

"BIS_clouds_Logic" createVehicleLocal (position player);

_d_dam = __XJIPGetVar(d_dam);
if (count _d_dam > 0) then {{_x allowDamage false} forEach _d_dam};

if (d_halo_jumptype == 1) then {
	execFSM "fsms\parachutecheck.fsm";
};


#ifndef __ACE__
if !(__OAVer) then {
	execFSM "fsms\flir.fsm";
};
#endif

if (LimitedWeapons) then {
	d_poss_weapons = [];
	for "_i" from 0 to (count d_limited_weapons_ar - 2) do {
		_ar = d_limited_weapons_ar select _i;
		if (d_string_player in (_ar select 0)) exitWith {d_poss_weapons =+ _ar select 1};
	};
	if (count d_poss_weapons == 0) then {d_poss_weapons =+ (d_limited_weapons_ar select (count d_limited_weapons_ar - 1)) select 1};
	execFSM "fsms\limitweapons.fsm";
	d_limited_weapons_ar = nil;
};

execVM "x_msg\x_playernamehud.sqf";

if (d_SidemissionsOnly == 1) then {
	execFSM "fsms\campdialog.fsm";
};

#ifdef __AI__
[] spawn {
	private ["_aiunitslist", "_i", "_one"];
	_aiunitslist = [];
	while {true} do {
		_d_ai_punits = d_ai_punits;
		if (count _d_ai_punits > 0) then {
			[_aiunitslist, _d_ai_punits] call X_fnc_arrayPushStack;
			d_ai_punits = [];
		};
		if (count _aiunitslist > 0) then {
			for "_i" from 0 to (count _aiunitslist - 1) do {
				_one = _aiunitslist select _i;
				if (!alive _one) then {
					d_current_ai_num = d_current_ai_num - 1;
					_aiunitslist set [_i, -1];
				} else {
					if !(_one in (units (group player))) then {
						d_current_ai_num = d_current_ai_num - 1;
						_aiunitslist set [_i, -1];
					};
				};
				sleep 0.442;
			};
			_aiunitslist = _aiunitslist - [-1];
			if (d_current_ai_num < 0) then {d_current_ai_num = 0};
		};
		sleep 1.212;
	};
};
#endif

execFSM "fsms\isadmin.fsm";

_p = player;
_primw = primaryWeapon _p;
if (_primw != "") then {
	_p selectWeapon _primw;
	_muzzles = getArray(configFile>>"cfgWeapons" >> _primw >> "muzzles");
	_p selectWeapon (_muzzles select 0);
};

#ifdef __ACE__
if (!(__TTVer)) then {
	[] spawn {
		private ["_pos", "_no","_s"];
		_pos = position d_peasa;
		_s = "ACE_EASA_Vehicle";
		_no = _pos nearestObject _s;
		while {isNull _no} do {
			_no = _pos nearestObject _s;
			sleep 1;
		};
		_no allowDamage false;
	};
};
#endif

#ifndef __TT__
if (d_SidemissionsOnly == 1) then {
	_sb = __XJIPGetVar(d_searchbody);
	if (!isNull _sb) then {
		if (isNil {_sb getVariable "d_search_body"}) then {_sb setVariable ["d_search_id", _sb addAction ["Search body", "x_client\x_searchbody.sqf"]]};
	};
};
#endif

player addEventHandler ["fired", {_this call XParaExploitHandler}];

#ifdef __ACE__
if ("ACE_Earplugs" in items player) then {
	__pSetVar ["d_earwear", true];
} else {
	__pSetVar ["d_earwear", false];
};
[] spawn {
	while {true} do {
		if (alive player) then {
			if (!__pGetVar(d_earwear)) then {
				if ("ACE_Earplugs" in items player || __pGetVar(ACE_EarWear)) then {
					__pSetVar ["d_earwear", true];
				};
			} else {
				if (__pGetVar(d_earwear)) then {
					if (!("ACE_Earplugs" in items player) && !__pGetVar(ACE_EarWear)) then {
						__pSetVar ["d_earwear", false];
					};
				};
			};
		};
		sleep 0.5;
	};
};
#endif

if (isNil "d_with_carrier") then {
	__pSetVar ["d_p_f_b", 0];
	
	XKickPlayerBaseFired = {
		if !(serverCommandAvailable "#shutdown") then {
			if (player in (list d_player_base_trig)) then {
				if ((_this select 4) isKindOf "TimeBombCore") then {
					_no = nearestObject [player, (_this select 4)];
					if (!isNull _no) then {deleteVehicle _no};
					if (d_kick_base_satchel == 0) then {
						["d_p_f_b_k", [player, name player,1]] call XNetCallEvent;
					} else {
						["d_p_bs", [player, name player,1]] call XNetCallEvent;
					};
				} else {
					if (!d_there_are_enemies_atbase) then {
						_num = __pGetVar(d_p_f_b);
						_num = _num + 1;
						__pSetVar ["d_p_f_b", _num];
						if !(player in (list d_player_base_trig2)) then {
							if (d_player_kick_shootingbase != 1000) then {
								if (_num >= d_player_kick_shootingbase) then {
									["d_p_f_b_k", [player, name player,0]] call XNetCallEvent;
								};
							} else {
								if (_num >= d_player_kick_shootingbase) then {
									["d_p_bs", [player, name player,0]] call XNetCallEvent;
								};
							};
						};
					};
				};
			} else {
				__pSetVar ["d_p_f_b", 0];
			};
		};
	};
	
#ifndef __TT__
	d_player_base_trig = createTrigger["EmptyDetector" ,d_base_array select 0];
	d_player_base_trig setTriggerArea [d_base_array select 1, d_base_array select 2, d_base_array select 3, true];
#else
	_dbase_a = if (playerSide == west) then {d_base_array select 0} else {d_base_array select 1};
	d_player_base_trig = createTrigger["EmptyDetector" ,_dbase_a select 0];
	d_player_base_trig setTriggerArea [_dbase_a select 1, _dbase_a select 2, d_base_array select 3, true];
#endif
	d_player_base_trig setTriggerActivation [d_own_side_trigger, "PRESENT", true];
	d_player_base_trig setTriggerStatements["this", "", ""];

#ifndef __TT__
	d_player_base_trig2 = createTrigger["EmptyDetector" ,position FLAG_BASE];
#else
	_dbase_a = if (playerSide == west) then {position WFLAG_BASE} else {position EFLAG_BASE};
	d_player_base_trig2 = createTrigger["EmptyDetector" ,_dbase_a];
#endif
	d_player_base_trig2 setTriggerArea [25, 25, 0, false];
	d_player_base_trig2 setTriggerActivation [d_own_side_trigger, "PRESENT", true];
	d_player_base_trig2 setTriggerStatements["this", "", ""];
	
	player addEventHandler ["fired", {_this call XKickPlayerBaseFired}];
};
