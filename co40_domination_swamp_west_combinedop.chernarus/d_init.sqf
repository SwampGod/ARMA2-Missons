#define THIS_FILE "d_init.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing Dom d_init.sqf"];
#include "x_setup.sqf"
private ["_mname","_dtar","_ar","_pos","_nlocs","_nl","_name","_paramName","_h","_first_ar","_second_ar","_targets_list","_wbarracks","_D_AI_HUT","_standard_weap","_silenced","_glweaps","_basic","_machineg","_sniper","_atweap","_elem","_armor","_car","_ranover","_ww","_east_targets_ar","_west_targets_ar"];

#ifdef __CARRIER__
GVAR(with_carrier) = true;
#endif

GVAR(with_dlc) =
#ifdef __DLC__
	true;
#else
	false;
#endif

#include "i_common.sqf"

X_INIT = false;X_Server = false; X_Client = false; X_JIP = false;X_SPE = false;X_MP = isMultiplayer;

#define __waitpl 0 spawn {waitUntil {!isNull player};X_INIT = true}
if (isServer) then {
	X_Server = true;
	if (!isDedicated) then {
		X_Client = true;
		X_SPE = true;
		__waitpl;
	} else {
		X_INIT = true;
	};
} else {
	X_Client = true;
	if (isNull player) then {
		X_JIP = true;
		__waitpl;
	} else {
		X_INIT = true;
	};
};

if (X_Client) then {
	if (isMultiplayer) then {
		0 spawn {
			waituntil {X_INIT};

			xr_phd_invulnerable = true;
			__pSetVar ["ace_w_allow_dam", false];
#ifndef __ACE__
			__pSetVar [QGVAR(p_ev_hd_last), time];
#endif
		};
	};
	execVM "tasks.sqf";
};

#ifdef __CARRIER__
// fix for delayed LHD creation on clients
if (X_Client) then {
	0 spawn {
		private ["_dirp", "_posp"];
		waituntil {X_INIT};
		_dirp = direction player;
		_posp = [position player select 0,position player select 1, position player select 2];
		if (isNull (nearestobject [player, "Land_LHD_4"])) then {
			player setPos [markerPos QGVAR(c_safepos) select 0, markerPos QGVAR(c_safepos) select 1, 0];
			waituntil {!isNull (nearestObject [_posp, "Land_LHD_4"])};
		};
		player setPosASL [_posp select 0, _posp select 1, 9.26];
		player setDir _dirp;
	};
};
#endif

if (isServer) then {
	__ccppfln(x_server\x_f\x_serverfuncs.sqf);
};
__ccppfln(x_common\x_f\x_commonfuncs.sqf);

