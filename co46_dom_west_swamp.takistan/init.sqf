#include "x_setup.sqf"
diag_log format ["############################# %1 #############################", missionName];

if (!isNil "d_init_started") exitWith {};
d_init_started = true;

enableSaving [false,false];
enableTeamSwitch false;

#ifdef __ACE__
if (isServer) then {
	ace_sys_aitalk_enabled = true;
	publicVariable "ace_sys_aitalk_enabled";
	ace_sys_aitalk_radio_enabled = true;
	publicVariable "ace_sys_aitalk_radio_enabled";
	ace_sys_tracking_markers_enabled = false;
	publicVariable "ace_sys_tracking_markers_enabled";
};
#endif

#ifdef __CARRIER__
d_with_carrier = true;

// Spawn of the LHD Carrier
if (isServer) then {
	_LHDspawnpoint = [getPosASL LHD_Center select 0, getPosASL LHD_Center select 1, -0.9];
	{
		_dummy = createVehicle [_x, _LHDspawnpoint, [], 0, "NONE"];
		_dummy setdir 270;
		_dummy setPos _LHDspawnpoint;
	} foreach ["Land_LHD_house_1","Land_LHD_house_2","Land_LHD_elev_R","Land_LHD_1","Land_LHD_2","Land_LHD_3","Land_LHD_4","Land_LHD_5","Land_LHD_6"];
};
#endif

#include "i_common.sqf"

if (isServer) then {skiptime d_TimeOfDay};

X_INIT = false;X_Server = false; X_Client = false; X_JIP = false;X_SPE = false;X_MP = isMultiplayer;

#define __waitpl [] spawn {waitUntil {!isNull player};X_INIT = true}
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
	[] spawn {
		waituntil {X_INIT};
#ifndef __ACE__
		d_phd_invulnerable = true;
		__pSetVar ["d_p_ev_hd_last", time];
		__pSetVar ["d_p_ev_hd", player addeventhandler ["HandleDamage", {_this call XfHitEffect}]];
#else
		player setVariable ["ace_w_allow_dam", false];
#endif
		execVM "tasks.sqf";
	};
};

#ifdef __CARRIER__
// fix for delayed LHD creation on clients
if (X_Client) then {
	[] spawn {
		private ["_dirp", "_posp"];
		waituntil {X_INIT};
		_dirp = direction player;
		_posp = [position player select 0,position player select 1, position player select 2];
		if (isNull (nearestobject [player, "Land_LHD_4"])) then {
			player setPos [markerPos "d_c_safepos" select 0, markerPos "d_c_safepos" select 1, 0];
			waituntil {!isNull (nearestObject [_posp, "Land_LHD_4"])};
		};
		player setPosASL [_posp select 0, _posp select 1, 9.26];
		player setDir _dirp;
	};
};
#endif

if (isNil "x_funcs1_compiled") then {
	__cppfln(x_reload,x_common\x_reload.sqf);
	__ccppfln(x_common\x_f\x_functions1.sqf);
	__ccppfln(x_common\x_f\x_netinit.sqf);
};

