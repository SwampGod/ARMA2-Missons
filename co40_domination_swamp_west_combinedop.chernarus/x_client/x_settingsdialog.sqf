// by Xeno
#define THIS_FILE "x_settingsdialog.sqf"
#include "x_setup.sqf"
#define __ctrl(numcontrol) (_XD_display displayCtrl numcontrol)
private ["_XD_display","_ctrl","_index","_glindex","_str","_ar","_hstr","_med","_art","_eng"];

disableSerialization;

createDialog "XD_SettingsDialog";

_XD_display = __uiGetVar(X_SETTINGS_DIALOG);

if (GVAR(disable_viewdistance)) then {
	__ctrl(1000) ctrlEnable false;
	__ctrl(1999) ctrlSetText "Viewdistance";
	__ctrl(1997) ctrlSetText "";
} else {
	sliderSetRange [1000, 200, GVAR(MaxViewDistance)];
	sliderSetPosition [1000, viewDistance];
	__ctrl(1999) ctrlSetText ("Viewdistance: " + str(round viewDistance));
};

_ctrl = __ctrl(1001);

_glindex = -1;
{
	_index = _ctrl lbAdd _x;
	if (GVAR(graslayer_index) == _index) then {_glindex = _index};
} forEach ["No Gras", "Medium Gras", "Full Gras"];

_ctrl lbSetCurSel _glindex;
if (GVAR(Terraindetail) == 1) then {
	_ctrl ctrlEnable false;
	__ctrl(1998) ctrlSetText "Gras Layer";
	__ctrl(1996) ctrlSetText "";
};

_ctrl = __ctrl(1002);
if (GVAR(dont_show_player_markers_at_all) == 1) then {
	{_ctrl lbAdd _x} forEach ["Off", "With Names", "Markers Only", "Role only", "Health"];
	_ctrl lbSetCurSel GVAR(show_player_marker);
} else {
	_ctrl ctrlShow false;
	__ctrl(1500) ctrlShow false;
	__ctrl(1501) ctrlShow false;
};

_ctrl = __ctrl(1602);
if (GVAR(show_playernames) == 1) then {
	{_ctrl lbAdd _x} forEach ["Off", "With Names", "Role only", "Health"];
	_ctrl lbSetCurSel GVAR(show_player_namesx);
} else {
	_ctrl ctrlEnable false;
};

__ctrl(2001) ctrlSetText str(GVAR(points_needed) select 0);
__ctrl(2002) ctrlSetText str(GVAR(points_needed) select 1);
__ctrl(2003) ctrlSetText str(GVAR(points_needed) select 2);
__ctrl(2004) ctrlSetText str(GVAR(points_needed) select 3);
__ctrl(2005) ctrlSetText str(GVAR(points_needed) select 4);
__ctrl(2006) ctrlSetText str(GVAR(points_needed) select 5);

#define __str _str = _str + 

_str = "Own side: " + GVAR(own_side) + "\n";
#ifndef __TT__
__str "Enemy side: " + GVAR(enemy_side);
#else
__str (switch (GVAR(player_side)) do {case east: {", WEST"};case west: {", EAST"};});
#endif
__str "\n";
__str "Own faction: " + GVAR(player_faction) + "\n";
__str "Main targets: " + str(GVAR(MainTargets)) + "\n";
__str "Island: " + (getText (configFile >> "CfgWorlds" >> worldName >> "description")) + "\n";
__str "With revive: " + (if (GVAR(WithRevive) == 0) then {"Yes\n"} else {"No\n"});
__str "Maximum number of team kills before first kick: " + str(GVAR(maxnum_tks_forkick)) + "\n";
__str "How often can a player shoot at base before kick: " + str(GVAR(player_kick_shootingbase)) + "\n";
__str "Kick for placing a satchel at base: " + (if (GVAR(kick_base_satchel) == 0) then {"Yes\n"} else {"No\n"});
__str "Initial viewdistance: " + str(GVAR(InitialViewDistance)) + "\n";
__str "Maximum viewdistance: " + str(GVAR(MaxViewDistance)) + "\n";
__str "Usable main weaponry: ";

