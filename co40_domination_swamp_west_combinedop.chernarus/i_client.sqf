// init include client
private ["_standard_weap","_silenced","_glweaps","_basic","_machineg","_sniper","_atweap","_elem","_i","_armor","_car"];

// GVAR(reserverd_slot) gives you the ability to add a reserved slot for admins
// if you don't log in when you've chosen the slot, you'll get kicked after ~20 once the intro ended
// default is no check, example: GVAR(reserverd_slot) = "RESCUE";
GVAR(reserverd_slot) = "";

// marker type used for players
GVAR(p_marker) = (getArray (missionConfigFile >> "Params" >> QGVAR(MarkerTypeL) >> "texts")) select GVAR(MarkerTypeL);

// position of the player ammobox at base (created only on the players computer, refilled every 20 minutes)
#ifdef __DEFAULT__
_mpos = markerPos QGVAR(player_ammobox_pos);
if (isNil QGVAR(with_carrier)) then {
	_mpos set [2,0];
} else {
	_mpos set [2,15.9];
};


GVAR(player_ammobox_pos) = [_mpos, markerDir QGVAR(player_ammobox_pos)];
#endif
#ifdef __TT__
_mpos = markerPos QGVAR(player_ammobox_pos_w);
_mpos set [2,0];
GVAR(player_ammobox_pos) = [[_mpos, markerDir QGVAR(player_ammobox_pos_w)]];
_mpos = markerPos QGVAR(player_ammobox_pos_e);
_mpos set [2,0];
GVAR(player_ammobox_pos) set [count GVAR(player_ammobox_pos), [_mpos, markerDir QGVAR(player_ammobox_pos_e)]];
#endif

#ifdef __ACE__
if !(__TTVer) then {
	_mpos = markerPos QGVAR(ace_player_RuckBox);
	_mpos set [2,0];
	GVAR(ace_boxes) = [["ACE_RuckBox_West", _mpos, markerDir QGVAR(ace_player_RuckBox)]];
	_mpos = markerPos QGVAR(ace_player_HuntIRBox);
	_mpos set [2,0];
	GVAR(ace_boxes) set [count GVAR(ace_boxes), ["ACE_HuntIRBox", _mpos, markerDir QGVAR(ace_player_HuntIRBox)]];
} else {
	_mpos = markerPos QGVAR(ace_player_RuckBox_West);
	_mpos set [2,0];
	GVAR(ace_boxes) = [["ACE_RuckBox_West", _mpos, markerDir QGVAR(ace_player_RuckBox_West)]];
	_mpos = markerPos QGVAR(ace_player_RuckBox_East);
	_mpos set [2,0];
	GVAR(ace_boxes) set [count GVAR(ace_boxes), ["ACE_RuckBox_East", _mpos, markerDir QGVAR(ace_player_RuckBox_East)]];
};
#endif

// this vehicle will be created if you use the "Create XXX" at a mobile respawn (old "Create Motorcycle") or at a jump flag
// IMPORTANT !!!! for ranked version !!!!
// if there is more than one vehicle defined in the array the vehicle will be selected by player rank
// one vehicle only, vehicle is only available when the player is at least lieutenant
GVAR(create_bike) =
#ifdef __OWN_SIDE_GUER__
["M1030"];
#endif
#ifdef __OWN_SIDE_WEST__
switch (true) do {
	case (__OAVer): {
		["ATV_US_EP1","M1030_US_DES_EP1"]
	};
	case (__ACEVer): {
		["MMT_USMC","M1030","ACE_ATV_Honda"]
	};
	case (__COVer): {
		["MMT_USMC","M1030"]
	};
};
#endif
#ifdef __OWN_SIDE_EAST__
switch (true) do {
	case (__OAVer): {
		["TT650_TK_EP1","Old_bike_TK_INS_EP1"]
	};
	case (__ACEVer): {
		["MMT_Civ","ACE_ATV_HondaR"]
	};
	case (__COVer): {
		["MMT_Civ","TT650_Civ"]
	};
};
#endif
#ifdef __TT__
[];
#endif

// if the array is empty, anybody can fly,
// just add the string name (var name in the editor) of the playable units that can fly, for example:
// for example: ["pilot_1","pilot_2"];, case sensitiv
// this includes bonus aircrafts too
GVAR(only_pilots_can_fly) = [];

GVAR(current_mission_text) = "";
GVAR(current_mission_resolved_text) = "";