[0, "d_AirD", {[_this] spawn BIS_Effects_AirDestruction}] call XNetAddEvent;
[0, "d_AirD2", {_this spawn BIS_Effects_AirDestructionStage2}] call XNetAddEvent;
[0, "D_Burn", {_this spawn BIS_Effects_Burn}] call XNetAddEvent;
[0, "rep_ar", {_this setDamage 0;_this setFuel 1}] call XNetAddEvent;
[0, "setcapt", {(_this select 0) setCaptive (_this select 1)}] call XNetAddEvent;
[0, "d_say", {(_this select 0) say3D (_this select 1)}] call XNetAddEvent;
[0, "d_nswm", {(_this select 0) switchmove (_this select 1)}] call XNetAddEvent;
#ifndef __OA__
[0, "d_flav", {[_this] call x_flares}] call XNetAddEvent;
#endif
[0, "d_del_ruin", {_ruin = nearestObject [_this, "Ruins"];if (!isNull _ruin) then {deleteVehicle _ruin}}] call XNetAddEvent;
[0, "d_lv2", {if (local (_this select 0)) then {(_this select 0) lock (_this select 1)}}] call XNetAddEvent;
if (isServer) then {
	[1, "d_dam", {_this call XDamHandler}] call XNetAddEvent; // different handling
	[1, "d_m_box", {if (!(__TTVer)) then {if (!AmmoBoxHandling) then {(_this select 0) call XCreateDroppedBox} else {[(_this select 0), (_this select 1)] call XCreateDroppedBox}} else {if (!AmmoBoxHandling) then {[(_this select 0), (_this select 1)] call XCreateDroppedBox} else {[_this select 0, _this select 1, _this select 2] call XCreateDroppedBox}}}] call XNetAddEvent;
	[1, "d_p_group", {if (!(_this in d_player_groups)) then {d_player_groups set [count d_player_groups, _this]}}] call XNetAddEvent;
	[1, "d_p_a", {_this call XGetPlayerPoints}] call XNetAddEvent;
	[1, "d_air_taxi", {_this execVM "x_server\x_airtaxiserver.sqf"}] call XNetAddEvent;
	[1, "d_r_box", {_this call XRemABox}] call XNetAddEvent;
	[1, "unit_tk", {_this call XfTKKickCheck}] call XNetAddEvent;
	[1, "d_p_f_b_k", {_this call XfKickPlayerBS}] call XNetAddEvent;
	[1, "d_p_bs", {_this call XfRptMsgBS}] call XNetAddEvent;
	[1, "d_pas", {(_this select 0) addScore (_this select 1)}] call XNetAddEvent;
	[1, "mr1_l_c", {if (!isNull _this) then {[_this, 1] spawn x_checktransport}}] call XNetAddEvent;
	[1, "mr2_l_c", {if (!isNull _this) then {[_this, 2] spawn x_checktransport}}] call XNetAddEvent;	
	[1, "d_p_varn", {_this call XGetPlayerArray}] call XNetAddEvent;
	[1, "d_ad", {__addDead(_this)}] call XNetAddEvent;
	[1, "d_ad2", {(_this select 0) setVariable ["d_end_time", _this select 1];d_allunits_add set [count d_allunits_add, _this select 0]}] call XNetAddEvent;
	[1, "d_p_o_a", {_ar = d_placed_objs_store getVariable (_this select 0);_ar set [count _ar, _this select 1];d_placed_objs_store setVariable [_this select 0, _ar];((_this select 1) select 0) setVariable ["d_owner", _this select 0];((_this select 1) select 0) addEventHandler ["killed",{_this call XfPlacedObjKilled}]}] call XNetAddEvent;
	[1, "d_p_o_r", {
		_ar = d_placed_objs_store getVariable (_this select 0);
		for "_lk" from 0 to (count _ar - 1) do {
			_el = _ar select _lk;
			if ((_el select 1) == (_this select 1)) exitWith {
				_ar set [_lk, -1];
			};
		};
		_ar = _ar - [-1];
		d_placed_objs_store setVariable [_this select 0, _ar]
	}] call XNetAddEvent;
	[1, "x_dr_t", {_this execVM "x_server\x_createdrop.sqf"}] call XNetAddEvent;
	[1, "d_f_ru_i", {[_this] execFSM "fsms\xfacrebuild.fsm"}] call XNetAddEvent;
	[1, "ari_type", {_this spawn x_arifire}] call XNetAddEvent;
	[1, "l_v", {if (!((_this select 0) in d_wreck_cur_ar)) then {if (local (_this select 0)) then {(_this select 0) lock (_this select 1)} else {["d_lv2", _this] call XNetCallEvent}}}] call XNetAddEvent;
	[1, "d_mhqdepl", {(_this select 0) lock (_this select 1);d_allunits_add set [count d_allunits_add, (_this select 0) getVariable "D_MHQ_Camo"]}] call XNetAddEvent;
	[1, "d_g_p_inf", {_this call XGetAdminArray}] call XNetAddEvent;
	[1, "d_ad_deltk", {_this call XAdminDelTKs}] call XNetAddEvent;
#ifdef __TT__
	[1, "d_a_p_w", {d_points_west = d_points_west + _this}] call XNetAddEvent;
	[1, "d_a_p_e", {d_points_east = d_points_east + _this}] call XNetAddEvent;
	[1, "mrr1_l_c", {if (!isNull _this) then {[_this, 1] spawn x_checktransport2}}] call XNetAddEvent;
	[1, "mrr2_l_c", {if (!isNull _this) then {[_this, 2] spawn x_checktransport2}}] call XNetAddEvent;
#endif
#ifndef __ACE__
	[1, "d_bi_a_v2", {
		switch (typeOf _this) do {
			case "MLRS": {
				_this removeMagazine "12Rnd_MLRS";
				_this addMagazine "ARTY_12Rnd_227mmHE_M270";
			};
			case "GRAD_RU": {
				_this removeMagazine "40Rnd_GRAD";
				_this addMagazine "ARTY_40Rnd_120mmHE_BM21";
			};
			case "MLRS_DES_EP1": {
				_this removeMagazine "12Rnd_MLRS";
				_this addMagazine "ARTY_12Rnd_227mmHE_M270";
			};
			case "GRAD_TK_EP1": {
				_this removeMagazine "40Rnd_GRAD";
				_this addMagazine "ARTY_40Rnd_120mmHE_BM21";
			};
		};
	}] call XNetAddEvent;
#endif
};

