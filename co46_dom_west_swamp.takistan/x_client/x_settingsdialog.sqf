// by Xeno
#include "x_setup.sqf"
#define __ctrl(numcontrol) (_XD_display displayCtrl numcontrol)
private ["_ok", "_XD_display", "_ctrl", "_rarray", "_vdindex", "_i", "_index", "_glindex", "_str", "_ar", "_counter", "_oldsliderpos"];

disableSerialization;

_ok = createDialog "XD_SettingsDialog";

_XD_display = __uiGetVar(X_SETTINGS_DIALOG);

if (d_disable_viewdistance) then {
	_ctrl ctrlEnable false;
	__ctrl(1999) ctrlSetText "Viewdistance";
	__ctrl(1997) ctrlSetText "";
} else {
	sliderSetRange [1000, 200, d_MaxViewDistance];
	sliderSetPosition [1000, viewDistance];
	__ctrl(1999) ctrlSetText ("Viewdistance: " + str(round viewDistance));
	_oldsliderpos = sliderPosition 1000;
};

_ctrl = _XD_display displayCtrl 1001;

_glindex = -1;
{
	_index = _ctrl lbAdd _x;
	if (d_graslayer_index == _index) then {_glindex = _index};
} forEach ["No Gras", "Medium Gras", "Full Gras"];

_ctrl lbSetCurSel _glindex;
if (d_Terraindetail == 1) then {
	_ctrl ctrlEnable false;
	__ctrl(1998) ctrlSetText "Gras Layer";
	__ctrl(1996) ctrlSetText "";
};

_ctrl = _XD_display displayCtrl 1002;
if (d_dont_show_player_markers_at_all == 1) then {
	{_ctrl lbAdd _x} forEach ["Off", "With Names", "Markers Only", "Role only", "Health"];
	_ctrl lbSetCurSel d_show_player_marker;
} else {
	_ctrl ctrlShow false;
	__ctrl(1500) ctrlShow false;
	__ctrl(1501) ctrlShow false;
};

_ctrl = _XD_display displayCtrl 1602;
if (d_show_playernames == 1) then {
	{_ctrl lbAdd _x} forEach ["Off", "With Names", "Role only", "Health"];
	_ctrl lbSetCurSel d_show_player_namesx;
} else {
	_ctrl ctrlEnable false;
};

__ctrl(2001) ctrlSetText str(d_points_needed select 0);
__ctrl(2002) ctrlSetText str(d_points_needed select 1);
__ctrl(2003) ctrlSetText str(d_points_needed select 2);
__ctrl(2004) ctrlSetText str(d_points_needed select 3);
__ctrl(2005) ctrlSetText str(d_points_needed select 4);
__ctrl(2006) ctrlSetText str(d_points_needed select 5);

_str = "Own side: " + d_own_side + "\n";
#ifndef __TT__
_str = _str + "Enemy side: " + d_enemy_side;
#else
_str = _str + (switch (playerSide) do {case east: {", WEST"};case west: {", EAST"};});
#endif
_str = _str + "\n";
_str = _str + "Own faction: " + d_player_faction + "\n";
_str = _str + "Main targets: " + str(d_MainTargets) + "\n";
_str = _str + "Island: " + (getText (configFile >> "CfgWorlds" >> worldName >> "description")) + "\n";
_str = _str + "Maximum number of team kills before first kick: " + str(d_maxnum_tks_forkick) + "\n";
_str = _str + "How often can a player shoot at base before kick: " + str(d_player_kick_shootingbase) + "\n";
_str = _str + "Kick for placing a satchel at base: " + (if (d_kick_base_satchel == 0) then {"Yes\n"} else {"No\n"});
_str = _str + "Initial viewdistance: " + str(d_InitialViewDistance) + "\n";
_str = _str + "Maximum viewdistance: " + str(d_MaxViewDistance) + "\n";
_str = _str + "Usable main weaponry: ";

if (!LimitedWeapons) then {
	_str = _str + "All\n";
} else {
	if (count d_poss_weapons > 0) then {
		for "_i" from 0 to (count d_poss_weapons - 1) do {
			_ele = d_poss_weapons select _i;
			_str = _str + ([_ele,1] call XfGetDisplayName);
			if (_i != (count d_poss_weapons - 1)) then {_str = _str + ", "};
		};
		_str = _str + "\n";
	} else {
		_str = _str + "Unknown\n";
	};
};

