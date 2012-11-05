if (isMultiplayer) then {titleText ["", "BLACK FADED", 0.1]};

if (isNil "paramsArray") then {
	if (isClass (missionConfigFile/"Params")) then {
		for "_i" from 0 to (count (missionConfigFile/"Params") - 1) do {
			_paramName = configName ((missionConfigFile >> "Params") select _i);
			__mNsSetVar [_paramName, getNumber (missionConfigFile >> "Params" >> _paramName >> "default")];
		};
	};
} else {
	for "_i" from 0 to (count paramsArray - 1) do {
		__mNsSetVar [configName ((missionConfigFile >> "Params") select _i), paramsArray select _i];
	};
};

#ifdef __TT__
WithJumpFlags = 1;
d_MaxNumAmmoboxes = d_MaxNumAmmoboxes * 2;
#endif
AmmoBoxHandling = if (AmmoBoxHandling == 0) then {false} else {true};
WithBackpack = if (WithBackpack == 1) then {false} else {true};
LimitedWeapons = if (LimitedWeapons == 1) then {false} else {true};
WithChopHud = if (WithChopHud == 1) then {false} else {true};
#ifndef __RANKED__
d_with_ranked = if (d_with_ranked == 1) then {false} else {true};
#else
d_with_ranked = true;
#endif
d_reload_engineoff = if (d_reload_engineoff == 1) then {false} else {true};

d_p_marker_dirs = if (d_p_marker_dirs == 1) then {false} else {true};
d_v_marker_dirs = if (d_v_marker_dirs == 1) then {false} else {true};

d_with_mgnest = if (d_with_mgnest == 1) then {false} else {true};

#ifdef __ACE__
// override for ACE. ACE 2 has it's own backpack/ruck feature
WithBackpack = false;
#endif

#ifdef __WOUNDS__
if (d_wounds_no_ai == 1) then {ace_sys_wounds_noai = true};
#endif

d_with_ai =
#ifdef __AI__
	true;
#else
	false;
#endif

setViewDistance d_InitialViewDistance;

// this will remove setVehicleInits in BIS effects and should fix sky in fire bug
// probably breaks addons like WarFX, dunno, I'm not using it
#ifndef __ACE__
if (OverrideBISEffects == 0) then {
	[] spawn {
		sleep 0.4;
		waitUntil {!isNil "BIS_Effects_Secondaries"};
		__cppfln(BIS_Effects_EH_Killed,bis_effects\killed.sqf);
		__cppfln(BIS_Effects_AirDestruction,bis_effects\airdestruction.sqf);
		__cppfln(BIS_Effects_AirDestructionStage2,bis_effects\airdestructionstage2.sqf);
		__cppfln(BIS_Effects_Burn,bis_effects\burn.sqf);
	};
};
#endif

d_number_targets_h = d_MainTargets;

if (d_MainTargets >= 50) then {
	_h = switch (d_MainTargets) do {
		case 50: {7};
		case 60: {5};
		case 70: {8};
		case 90: {21};
	};
	d_MainTargets = _h;
};

if (d_GrasAtStart == 1) then {setterraingrid 50};

// WEST, EAST or GUER for own side, setup in x_setup.sqf
#ifdef __OWN_SIDE_WEST__
d_own_side = "WEST";
d_enemy_side = "EAST";
#endif
#ifdef __OWN_SIDE_EAST__
d_own_side = "EAST";
d_enemy_side = "WEST";
#endif
#ifdef __OWN_SIDE_GUER__
d_own_side = "GUER";
d_enemy_side = "EAST";
#endif
#ifdef __TT__
d_enemy_side = "GUER";
d_own_side = "WEST";
#endif