// time player has to wait until he can drop the next ammobox (old ammobox handling)
// in the new ammobox handling (default, loading and dropping boxes) it means the time dif in seconds before a box can be loaded or dropped again in a vehicle
GVAR(drop_ammobox_time) = if (GVAR(AmmoBoxHandling)) then {120} else {120};
GVAR(current_truck_cargo_array) = 0;
// GVAR(check_ammo_load_vecs)
// the only vehicles that can load an ammo box are the transport choppers and MHQs__
#ifdef __OWN_SIDE_WEST__
GVAR(check_ammo_load_vecs) = switch (true) do {
	case (__OAVer): {["M1133_MEV_EP1","UH60M_EP1","UH1H_TK_GUE_EP1","BMP2_HQ_TK_EP1","Mi17_TK_EP1","CH_47F_BAF","BAF_Merlin_HC3_D"]};
	case (__COVer): {["LAV25_HQ","MH60S","M1133_MEV_EP1","UH60M_EP1","UH1H_TK_GUE_EP1","BMP2_HQ_TK_EP1","Mi17_TK_EP1","CH_47F_BAF","Ka60_PMC","BAF_Merlin_HC3_D","UH1Y","Offroad_DSHKM_Gue","BAF_FV510_D","BAF_FV510_W","Offroad_DSHKM_TK_GUE_EP1"]};
};
#endif
#ifdef __OWN_SIDE_EAST__
GVAR(check_ammo_load_vecs) = switch (true) do {
	case (__OAVer): {["BMP2_HQ_TK_EP1","Mi17_TK_EP1"]};
	case (__COVer): {["BTR90_HQ","Mi17_Ins"]};
};
#endif
#ifdef __TT__
GVAR(check_ammo_load_vecs) = switch (true) do {
	case (__OAVer): {["M1133_MEV_EP1","UH60M_EP1","CH_47F_EP1","BMP2_HQ_TK_EP1","Mi17_TK_EP1"]};
	case (__COVer): {["LAV25_HQ","MH60S","BTR90_HQ","Mi17_Ins"]};
};
#endif

GVAR(weapon_respawn) = true;

if (GVAR(with_ai)) then {
	GVAR(current_ai_num) = 0;
};

// points needed to get a specific rank
// gets even used in the unranked versions, though it's just cosmetic there
#ifndef __TT__
GVAR(points_needed) = [
	10, // Corporal
	25, // Sergeant
	50, // Lieutenant
	125, // Captain
	250, // Major
	300 // Colonel
];
#else
GVAR(points_needed) = [
	10, // Corporal
	25, // Sergeant
	50, // Lieutenant
	125, // Captain
	250, // Major
	300 // Colonel
];
#endif

if (GVAR(with_ranked)) then {
	GVAR(ranked_a) = [
		1, // points that an engineer must have to repair/refuel a vehicle
		[3,2,1,0], // points engineers get for repairing an air vehicle, tank, car, other
#ifndef __TT__
		5, // points an artillery operator needs for a strike
#else
		1,
#endif
		1, // points in the AI version for recruiting one soldier
		0, // points a player needs for an AAHALO parajump
#ifndef __TT__
		0, // points that get subtracted for creating a vehicle at a MHQ
#else
		1,
#endif
		1, // points needed to create a vehicle at a MHQ
		1, // points a medic gets if someone heals at his Mash
		["Sergeant","Lieutenant","Captain","Major"], // Ranks needed to drive different vehicles, starting with: kindof wheeled APC, kindof Tank, kindof Helicopter (except the inital 4 helis), Plane
		30, // points that get added if a player is xxx m in range of a main target when it gets cleared
		400, // range the player has to be in to get the main target extra points
		15, // points that get added if a player is xxx m in range of a sidemission when the sidemission is resolved
		300, // range the player has to be in to get the sidemission extra points
		0, // points needed for an egineer to rebuild the support buildings at base
		0, // points needed to build a mg nest
		0, // points needed in AI Ranked to call in an airtaxi
		2, // points needed to call in an air drop
		1, // points a medic gets when he heals another unit
		1, // points that a player gets when transporting others
		1, // points needed for activating satellite view
		1, // points needed to build a FARP (engineer)
		1 // points a player gets for reviving another player
	];

	// distance a player has to transport others to get points
	GVAR(transport_distance) = 500;

	// rank needed to fly the wreck lift chopper
	GVAR(wreck_lift_rank) = "Private";
} else {
	GVAR(ranked_a) = [];
};

GVAR(graslayer_index) = if (GVAR(GrasAtStart) == 1) then {0} else {1};

GVAR(custom_layout) = [];

GVAR(disable_viewdistance) = (GVAR(ViewdistanceChange) == 1);