if (isNil "x_funcs1_compiled") then {
	#ifndef __A2ONLY__
	__cppfln(x_reload,x_common\x_reload2.sqf);
	//__cppfln(x_reload,x_common\x_reload.sqf);
	#else
	__cppfln(x_reload,x_common\x_reloadA2.sqf);
	#endif
	__ccppfln(x_common\x_f\x_functions1.sqf);
	__ccppfln(x_common\x_f\x_netinit.sqf);
#ifndef __TT__
	__cppfln(FUNC(x_checkkill),x_common\x_checkkill.sqf);
#else
	__cppfln(FUNC(x_checkkillwest),x_common\x_checkkillwest.sqf);
	__cppfln(FUNC(x_checkkilleast),x_common\x_checkkilleast.sqf);
#endif
};
if (X_Client) then {
	// dialog related scripts, precompiled to call them from UI EH's to get rid of script scheduling
	__cppfln(FUNC(showstatus),x_client\x_showstatus.sqf);
	__cppfln(FUNC(settingsdialog),x_client\x_settingsdialog.sqf);
	__cppfln(FUNC(pnselchanged),x_msg\x_pnselchanged.sqf);
	__cppfln(FUNC(pmmsgselchanged),x_msg\x_pmselchanged.sqf);
	__cppfln(FUNC(pmrecchanged),x_msg\x_pmrecchanged.sqf);
	__cppfln(FUNC(pmrsendchanged),x_msg\x_pmrsendchanged.sqf);
	__cppfln(FUNC(showmsg_dialog),x_msg\x_showmsgd.sqf);
	if (!GVAR(AmmoBoxHandling)) then {
		__cppfln(FUNC(x_dropammoboxd),x_client\x_dropammobox2.sqf);
	} else {
		__cppfln(FUNC(x_dropammoboxd),x_client\x_dropammobox_old.sqf);
	};
	__cppfln(FUNC(x_loaddropped),x_client\x_loaddropped.sqf);
	__cppfln(FUNC(x_deploymhq),x_client\x_deploymhq.sqf);
	__cppfln(FUNC(x_teleport),x_client\x_teleport.sqf);
	__cppfln(FUNC(x_beam_tele),x_client\x_beam_tele.sqf);
	__cppfln(FUNC(x_update_target),x_client\x_update_target.sqf);
	__cppfln(FUNC(SatellitenBildd),scripts\SatellitenBild.sqf);
	
	__ccppfln(x_client\x_f\x_clientfuncs.sqf);
	__ccppfln(x_client\x_f\x_uifuncs.sqf);

	__ccppfln(x_client\x_f\x_netinitclient.sqf);

	__cppfln(FUNC(checktrucktrans),x_client\x_checktrucktrans.sqf);
	__cppfln(FUNC(checkhelipilot),x_client\x_checkhelipilot.sqf);
	__cppfln(FUNC(checkhelipilot_wreck),x_client\x_checkhelipilot_wreck.sqf);
	__cppfln(FUNC(checkhelipilotout),x_client\x_checkhelipilotout.sqf);
	__cppfln(FUNC(checkenterer),x_client\x_checkenterer.sqf);
	__cppfln(FUNC(checkdriver),x_client\x_checkdriver.sqf);
	__cppfln(FUNC(infoText),x_client\x_f\fn_infoText.sqf);

	__cppfln(FUNC(getsidemissionclient),x_missions\x_getsidemissionclient.sqf);
	__cppfln(FUNC(initvec),x_client\x_initvec.sqf);
	
	#ifndef __ACE__
	if (!GVAR(with_ranked)) then {
		switch (true) do {
			case (__OAVer): {__cppfln(FUNC(weaponcargo),x_client\x_weaponcargo_oa.sqf)};
			case (__COVer): {__cppfln(FUNC(weaponcargo),x_client\x_weaponcargo.sqf)};
		};
	} else {
		switch (true) do {
			case (__OAVer): {__cppfln(FUNC(weaponcargo),x_client\x_weaponcargor_oa.sqf)};
			case (__COVer): {__cppfln(FUNC(weaponcargo),x_client\x_weaponcargor.sqf)};
		};
	};
	#else
	if (!GVAR(with_ranked)) then {
		switch (true) do {
			case (__OAVer): {__cppfln(FUNC(weaponcargo),x_client\x_weaponcargo_oa_ace.sqf)};
			case (__COVer): {__cppfln(FUNC(weaponcargo),x_client\x_weaponcargo_ace.sqf)};
		};
	} else {
		switch (true) do {
			case (__OAVer): {__cppfln(FUNC(weaponcargo),x_client\x_weaponcargor_oa_ace.sqf)};
			case (__COVer): {__cppfln(FUNC(weaponcargo),x_client\x_weaponcargor_ace.sqf)};
		};
	};
	#endif

	if !(__ACEVer) then {
		bis_fnc_halo = compile preprocessFileLineNumbers "AAHALO\Scripts\fn_halo.sqf";
	};
};

if (isServer) then {
#include "i_server.sqf"
};

if (!isDedicated) then {
#include "i_client.sqf"
};

if (isDedicated) then {
#ifndef __ACE__
	if (GVAR(WithRevive) == 0) then {
		__ccppfln(x_revive.sqf);
	};
#else
	if (GVAR(WithRevive) == 0 && GVAR(WithWounds) == 1) then {
		__ccppfln(x_revive.sqf);
	};
#endif
};