// setup in x_setup.sqf
d_version = [];
#define __adddv(dtype) d_version set [count d_version, #dtype]
#ifdef __OA__
__adddv(OA);
#endif
if (d_with_ai) then {__adddv(AI)};
#ifdef __REVIVE__
__adddv(REVIVE);
#endif
#ifdef __TT__
__adddv(TT);
#endif
#ifdef __ACE__
__adddv(ACE);
#endif
#ifdef __WOUNDS__
__adddv(WOUNDS);
#endif
#ifdef __MANDO__
__adddv(MANDO);
#endif
if (d_with_ranked) then {__adddv(RANKED)};
#ifdef __DEFAULT__
d_target_names =
if (__OAVer) then {
	[
		[[1779.68,11808.1,0],"Nur",300], // 0
		[[3082.35,9922.74,0],"Nagara",300], // 1
		[[6220.99,11111.8,0],"Rasman",300], // 2
		[[5662.6,8936.69,0],"Bastam",300], // 3
		[[9858.96,11464.5,0],"Zavarak",300], // 4
		[[12334.2,10247.7,0],"Karachinar",300], // 5
		[[10721.5,6347.16,0],"Garmsar",300], // 6
		[[9127.56,6757.6,0],"Garmarud",300], // 7
		[[5937.14,7282.13,0],"Falar",300], // 8
		[[5253.33,6177.37,0],"Feruz-Abad",300], // 9
		[[3655.71,4316.29,0],"Sakhe",300], // 10
		[[1466.8,3594.07,0],"Shukurkalay",300], // 11
		[[546.094,2811.05,0],"Chaman",300], // 12
		[[8894.68,5272.33,0],"Timurkalay",300], // 13
		[[4438.04,686.898,0],"Chak Chak",300], // 14
		[[10142.7,2336.75,0],"Chardarakht",300], // 15
		[[2003.28,352.347,0],"Landay",300], // 16
		[[1987.14,7657.36,0],"Mulladost",300], // 17
		[[11528.4,8351.98,0],"Ravanay",300], // 18
		[[1507.13,5701.05,0],"Khushab",300], // 19
		[[2528.11,5068.08,0],"Jilavur",300] // 20
	]
} else {
	[
		[[2733.7,5306.05,0],"Zelenogorsk",300], // 0
		[[6728.4,2590.29,0],"Chernogorsk",300], // 1
		[[10269.5,2110.25,0],"Elektrozavodsk",300], // 2
		[[11146.5,12302.7,0],"Krasnostav",300], // 3
		[[12012.4,9095.97,0],"Berezino",300], // 4
		[[6147.54,7757.34,0],"Stary Sobor",300], // 5
		[[3814.73,8901.37,0],"Vybor",300], // 6
		[[7555.26,5149.45,0],"Mogilevka",300], // 7
		[[10680.4,8054.11,0],"Polana",300], // 8
		[[10412.8,9768.09,0],"Dubrovka",300], // 9
		[[9548.47,8846.42,0],"Gorka",300], // 10
		[[13381.5,6254.74,0],"Solnichniy",300], // 11
		[[10118.6,5521.33,0],"Staroye",300], // 12
		[[1697.54,3847.5,0],"Pavlovo",300], // 13
		[[3075.33,7916.48,0],"Pustoschka",300], // 14
		[[12971.1,10109.1,0],"Berezino Harbour",300], // 15
		[[9178.31,3870.64,0],"Pusta",300], // 16
		[[4741.96,6799.19,0],"Rogovo",300], // 17
		[[4393.77,4606.03,0],"Kozlovka",300], // 18
		[[1828.09,2249.49,0],"Kamenka",300], // 19
		[[8659.28,11840.9,0],"Gvozdno",300] // 20
	]
};
#endif
#ifdef __TT__
d_target_names =
if (__OAVer) then {
	[
		[[1779.68,11808.1,0],"Nur",300], // 0
		[[3082.35,9922.74,0],"Nagara",300], // 1
		[[5662.6,8936.69,0],"Bastam",300], // 3
		[[9858.96,11464.5,0],"Zavarak",300], // 4
		[[12334.2,10247.7,0],"Karachinar",300], // 5
		[[10721.5,6347.16,0],"Garmsar",300], // 6
		[[9127.56,6757.6,0],"Garmarud",300], // 7
		[[5937.14,7282.13,0],"Falar",300], // 8
		[[5253.33,6177.37,0],"Feruz-Abad",300], // 9
		[[3655.71,4316.29,0],"Sakhe",300], // 10
		[[1466.8,3594.07,0],"Shukurkalay",300], // 11
		[[546.094,2811.05,0],"Chaman",300], // 12
		[[8894.68,5272.33,0],"Timurkalay",300], // 13
		[[4438.04,686.898,0],"Chak Chak",300], // 14
		[[10142.7,2336.75,0],"Chardarakht",300], // 15
		[[2003.28,352.347,0],"Landay",300], // 16
		[[1987.14,7657.36,0],"Mulladost",300], // 17
		[[11528.4,8351.98,0],"Ravanay",300], // 18
		[[1507.13,5701.05,0],"Khushab",300], // 19
		[[2528.11,5068.08,0],"Jilavur",300] // 20
	]
} else {
	[
		[[2733.7,5306.05,0],"Zelenogorsk",300], // 0
		[[6728.4,2590.29,0],"Chernogorsk",300], // 1
		[[10269.5,2110.25,0],"Elektrozavodsk",300], // 2
		[[11146.5,12302.7,0],"Krasnostav",300], // 3
		[[12012.4,9095.97,0],"Berezino",300], // 4
		[[6147.54,7757.34,0],"Stary Sobor",300], // 5
		[[3814.73,8901.37,0],"Vybor",300], // 6
		[[7555.26,5149.45,0],"Mogilevka",300], // 7
		[[10680.4,8054.11,0],"Polana",300], // 8
		[[10412.8,9768.09,0],"Dubrovka",300], // 9
		[[9548.47,8846.42,0],"Gorka",300], // 10
		[[13381.5,6254.74,0],"Solnichniy",300], // 11
		[[10118.6,5521.33,0],"Staroye",300], // 12
		[[1697.54,3847.5,0],"Pavlovo",300], // 13
		[[3075.33,7916.48,0],"Pustoschka",300], // 14
		[[12971.1,10109.1,0],"Berezino Harbour",300], // 15
		[[9178.31,3870.64,0],"Pusta",300], // 16
		[[4741.96,6799.19,0],"Rogovo",300], // 17
		[[4393.77,4606.03,0],"Kozlovka",300], // 18
		[[1828.09,2249.49,0],"Kamenka",300], // 19
		[[8659.28,11840.9,0],"Gvozdno",300] // 20
	]
};
#endif
#ifdef __EVERON__
d_target_names = [
	[[4671.13,10722.6,0],"Saint Phillipe",300], // 0
	[[4527.21,9506.97,0],"Meaux",300], // 1
	[[4941.61,9077.45,0],"Tyrone",300], // 2
	[[4135.95,7801.06,0],"Gravette",300], // 3
	[[4897.7,6973.78,0],"Montignac",300], // 4
	[[5755.12,7052.86,0],"Entre Deux",300], // 5
	[[1268.59,5967.68,0],"Lamentin",300], // 6
	[[2591.19,5442.5,0],"Le Moule",300], // 7
	[[5052.18,3980.89,0],"Morton",300], // 8
	[[5297.28,5360.35,0],"Figari",300], // 9
	[[5510.28,6084.46,0],"Provins",300], // 10
	[[7078.44,6039.96,0],"Chotain",300], // 11
	[[7567.68,5573.83,0],"Laruns",300], // 12
	[[7554.94,4724.12,0],"Levie",300], // 13
	[[7183.02,2293.89,0],"Regina",300], // 14
	[[8830.23,2717.55,0],"Durras",300], // 15
	[[9114.86,2174.21,0],"Vernon",300], // 16
	[[9654.58,1565.62,0],"Saint Pierre",300] // 17
];
#endif