if (GVAR(LimitedWeapons)) then {
_standard_weap = ["M16A2","M4A1","G36A_camo","G36C_camo","G36K_camo","LeeEnfield","M14_EP1","AKS_74_kobra","AK_47_M","AK_47_S","AK_74","AKS_74","AKS_74_kobra","AKS_74_U","FN_FAL","Sa58P_EP1","Sa58V_EP1","SCAR_L_CQC","SCAR_L_CQC_Holo","SCAR_L_STD_HOLO"];
_silenced = ["SCAR_H_CQC_CCO_SD","SCAR_H_STD_TWS_SD"];
_glweaps = ["AK_74_GL","AK_74_GL_kobra","M16A2GL","M4A3_RCO_GL_EP1","SCAR_H_STD_EGLM_Spect","SCAR_L_CQC_EGLM_Holo","SCAR_L_STD_EGLM_RCO","SCAR_L_STD_EGLM_TWS","M32_EP1","M79_EP1","Mk13_EP1"];
_basic = ["M16A2","M4A1","AK_47_M","AK_47_S","AK_74","M14_EP1","LeeEnfield","AKS_74","FN_FAL","Sa58P_EP1","Sa58V_EP1"];
_machineg = ["m240_scoped_EP1","M249_EP1","M249_m145_EP1","M249_TWS_EP1","M60A4_EP1","MG36_camo","Mk_48_DES_EP1","PK","RPK_74"];
_sniper = ["KSVK","M107","M107 TWS","M110_NVG_EP1","M110_TWS_EP1","M24_des_EP1","SCAR_H_LNG_Sniper","SCAR_H_LNG_Sniper_SD","SVD","SVD_des_EP1","SVD_NSPU_EP1"];
_atweap = ["Javelin","M136","M47Launcher_EP1","MAAWS","MetisLauncher","RPG18","RPG7V"];
GVAR(limited_weapons_ar) = [
	[["delta_1","delta_2","delta_3","delta_4","delta_5","delta_6"], _standard_weap],
	[["RESCUE","RESCUE2"], _standard_weap],
	[["bravo_1","alpha_1","charlie_1","echo_1"], _standard_weap + _silenced],
	[["alpha_5","bravo_3","bravo_7"], _standard_weap + _glweaps],
	[["alpha_3","alpha_7","charlie_7","charlie_3","bravo_4"], _basic + _machineg],
	[["alpha_2","bravo_5","charlie_2"], _basic + _sniper],
	[["alpha_6","bravo_6","charlie_6"], _basic],
	[["alpha_4","alpha_8","charlie_4","charlie_8"], _standard_weap + _atweap],
	[[], _standard_weap]
];
};

GVAR(marker_vecs) = [];

// chopper varname, type (0 = lift chopper, 1 = wreck lift chopper, 2 = normal chopper), marker name, unique number (same as in init.sqf), marker type, marker color, marker text, chopper string name
#ifdef __TT__
if !(__ACEVer) then {
	GVAR(choppers_west) = [
		["HR1",0,"chopper1",301,"n_air","ColorWhite","1","Lift One"], ["HR2",0,"chopper2",302,"n_air","ColorWhite","2","Lift Two"],
		["HR3",0,"chopper3",303,"n_air","ColorWhite","3","Lift Three"], ["HR4",1,"chopper4",304,"n_air","ColorWhite","W","Wreck Lift"],
		["HR5",2,"chopper5",305,"n_air","ColorWhite","5","Normal"], ["HR6",2,"chopper6",306,"n_air","ColorWhite","6","Normal"]
	];
	GVAR(choppers_east) = [
		["HRR1",0,"chopperR1",401,"n_air","ColorWhite","1","Lift One"], ["HRR2",0,"chopperR2",402,"n_air","ColorWhite","2","Lift Two"],
		["HRR3",0,"chopperR3",403,"n_air","ColorWhite","3","Lift Three"], ["HRR4",1,"chopperR4",404,"n_air","ColorWhite","W","Wreck Lift"],
		["HRR5",2,"chopperR5",405,"n_air","ColorWhite","5","Normal"], ["HRR6",2,"chopperR6",406,"n_air","ColorWhite","6","Normal"]
	];
} else {
	GVAR(choppers_west) = [
		["HR1",0,"chopper1",301,"n_air","ColorWhite","1","Lift One"], ["HR2",0,"chopper2",302,"n_air","ColorWhite","2","Lift Two"],
		["HR3",0,"chopper3",303,"n_air","ColorWhite","3","Lift Three"], ["HR4",1,"chopper4",304,"n_air","ColorWhite","W","Wreck Lift"],
		["HR5",2,"chopper5",305,"n_air","ColorWhite","5","Normal"], ["HR6",2,"chopper6",306,"n_air","ColorWhite","6","Normal"]
	];
	GVAR(choppers_east) = [
		["HRR1",0,"chopperR1",401,"n_air","ColorWhite","1","Lift One"], ["HRR2",0,"chopperR2",402,"n_air","ColorWhite","2","Lift Two"],
		["HRR3",0,"chopperR3",403,"n_air","ColorWhite","3","Lift Three"], ["HRR4",1,"chopperR4",404,"n_air","ColorWhite","W","Wreck Lift"],
		["HRR5",2,"chopperR5",405,"n_air","ColorWhite","5","Normal"], ["HRR6",2,"chopperR6",406,"n_air","ColorWhite","6","Normal"]
	];
};
#else
switch (true) do {
	 case (__ACEVer || __OAVer): {
		GVAR(choppers) = [
			["HR1",0,"chopper1",301,"n_air","ColorWhite","1","Lift One"], ["HR2",2,"chopper2",302,"n_air","ColorWhite","2",""],
			["HR3",2,"chopper3",303,"n_air","ColorWhite","3",""], ["HR4",1,"chopper4",304,"n_air","ColorWhite","W","Wreck Lift"],
			["HR5",2,"chopper5",305,"n_air","ColorWhite","5",""], ["HR6",2,"chopper6",306,"n_air","ColorWhite","6",""]
		];
	};
	case (__COVer): {
		GVAR(choppers) = [
			["HR1",0,"chopper1",301,"n_air","ColorWhite","1","Lift One"], ["HR2",0,"chopper2",302,"n_air","ColorWhite","2","Lift Two"],
			["HR3",0,"chopper3",303,"n_air","ColorWhite","3","Lift Three"], ["HR4",1,"chopper4",304,"n_air","ColorWhite","W","Wreck Lift"]
		];
	};
};
#endif