[0, QGVAR(AirD), {[_this] spawn BIS_Effects_AirDestruction}] call FUNC(NetAddEvent);
[0, QGVAR(AirD2), {_this spawn BIS_Effects_AirDestructionStage2}] call FUNC(NetAddEvent);
[0, QGVAR(Burn), {_this spawn BIS_Effects_Burn}] call FUNC(NetAddEvent);
[0, QGVAR(rep_ar), {_this setDamage 0;_this setFuel 1}] call FUNC(NetAddEvent);
[0, QGVAR(setcapt), {(_this select 0) setCaptive (_this select 1)}] call FUNC(NetAddEvent);
[0, QGVAR(say), {(_this select 0) say3D (_this select 1)}] call FUNC(NetAddEvent);
[0, QGVAR(nswm), {(_this select 0) switchmove (_this select 1)}] call FUNC(NetAddEvent);
[0, QGVAR(eswm), {_this switchmove ""}] call FUNC(NetAddEvent);
[0, QGVAR(del_ruin), {_ruin = nearestObject [_this, "Ruins"];if (!isNull _ruin) then {deleteVehicle _ruin}}] call FUNC(NetAddEvent);
[0, QGVAR(lv2), {if (local (_this select 0)) then {(_this select 0) lock (_this select 1)}}] call FUNC(NetAddEvent);
[0, QGVAR(grpl), {if (local (leader (_this select 0))) then {(_this select 0) selectLeader (_this select 1)}}] call FUNC(NetAddEvent);
[0, QGVAR(joing), {(_this select 0) join (_this select 1)}] call FUNC(NetAddEvent);
[0, QGVAR(r_delm), {deleteMarkerLocal _this}] call FUNC(NetAddEvent);
//[2, QGVAR(ARTY_SADARM_NET), {_this call FUNC(ARTY_PV_NETSADARM)}] call FUNC(NetAddEvent);
#ifdef __A2ONLY__
if !(__TTVer) then {
	[0, QGVAR(callPPE), {_this call FUNC(x_checkkill)}] call FUNC(NetAddEvent);
} else {
	[0, QGVAR(callPPW), {_this call FUNC(x_checkkillwest)}] call FUNC(NetAddEvent);
	[0, QGVAR(callPPE), {_this call FUNC(x_checkkilleast)}] call FUNC(NetAddEvent);
};
#endif
if (isServer) then {
	[1, QGVAR(m_box), {if !(__TTVer) then {if (!GVAR(AmmoBoxHandling)) then {(_this select 0) call FUNC(CreateDroppedBox)} else {[(_this select 0), (_this select 1)] call FUNC(CreateDroppedBox)}} else {if (!GVAR(AmmoBoxHandling)) then {[(_this select 0), (_this select 1)] call FUNC(CreateDroppedBox)} else {[_this select 0, _this select 1, _this select 2] call FUNC(CreateDroppedBox)}}}] call FUNC(NetAddEvent);
	[1, QGVAR(p_group), {
		private "_idx";
		_idx = GVAR(player_groups) find (_this select 0);
		if (_idx == -1) then {
			GVAR(player_groups) set [count GVAR(player_groups), _this select 0];
			GVAR(player_groups_lead) set [count GVAR(player_groups_lead), _this select 1];
		} else {
			GVAR(player_groups_lead) set [_idx, _this select 1]
		};
	}] call FUNC(NetAddEvent);
	[1, QGVAR(p_a), {_this call FUNC(GetPlayerPoints)}] call FUNC(NetAddEvent);
	[1, QGVAR(air_taxi), {_this execVM "x_server\x_airtaxiserver.sqf"}] call FUNC(NetAddEvent);
	[1, QGVAR(r_box), {_this call FUNC(RemABox)}] call FUNC(NetAddEvent);
	[1, QGVAR(p_f_b_k), {_this call FUNC(KickPlayerBS)}] call FUNC(NetAddEvent);
	[1, QGVAR(p_bs), {_this call FUNC(RptMsgBS)}] call FUNC(NetAddEvent);
	[1, QGVAR(pas), {(_this select 0) addScore (_this select 1)}] call FUNC(NetAddEvent);
	[1, QGVAR(mr1_l_c), {if (!isNull _this) then {[_this, 1] spawn x_checktransport}}] call FUNC(NetAddEvent);
	[1, QGVAR(mr2_l_c), {if (!isNull _this) then {[_this, 2] spawn x_checktransport}}] call FUNC(NetAddEvent);	
	[1, QGVAR(p_varn), {_this call FUNC(GetPlayerArray)}] call FUNC(NetAddEvent);
	[1, QGVAR(ad), {__addDead(_this)}] call FUNC(NetAddEvent);
	[1, QGVAR(ad2), {(_this select 0) setVariable [QGVAR(end_time), _this select 1];GVAR(allunits_add) set [count GVAR(allunits_add), _this select 0]}] call FUNC(NetAddEvent);
	[1, QGVAR(p_o_a), {
		_ar = GVAR(placed_objs_store) getVariable (_this select 0);
		if (isNil "_ar") then {_ar = []};
		if (count _ar > 0) then {_ar = _ar - [objNull]};
		_ar set [count _ar, _this select 1];
		GVAR(placed_objs_store) setVariable [_this select 0, _ar];
		((_this select 1) select 0) setVariable [QGVAR(owner), _this select 0];
#ifndef __A2ONLY__
		((_this select 1) select 0) addMPEventhandler ["MPKilled",{_this call FUNC(PlacedObjKilled)}];
#else
		((_this select 1) select 0) addEventhandler ["Killed",{_this call FUNC(PlacedObjKilled)}];
#endif
	}] call FUNC(NetAddEvent);
	#ifdef __A2ONLY__
	[1, QGVAR(p_o_a_exe), {_this call FUNC(PlacedObjKilled)}] call FUNC(NetAddEvent);
	#endif
	[1, QGVAR(p_o_r), {
		_ar = GVAR(placed_objs_store) getVariable (_this select 0);
		if (isNil "_ar") then {_ar = []};
		if (count _ar > 0) then {
			_ar = _ar - [objNull];
			if (count _ar > 0) then {
				#ifdef __A2ONLY__
				private "_forEachIndex";
				_forEachIndex = 0;
				#endif
				{
					if ((_x select 1) == (_this select 1)) exitWith {_ar set [_forEachIndex, -1]};
					#ifdef __A2ONLY__
					__INC(_forEachIndex);
					#endif
				} forEach _ar;
				_ar = _ar - [-1];
			};
		};
		GVAR(placed_objs_store) setVariable [_this select 0, _ar]
	}] call FUNC(NetAddEvent);
	[1, QGVAR(p_o_a2), {
		_ar = GVAR(placed_objs_store2) getVariable (_this select 0);
		if (isNil "_ar") then {_ar = []};
		if (count _ar > 0) then {_ar = _ar - [objNull]};
		_ar set [count _ar, _this select 1];
		GVAR(placed_objs_store2) setVariable [_this select 0, _ar];
	}] call FUNC(NetAddEvent);
	[1, QGVAR(p_o_a2r), {
		_ar = GVAR(placed_objs_store2) getVariable (_this select 0);
		if (isNil "_ar") then {_ar = []};
		if (count _ar > 0) then {
			_ar = _ar - [_this select 0, objNull];
		};
		GVAR(placed_objs_store2) setVariable [_this select 0, _ar];
	}] call FUNC(NetAddEvent);
	[1, QGVAR(x_dr_t), {_this execVM "x_server\x_createdrop.sqf"}] call FUNC(NetAddEvent);
	[1, QGVAR(f_ru_i), {[_this] execFSM "fsms\XFacRebuild.fsm"}] call FUNC(NetAddEvent);
	[1, QGVAR(ari_type), {_this spawn FUNC(arifire)}] call FUNC(NetAddEvent);
	[1, QGVAR(l_v), {if !((_this select 0) in GVAR(wreck_cur_ar)) then {if (local (_this select 0)) then {(_this select 0) lock (_this select 1)} else {[QGVAR(lv2), _this] call FUNC(NetCallEvent)}}}] call FUNC(NetAddEvent);
	[1, QGVAR(mhqdepl), {if (local (_this select 0)) then {(_this select 0) lock (_this select 1)};if (_this select 1) then {(_this select 0) call FUNC(createMHQEnemyTeleTrig)} else {(_this select 0) call FUNC(removeMHQEnemyTeleTrig)}}] call FUNC(NetAddEvent);
	[1, QGVAR(g_p_inf), {_this call FUNC(GetAdminArray)}] call FUNC(NetAddEvent);
	[1, QGVAR(ad_deltk), {_this call FUNC(AdminDelTKs)}] call FUNC(NetAddEvent);
#ifdef __TT__
	[1, QGVAR(a_p_w), {GVAR(points_west) = GVAR(points_west) + _this}] call FUNC(NetAddEvent);
	[1, QGVAR(a_p_e), {GVAR(points_east) = GVAR(points_east) + _this}] call FUNC(NetAddEvent);
	[1, QGVAR(mrr1_l_c), {if (!isNull _this) then {[_this, 1] spawn FUNC(checktransport2)}}] call FUNC(NetAddEvent);
	[1, QGVAR(mrr2_l_c), {if (!isNull _this) then {[_this, 2] spawn FUNC(checktransport2)}}] call FUNC(NetAddEvent);
#endif
	[1, QGVAR(addai), {__addDeadAI(_this)}] call FUNC(NetAddEvent);
#ifdef __A2ONLY__
	[1, QGVAR(callMHQF), {(_this select 0) call FUNC(MHQFunc)}] call FUNC(NetAddEvent);
	if (__TTVer) then {
		[1, QGVAR(callTTVW), {_this call FUNC(checkveckillwest)}] call FUNC(NetAddEvent);
		[1, QGVAR(callTTVE), {_this call FUNC(checkveckilleast)}] call FUNC(NetAddEvent);
	};
#endif
	[1, QGVAR(crl), {_this call FUNC(ChangeRLifes)}] call FUNC(NetAddEvent);
	[1, QGVAR(unit_tkr), {_this call FUNC(TKR)}] call FUNC(NetAddEvent);
};