#ifdef __DEBUG__
// only for debugging, creates markers at all main target positions
{
	_pos = _x select 0;
	_name = _x select 1;
	_size = _x select 2;
	_marker= createMarkerLocal [_name, _pos];
	_marker setMarkerShapeLocal "ELLIPSE";
	_name setMarkerColorLocal "ColorGreen";
	_name setMarkerSizeLocal [_size,_size];
	_name = _name + "xx";
	_marker= createMarkerLocal [_name, _pos];
	_marker setMarkerTypeLocal "mil_dot";
	_name setMarkerColorLocal "ColorBlack";
	_name setMarkerSizeLocal [0.5,0.5];
	_name setMarkerTextLocal _name;
} forEach d_target_names;
#endif

d_side_enemy = switch (d_enemy_side) do {
	case "EAST": {east};
	case "WEST": {west};
	case "GUER": {resistance};
};

d_side_player =
#ifdef __OWN_SIDE_EAST__
	east;
#endif
#ifdef __OWN_SIDE_WEST__
	west;
#endif
#ifdef __OWN_SIDE_GUER__
	resistance;
#endif
#ifdef __TT__
	west;
#endif

d_side_player_str =
#ifdef __OWN_SIDE_EAST__
	"east";
#endif
#ifdef __OWN_SIDE_WEST__
	"west";
#endif
#ifdef __OWN_SIDE_GUER__
	"guerrila";
#endif
#ifdef __TT__
	"west";
#endif

d_own_side_trigger =
#ifdef __OWN_SIDE_EAST__
	"EAST";
#endif
#ifdef __OWN_SIDE_WEST__
	"WEST";
#endif
#ifdef __OWN_SIDE_GUER__
	"GUER";
#endif
#ifdef __TT__
	"WEST";
#endif

d_ai_enemy_sides =
#ifdef __OWN_SIDE_EAST__
	[west];
#endif
#ifdef __OWN_SIDE_WEST__
	[east];
#endif
#ifdef __OWN_SIDE_GUER__
	[east];
#endif
#ifdef __TT__
	[east,west];
#endif

#ifndef __TT__
d_rep_truck = if (__OAVer) then {
	if (d_enemy_side == "EAST") then {"MtvrRepair_DES_EP1"} else {"UralRepair_TK_EP1"}
} else {
	if (d_enemy_side == "EAST") then {"MtvrRepair"} else {"KamazRepair"}
};
#endif

d_version_string =
#ifdef __OWN_SIDE_EAST__
	"East";
#endif
#ifdef __OWN_SIDE_WEST__
	"West";
#endif
#ifdef __OWN_SIDE_GUER__
	"Guer";
#endif
#ifdef __TT__
	"Two Teams";
#endif

// OATODO: check if the flag names are still the same
//default flag GUER
#ifdef __OWN_SIDE_WEST__
FLAG_BASE setflagtexture "\ca\data\flag_usa_co.paa";
#endif
#ifdef __OWN_SIDE_EAST__
if (__OAVer) then {
	FLAG_BASE setflagtexture "logo.paa";
} else {
	FLAG_BASE setflagtexture "logo.paa";
};
#endif

if (d_with_mgnest) then {
	d_mg_nest = 
#ifdef __OWN_SIDE_GUER__
	"GUE_WarfareBMGNest_PK";
#endif
#ifdef __OWN_SIDE_EAST__
	if (__OAVer) then {
		"WarfareBMGNest_PK_TK_EP1"
	} else {
		"RU_WarfareBMGNest_PK"
	};
#endif
#ifdef __OWN_SIDE_WEST__
	if (__OAVer) then {
		"WarfareBMGNest_M240_US_EP1"
	} else {
		"USMC_WarfareBMGNest_M240"
	};
#endif
#ifdef __TT__
	"";
#endif
};