if (!GVAR(LimitedWeapons)) then {
	__str "All\n";
} else {
	if (count GVAR(poss_weapons) > 0) then {
		#ifdef __A2ONLY__
		private "_forEachIndex";
		_forEachIndex = 0;
		#endif
		{
			__str ([_x, 1] call FUNC(GetDisplayName));
			if (_forEachIndex != (count GVAR(poss_weapons)- 1)) then {__str ", "};
			#ifdef __A2ONLY__
			__INC(_forEachIndex);
			#endif
		} forEach GVAR(poss_weapons);
		__str "\n";
	} else {
		__str "Unknown\n";
	};
};

#define __tyn then {"Yes\n"} else {"No\n"}

if (__ACEVer) then {__str "Version: A.C.E\n"};

__str "With player AI: " + (if (GVAR(with_ai)) __tyn);
__str "Ranked: " + (if (GVAR(with_ranked)) __tyn);

__str "Version string: " + GVAR(version_string) + "\n";
__str "Mission starttime: " + (if (GVAR(TimeOfDay) < 10) then {"0"} else {""}) + str(GVAR(TimeOfDay)) + ":00\n";
__str "Internal backpack enabled: " + (if (GVAR(WithBackpack)) __tyn);
__str "Sidemissions only: " + (if (GVAR(MissionType) == 2) __tyn);
__str "Main targets only: " + (if (GVAR(MissionType) == 1) __tyn);
__str "Show player marker direction: " + (if (GVAR(p_marker_dirs)) __tyn);
__str "Show vehicle marker direction: " + (if (GVAR(v_marker_dirs)) __tyn);
__str "Player marker type: " + GVAR(p_marker) + "\n";
__str "Teamstatus Dialog enabled: " + (if (GVAR(use_teamstatusdialog) == 0) __tyn);
__str "With MHQ Respawn/Teleport: " + (if (GVAR(WithMHQTeleport) == 0) __tyn);
__str "With Fasttime: " + (if (GVAR(FastTime) > 0) __tyn);
__str "Enemy skill: " + (switch (GVAR(EnemySkill)) do {case 1: {"Low"};case 2: {"Normal"};case 3: {"High"};}) + "\n";
__str "With island defense: " + (if (GVAR(WithIsleDefense) == 0) __tyn);
__str "With AI recapture: " + (if (GVAR(WithRecapture) == 0) __tyn);
__str "With island defense: " + (if (GVAR(WithIsleDefense) == 0) __tyn);
__str "Armor at main targets: " + (switch (GVAR(WithLessArmor)) do {case 0: {"Normal"};case 1: {"Less"};case 2: {"None"};}) + "\n";
__str "With teleport to base: " + (if (GVAR(WithTeleToBase) == 0) __tyn);
__str "Illumination over main target: " + (if (GVAR(IllumMainTarget) == 0) __tyn);
__str "With enemy artillery spotters: " + (if (GVAR(WithEnemyArtySpotters) == 0) __tyn);

#ifndef __TT__
__str "With base attack (sabotage): " + (if (GVAR(WithBaseAttack) == 0) __tyn);
#endif

__str "With winter weather: " + (if (GVAR(WithWinterWeather) == 0) __tyn);

#ifndef __ACE__
__str "Override BIS destruction effects: " + (if (GVAR(OverrideBISEffects) == 0) __tyn);
__str "Blood and dirt hit effects: " + (if (GVAR(BloodDirtScreen) == 0) __tyn);
#endif

__str "Block spacebar scanning: " + (if (GVAR(BlockSpacebarScanning) == 0) __tyn);
__str "Player names above head disabled: " + (if (GVAR(show_playernames) == 0) __tyn);

__str "Gras visible at missionstart: " + (if (GVAR(GrasAtStart) == 0) __tyn);

__str "Player can change gras layer (terraindetail): " + (if (GVAR(Terraindetail) == 0) __tyn);