#include "x_missions\x_missionssetup.sqf"

if (X_SPE) then {GVAR(date_str) = date};

if (isServer) then {
	[QGVAR(mt_radio_down),true] call FUNC(NetSetJIP);
	[QUOTE(mt_radio_pos),[0,0,0]] call FUNC(NetSetJIP);
	[QUOTE(target_clear),false] call FUNC(NetSetJIP);
	[QUOTE(all_sm_res),false] call FUNC(NetSetJIP);
	[QGVAR(the_end),false] call FUNC(NetSetJIP);
	[QUOTE(mr1_in_air),false] call FUNC(NetSetJIP);
	[QUOTE(mr2_in_air),false] call FUNC(NetSetJIP);
	[QUOTE(ari_available),true] call FUNC(NetSetJIP);
	[QUOTE(ari2_available),true] call FUNC(NetSetJIP);
#ifndef __TT__
	[QGVAR(jet_s_reb),false] call FUNC(NetSetJIP);
	[QGVAR(chopper_s_reb),false] call FUNC(NetSetJIP);	
	[QGVAR(wreck_s_reb),false] call FUNC(NetSetJIP);
#else
	[QUOTE(mrr1_in_air),false] call FUNC(NetSetJIP);
	[QUOTE(mrr2_in_air),false] call FUNC(NetSetJIP);
#endif
	[QGVAR(current_target_index),-1] call FUNC(NetSetJIP);
	[QGVAR(current_mission_index),-1] call FUNC(NetSetJIP);
	[QUOTE(ammo_boxes),0] call FUNC(NetSetJIP);
	[QUOTE(sec_kind),0] call FUNC(NetSetJIP);
	[QUOTE(resolved_targets),[]] call FUNC(NetSetJIP);
	[QUOTE(jump_flags),[]] call FUNC(NetSetJIP);
	[QGVAR(ammo_boxes),[]] call FUNC(NetSetJIP);
	[QGVAR(wreck_marker),[]] call FUNC(NetSetJIP);
	[QUOTE(para_available),true] call FUNC(NetSetJIP);
	[QGVAR(searchbody),objNull] call FUNC(NetSetJIP);
	[QGVAR(searchintel),[0,0,0,0,0,0,0]] call FUNC(NetSetJIP);
	
	if (GVAR(with_ai) || GVAR(with_ai_features) == 0) then {
		[QGVAR(ari_blocked),false] call FUNC(NetSetJIP);
		[QGVAR(drop_blocked),false] call FUNC(NetSetJIP);
	};

	if (!__TTVer) then {
		[QGVAR(campscaptured),0] call FUNC(NetSetJIP);
	} else {
		[QGVAR(campscaptured_w),0] call FUNC(NetSetJIP);
		[QGVAR(campscaptured_e),0] call FUNC(NetSetJIP);
	};
	[QGVAR(currentcamps),[]] call FUNC(NetSetJIP);
	
	execVM "x_bikb\kbinit.sqf";
	
	GVAR(X_DropZone) = createVehicle [GVAR(HeliHEmpty), [0, 0, 0], [], 0, "NONE"];
	[QUOTE(X_DropZone), GVAR(X_DropZone)] call FUNC(NetSetJIP);
	
	GVAR(AriTarget) = createVehicle [GVAR(HeliHEmpty), [0, 0, 0], [], 0, "NONE"];
	[QGVAR(AriTarget),GVAR(AriTarget)] call FUNC(NetSetJIP);
	
	GVAR(AriTarget2) = createVehicle [GVAR(HeliHEmpty), [0, 0, 0], [], 0, "NONE"];
	[QGVAR(AriTarget2),GVAR(AriTarget2)] call FUNC(NetSetJIP);
	
	__XJIPSetVar [QGVAR(farps), [], true];
	
	GVAR(counterattack) = false;
	
#ifdef __TT__
	GVAR(points_west) = 0;
	GVAR(points_east) = 0;
	GVAR(kill_points_west) = 0;
	GVAR(kill_points_east) = 0;
	[QUOTE(points_array),[0,0,0,0]] call FUNC(NetSetJIP);
#endif
	
	__ccppfln(x_server\x_initx.sqf);
	
	if (GVAR(weather) == 0 && GVAR(FastTime) == 0) then {
		_ranover = random 1;
		[QGVAR(overcast),_ranover] call FUNC(NetSetJIP);
		_ww = if (_ranover > 0.5) then {if (rain <= 0.3) then {1} else {2}} else {0};
		[QGVAR(winterw), _ww] call FUNC(NetSetJIP);
		execFSM "fsms\WeatherServer.fsm";
	} else {
		GVAR(weather) = 1;
		[QGVAR(overcast),0] call FUNC(NetSetJIP);
	};

	// create random list of targets
#ifndef __DEFAULT__
	GVAR(maintargets_list) = (count GVAR(target_names)) call FUNC(RandomIndexArray);
#else
	if (GVAR(number_targets_h) < 50) then {
		GVAR(maintargets_list) = (count GVAR(target_names)) call FUNC(RandomIndexArray);
	} else {
		switch (true) do {
			case (__COVer): {
				switch (GVAR(number_targets_h)) do {
					case 50: {GVAR(maintargets_list) = [6,14,17,18,0,13,19]};
					case 60: {GVAR(maintargets_list) = [5,7,1,16,2]};
					case 70: {GVAR(maintargets_list) = [20,3,15,4,9,10,8,11]};
					case 90: {GVAR(maintargets_list) = [6,14,5,17,18,0,13,19,1,7,16,2,12,11,8,10,9,4,15,3,20]};
				};
			};
			case (__OAVer): {
				switch (GVAR(number_targets_h)) do {
					case 50: {GVAR(maintargets_list) = [14,16,12,11,20,19,17,1,0]};
					case 60: {GVAR(maintargets_list) = [14,10,9,8,3,2]};
					case 70: {GVAR(maintargets_list) = [15,13,7,6,18,5,4,2]};
					case 90: {GVAR(maintargets_list) = [14,16,10,20,11,12,19,17,1,0,2,3,8,9,13,15,7,6,18,5,4]};
				};
			};
		};
	};
#endif

	__TRACE_1("","d_maintargets_list")
	// create random list of side missions
	if (GVAR(random_sm_array)) then {
		GVAR(side_missions_random) = GVAR(sm_array) call FUNC(RandomArray);
	} else {
		GVAR(side_missions_random) = GVAR(sm_array);
	};
	
	__TRACE_1("","d_side_missions_random")
	
	GVAR(current_counter) = 0;
	GVAR(current_mission_counter) = 0;
	
	GVAR(side_mission_resolved) = false;
		
	GVAR(extra_mission_remover_array) = [];
	GVAR(extra_mission_vehicle_remover_array) = [];
	GVAR(check_trigger) = objNull;
	GVAR(create_new_paras) = false;
	GVAR(first_time_after_start) = true;
	GVAR(nr_observers) = 0;
#ifndef __TT__
	if (!__ACEVer) then {
		// editor varname, unique number, true = respawn only when the chopper is completely destroyed, false = respawn after some time when no crew is in or chopper is destroyed
		switch (true) do {
			case (__COVer): {
				[[ch1,301,true],[ch2,302,true],[ch3,303,false,1500],[ch4,304,false,1500]] execVM "x_server\x_helirespawn2.sqf"
			};
			case (__OAVer): {
				[[ch1,301,true],[ch2,302,true],[ch3,303,false,1500],[ch4,304,false,1500],[ch5,305,false,600],[ch6,306,false,600]] execVM "x_server\x_helirespawn2.sqf"
			};
		};
	} else {
		if (GVAR(enemy_side) == "EAST") then {
			[[ch1,301,true],[ch2,302,true],[ch3,303,false,1500],[ch4,304,false,1500],[ch5,305,false,600],[ch6,306,false,600]] execVM "x_server\x_helirespawn2.sqf"
		} else {
			[[ch1,301,true],[ch2,302,true],[ch3,303,false,1500],[ch4,304,false,1500]] execVM "x_server\x_helirespawn2.sqf"
		};
	};
	// editor varname, unique number
	//0-9 = MHQ, 10-19 = Medic vehicles, 20-29 = Fuel, Repair, Reammo trucks, 30-39 = Engineer Salvage trucks, 40-49 = Transport trucks
	[
		[xvec1,0],[xvec2,1],[xmedvec,10],[xvec3,20],[xvec4,21],[xvec5,22], [xvec7,23],
		[xvec8,24], [xvec9,25], [xvec6,30], [xvec10,31], [xvec11,40], [xvec12,41]
	] execVM "x_server\x_vrespawn2.sqf";
#else
	if !(__ACEVer) then {
		[
			[ch1,301,true],[ch2,302,true],[ch3,303,false],[ch4,304,false],[ch5,305,false,600],[ch6,306,false,600],
			[chR1,401,true],[chR2,402,true],[chR3,403,false],[chR4,404,false],[chR5,405,false,600],[chR6,406,false,600]
		] execVM "x_server\x_helirespawn2.sqf";
		
		if (__COVer) then {
			_helper = [];
			for "_i" from 1 to 32 do {
				_v = missionNamespace getVariable format ["vecvec%1", _i];
				_helper set [count _helper, _v];
			};
			_helper execVM "x_server\x_vrespawnn.sqf";
		};
	} else {
		[
			[ch1,301,true],[ch2,302,true],[ch3,303,false],[ch4,304,false],[ch5,305,false,600],[ch6,306,false,600],
			[chR1,401,true],[chR2,402,true],[chR3,403,false],[chR4,404,false],[chR5,405,false,600],[chR6,406,false,600]
		] execVM "x_server\x_helirespawn2.sqf";
	};
	[
		[xvec1,0],[xvec2,1],[xmedvec,10],[xvec3,20],[xvec4,21],[xvec5,22],[xvec6,30],[xvec7,40],
		[xvecR1,100],[xvecR2,101],[xmedvecR,110],[xvecR3,120],[xvecR4,121],[xvecR5,122],[xvecR6,130],[xvecR7,140]
	] execVM "x_server\x_vrespawn2.sqf";
#endif
#ifdef __ACE__
	if !(__TTVer) then {
		[HC130, 300] spawn FUNC(vehirespawn);
		if (__COVer) then {
			[towtrac1, 280] spawn FUNC(vehirespawn2);
			[towtrac2, 280] spawn FUNC(vehirespawn2);
			[towtrac3, 280] spawn FUNC(vehirespawn2);
			[towtrac4, 280] spawn FUNC(vehirespawn2);
		};
	};
#endif
	if (!isNil "boat1") then {
		execFSM "fsms\Boatrespawn.fsm";
	};
	[GVAR(wreck_rep),"Wreck Repair Point",GVAR(heli_wreck_lift_types)] execFSM "fsms\RepWreck.fsm";
#ifdef __TT__
	[GVAR(wreck_rep2),"Wreck Repair Point",GVAR(heli_wreck_lift_types)] execFSM "fsms\RepWreck.fsm";
	GVAR(public_points) = true;
#endif
	GVAR(check_boxes) = [];
	GVAR(no_more_observers) = false;
	GVAR(main_target_ready) = false;
	GVAR(mt_spotted) = false;
	__ccppfln(x_server\x_setupserver.sqf);
	if (GVAR(MissionType) != 2) then {
		execVM "x_server\x_createnexttarget.sqf";
	};
	GVAR(player_store) = GVAR(HeliHEmpty) createVehicleLocal [0, 0, 0];
	GVAR(placed_objs_store) = GVAR(HeliHEmpty) createVehicleLocal [0, 0, 0];
	GVAR(placed_objs_store2) = GVAR(HeliHEmpty) createVehicleLocal [0, 0, 0];
	if (GVAR(with_ai)) then {
		GVAR(player_groups) = [];
		GVAR(player_groups_lead) = [];
	};
	if (GVAR(FastTime) > 0) then {execFSM "fsms\FastTime.fsm"};
	
	__cppfln(FUNC(serverOPC),x_server\x_serverOPC.sqf);
	__cppfln(FUNC(serverOPD),x_server\x_serverOPD.sqf);
	onPlayerConnected {[_name,_uid] call FUNC(serverOPC)};
	onPlayerDisconnected {[_name,_uid] call FUNC(serverOPD)};
	
#ifdef __ACE__
	if (__COVer) then {
		if !(__TTVer) then {
			0 spawn {
				private ["_pos", "_no"];
				_pos = position GVAR(peasa);
				_no = _pos nearestObject "ACE_EASA_Vehicle";
				_endtime = time + 200;
				while {isNull _no && time < _endtime} do {
					_no = _pos nearestObject "ACE_EASA_Vehicle";
					sleep 1;
				};
				if (!isNull _no) then {
					_no addEventHandler ["handleDamage", {0}];
				};
			};
		};
	};
#endif
};