d_sm_bonus_vehicle_array = (
#ifdef __DEFAULT__
	switch (d_own_side) do {
		case "GUER": {["A10","AH1Z","UH1Y","AV8B","AV8B2", "F35B", "M1A2_TUSK_MG","M1A1"]};
		case "WEST": {
			switch (true) do {
				case (__OAVer): {
					if (__ACEVer) then {
						["A10_US_EP1","AH64D_EP1","AH6J_EP1","M1A1_US_DES_EP1","M1A2_US_TUSK_MG_EP1","M6_EP1","ACE_M1A1HC_DESERT","ACE_M1A1HC_TUSK_DESERT","ACE_M1A1HC_TUSK_CSAMM_DESERT","ACE_M1A1HA_TUSK_CSAMM_DESERT","UH60M_EP1"]
					} else {
						//["A10_US_EP1","AH64D_EP1","AH6J_EP1","M1A1_US_DES_EP1","M1A2_US_TUSK_MG_EP1","M6_EP1","UH60M_EP1"]
						["A10_US_EP1","AH64D_EP1","AH6J_EP1"];
					}
				};
				case (__ACEVer): {
					["A10","AH1Z","UH1Y","AV8B","AV8B2", "F35B", "M1A2_TUSK_MG","M1A1", "AH64D", "ACE_Stryker_MGS_Slat" ,"ACE_Stryker_TOW","ACE_Stryker_TOW_MG","ACE_AH6_GAU19","ACE_AH6","ACE_AH1W_AGM_W","ACE_AH1W_AGM_D","ACE_M2A2_W","ACE_M2A2_D","ACE_M6A1_W","ACE_M6A1_D","ACE_AH1Z_AGM_D","ACE_AH1Z_AGM_AGM_D","ACE_AH1Z_AGM_AGM_W","ACE_M1A1HC_DESERT"]
				};
				default {
					["A10","AH1Z","UH1Y","AV8B","AV8B2", "F35B", "M1A2_TUSK_MG","M1A1","AH64D"]
				};
			}
		};
		case "EAST": {
			switch (true) do {
				case (__OAVer): {
					["Su25_TK_EP1","L39_TK_EP1","Mi24_D_TK_EP1","T72_TK_EP1","T55_TK_EP1","ZSU_TK_EP1"]
				};
				case (__ACEVer): {
					["Su34","Ka52","Ka52Black","Mi24_P","Mi24_V","Su39","T72_RU","2S6M_Tunguska","T90","ACE_T72B_RU","ACE_T72BA_RU","ACE_Su27_CAP","ACE_Su27_CAS","ACE_Su27_CASP"]
				};
				default {
					["Su34","Ka52","Ka52Black","Mi24_P","Mi24_V","Su39","T72_RU","2S6M_Tunguska","T90"]
				};
			}
		};
	}
#endif
#ifdef __EVERON__
	switch (d_own_side) do {
		case "GUER": {["A10","AH1Z","UH1Y","AV8B","AV8B2", "F35B", "M1A2_TUSK_MG","M1A1"]};
		case "WEST": {
			if (__ACEVer) then {
				["A10","AH1Z","UH1Y","AV8B","AV8B2", "F35B", "M1A2_TUSK_MG","M1A1", "AH64D", "ACE_Stryker_MGS_Slat" ,"ACE_Stryker_TOW","ACE_Stryker_TOW_MG","ACE_AH6_GAU19","ACE_AH6","ACE_AH1W_AGM_W","ACE_AH1W_AGM_D","ACE_M2A2_W","ACE_M2A2_D","ACE_M6A1_W","ACE_M6A1_D","ACE_AH1Z_AGM_D","ACE_AH1Z_AGM_AGM_D","ACE_AH1Z_AGM_AGM_W","ACE_M1A1HC_DESERT"]
			} else {
				["A10","AH1Z","UH1Y","AV8B","AV8B2", "F35B", "M1A2_TUSK_MG","M1A1" ,"AH64D"]
			}
		};
		case "EAST": {
			if (__ACEVer) then {
				["Su34","Ka52","Ka52Black","Mi24_P","Mi24_V","Su39","T72_RU","2S6M_Tunguska","T90","ACE_T72B_RU","ACE_T72BA_RU","ACE_Su27_CAP","ACE_Su27_CAS","ACE_Su27_CASP"]
			} else {
				["Su34","Ka52","Ka52Black","Mi24_P","Mi24_V","Su39","T72_RU","2S6M_Tunguska","T90"]
			}
		};
	}
#endif
#ifdef __TT__
	switch (true) do {
		case (__OAVer): {
			[
				["A10_US_EP1","AH64D_EP1","AH6J_EP1","M1A1_US_DES_EP1","M1A2_US_TUSK_MG_EP1","M6_EP1"],
				["Su25_TK_EP1","L39_TK_EP1","Mi24_D_TK_EP1","T72_TK_EP1","T55_TK_EP1","ZSU_TK_EP1"]
			]
		};
		case (__ACEVer): {
			[
				["A10","AH1Z","UH1Y","AV8B","AV8B2", "F35B", "M1A2_TUSK_MG","M1A1", "AH64D", "ACE_Stryker_MGS_Slat" ,"ACE_Stryker_TOW","ACE_Stryker_TOW_MG","ACE_AH6_GAU19","ACE_AH6","ACE_AH1W_AGM_W","ACE_AH1W_AGM_D","ACE_M2A2_W","ACE_M2A2_D","ACE_M6A1_W","ACE_M6A1_D","ACE_AH1Z_AGM_D","ACE_AH1Z_AGM_AGM_D","ACE_AH1Z_AGM_AGM_W","ACE_M1A1HC_DESERT"],
				["Su34","Ka52","Ka52Black","Mi24_P","Mi24_V","Su39","T72_RU","2S6M_Tunguska","T90","ACE_T72B_RU","ACE_T72BA_RU","ACE_Su27_CAP","ACE_Su27_CAS","ACE_Su27_CASP"]
			]
		};
		default {
			[
				["A10","AH1Z","UH1Y","AV8B","AV8B2", "F35B", "M1A2_TUSK_MG","M1A1","AH64D"],
				["Su25_TK_EP1","L39_TK_EP1","Mi24_D_TK_EP1","T72_TK_EP1","T55_TK_EP1","ZSU_TK_EP1"]
			]
		};
	}
#endif
);