// vehicle varname, unique number (same as in init.sqf), marker name, marker type, marker color, marker text, vehicle string name
#ifndef __TT__
GVAR(p_vecs) = [
	["MRR1",0,"mobilerespawn1","HQ","ColorYellow","1","MHQ One"],["MRR2",1,"mobilerespawn2","HQ","ColorYellow","2","MHQ Two"],
	["MEDVEC",10,"medvec","n_med","ColorGreen","M",""],["TR1",20,"truck1","n_maint","ColorGreen","R1",""],
	["TR2",21,"truck2","n_support","ColorGreen","F1",""],["TR3",22,"truck3","n_support","ColorGreen","A1",""],
	["TR6",23,"truck4","n_maint","ColorGreen","R2",""],["TR5",24,"truck5","n_support","ColorGreen","F2",""],
	["TR4",25,"truck6","n_support","ColorGreen","A2",""],["TR7",30,"truck7","n_service","ColorGreen","E1",""],
	["TR8",31,"truck8","n_service","ColorGreen","E2",""],["TR9",40,"truck9","n_support","ColorGreen","T2",""],
	["TR10",41,"truck10","n_support","ColorGreen","T1",""]
];
#else
GVAR(p_vecs_west) = [
	["MRR1",0,"mobilerespawn1","HQ","ColorYellow","1","West MHQ One"],["MRR2",1,"mobilerespawn2","HQ","ColorYellow","2","West MHQ Two"],
	["MEDVEC",10,"medvec","n_med","ColorGreen","M",""],["TR1",20,"truck1","n_maint","ColorGreen","R",""],
	["TR2",21,"truck2","n_support","ColorGreen","F",""],["TR3",22,"truck3","n_support","ColorGreen","A",""],
	["TR4",30,"truck4","n_service","ColorGreen","E",""],["TR5",40,"truck5","n_support","ColorGreen","T",""]
];
	
GVAR(p_vecs_east) = [
	["MRRR1",100,"mobilerespawnE1","HQ","ColorYellow","1","East MHQ One"],["MRRR2",101,"mobilerespawnE2","HQ","ColorYellow","2","East MHQ Two"],
	["MEDVECR",110,"medvecE","n_med","ColorGreen","M",""],["TRR1",120,"truckE1","n_maint","ColorGreen","R",""],
	["TRR2",121,"truckE2","n_support","ColorGreen","F",""],["TRR3",122,"truckE3","n_support","ColorGreen","A",""],
	["TRR4",130,"truckE4","n_service","ColorGreen","E",""],["TRR5",140,"truckE5","n_support","ColorGreen","T",""]
];
#endif

// is engineer
#ifndef __TT__
GVAR(is_engineer) = if !(__ACEVer) then {
	[
	"RESCUE","RESCUE2",
	"alpha_1","alpha_2","alpha_3","alpha_4","alpha_5","alpha_6","alpha_7","alpha_8",
	"bravo_1","bravo_2","bravo_3","bravo_4","bravo_5","bravo_6","bravo_7","bravo_8",
	"charlie_1","charlie_2","charlie_3","charlie_4","charlie_5","charlie_6","charlie_7","charlie_8",
	"delta_1","delta_2","delta_3","delta_4","delta_5","delta_6",
	"echo_1","echo_2","echo_3","echo_4","echo_5","echo_6","echo_7","echo_8"
	]
} else {
	[
	"RESCUE","RESCUE2",
	"alpha_1","alpha_2","alpha_3","alpha_4","alpha_5","alpha_6","alpha_7","alpha_8",
	"bravo_1","bravo_2","bravo_3","bravo_4","bravo_5","bravo_6","bravo_7","bravo_8",
	"charlie_1","charlie_2","charlie_3","charlie_4","charlie_5","charlie_6","charlie_7","charlie_8",
	"delta_1","delta_2","delta_3","delta_4","delta_5","delta_6",
	"echo_1","echo_2","echo_3","echo_4","echo_5","echo_6","echo_7","echo_8"
	]
};
#else
GVAR(is_engineer) = ["west_9","west_10","east_9","east_10"];
#endif

// is artillery operator
// please be aware that Dom 2 only supports two artillery operators in the non AI versions
// in the AI version everybody can call in artillery though only one arty is used
GVAR(can_use_artillery) = ["RESCUE","RESCUE2"];