if (__ACEVer) then {_str = _str + "Version: A.C.E\n"};

_str = _str + "With player AI: " + (if (d_with_ai) then {"Yes\n"} else {"No\n"});

_str = _str + "Ranked: " + (if (d_with_ranked) then {"Yes\n"} else {"No\n"});

_str = _str + "With revive: " +
#ifdef __REVIVE__
"Yes\n";
#else
"No\n";
#endif

_str = _str + "Version string: " + d_version_string + "\n";
_str = _str + "Mission starttime: " + (if (d_TimeOfDay < 10) then {"0"} else {""}) + str(d_TimeOfDay) + ":00\n";
_str = _str + "Internal backpack enabled: " + (if (WithBackpack) then {"Yes\n"} else {"No\n"});
_str = _str + "Sidemissions only: " + (if (d_SidemissionsOnly == 0) then {"Yes\n"} else {"No\n"});
_str = _str + "Show player marker direction: " + (if (d_p_marker_dirs) then {"Yes\n"} else {"No\n"});
_str = _str + "Show vehicle marker direction: " + (if (d_v_marker_dirs) then {"Yes\n"} else {"No\n"});
_str = _str + "Player marker type: " + d_p_marker + "\n";
_str = _str + "Teamstatus Dialog enabled: " + (if (d_use_teamstatusdialog == 0) then {"Yes\n"} else {"No\n"});
_str = _str + "With MHQ Respawn/Teleport: " + (if (d_WithMHQTeleport == 0) then {"Yes\n"} else {"No\n"});
_str = _str + "With Fasttime: " + (if (d_FastTime == 0) then {"Yes\n"} else {"No\n"});
_str = _str + "Enemy skill: " + (switch (EnemySkill) do {case 1: {"Low"};case 2: {"Normal"};case 3: {"High"};}) + "\n";
_str = _str + "With island defense: " + (if (WithIsleDefense == 0) then {"Yes\n"} else {"No\n"});
_str = _str + "With AI recapture: " + (if (WithRecapture == 0) then {"Yes\n"} else {"No\n"});
_str = _str + "Armor at main targets: " + (switch (WithLessArmor) do {case 0: {"Normal"};case 1: {"Less"};case 2: {"None"};}) + "\n";
_str = _str + "With teleport to base: " + (if (WithTeleToBase == 0) then {"Yes\n"} else {"No\n"});
_str = _str + "Illumination over main target: " + (if (d_IllumMainTarget == 0) then {"Yes\n"} else {"No\n"});
_str = _str + "With enemy artillery spotters: " + (if (d_WithEnemyArtySpotters == 0) then {"Yes\n"} else {"No\n"});

_str = _str + "HALO type: " + (if (d_halo_jumptype == 0) then {"New\n"} else {"Old\n"});

#ifndef __TT__
_str = _str + "With base attack (sabotage): " + (if (WithBaseAttack == 0) then {"Yes\n"} else {"No\n"});
#endif

_str = _str + "With winter weather: " + (if (WithWinterWeather == 0) then {"Yes\n"} else {"No\n"});

#ifndef __ACE__
_str = _str + "Override BIS destruction effects: " + (if (OverrideBISEffects == 0) then {"Yes\n"} else {"No\n"});

_str = _str + "Blood and dirt hit effects: " + (if (d_BloodDirtScreen == 0) then {"On\n"} else {"Off\n"});
#endif

_str = _str + "Block spacebar scanning: " + (if (d_BlockSpacebarScanning == 0) then {"Yes\n"} else {"No\n"});
_str = _str + "Player names above head disabled: " + (if (d_show_playernames == 0) then {"Yes\n"} else {"No\n"});

_str = _str + "Gras visible at missionstart: " + (if (d_GrasAtStart == 0) then {"Yes\n"} else {"No\n"});

_str = _str + "Player can change gras layer (terraindetail): " + (if (d_Terraindetail == 0) then {"Yes\n"} else {"No\n"});

_str = _str + "Wrecks get deleted after: " + (if (d_WreckDeleteTime == -1) then {"Never\n"} else {(str(d_WreckDeleteTime / 60) + "minutes\n")});