__str "Wrecks get deleted after: " + (if (GVAR(WreckDeleteTime) == -1) then {"Never\n"} else {(str(GVAR(WreckDeleteTime) / 60) + "minutes\n")});

__str "Viewdistance can be changed: " + (if (GVAR(ViewdistanceChange) == 0) __tyn);

__str "MHQ vehicles (create): ";
#ifdef __A2ONLY__
private "_forEachIndex";
_forEachIndex = 0;
#endif
{
	__str ([_x, 0] call FUNC(GetDisplayName));
	if (_forEachIndex < (count GVAR(create_bike) - 1)) then {__str ", "};
	#ifdef __A2ONLY__
	__INC(_forEachIndex);
	#endif
} forEach GVAR(create_bike);
__str "\n";

__str "Time a player has to wait until he can create a new vehicle at a MHQ: " + str(GVAR(VecCreateWaitTime)) + "\n";

if (count GVAR(only_pilots_can_fly) > 0) then {
	__str "Able to fly: ";
	_hstr = "";
	{
		if (_hstr != "") then {_hstr = _hstr + ", "};
		_hstr = _hstr + _x;
	} forEach GVAR(only_pilots_can_fly);
	__str _hstr + "\n";
};

__str "Maximum number of ammoboxes: " + str(GVAR(MaxNumAmmoboxes)) + "\n";
__str "Ammoboxes currently in use: " + str(__XJIPGetVar(ammo_boxes)) + "\n";

__str "Time to wait until an ammobox can be dropped/loaded again: " + str(GVAR(drop_ammobox_time)) + "\n";

__str "Maximum number of statics per engineer truck: " + str(GVAR(max_truck_cargo)) + "\n";