// can build mash
#ifndef __TT__
GVAR(is_medic) = 
	[
	"RESCUE","RESCUE2",
	"alpha_1","alpha_2","alpha_3","alpha_4","alpha_5","alpha_6","alpha_7","alpha_8",
	"bravo_1","bravo_2","bravo_3","bravo_4","bravo_5","bravo_6","bravo_7","bravo_8",
	"charlie_1","charlie_2","charlie_3","charlie_4","charlie_5","charlie_6","charlie_7","charlie_8",
	"delta_1","delta_2","delta_3","delta_4","delta_5","delta_6",
	"echo_1","echo_2","echo_3","echo_4","echo_5","echo_6","echo_7","echo_8"
	];
#else
GVAR(is_medic) = ["west_6","east_6","west_17","east_17"];
#endif

// can build mg nest
#ifndef __TT__
GVAR(can_use_mgnests) = if !(__ACEVer) then {
	[
	"RESCUE","RESCUE2",
	"alpha_1","alpha_2","alpha_3","alpha_4","alpha_5","alpha_6","alpha_7","alpha_8",
	"bravo_1","bravo_2","bravo_3","bravo_4","bravo_5","bravo_6","bravo_7","bravo_8",
	"charlie_1","charlie_2","charlie_3","charlie_4","charlie_5","charlie_6","charlie_7","charlie_8",
	"delta_1","delta_2","delta_3","delta_4","delta_5","delta_6",
	"echo_1","echo_2","echo_3","echo_4","echo_5","echo_6","echo_7","echo_8"
	]
} else {
	[
	"RESCUE","RESCUE2",
	"alpha_1","alpha_2","alpha_3","alpha_4","alpha_5","alpha_6","alpha_7","alpha_8",
	"bravo_1","bravo_2","bravo_3","bravo_4","bravo_5","bravo_6","bravo_7","bravo_8",
	"charlie_1","charlie_2","charlie_3","charlie_4","charlie_5","charlie_6","charlie_7","charlie_8",
	"delta_1","delta_2","delta_3","delta_4","delta_5","delta_6",
	"echo_1","echo_2","echo_3","echo_4","echo_5","echo_6","echo_7","echo_8"
	]
};
#else
GVAR(can_use_mgnests) = ["west_3","west_7","west_18","east_3","east_7","east_18"];
#endif

// can call in air drop
#ifndef __TT__
GVAR(can_call_drop_ar) = 
	[
	"RESCUE","RESCUE2",
	"alpha_1","alpha_2","alpha_3","alpha_4","alpha_5","alpha_6","alpha_7","alpha_8",
	"bravo_1","bravo_2","bravo_3","bravo_4","bravo_5","bravo_6","bravo_7","bravo_8",
	"charlie_1","charlie_2","charlie_3","charlie_4","charlie_5","charlie_6","charlie_7","charlie_8",
	"delta_1","delta_2","delta_3","delta_4","delta_5","delta_6",
	"echo_1","echo_2","echo_3","echo_4","echo_5","echo_6","echo_7","echo_8"
	];
#else
GVAR(can_call_drop_ar) = [];
#endif