_str = _str + "Viewdistance can be changed: " + (if (d_ViewdistanceChange == 0) then {"Yes\n"} else {"No\n"});

_str = _str + "MHQ vehicles (create): ";
for "_i" from 0 to (count d_create_bike - 1) do {
	_str = _str + ([d_create_bike select _i,0] call XfGetDisplayName);
	if (_i < (count d_create_bike - 1)) then {
		_str = _str + ", ";
	};
};
_str = _str + "\n";

_str = _str + "Time a player has to wait until he can create a new vehicle at a MHQ: " + str(VecCreateWaitTime) + "\n";

if (count d_only_pilots_can_fly > 0) then {
	_str = _str + "Able to fly: ";
	_hstr = "";
	{
		if (_hstr != "") then {_hstr = _hstr + ", "};
		_hstr = _hstr + _x;
	} forEach d_only_pilots_can_fly;
	_str = _str + _hstr + "\n";
};

_str = _str + "Maximum number of ammoboxes: " + str(d_MaxNumAmmoboxes) + "\n";
_str = _str + "Ammoboxes currently in use: " + str(__XJIPGetVar(ammo_boxes)) + "\n";

_str = _str + "Time to wait until an ammobox can be dropped/loaded again: " + str(d_drop_ammobox_time) + "\n";

_str = _str + "Maximum number of statics per engineer truck: " + str(d_max_truck_cargo) + "\n";


_str = _str + "Vehicles able to load ammoboxes: ";
for "_i" from 0 to (count d_check_ammo_load_vecs - 1) do {
	_str = _str + ([d_check_ammo_load_vecs select _i,0] call XfGetDisplayName);
	if (_i < (count d_check_ammo_load_vecs - 1)) then {_str = _str + ", "};
};
_str = _str + "\n";

#ifndef __REVIVE__
_str = _str + "Player respawn delay (in seconds): " + str(D_RESPAWN_DELAY) + "\n";
#endif

_str = _str + "Player respawn dialog after death: " + (if (d_with_respawn_dialog_after_death) then {"Yes\n"} else {"No\n"});

_str = _str + "Weather system enabled: " + (if (d_weather == 0) then {"Yes\n"} else {"No\n"});

_str = _str + "MG gunners able to build mg nest: " + (if (d_with_mgnest) then {"Yes\n"} else {"No\n"});

#ifndef __REVIVE__
_str = _str + "Respawn with same weapons after death: " + (if (x_weapon_respawn) then {"Yes\n"} else {"No\n"});
#endif

if (d_with_ai) then {_str = _str + "Maximum number of AI that can get recruited: " + str(d_max_ai) + "\n"};

_str = _str + "Points a player loses for teamkill: " + str(d_sub_tk_points) + "\n";