d_mt_bonus_vehicle_array = (
#ifdef __DEFAULT__
	switch (d_own_side) do {
		case "GUER": {["BMP2_Gue","BRDM2_Gue","T34","HMMWV_M2","HMMWV_MK19","HMMWV_TOW","HMMWV_Avenger"]};
		case "WEST": {
			switch (true) do {
				case (__OAVer): {
					["M1126_ICV_M2_EP1","M1126_ICV_mk19_EP1","M1128_MGS_EP1","M1129_MC_EP1","M1135_ATGMV_EP1","M2A2_EP1","M2A3_EP1","HMMWV_M1151_M2_DES_EP1","HMMWV_M1151_M2_DES_EP1","HMMWV_M998_crows_M2_DES_EP1","HMMWV_M998_crows_MK19_DES_EP1","HMMWV_M998A2_SOV_DES_EP1","HMMWV_MK19_DES_EP1","HMMWV_TOW_DES_EP1","HMMWV_M1151_M2_CZ_DES_EP1","LandRover_Special_CZ_EP1"]
				};
				case (__ACEVer): {
					["AAV","LAV25","HMMWV_M2","HMMWV_MK19","HMMWV_TOW","HMMWV_Avenger", "ACE_Stryker_ICV_M2", "ACE_Stryker_ICV_M2_SLAT","ACE_Stryker_ICV_MK19","ACE_Stryker_ICV_MK19_SLAT","ACE_Stryker_RV","ACE_M113A3","ACE_Vulcan","ACE_HMMWV_GMV","ACE_HMMWV_GMV_MK19"]
				};
				default {
					["AAV","LAV25","HMMWV_M2","HMMWV_MK19","HMMWV_TOW","HMMWV_Avenger"]
				};
			}
		};
		case "EAST": {
			switch (true) do {
				case (__OAVer): {
					["BMP2_TK_EP1","BRDM2_ATGM_TK_EP1","BRDM2_TK_EP1","BTR60_TK_EP1","M113_TK_EP1","GRAD_TK_EP1","LandRover_MG_TK_EP1","LandRover_SPG9_TK_EP1","UAZ_AGS30_TK_EP1","UAZ_MG_TK_EP1","Ural_ZU23_TK_EP1"]
				};
				case (__ACEVer): {
					["BMP3","BTR90","GAZ_Vodnik","GAZ_Vodnik_HMG","UAZ_AGS30_RU","GRAD_RU","ACE_BMP2D_RU","ACE_BRDM2_ATGM_RU","ACE_BRDM2_RU","ACE_Ural_ZU23_RU","ACE_BRDM2_SA9_RU","ACE_Offroad_SPG9_INS"]
				};
				default {
					["BMP3","BTR90","GAZ_Vodnik","GAZ_Vodnik_HMG","UAZ_AGS30_RU","GRAD_RU"]
				};
			}
		};
	}
#endif
#ifdef __EVERON__
	switch (d_own_side) do {
		case "GUER": {["BMP2_Gue","BRDM2_Gue","T34","HMMWV_M2","HMMWV_MK19","HMMWV_TOW","HMMWV_Avenger"]};
		case "WEST": {
			if (__ACEVer) then {
				["AAV","LAV25","HMMWV_M2","HMMWV_MK19","HMMWV_TOW","HMMWV_Avenger","ACE_Stryker_ICV_M2", "ACE_Stryker_ICV_M2_SLAT","ACE_Stryker_ICV_MK19","ACE_Stryker_ICV_MK19_SLAT","ACE_Stryker_RV","ACE_M113A3","ACE_Vulcan","ACE_HMMWV_GMV","ACE_HMMWV_GMV_MK19"]
			} else {
				["AAV","LAV25","HMMWV_M2","HMMWV_MK19","HMMWV_TOW","HMMWV_Avenger"]
			}
		};
		case "EAST": {
			if (__ACEVer) then {
				["BMP3","BTR90","GAZ_Vodnik","GAZ_Vodnik_HMG","UAZ_AGS30_RU","GRAD_RU","ACE_BMP2D_RU","ACE_BRDM2_ATGM_RU","ACE_BRDM2_RU","ACE_Ural_ZU23_RU","ACE_BRDM2_SA9_RU","ACE_Offroad_SPG9_INS"]
			} else {
				["BMP3","BTR90","GAZ_Vodnik","GAZ_Vodnik_HMG","UAZ_AGS30_RU","GRAD_RU"]
			}
		};
	}
#endif
#ifdef __TT__
	switch (true) do {
		case (__OAVer): {
			[
				["M1126_ICV_M2_EP1","M1126_ICV_mk19_EP1","M1128_MGS_EP1","M1129_MC_EP1","M1135_ATGMV_EP1","M2A2_EP1","M2A3_EP1","HMMWV_M1151_M2_DES_EP1","HMMWV_M1151_M2_DES_EP1","HMMWV_M998_crows_M2_DES_EP1","HMMWV_M998_crows_MK19_DES_EP1","HMMWV_M998A2_SOV_DES_EP1","HMMWV_MK19_DES_EP1","HMMWV_TOW_DES_EP1","HMMWV_M1151_M2_CZ_DES_EP1","LandRover_Special_CZ_EP1"],
				["BMP2_TK_EP1","BRDM2_ATGM_TK_EP1","BRDM2_TK_EP1","BTR60_TK_EP1","M113_TK_EP1","GRAD_TK_EP1","LandRover_MG_TK_EP1","LandRover_SPG9_TK_EP1","UAZ_AGS30_TK_EP1","UAZ_MG_TK_EP1","Ural_ZU23_TK_EP1"]
			]
		};
		case (__ACEVer): {
			[
				["AAV","LAV25","HMMWV_M2","HMMWV_MK19","HMMWV_TOW","HMMWV_Avenger", "ACE_Stryker_ICV_M2", "ACE_Stryker_ICV_M2_SLAT","ACE_Stryker_ICV_MK19","ACE_Stryker_ICV_MK19_SLAT","ACE_Stryker_RV","ACE_M113A3","ACE_Vulcan","ACE_HMMWV_GMV","ACE_HMMWV_GMV_MK19"],
				["BMP3","BTR90","GAZ_Vodnik","GAZ_Vodnik_HMG","UAZ_AGS30_RU","ACE_BMP2D_RU","ACE_BRDM2_ATGM_RU","ACE_BRDM2_RU","ACE_Ural_ZU23_RU","ACE_BRDM2_SA9_RU","ACE_Offroad_SPG9_INS"]
			]
		};
		default {
			[
				["AAV","LAV25","HMMWV_M2","HMMWV_MK19","HMMWV_TOW","HMMWV_Avenger"],
				["BMP3","BTR90","GAZ_Vodnik","GAZ_Vodnik_HMG","UAZ_AGS30_RU"]
			]
		};
	}
#endif
);