#ifdef __OWN_SIDE_EAST__
_armor = if (GVAR(LockArmored) == 1) then {
	switch (true) do {
		case (__OAVer): {["M1A2_US_TUSK_MG_EP1","M1A1_US_DES_EP1","M1126_ICV_M2_EP1","M1126_ICV_mk19_EP1","M1128_MGS_EP1","M1135_ATGMV_EP1","M2A2_EP1","M2A3_EP1","M6_EP1"]};
		case (__ACEVer): {
			["ACE_Stryker_ICV_M2","ACE_Stryker_ICV_M2_SLAT","ACE_Stryker_ICV_MK19","ACE_Stryker_ICV_MK19_SLAT","ACE_Stryker_RV","ACE_Stryker_MGS","ACE_Stryker_MGS_Slat","ACE_Stryker_TOW","ACE_Stryker_TOW_MG","ACE_M2A2_D","ACE_M2A2_W","ACE_M6A1_D","ACE_M6A1_W","ACE_Vulcan"]
		};
		case (__COVer): {["AAV","LAV25","MLRS"]};
	};
} else {[]};
_car = if (GVAR(LockCars) == 1) then {
	switch (true) do {
		case (__OAVer): {["HMMWV_Avenger_DES_EP1","HMMWV_M1151_M2_DES_EP1","HMMWV_M998_crows_M2_DES_EP1","HMMWV_M1151_M2_CZ_DES_EP1","LandRover_Special_CZ_EP1","HMMWV_M998_crows_MK19_DES_EP1","HMMWV_MK19_DES_EP1","HMMWV_TOW_DES_EP1","M119_US_EP1"]};
		case (__ACEVer): {["HMMWV_Avenger","HMMWV_M2","HMMWV_Armored","HMMWV_MK19","HMMWV_TOW","ACE_HMMWV_GMV","ACE_HMMWV_GMV_MK19","M119"]};
		case (__COVer): {["HMMWV_Avenger","HMMWV_M2","HMMWV_Armored","HMMWV_MK19","HMMWV_TOW","M119"]};
	};
} else {[]};
#endif
#ifdef __OWN_SIDE_WEST__
_armor = if (GVAR(LockArmored) == 1) then {
	switch (true) do {
		case (__OAVer): {["T72_TK_EP1","T55_TK_EP1","T34_TK_EP1","BMP2_HQ_TK_EP1","BMP2_TK_EP1","M113_TK_EP1","BRDM2_ATGM_TK_EP1","BRDM2_TK_EP1","BTR60_TK_EP1","ZSU_TK_EP1","Ural_ZU23_TK_EP1","GRAD_TK_EP1"]};
		case (__ACEVer): {["BMP3","BTR90","BTR90_HQ","GAZ_Vodnik","GAZ_Vodnik_HMG"]};
		case (__COVer): {["BMP3","BTR90","BTR90_HQ","GAZ_Vodnik","GAZ_Vodnik_HMG"]};
	};
} else {[]};
_car = if (GVAR(LockCars) == 1) then {
	switch (true) do {
		case (__OAVer): {["UAZ_MG_TK_EP1","BTR40_MG_TK_INS_EP1","LandRover_MG_TK_INS_EP1","LandRover_MG_TK_EP1","UAZ_AGS30_TK_EP1","LandRover_SPG9_TK_INS_EP1","LandRover_SPG9_TK_EP1","D30_TK_EP1","D30_TK_INS_EP1"]};
		case (__ACEVer): {["UAZ_RU","UAZ_AGS30_RU","D30_RU"]};
		case (__COVer): {["UAZ_RU","UAZ_AGS30_RU","D30_RU"]};
	};
} else {[]};
#endif
#ifdef __OWN_SIDE_GUER__
_armor = if (GVAR(LockArmored) == 1) then {["BMP3","BTR90","BTR90_HQ","GAZ_Vodnik","GAZ_Vodnik_HMG"]} else {[]};
_car = if (GVAR(LockCars) == 1) then {["UAZ_RU","UAZ_AGS30_RU","D30_RU"]} else {[]};
#endif
#ifdef __TT__
_armor = if (GVAR(LockArmored) == 1) then {
	switch (true) do {
		case (__OAVer): {["T55_TK_GUE_EP1","T34_TK_GUE_EP1","BRDM2_TK_GUE_EP1","BTR40_MG_TK_GUE_EP1","Ural_ZU23_TK_GUE_EP1"]};
		case (__COVer): {["BMP2_Gue","BRDM2_Gue","BRDM2_HQ_Gue","T34"]};
	};
} else {[]};
_car = if (GVAR(LockCars) == 1) then {
	switch (true) do {
		case (__OAVer): {["Offroad_DSHKM_TK_GUE_EP1","Offroad_SPG9_TK_GUE_EP1","D30_TK_GUE_EP1"]};
		case (__COVer): {["Offroad_DSHKM_Gue","Offroad_SPG9_Gue","Pickup_PK_GUE","Ural_ZU23_Gue"]};
	};
} else {[]};
#endif

GVAR(helilift1_types) =
#ifdef __OWN_SIDE_EAST__
switch (true) do {
	case (__OAVer): {
		["BMP2_HQ_TK_EP1","M113Ambul_TK_EP1","UralSupply_TK_EP1","UralRepair_TK_EP1","UralRefuel_TK_EP1","UralReammo_TK_EP1","V3S_Open_TK_EP1","V3S_TK_EP1","UAZ_Unarmed_TK_EP1","D30_TK_EP1"]
	};
	case (__ACEVer): {
		["BTR90_HQ","GAZ_Vodnik_MedEvac","WarfareSalvageTruck_RU","KamazRepair","KamazRefuel","KamazReammo","ACE_KamazReammo","ACE_KamazRefuel","ACE_KamazRepair","Kamaz","KamazOpen","UAZ_RU"]
	};
	case (__COVer): {
		["BTR90_HQ","GAZ_Vodnik_MedEvac","WarfareSalvageTruck_RU","KamazRepair","KamazRefuel","KamazReammo","Kamaz","KamazOpen","UAZ_RU"]
	};
};
#endif
#ifdef __OWN_SIDE_WEST__
switch (true) do {
	case (__OAVer): {
		["M1133_MEV_EP1","HMMWV_DES_EP1","HMMWV_M1035_DES_EP1","MTVR_DES_EP1","HMMWV_Ambulance_DES_EP1","MtvrReammo_DES_EP1","MtvrRefuel_DES_EP1","MtvrRepair_DES_EP1","LandRover_CZ_EP1","HMMWV_Ambulance_CZ_DES_EP1","MtvrSupply_DES_EP1","M119_US_EP1"]
	};
	case (__ACEVer): {
		["LAV25_HQ","HMMWV","HMMWV_Armored","MTVR","HMMWV_Ambulance","MtvrReammo","MtvrRefuel","MtvrRepair","ACE_MTVRRepair","ACE_MTVRReammo","ACE_MTVRRefuel"]
	};
	case (__COVer): {
		["LAV25_HQ","HMMWV","HMMWV_Armored","MTVR","HMMWV_Ambulance","MtvrReammo","MtvrRefuel","MtvrRepair"]
	};
};
#endif
#ifdef __OWN_SIDE_GUER__
	[];