if (d_with_ranked) then {
	_str = _str + "Player points that get subtracted after death: " + str(abs d_sub_kill_points) + "\n";
	_str = _str + "Points an engineer needs to service a vehicle: " + str(d_ranked_a select 0) + "\n";
	_str = _str + "Points an engineer gets for servicing (air vec): " + str((d_ranked_a select 1) select 0) + "\n";
	_str = _str + "Points an engineer gets for servicing (tank): " + str((d_ranked_a select 1) select 1) + "\n";
	_str = _str + "Points an engineer gets for servicing (car): " + str((d_ranked_a select 1) select 2) + "\n";
	_str = _str + "Points an engineer gets for servicing (other): " + str((d_ranked_a select 1) select 3) + "\n";
	_str = _str + "Points an engineer needs to rebuild the support buildings at base: " + str(d_ranked_a select 13) + "\n";
	_str = _str + "Points an artillery operator needs for a strike: " + str(d_ranked_a select 2) + "\n";
	if (d_with_ai) then {
		_str = _str + "Points needed to recuruit one AI soldier: " + str(d_ranked_a select 3) + "\n";
		_str = _str + "Points needed to call in an air taxi: " + str(d_ranked_a select 15) + "\n";
	};
	_str = _str + "Points needed for AAHALO parajump: " + str(d_ranked_a select 4) + "\n";
	_str = _str + "Points needed to create a vehicle at a MHQ: " + str(d_ranked_a select 6) + "\n";
	_str = _str + "Points that get subtracted for creating a vehicle at a MHQ: " + str(d_ranked_a select 5) + "\n";
	_str = _str + "Points a medic gets if someone heals at his Mash: " + str(d_ranked_a select 7) + "\n";
	_str = _str + "Points a medic gets if he heals another unit: " + str(d_ranked_a select 17) + "\n";

	_ar = d_ranked_a select 8;
	_str = _str + "Rank needed to drive wheeled APCs: " + ((_ar select 0) call XGetRankString) + "\n";
	_str = _str + "Rank needed to drive tanks: " + ((_ar select 1) call XGetRankString) + "\n";
	_str = _str + "Rank needed to fly helicopters: " + ((_ar select 2) call XGetRankString) + "\n";
	_str = _str + "Rank needed to fly planes: " + ((_ar select 3) call XGetRankString) + "\n";

	_str = _str + "Points a player gets if he is near a main target when it gets cleared: " + str(d_ranked_a select 9) + "\n";
	_str = _str + format ["Points a player gets if he is %1 m away from a main target when it gets cleared: ",d_ranked_a select 10] + str(d_ranked_a select 9) + "\n";
	_str = _str + format ["Points a player gets if he is %1 m away from a sidemission when it gets solved: ",d_ranked_a select 12] + str(d_ranked_a select 11) + "\n";

	_str = _str + "Points needed to build a mg nest: " + str(d_ranked_a select 14) + "\n";
	_str = _str + "Points needed to call in an air drop: " + str(d_ranked_a select 16) + "\n";
	_str = _str + "Points for transporting other players: " + str(d_ranked_a select 18) + "\n";
	_str = _str + "Points needed to activate SAT View: " + str(d_ranked_a select 19) + "\n";
	_str = _str + "Transport distance to get points: " + str(d_transport_distance) + "\n";
	_str = _str + "Rank needed to fly the wreck lift chopper: " + ((d_wreck_lift_rank) call XGetRankString) + "\n";
};

_str = _str + "Air drop radius (0 = exact position): " + str(d_drop_radius) + "\n";

_str = _str + "Reload/refuel/repair time factor: " + str(x_reload_time_factor) + "\n";

_str = _str + "Engine gets shut off on service point: " + (if (d_reload_engineoff) then {"Yes\n"} else {"No\n"});

#ifndef __TT__
_str = _str + "AAHALO jump enabled: " + (if (WithJumpFlags == 1) then {"Yes\n"} else {"No\n"});
#endif

if (WithJumpFlags == 1) then {
	_str = _str + "AAHALO jump available at flag at base: " + (if (ParaAtBase == 0) then {"Yes\n"} else {"No\n"});
	if (ParaAtBase == 0) then {_str = _str + "Time between two AAHALO jumps from base flag: " + str(d_HALOWaitTime/60) + "\n"};
	_str = _str + "AAHALO jump start height: " + str(HALOJumpHeight) + "\n";
	if (d_jumpflag_vec != "") then {_str = _str + "Create the following vehicle at jump flag instead parajump: " + d_jumpflag_vec + "\n"};
};

_str = _str + "Maximum distance artillery operator to arti strike point: " + str(ArtiOperatorMaxDist) + "\n";
_str = _str + "Artillery reload time between two salvoes: " + str(d_arti_reload_time) + "\n";
_str = _str + format ["Artillery available again after 1, 2, 3 salvoes: %1, %2, %3", d_arti_available_time, d_arti_available_time + 200, d_arti_available_time + 400] + "\n";
_str = _str + "Check for friendly units near artillery target: " + (if (d_arti_check_for_friendlies == 0) then {"Yes\n"} else {"No\n"});
_str = _str + "Maximum distance player to airdrop point to call in an airdrop: " + str(d_drop_max_dist) + "\n";

_str = _str + "Player autokick time (kicked out of tanks, planes, choppers for the first seconds): " + str(AutoKickTime) + "\n";

#ifdef __REVIVE__
_str = _str + "Player starts with the following number of lives (Revive): " + str(d_NORRN_max_respawns) + "\n";
_str = _str + "Respawn button after: " + str(d_NORRN_respawn_button_timer) + "\n";
_str = _str + "Revive time limit: " + str(d_NORRN_revive_time_limit) + "\n";
_str = _str + "Number of heals: " + str(d_NORRN_no_of_heals) + "\n";
#endif