#include "i_server.sqf"
#include "i_client.sqf"

#include "x_missions\x_missionssetup.sqf"

#ifdef __MANDO__
[false] execVM "mando_missiles\mando_missileinit.sqf";
[] spawn {
	// Wait for Mando Missile initialization 
	waitUntil {!isNil "mando_missile_init_done"};
	waitUntil {mando_missile_init_done};

	[] execVM "mando_missiles\mando_setup_full.sqf";
	[] execVM "mando_missiles\mando_setup_ffaa.sqf";
	[] execVM "mando_missiles\mando_setup_ace.sqf";
};
#endif

if (X_SPE) then {d_date_str = date};

if (isServer) then {
	["d_mt_radio_down",true] call XNetSetJIP;
	["mt_radio_pos",[0,0,0]] call XNetSetJIP;
	["target_clear",false] call XNetSetJIP;
	["all_sm_res",false] call XNetSetJIP;
	["the_end",false] call XNetSetJIP;
	["mr1_in_air",false] call XNetSetJIP;
	["mr2_in_air",false] call XNetSetJIP;
	["ari_available",true] call XNetSetJIP;
	["ari2_available",true] call XNetSetJIP;
#ifndef __TT__
	["d_jet_s_reb",false] call XNetSetJIP;
	["d_chopper_s_reb",false] call XNetSetJIP;	
	["d_wreck_s_reb",false] call XNetSetJIP;
#else
	["mrr1_in_air",false] call XNetSetJIP;
	["mrr2_in_air",false] call XNetSetJIP;
#endif
	["current_target_index",-1] call XNetSetJIP;
	["current_mission_index",-1] call XNetSetJIP;
	["ammo_boxes",0] call XNetSetJIP;
	["sec_kind",0] call XNetSetJIP;
	["resolved_targets",[]] call XNetSetJIP;
	["jump_flags",[]] call XNetSetJIP;
	["d_ammo_boxes",[]] call XNetSetJIP;
	["d_wreck_marker",[]] call XNetSetJIP;
	["para_available",true] call XNetSetJIP;
	["d_dam",[]] call XNetSetJIP;
#ifndef __TT__
	["d_campscaptured",0] call XNetSetJIP;
	["d_searchbody",objNull] call XNetSetJIP;
	["d_searchintel",[0,0,0,0,0,0,0]] call XNetSetJIP;
#else
	["d_campscaptured_w",0] call XNetSetJIP;
	["d_campscaptured_e",0] call XNetSetJIP;
#endif
	["d_currentcamps",[]] call XNetSetJIP;
	
	execVM "x_bikb\kbinit.sqf";
	
	X_DropZone = createVehicle ["HeliHEmpty", [0, 0, 0], [], 0, "NONE"];
	["X_DropZone",X_DropZone] call XNetSetJIP;
	
	D_AriTarget = createVehicle ["HeliHEmpty", [0, 0, 0], [], 0, "NONE"];
	["D_AriTarget",D_AriTarget] call XNetSetJIP;
	
	D_AriTarget2 = createVehicle ["HeliHEmpty", [0, 0, 0], [], 0, "NONE"];
	["D_AriTarget2",D_AriTarget2] call XNetSetJIP;
	
	__XJIPSetVar ["d_farps", [], true];
	
#ifdef __TT__
	d_points_west = 0;
	d_points_east = 0;
	d_kill_points_west = 0;
	d_kill_points_east = 0;
	["points_array",[0,0,0,0]] call XNetSetJIP;
#endif
	
	__ccppfln(x_server\x_initx.sqf);
	
	if (d_weather == 0 && d_FastTime == 1) then {
		_ranover = random 1;
		["d_overcast",_ranover] call XNetSetJIP;
		_ww = if (_ranover > 0.5) then {if (rain <= 0.3) then {1} else {2}} else {0};
		["d_winterw", _ww] call XNetSetJIP;
		execFSM "fsms\weatherserver.fsm";
	} else {
		d_weather = 1;
		["d_overcast",0] call XNetSetJIP;
	};

	// create random list of targets
#ifndef __DEFAULT__
	d_maintargets_list = (count d_target_names) call XfRandomIndexArray;
#else
	if (d_number_targets_h < 50) then {
		d_maintargets_list = (count d_target_names) call XfRandomIndexArray;
	} else {
		if !(__OAVer) then {
			switch (d_number_targets_h) do {
				case 50: {d_maintargets_list = [6,14,17,18,0,13,19]};
				case 60: {d_maintargets_list = [5,7,1,16,2]};
				case 70: {d_maintargets_list = [20,3,15,4,9,10,8,11]};
				case 90: {d_maintargets_list = [6,14,5,17,18,0,13,19,1,7,16,2,12,11,8,10,9,4,15,3,20]};
			};
		} else {
			switch (d_number_targets_h) do {
				case 50: {d_maintargets_list = [14,16,12,11,20,19,17,1,0]};
				case 60: {d_maintargets_list = [14,10,9,8,3,2]};
				case 70: {d_maintargets_list = [15,13,7,6,18,5,4,2]};
				case 90: {d_maintargets_list = [14,16,10,20,11,12,19,17,1,0,2,3,8,9,13,15,7,6,18,5,4]};
			};
		};
	};
#endif
	
	__DEBUG_SERVER("init.sqf",d_maintargets_list)
	// create random list of side missions
	if (d_random_sm_array) then {
		d_side_missions_random = sm_array call XfRandomArray;
	} else {
		d_side_missions_random = sm_array;
	};
	
	__DEBUG_SERVER("init.sqf",d_side_missions_random)
	
	d_current_counter = 0;
	d_current_mission_counter = 0;
	
	d_side_mission_resolved = false;
	
	d_counterattack = false;
		
	extra_mission_remover_array = [];
	extra_mission_vehicle_remover_array = [];
	d_check_trigger = objNull;
	d_create_new_paras = false;
	d_first_time_after_start = true;
	d_nr_observers = 0;
#ifndef __TT__
	if (!(__ACEVer)) then {
		// editor varname, unique number, true = respawn only when the chopper is completely destroyed, false = respawn after some time when no crew is in or chopper is destroyed
		if !(__OAVer) then {
			[[ch1,301,true],[ch2,302,true],[ch3,303,false,1500],[ch4,304,false,1500]] execVM "x_server\x_helirespawn2.sqf";
		} else {
			[[ch1,301,true],[ch2,302,true],[ch3,303,false,1500],[ch4,304,false,1500],[ch5,305,false,600],[ch6,306,false,600]] execVM "x_server\x_helirespawn2.sqf";
		};
	} else {
		if (d_enemy_side == "EAST") then {
			[[ch1,301,true],[ch2,302,true],[ch3,303,false,1500],[ch4,304,false,1500],[ch5,305,false,600],[ch6,306,false,600]] execVM "x_server\x_helirespawn2.sqf";
		} else {
			[[ch1,301,true],[ch2,302,true],[ch3,303,false,1500],[ch4,304,false,1500]] execVM "x_server\x_helirespawn2.sqf";
		};
	};
	// editor varname, unique number
	//0-9 = MHQ, 10-19 = Medic vehicles, 20-29 = Fuel, Repair, Reammo trucks, 30-39 = Engineer Salvage trucks, 40-49 = Transport trucks
	[
		[xvec1,0],[xvec2,1],[xmedvec,10],[xvec3,20],[xvec4,21],[xvec5,22], [xvec7,23],
		[xvec8,24], [xvec9,25], [xvec6,30], [xvec10,31], [xvec11,40], [xvec12,41]
	] execVM "x_server\x_vrespawn2.sqf";
#else
	if (!(__ACEVer)) then {
		[
			[ch1,301,true],[ch2,302,true],[ch3,303,false],[ch4,304,false],[ch5,305,false,600],[ch6,306,false,600],
			[chR1,401,true],[chR2,402,true],[chR3,403,false],[chR4,404,false],[chR5,405,false,600],[chR6,406,false,600]
		] execVM "x_server\x_helirespawn2.sqf";
		
		if !(__OAVer) then {
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
	if (!(__TTVer)) then {
		[HC130, 300] spawn x_vehirespawn;
		if !(__OAVer) then {
			[towtrac1, 280] spawn x_vehirespawn2;
			[towtrac2, 280] spawn x_vehirespawn2;
			[towtrac3, 280] spawn x_vehirespawn2;
			[towtrac4, 280] spawn x_vehirespawn2;
		};
	};
#endif
#ifndef __OA__
	execFSM "fsms\boatrespawn.fsm";
#endif
	[d_wreck_rep,"Wreck Repair Point",x_heli_wreck_lift_types] execFSM "fsms\repwreck.fsm";
#ifdef __TT__
	[d_wreck_rep2,"Wreck Repair Point",x_heli_wreck_lift_types] execFSM "fsms\repwreck.fsm";
	d_public_points = true;
#endif
	d_check_boxes = [];
	d_no_more_observers = false;
	d_main_target_ready = false;
	d_mt_spotted = false;
	execVM "x_server\x_setupserver.sqf";
	if (d_SidemissionsOnly == 1) then {
		execVM "x_server\x_createnexttarget.sqf";
	};
	d_player_store = "HeliHEmpty" createVehicleLocal [0, 0, 0];
	d_placed_objs_store = "HeliHEmpty" createVehicleLocal [0, 0, 0];
	if (d_with_ai) then {d_player_groups = []};
	if (d_FastTime == 0) then {execFSM "fsms\fasttime.fsm"};
	
	__cppfln(X_fnc_serverOPC,x_server\x_serverOPC.sqf);
	__cppfln(X_fnc_serverOPD,x_server\x_serverOPD.sqf);
	onPlayerConnected "0 = [_name,_uid] call X_fnc_serverOPC";
	onPlayerDisconnected "0 = [_name,_uid] call X_fnc_serverOPD";
	
#ifdef __ACE__
	if !(__OAVer) then {
		if (!(__TTVer)) then {
			[] spawn {
				private ["_pos", "_no"];
				_pos = position d_peasa;
				_no = _pos nearestObject "ACE_EASA_Vehicle";
				while {isNull _no} do {
					_no = _pos nearestObject "ACE_EASA_Vehicle";
					sleep 1;
				_no allowDamage false;
				};
			};
		};
	};
#endif
};

#ifdef __REVIVE__
execVM "r_init.sqf";
#endif

if (!X_Client) exitWith {};
	
if (!isMultiplayer) then {
	d_player_stuff = [AutoKickTime, time, "", 0, str(player), name player, 0];
	d_player_store setVariable ["", d_player_stuff];
};