#endif
#ifdef __TT__
switch (true) do {
	case (__OAVer): {
		["M1133_MEV_EP1","HMMWV_DES_EP1","HMMWV_M1035_DES_EP1","MTVR_DES_EP1","HMMWV_Ambulance_DES_EP1","MtvrReammo_DES_EP1","MtvrRefuel_DES_EP1","MtvrRepair_DES_EP1","LandRover_CZ_EP1","HMMWV_Ambulance_CZ_DES_EP1","MtvrSupply_DES_EP1","M119_US_EP1","BMP2_HQ_TK_EP1","M113Ambul_TK_EP1","UralSupply_TK_EP1","UralRepair_TK_EP1","UralRefuel_TK_EP1","UralReammo_TK_EP1","V3S_Open_TK_EP1","V3S_TK_EP1","UAZ_Unarmed_TK_EP1","D30_TK_EP1"]
	};
	case (__ACEVer): {
		["BTR90_HQ","GAZ_Vodnik_MedEvac","WarfareSalvageTruck_RU","KamazRepair","KamazRefuel","KamazReammo","ACE_KamazReammo","ACE_KamazRefuel","ACE_KamazRepair","Kamaz","KamazOpen","UAZ_RU","LAV25_HQ","HMMWV","HMMWV_Armored","MTVR","HMMWV_Ambulance","MtvrReammo","MtvrRefuel","MtvrRepair","ACE_MTVRRepair","ACE_MTVRReammo","ACE_MTVRRefuel","M119"]
	};
	case (__COVer): {
		["BTR90_HQ","GAZ_Vodnik_MedEvac","WarfareSalvageTruck_RU","KamazRepair","KamazRefuel","KamazReammo","Kamaz","KamazOpen","UAZ_RU","LAV25_HQ","HMMWV","HMMWV_Armored","MTVR","HMMWV_Ambulance","MtvrReammo","MtvrRefuel","MtvrRepair","M119"]
	};
};
#endif

if (count _armor > 0) then {GVAR(helilift1_types) = [GVAR(helilift1_types), _armor] call FUNC(arrayPushStack)};
if (count _car > 0) then {GVAR(helilift1_types) = [GVAR(helilift1_types), _car] call FUNC(arrayPushStack)};
	
#ifdef __TT__
{
	switch (_x select 1) do {
		case 0: {_x set [count _x, GVAR(helilift1_types)]};
		case 1: {_x set [count _x, GVAR(heli_wreck_lift_types)]};
	};
} forEach GVAR(choppers_west);
{
	switch (_x select 1) do {
		case 0: {_x set [count _x, GVAR(helilift1_types)]};
		case 1: {_x set [count _x, GVAR(heli_wreck_lift_types)]};
	};
} forEach GVAR(choppers_east);
#else
{
	switch (_x select 1) do {
		case 0: {_x set [count _x, GVAR(helilift1_types)]};
		case 1: {_x set [count _x, GVAR(heli_wreck_lift_types)]};
	};
} forEach GVAR(choppers);
// also possible:
// _element = GVAR(choppers) select 2; // third chopper
// _elem set [3, GVAR(helilift_types_custom)];
#endif

GVAR(prim_weap_player) = "";
GVAR(last_telepoint) = 0;
GVAR(chophud_on) = true;

// show a welcome message in a chopper (mainly used to tell the player if it is a lift or wreck lift chopper).
// false = disable it
GVAR(show_chopper_welcome) = GVAR(WithChopHud);