// positions for aircraft factories (if one get's destroyed you're not able to service jets/service choppers/repair wrecks)
// first jet service, second chopper service, third wreck repair

d_aircraft_facs =
#ifdef __DEFAULT__
if (__OAVer) then {
	[[[7731.88,1694.06,0],333],[[7857.73,1745.96,0],244],[[7970.34,1810.31,0],244]]
} else {
	[[[4329.36,10899.2,0],60],[[4397.26,10690.8,0],148],[[4932.19,9773.54,0],325]]
};
#endif
#ifdef __EVERON__
	[[[4814.13,11092.8,0],0],[[4841.15,11948,0],0],[[4814.62,11361.6,0],0]];
#endif
#ifdef __TT__
	[];
#endif

x_drop_array =
#ifdef __OWN_SIDE_GUER__
	switch (true) do {
		case (__ACEVer): {
			[["Drop Artillery", "M119"], ["Drop Humvee","HMMWV"], ["Drop Ammo", "USBasicAmmunitionBox"]]
		};
		case (__OAVer): {
			[["Drop Artillery", "D30_TK_GUE_EP1"], ["Drop Pickup","Pickup_PK_TK_GUE_EP1"], ["Drop Ammo", "USBasicAmmunitionBox"]]
		};
		default {
			[["Drop Artillery", "M119"], ["Drop Humvee","HMMWV"], ["Drop Ammo", "USBasicAmmunitionBox"]]
		};
	};
#endif
#ifdef __OWN_SIDE_WEST__
	switch (true) do {
		case (__ACEVer): {
			[["Drop Artillery", "M119"], ["Drop Humvee","HMMWV"], ["Drop Ammo", "USBasicAmmunitionBox"]]
		};
		case (__OAVer): {
			[["Drop Artillery", "M119_US_EP1"], ["Drop Humvee","HMMWV_M1035_DES_EP1"], ["Drop Ammo", "USBasicAmmunitionBox_EP1"]]
		};
		default {
			[["Drop Artillery", "M119"], ["Drop Humvee","HMMWV"], ["Drop Ammo", "USBasicAmmunitionBox"]]
		}
	};
#endif
#ifdef __OWN_SIDE_EAST__
	switch (true) do {
		case (__ACEVer): {
			[["Drop Artillery", "D30_RU"], ["Drop Uaz","UAZ_RU"], ["Drop Ammo", "RUBasicAmmunitionBox"]]
		};
		case (__OAVer): {
			[["Drop Artillery", "D30_TK_EP1"], ["Drop Uaz","UAZ_Unarmed_TK_EP1"], ["Drop Ammo", "TKBasicAmmunitionBox_EP1"]]
		};
		default {
			[["Drop Artillery", "D30_RU"], ["Drop Uaz","UAZ_RU"], ["Drop Ammo", "RUBasicAmmunitionBox"]]
		};
	};
#endif
#ifdef __TT__
	[["Drop Artillery", "M119"], ["Drop Humvee","HMMWV"], ["Drop Ammo", "USBasicAmmunitionBox"]];
#endif

// side of the pilot that will fly the drop air vehicle
x_drop_side = d_own_side;

// these vehicles can be lifted by the wreck lift chopper (previous chopper 4), but only, if they are completely destroyed
#ifndef __TT__
x_heli_wreck_lift_types = d_sm_bonus_vehicle_array + d_mt_bonus_vehicle_array;
#else
x_heli_wreck_lift_types = (d_sm_bonus_vehicle_array select 0) + (d_sm_bonus_vehicle_array select 1) + (d_mt_bonus_vehicle_array select 0) + (d_mt_bonus_vehicle_array select 1);
#endif