#ifdef __ACE__
if (isServer) then {
	_mname = QGVAR(ACE_CSW_Box_Marker);
	_mpos = markerPos _mname;
	if (str _mpos == "[0,0,0]") exitWith {};
	_mpos set [2,0];
	
	_box = createVehicle ["ACE_CSW_Box_M2", _mpos, [], 0, "NONE"];
	_box setDir (markerDir QGVAR(ACE_CSW_Box_Marker));
	_box setPos _mpos;
	#define __awcg _box addWeaponCargoGlobal
	#define __amcg _box addMagazineCargoGlobal
	__awcg ["ACE_MK19MOD3Proxy", 1];
	__awcg ["ACE_M3TripodProxy", 1];
	
	__amcg ["ACE_MK19_CSWDM", 30];
	
	__awcg ["ACE_M252Proxy", 1];
	__awcg ["ACE_M252TripodProxy", 1];
	
	__awcg ["ACE_M224Proxy", 1];
	__awcg ["ACE_M224TripodProxy", 1];
	
	__amcg ["ACE_M252HE_CSWDM", 30];
	__amcg ["ACE_M252WP_CSWDM", 30];
	__amcg ["ACE_M252IL_CSWDM", 30];
	__amcg ["ACE_M224HE_CSWDM", 30];
	__amcg ["ACE_M224WP_CSWDM", 30];
	__amcg ["ACE_M224IL_CSWDM", 30];
};
#endif