GVAR(backpackclasses) = [
	[ // US
		"USBasicBag", "Tripod_Bag", "M2StaticMG_US_Bag_EP1", "M2HD_mini_TriPod_US_Bag_EP1", "MK19_TriPod_US_Bag_EP1", "M252_US_Bag_EP1", "TOW_TriPod_US_Bag_EP1",
		"US_UAV_Pack_EP1", "US_Assault_Pack_EP1", "US_Patrol_Pack_EP1", "US_Backpack_EP1", "DE_Backpack_Specops_EP1"
		
		// "USBasicBag", "Tripod_Bag", "M2StaticMG_US_Bag_EP1", "M2HD_mini_TriPod_US_Bag_EP1", "MK19_TriPod_US_Bag_EP1", "M252_US_Bag_EP1", "TOW_TriPod_US_Bag_EP1",
		// "US_UAV_Pack_EP1", "US_Assault_Pack_EP1", "US_Assault_Pack_Ammo_EP1", "US_Assault_Pack_AmmoSAW_EP1", "US_Assault_Pack_AT_EP1", "US_Assault_Pack_Explosives_EP1", "US_Patrol_Pack_EP1", "US_Patrol_Pack_Ammo_EP1",
		// "US_Patrol_Pack_Specops_EP1", "US_Backpack_EP1", "US_Backpack_AmmoMG_EP1", "US_Backpack_AT_EP1", "US_Backpack_Specops_EP1", "DE_Backpack_Specops_EP1"
	],
	[ // East
		"Tripod_Bag", "DSHKM_TK_GUE_Bag_EP1", "KORD_high_TK_Bag_EP1", "KORD_TK_Bag_EP1", "AGS_TK_Bag_EP1", "2b14_82mm_TK_Bag_EP1", "Metis_TK_Bag_EP1", "TK_RPG_Backpack_EP1",
		"TK_ALICE_Pack_EP1", "TK_Assault_Pack_EP1"
		
		// "Tripod_Bag", "DSHKM_TK_GUE_Bag_EP1", "DSHKM_TK_INS_Bag_EP1", "KORD_high_TK_Bag_EP1", "KORD_TK_Bag_EP1", "AGS_TK_Bag_EP1", "2b14_82mm_TK_Bag_EP1", "Metis_TK_Bag_EP1", "TK_RPG_Backpack_EP1",
		// "TK_ALICE_Pack_EP1", "TK_ALICE_Pack_Explosives_EP1", "TK_ALICE_Pack_AmmoMG_EP1", "TKA_ALICE_Pack_Ammo_EP1", "TKG_ALICE_Pack_AmmoAK47_EP1", "TKG_ALICE_Pack_AmmoAK74_EP1", "TK_Assault_Pack_EP1",
		// "TK_Assault_Pack_RPK_EP1", "TKA_Assault_Pack_Ammo_EP1"
	]
];

#ifdef __OA__
GVAR(jump_helo) = ["Mi17_TK_EP1", "UH60M_EP1", "UH1H_TK_GUE_EP1"];
#endif
#ifdef __CO__
GVAR(jump_helo) = ["Mi17_rockets_RU", "MH60S", "UH1H_TK_GUE_EP1"];
#endif

#ifdef __OA__
GVAR(headbug_vehicle) = "UAZ_Unarmed_TK_EP1";
#endif
#ifdef __CO__
GVAR(headbug_vehicle) = "UAZ_RU";
#endif

if (GVAR(with_ai)) then {
	// additional AI recruit buildings
	// these have to be placed in the editor, give them a var name in the editor
	// only client handling means, no damage handling done for those buildings (contrary to the standard AI hut)
	// example:
	// GVAR(additional_recruit_buildings) = [my_ai_building1, my_ai_building2];
	GVAR(additional_recruit_buildings) = [];
};

// add action menu entries + scripts that will be executed to specific player types
// if the first array is empty, then all players will get that action menu entry
// default, nothing in it
// you have to set fourth element allways to -1000
// example:
//	GVAR(action_menus_type) = [
//		[[],"Whatever2", "whateverscript2.sqf", -1000], // ALL players will get the action menu entry "Whatever2"
//		[["SoldierWMiner", "SoldierWAT","OfficerW"],"Whatever1", "whateverscript1.sqf", -1000] // only players of type SoldierWMiner, SoldierWAT and OfficerW will get the action menu entry "Whatever1"
//	];
// GVAR(action_menus_type) = [];

// add action menu entries + scripts that will be executed to specific player units
// if the first array is empty, then all players will get that action menu entry
// default, nothing in it
// you have to set fourth element allways to -1000
// example:
// 	GVAR(action_menus_unit) = [
//		[[],"Whatever2", "whateverscript2.sqf", -1000], // ALL players will get the action menu entry "Whatever2"
//		[["RESCUE", "delta_1","bravo_6"],"Whatever1", "whateverscript1.sqf", -1000] // only players who are RESCUE, delta_1 and bravo_6 will get the action menu entry "Whatever1"
//	];
// GVAR(action_menus_unit) = [];

// add action menu entries to all or specific vehicles, default = none
// example:
// GVAR(action_menus_vehicle) = [
// 		[[],"Whatever2", "whateverscript2.sqf", -1000], // will add action menu entry "Whatever2" to all vehicles
// 		[["UH60MG", "M113_MHQ"],"Whatever1", "whateverscript1.sqf", -1000] // will add action menu entry "Whatever1" to chopper 1 and MHQ 1
// 
// ];
// GVAR(action_menus_vehicle) = [];

#ifndef __A2ONLY__
if (typeName productVersion != "ARRAY") then {
	productVersion = ["Unknown","Unknown",-1,-1];
};
GVAR(product_array) = [
	productVersion select 0, // product name
	productVersion select 1, // product short name
	(productVersion select 2) / 100, // version * 100
	productVersion select 3 // build
];
#endif