d_next_jump_time = -1;

// d_jumpflag_vec = empty ("") means normal jump flags for HALO jump get created
// if you add a vehicle typename to d_jumpflag_vec (d_jumpflag_vec = "UAZ"; for example) only a vehicle gets created and no HALO jump is available
d_jumpflag_vec = "";

d_side_mission_winner = 0;
d_objectID1 = objNull;
d_objectID2 = objNull;

MEDIC_TENT1 allowDamage false;
#ifndef __CARRIER__
AMMOBUILDING allowDamage false;
#endif
MEDIC_TENT2 allowDamage false;
#ifndef __TT__
if (isNil "d_with_carrier") then {
	WALL1 allowDamage false;
	WALL2 allowDamage false;
	WALL3 allowDamage false;
};
#else
AMMOBUILDING2 allowDamage false;
#endif

// for markers and revive (same like NORRN_player_units)
d_player_entities =  switch (true) do {
	case (__ACEVer): {
		//["RESCUE","RESCUE2","alpha_1","alpha_2","alpha_3","alpha_4","alpha_5","alpha_6","alpha_7","alpha_8","bravo_1","bravo_2","bravo_4","bravo_5","bravo_6","bravo_7","bravo_8","charlie_1","charlie_2","charlie_4","charlie_5","charlie_6","charlie_7","charlie_8","delta_1","delta_2","delta_3","delta_4","delta_5","echo_1","echo_2","echo_4","echo_5","echo_6","echo_7","echo_8","pilot_1","pilot_2","pilot_3","pilot_4"]*/
		["RESCUE","RESCUE2","eng_1","eng_2","eng_3","eng_4","echo_sl","echo_mrk","echo_med","echo_ar","echo_rm","delta_sl","delta_rm","delta_mg","delta_med","delta_mrk","charlie_sl","charlie_rm","charlie_at","charlie_ar","charlie_med","charlie_mrk","bravo_sl","bravo_rm","bravo_at","bravo_mg","bravo_mrk","alpha_sl","alpha_rm","alpha_at","alpha_ar","alpha_med","alpha_mrk","pmc_1","pmc_2","pmc_3","pmc_4","pmc_5","pilot_1","pilot_2","pilot_3","pilot_4","pilot_5","pilot_6","pilot_7","pilot_8","pilot_9","pilot_10","pilot_11","pilot_12"]
	};
	case (__OAVer): {
		//["RESCUE","RESCUE2","alpha_1","alpha_2","alpha_3","alpha_4","alpha_5","alpha_6","alpha_7","alpha_8","bravo_1","bravo_2","bravo_3","bravo_4","bravo_5","bravo_6","bravo_7","bravo_8","charlie_1","charlie_2","charlie_3","charlie_4","charlie_5","charlie_6","charlie_7","charlie_8","delta_1","delta_2","delta_3","delta_4"]
		["RESCUE","RESCUE2","eng_1","eng_2","eng_3","eng_4","echo_sl","echo_mrk","echo_med","echo_ar","echo_rm","delta_sl","delta_rm","delta_mg","delta_med","delta_mrk","charlie_sl","charlie_rm","charlie_at","charlie_ar","charlie_med","charlie_mrk","bravo_sl","bravo_rm","bravo_at","bravo_mg","bravo_mrk","alpha_sl","alpha_rm","alpha_at","alpha_ar","alpha_med","alpha_mrk","pmc_1","pmc_2","pmc_3","pmc_4","pmc_5","pilot_1","pilot_2","pilot_3","pilot_4","pilot_5","pilot_6","pilot_7","pilot_8","pilot_9","pilot_10","pilot_11","pilot_12"]
	};
	default {
	
		//["RESCUE","RESCUE2","alpha_1","alpha_2","alpha_3","alpha_4","alpha_5","alpha_6","alpha_7","alpha_8","bravo_1","bravo_2","bravo_3","bravo_4","bravo_5","bravo_6","bravo_7","bravo_8","charlie_1","charlie_2","charlie_3","charlie_4","charlie_5","charlie_6","charlie_7","charlie_8","delta_1","delta_2","delta_3","delta_4","delta_5","delta_6","echo_1","echo_2","echo_3","echo_4","echo_5","echo_6","echo_7","echo_8"]
		["RESCUE","RESCUE2","eng_1","eng_2","eng_3","eng_4","echo_sl","echo_mrk","echo_med","echo_ar","echo_rm","delta_sl","delta_rm","delta_mg","delta_med","delta_mrk","charlie_sl","charlie_rm","charlie_at","charlie_ar","charlie_med","charlie_mrk","bravo_sl","bravo_rm","bravo_at","bravo_mg","bravo_mrk","alpha_sl","alpha_rm","alpha_at","alpha_ar","alpha_med","alpha_mrk","pmc_1","pmc_2","pmc_3","pmc_4","pmc_5","pilot_1","pilot_2","pilot_3","pilot_4","pilot_5","pilot_6","pilot_7","pilot_8","pilot_9","pilot_10","pilot_11","pilot_12"]
	};
};
if (!isDedicated) then {
	d_player_roles = switch (true) do {
		case (__ACEVer): {
			//["PLT LD","PLT SGT","SL","SN","MG","AT","GL","CM","AR","AM","TL","OP","MG","MM","CM","GL","DS","SL","SN","AR","AT","RM","CM","AT","EN","EN","EN","EN","EN","SL","SN","AT","RM","CM","MG","AT","PL","PL","PL","PL"]
			["RESCUE","RESCUE2","eng_1","eng_2","eng_3","eng_4","echo_sl","echo_mrk","echo_med","echo_ar","echo_rm","delta_sl","delta_rm","delta_mg","delta_med","delta_mrk","charlie_sl","charlie_rm","charlie_at","charlie_ar","charlie_med","charlie_mrk","bravo_sl","bravo_rm","bravo_at","bravo_mg","bravo_mrk","alpha_sl","alpha_rm","alpha_at","alpha_ar","alpha_med","alpha_mrk","pmc_1","pmc_2","pmc_3","pmc_4","pmc_5","pilot_1","pilot_2","pilot_3","pilot_4","pilot_5","pilot_6","pilot_7","pilot_8","pilot_9","pilot_10","pilot_11","pilot_12"]
		};
		case (__OAVer): {
			//["PLT LD","PLT SGT","SL","SN","MG","AT","GL","CM","AR","AM","TL","OP","GL","MG","MM","CM","GL","DS","SL","SN","AR","AT","RM","CM","MG","AT","EN","EN","EN","EN"]
			["RESCUE","RESCUE2","eng_1","eng_2","eng_3","eng_4","echo_sl","echo_mrk","echo_med","echo_ar","echo_rm","delta_sl","delta_rm","delta_mg","delta_med","delta_mrk","charlie_sl","charlie_rm","charlie_at","charlie_ar","charlie_med","charlie_mrk","bravo_sl","bravo_rm","bravo_at","bravo_mg","bravo_mrk","alpha_sl","alpha_rm","alpha_at","alpha_ar","alpha_med","alpha_mrk","pmc_1","pmc_2","pmc_3","pmc_4","pmc_5","pilot_1","pilot_2","pilot_3","pilot_4","pilot_5","pilot_6","pilot_7","pilot_8","pilot_9","pilot_10","pilot_11","pilot_12"]
		};
		default {
			//["PLT LD","PLT SGT","SL","SN","MG","AT","GL","CM","AR","AM","TL","OP","GL","MG","MM","CM","GL","DS","SL","SN","AR","AT","RM","CM","MG","AT","EN","EN","EN","EN","EN","EN","SL","SN","AR","AT","RM","CM","MG","AT"]
			["RESCUE","RESCUE2","eng_1","eng_2","eng_3","eng_4","echo_sl","echo_mrk","echo_med","echo_ar","echo_rm","delta_sl","delta_rm","delta_mg","delta_med","delta_mrk","charlie_sl","charlie_rm","charlie_at","charlie_ar","charlie_med","charlie_mrk","bravo_sl","bravo_rm","bravo_at","bravo_mg","bravo_mrk","alpha_sl","alpha_rm","alpha_at","alpha_ar","alpha_med","alpha_mrk","pmc_1","pmc_2","pmc_3","pmc_4","pmc_5","pilot_1","pilot_2","pilot_3","pilot_4","pilot_5","pilot_6","pilot_7","pilot_8","pilot_9","pilot_10","pilot_11","pilot_12"]
		};
	};
};