__str "Vehicles able to load ammoboxes: ";
#ifdef __A2ONLY__
private "_forEachIndex";
_forEachIndex = 0;
#endif
{
	__str ([_x, 0] call FUNC(GetDisplayName));
	if (_forEachIndex < (count GVAR(check_ammo_load_vecs) - 1)) then {__str ", "};
	#ifdef __A2ONLY__
	__INC(_forEachIndex);
	#endif
} forEach GVAR(check_ammo_load_vecs);
__str "\n";
__str "Weather system enabled: " + (if (GVAR(weather) == 0) __tyn);
__str "MG gunners able to build mg nest: " + (if (GVAR(with_mgnest)) __tyn);
__str "Medics able to build medic tent: " + (if (GVAR(with_medtent)) __tyn);
__str "Respawn with same weapons after death: " + (if (GVAR(weapon_respawn)) __tyn);
__str "With ACRE: " + (if (GVAR(WithAcre)) __tyn);
if (GVAR(WithAcre)) then {
	__str "ACRE signal loss: " + str(GVAR(AcreSignalLoss)) + "%" + "\n";
	__str "ACRE radio on back: " + (if (GVAR(AcreRadioOnBackWorks) == 1) __tyn);
};
if (GVAR(with_ai)) then {__str "Maximum number of AI that can get recruited: " + str(GVAR(max_ai)) + "\n"};
__str "Points a player loses for teamkill: " + str(GVAR(sub_tk_points)) + "\n";
if (GVAR(with_ranked)) then {
	__str "Player points that get subtracted after death: " + str(abs GVAR(sub_kill_points)) + "\n";
	__str "Points an engineer needs to service a vehicle: " + str(GVAR(ranked_a) select 0) + "\n";
	__str "Points an engineer gets for servicing (air vec): " + str((GVAR(ranked_a) select 1) select 0) + "\n";
	__str "Points an engineer gets for servicing (tank): " + str((GVAR(ranked_a) select 1) select 1) + "\n";
	__str "Points an engineer gets for servicing (car): " + str((GVAR(ranked_a) select 1) select 2) + "\n";
	__str "Points an engineer gets for servicing (other): " + str((GVAR(ranked_a) select 1) select 3) + "\n";
	__str "Points an engineer needs to rebuild the support buildings at base: " + str(GVAR(ranked_a) select 13) + "\n";
	__str "Points an artillery operator needs for a strike: " + str(GVAR(ranked_a) select 2) + "\n";
	if (GVAR(with_ai)) then {
		__str "Points needed to recuruit one AI soldier: " + str(GVAR(ranked_a) select 3) + "\n";
		__str "Points needed to call in an air taxi: " + str(GVAR(ranked_a) select 15) + "\n";
	};
	__str "Points needed for AAHALO parajump: " + str(GVAR(ranked_a) select 4) + "\n";
	__str "Points needed to create a vehicle at a MHQ: " + str(GVAR(ranked_a) select 6) + "\n";
	__str "Points that get subtracted for creating a vehicle at a MHQ: " + str(GVAR(ranked_a) select 5) + "\n";
	__str "Points a medic gets if someone heals at his Mash: " + str(GVAR(ranked_a) select 7) + "\n";
	__str "Points a medic gets if he heals another unit: " + str(GVAR(ranked_a) select 17) + "\n";

	_ar = GVAR(ranked_a) select 8;
	__str "Rank needed to drive wheeled APCs: " + ((_ar select 0) call FUNC(GetRankString)) + "\n";
	__str "Rank needed to drive tanks: " + ((_ar select 1) call FUNC(GetRankString)) + "\n";
	__str "Rank needed to fly helicopters: " + ((_ar select 2) call FUNC(GetRankString)) + "\n";
	__str "Rank needed to fly planes: " + ((_ar select 3) call FUNC(GetRankString)) + "\n";

	__str "Points a player gets if he is near a main target when it gets cleared: " + str(GVAR(ranked_a) select 9) + "\n";
	__str format ["Points a player gets if he is %1 m away from a main target when it gets cleared: ",GVAR(ranked_a) select 10] + str(GVAR(ranked_a) select 9) + "\n";
	__str format ["Points a player gets if he is %1 m away from a sidemission when it gets solved: ",GVAR(ranked_a) select 12] + str(GVAR(ranked_a) select 11) + "\n";

	__str "Points needed to build a mg nest: " + str(GVAR(ranked_a) select 14) + "\n";
	__str "Points needed to call in an air drop: " + str(GVAR(ranked_a) select 16) + "\n";
	__str "Points for transporting other players: " + str(GVAR(ranked_a) select 18) + "\n";
	__str "Points needed to activate SAT View: " + str(GVAR(ranked_a) select 19) + "\n";
	__str "Transport distance to get points: " + str(GVAR(transport_distance)) + "\n";
	__str "Rank needed to fly the wreck lift chopper: " + ((GVAR(wreck_lift_rank)) call FUNC(GetRankString)) + "\n";
};
__str "Air drop radius (0 = exact position): " + str(GVAR(drop_radius)) + "\n";

__str "Reload/refuel/repair time factor: " + str(GVAR(reload_time_factor)) + "\n";

__str "Engine gets shut off on service point: " + (if (GVAR(reload_engineoff)) __tyn);

#ifndef __TT__
__str "AAHALO jump enabled: " + (if (GVAR(WithJumpFlags) == 1) __tyn);
#endif

if (GVAR(WithJumpFlags) == 1) then {
	__str "AAHALO jump available at flag at base: " + (if (GVAR(ParaAtBase) == 0) then {"Yes\n"} else {"No\n"});
	if (GVAR(ParaAtBase) == 0) then {__str "Time between two AAHALO jumps from base flag: " + str(GVAR(HALOWaitTime)/60) + "\n"};
	__str "AAHALO jump start height: " + str(GVAR(HALOJumpHeight)) + "\n";
	if (GVAR(jumpflag_vec) != "") then {__str "Create the following vehicle at jump flag instead parajump: " + GVAR(jumpflag_vec) + "\n"};
};

__str "Maximum distance artillery operator to arti strike point: " + str(GVAR(ArtiOperatorMaxDist)) + "\n";
__str "Artillery reload time between two salvoes: " + str(GVAR(arti_reload_time)) + "\n";
__str format ["Artillery available again after 1, 2, 3 salvoes: %1, %2, %3", GVAR(arti_available_time), GVAR(arti_available_time) + 200, GVAR(arti_available_time) + 400] + "\n";
__str "Check for friendly units near artillery target: " + (if (GVAR(arti_check_for_friendlies) == 0) then {"Yes\n"} else {"No\n"});
__str "Maximum distance player to airdrop point to call in an airdrop: " + str(GVAR(drop_max_dist)) + "\n";