QGVAR(island_marker) setMarkerAlphaLocal 0;

if (!isDedicated) then {
	#ifndef __TT__
	[QGVAR(wreck_service), getPosASL GVAR(wreck_rep),"ICON","ColorYellow",[1,1],"Wreck Repair",0,"n_service"] call FUNC(CreateMarkerLocal);
	[QGVAR(aircraft_service), getPosASL GVAR(jet_trigger),"ICON","ColorYellow",[1,1],"Jet Service",0,"n_service"] call FUNC(CreateMarkerLocal);
	[QGVAR(chopper_service), getPosASL GVAR(chopper_trigger),"ICON","ColorYellow",[1,1],"Chopper Service",0,"n_service"] call FUNC(CreateMarkerLocal);
	[QGVAR(vehicle_service), getPosASL GVAR(vecre_trigger),"ICON","ColorYellow",[1,1],"Vehicle Service",0,"n_service"] call FUNC(CreateMarkerLocal);
	if (isNil QGVAR(with_carrier)) then {
		["Ammobox Reload", getPosASL AMMOLOAD,"ICON","ColorYellow",[1,1],"Ammo Point",0,"Depot"] call FUNC(CreateMarkerLocal);
	};
	[QGVAR(teleporter), getPosASL FLAG_BASE,"ICON","ColorYellow",[1,1],"Teleporter / Parajump",0,"mil_flag"] call FUNC(CreateMarkerLocal);
	#else
	[QGVAR(wreck_service), getPosASL GVAR(wreck_rep),"ICON","ColorYellow",[1,1],"Wreck Repair",0,"n_service"] call FUNC(CreateMarkerLocal);
	[QGVAR(aircraft_service), getPosASL GVAR(jet_trigger),"ICON","ColorYellow",[1,1],"Jet Service",0,"n_service"] call FUNC(CreateMarkerLocal);
	[QGVAR(chopper_service), getPosASL GVAR(chopper_trigger),"ICON","ColorYellow",[1,1],"Chopper Service",0,"n_service"] call FUNC(CreateMarkerLocal);
	[QGVAR(vehicle_service), getPosASL GVAR(vecre_trigger),"ICON","ColorYellow",[1,1],"Vehicle Service",0,"n_service"] call FUNC(CreateMarkerLocal);
	["Ammobox Reload", getPosASL AMMOLOAD,"ICON","ColorYellow",[1,1],"Ammo Point",0,"Depot"] call FUNC(CreateMarkerLocal);
	[QGVAR(teleporter), getPosASL WFLAG_BASE,"ICON","ColorYellow",[1,1],"Teleporter / Parajump",0,"mil_flag"] call FUNC(CreateMarkerLocal);
	
	[QGVAR(wreck_serviceR), getPosASL GVAR(wreck_rep2),"ICON","ColorYellow",[1,1],"Wreck Repair",0,"n_service"] call FUNC(CreateMarkerLocal);
	[QGVAR(aircraft_serviceR), getPosASL GVAR(jet_trigger2),"ICON","ColorYellow",[1,1],"Jet Service",0,"n_service"] call FUNC(CreateMarkerLocal);
	[QGVAR(chopper_serviceR), getPosASL GVAR(chopper_triggerR),"ICON","ColorYellow",[1,1],"Chopper Service",0,"n_service"] call FUNC(CreateMarkerLocal);
	[QGVAR(vehicle_serviceR), getPosASL GVAR(vecre_trigger2),"ICON","ColorYellow",[1,1],"Vehicle Service",0,"n_service"] call FUNC(CreateMarkerLocal);
	["Ammobox ReloadR", getPosASL AMMOLOAD2,"ICON","ColorYellow",[1,1],"Ammo Point",0,"Depot"] call FUNC(CreateMarkerLocal);
	[QGVAR(teleporter_1), getPosASL EFLAG_BASE,"ICON","ColorYellow",[1,1],"Teleporter / Parajump",0,"mil_flag"] call FUNC(CreateMarkerLocal);
	#endif
};

#ifdef __TT__
{
	_x setMarkerAlphaLocal 0;
} forEach [QGVAR(chopper_service),QGVAR(wreck_service),QGVAR(teleporter),QGVAR(aircraft_service),"bonus_air","bonus_vehicles","Ammobox Reload",QGVAR(vehicle_service),
	"Start",QGVAR(chopper_serviceR),QGVAR(wreck_serviceR),QGVAR(teleporter_1),QGVAR(aircraft_serviceR),"bonus_airR","bonus_vehiclesR","Ammobox ReloadR","Start_east",QGVAR(vehicle_serviceR)];
#endif

GVAR(init_processed) = true;

if (!isDedicated) then {	
	if (!isMultiplayer) then {
		GVAR(player_stuff) = [GVAR(AutoKickTime), time, "", 0, str(player), sideUnknown, name player, 0, xr_max_lives];
		GVAR(player_store) setVariable ["", GVAR(player_stuff)];
	};
};

#include "x_commoncustomcode.sqf";

diag_log [diag_frameno, diag_ticktime, time, "Dom d_init.sqf processed"];