_str = _str + "Enemy armored vehicles locked: " + (if (d_LockArmored == 0) then {"Yes\n"} else {"No\n"});

_str = _str + "Enemy cars locked: " + (if (d_LockCars == 0) then {"Yes\n"} else {"No\n"});

_str = _str + "Enemy air vehicles locked: " + (if (d_LockAir == 0) then {"Yes\n"} else {"No\n"});

if (WithChopHud) then {
	_str = _str + "Chopper hud on: " +(if (d_chophud_on) then {"Yes\n"} else {"No\n"});
};

_str = _str + "Show chopper welcome message: " + (if (d_show_chopper_welcome) then {"Yes\n"} else {"No\n"});

_str = _str + "Show vehicle welcome message: " + (if (d_show_vehicle_welcome == 0) then {"Yes\n"} else {"No\n"});

_str = _str + "Island repair stations can repair vehicles: " + (if (WithRepStations == 0) then {"Yes"} else {"No"});

#ifdef __TT__
_str = _str + "\nPoints for the main target winner team: " + str(d_tt_points select 0) + "\n";
_str = _str + "Points for draw (main target): " + str(d_tt_points select 1) + "\n";
_str = _str + "Points for destroying mt radio tower: " + str(d_tt_points select 2) + "\n";
_str = _str + "Points for main target mission: " + str(d_tt_points select 3) + "\n";
_str = _str + "Points for sidemisson: " + str(d_tt_points select 4) + "\n";
_str = _str + "Points for capturing a camp: " + str(d_tt_points select 5) + "\n";
_str = _str + "Points subtracted for loosing a camp: " + str(d_tt_points select 6) + "\n";
_str = _str + "Points for destroying a vehicle of the other team: " + str(d_tt_points select 7) + "\n";
_str = _str + "Points for killing a member of the other team: " + str(d_tt_points select 8);
#endif

// don't forget to add \n, but not when adding the last string part
__ctrl(2007) ctrlSetText _str;

_str = "";
{
	_med = missionNamespace getVariable _x;
	if (!isNull _med && isPlayer _med) then {
		if (_str != "") then {_str = _str + ", "};
#ifdef __TT__
		if (side _art == playerSide) then {
#endif
		_str = _str + (if (alive _med) then {name _med} else {"(Dead)"});
#ifdef __TT__
		};
#endif
	};
} forEach d_is_medic;

if (_str == "") then {_str = "No human players are medics"};
__ctrl(2008) ctrlSetText _str;

_str = "";
{
	_art = missionNamespace getVariable _x;
	if (!isNull _art && isPlayer _art) then {
		if (_str != "") then {_str = _str + ", "};
#ifdef __TT__
		if (side _art == playerSide) then {
#endif
		_str = _str + (if (alive _art) then {name _art} else {"(Dead)"});
#ifdef __TT__
		};
#endif
	};
} forEach d_can_use_artillery;

if (_str == "") then {_str = "No human players are artillery operators"};
__ctrl(2009) ctrlSetText _str;

_str = "";
{
	_eng = missionNamespace getVariable _x;
	if (!isNull _eng && isPlayer _eng) then {
		if (_str != "") then {_str = _str + ", "};
#ifdef __TT__
		if (side _art == playerSide) then {
#endif
		_str = _str + (if (alive _eng) then {name _eng} else {"(Dead)"});
#ifdef __TT__
		};
#endif
	};
} forEach d_is_engineer;

if (_str == "") then {_str = "No human players are engineers"};
__ctrl(2010) ctrlSetText _str;

if (d_disable_viewdistance) then {
	waitUntil {!dialog || !alive player};
} else {
	while {alive player && dialog} do {
		if (_oldsliderpos != (sliderPosition 1000)) then {
			_slpos = sliderPosition 1000;
			_nvd = floor _slpos;
			setViewDistance _nvd;
			__ctrl(1999) ctrlSetText ("Viewdistance: " + str(_nvd));
			_oldsliderpos = _slpos;
		};
		sleep 0.05;
	};
};

if (!alive player) then {closeDialog 0};