__str "Player autokick time (kicked out of tanks, planes, choppers for the first seconds): " + str(GVAR(AutoKickTime)) + "\n";

__str "Enemy armored vehicles locked: " + (if (GVAR(LockArmored) == 0) __tyn);

__str "Enemy cars locked: " + (if (GVAR(LockCars) == 0) __tyn);

__str "Enemy air vehicles locked: " + (if (GVAR(LockAir) == 0) __tyn);

if (GVAR(WithChopHud)) then {
	__str "Chopper hud on: " + (if (GVAR(chophud_on)) __tyn);
};

__str "Show chopper welcome message: " + (if (GVAR(show_chopper_welcome)) __tyn);

__str "Show vehicle welcome message: " + (if (GVAR(show_vehicle_welcome) == 0) __tyn);

__str "Island repair stations can repair vehicles: " + (if (GVAR(WithRepStations) == 0) __tyn);

#ifdef __TT__
__str "\nPoints for the main target winner team: " + str(GVAR(tt_points) select 0) + "\n";
__str "Points for draw (main target): " + str(GVAR(tt_points) select 1) + "\n";
__str "Points for destroying mt radio tower: " + str(GVAR(tt_points) select 2) + "\n";
__str "Points for main target mission: " + str(GVAR(tt_points) select 3) + "\n";
__str "Points for sidemisson: " + str(GVAR(tt_points) select 4) + "\n";
__str "Points for capturing a camp: " + str(GVAR(tt_points) select 5) + "\n";
__str "Points subtracted for loosing a camp: " + str(GVAR(tt_points) select 6) + "\n";
__str "Points for destroying a vehicle of the other team: " + str(GVAR(tt_points) select 7) + "\n";
__str "Points for killing a member of the other team: " + str(GVAR(tt_points) select 8);
#endif

// don't forget to add \n, but not when adding the last string part
__ctrl(2007) ctrlSetText _str;
__ctrl(2007) ctrlCommit 0;

_str = "";
{
	_med = __getMNsVar2(_x);
	if (!isNull _med && isPlayer _med) then {
		if (_str != "") then {__str ", "};
#ifdef __TT__
		if (side (group _med) == GVAR(player_side)) then {
#endif
		__str (if (alive _med) then {name _med} else {"(Dead)"});
#ifdef __TT__
		};
#endif
	};
} forEach GVAR(is_medic);

if (_str == "") then {_str = "No human players are medics"};
__ctrl(2008) ctrlSetText _str;

_str = "";
{
	_art = __getMNsVar2(_x);
	if (!isNull _art && isPlayer _art) then {
		if (_str != "") then {__str ", "};
#ifdef __TT__
		if (side (group _art) == GVAR(player_side)) then {
#endif
		__str (if (alive _art) then {name _art} else {"(Dead)"});
#ifdef __TT__
		};
#endif
	};
} forEach GVAR(can_use_artillery);

if (_str == "") then {_str = "No human players are artillery operators"};
__ctrl(2009) ctrlSetText _str;

_str = "";
{
	_eng = __getMNsVar2(_x);
	if (!isNull _eng && isPlayer _eng) then {
		if (_str != "") then {__str ", "};
#ifdef __TT__
		if (side (group _eng) == GVAR(player_side)) then {
#endif
		__str (if (alive _eng) then {name _eng} else {"(Dead)"});
#ifdef __TT__
		};
#endif
	};
} forEach GVAR(is_engineer);

if (_str == "") then {_str = "No human players are engineers"};
__ctrl(2010) ctrlSetText _str;

0 spawn {
	waitUntil {!GVAR(settings_dialog_open) || !alive player || __pGetVar(xr_pluncon)};
	if (GVAR(settings_dialog_open)) then {closeDialog 0};
};