// position base, a,b, for the enemy at base trigger and marker
d_base_array =
#ifdef __DEFAULT__
if (isNil "d_with_carrier") then {
	if (__OAVer) then {
		[[8006.81,1864.2,0], 500, 200, -210.238]
	} else {
		[[4560.96,10291.4,0], 220, 750, -30.6]
	}
} else {[[14716.3,542.458,0], 40,230,270]};
#endif
#ifdef __EVERON__
	if (isNil "d_with_carrier") then {[[4808.47,11443.2,0], 600, 140, 0]} else {[[14716.3,542.458,0], 40,230,270]};
#endif
#ifdef __TT__
	[
		[[4938.07,2427.23,0], 400, 100, 30], // West
		[[12105,12661.4,0], 400, 100, 20] // East
	];
#endif

if (AmmoBoxHandling) then {last_ammo_drop = -3423};

#ifdef __TT__
d_tt_points = [
	30, // points for the main target winner team
	7, // points if draw (main target)
	3, // points for destroying main target radio tower
	1, // points for main target mission
	10, // points for sidemission
	1, // points for capturing a camp (main target)
	1, // points that get subtracted when loosing a mt camp again
	4, // points for destroying a vehicle of the other team
	1 // points for killing a member of the other team
];
#endif

// position of radar and anti air at own base
#ifdef __DEFAULT__
if (__OAVer) then {
	d_base_radar_pos = [8108.81,1742.59,0];
	d_base_anti_air1 = [7802.25,1569.14,0];
	d_base_anti_air2 = [8356.78,1875.39,0];

} else {
	d_base_radar_pos = [4452.74,10256.3,0];
	d_base_anti_air1 = [4210.8,10670.5,0];
	d_base_anti_air2 = [4737.63,9774.83,0];
};
#endif
#ifdef __EVERON__
d_base_radar_pos = [4853.66,12051.6,0];
d_base_anti_air1 = [4694.31,11914.1,0];
d_base_anti_air2 = [4710.19,10933.5,0];
#endif