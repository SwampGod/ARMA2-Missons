// init include server
if (isServer) then {
#ifdef __DEFAULT__
d_bap_counter = 0;
if (__OAVer) then {
d_bonus_create_pos = [7538.68,1774.33,0];
d_bonus_air_positions = [
	[[7882.39,1858.47,0], 150],
	[[7889.29,1868.64,0], 150],
	[[7916.63,1878.25,0], 150],
	[[7934.26,1888.01,0], 150],
	[[7951.35,1897.63,0], 150],
	[[7969.25,1907.26,0], 150],
	[[7986.89,1916.95,0], 150]
];
} else {
d_bonus_create_pos = [4140.94,11077.3,0];
d_bonus_air_positions = [
	[[4810.18,10198.1,0], 240],
	[[4833.96,10157.5,0], 240],
	[[4858.06,10115.1,0], 240],
	[[4882.69,10074.5,0], 240],
	[[4908.32,10032.5,0], 240],
	[[4928.85,9989.33,0], 240],
	[[4782.28,10129.4,0], 60],
	[[4806.74,10085.6,0], 60],
	[[4831.7,10043.4,0], 60],
	[[4854.84,9998.71,0], 60],
	[[4881.22,9957.26,0], 60]
];
};
#endif
#ifdef __TT__
if (__OAVer) then {
d_bonus_create_pos_w = [7538.68,1774.33,0];
} else {
d_bonus_create_pos_w = [4498.87,2731.55,0];
};
d_bap_counter_w = 0;
if (__OAVer) then {
d_bonus_air_positions_w = [
	[[7882.39,1858.47,0], 150],
	[[7889.29,1868.64,0], 150],
	[[7916.63,1878.25,0], 150],
	[[7934.26,1888.01,0], 150],
	[[7951.35,1897.63,0], 150],
	[[7969.25,1907.26,0], 150],
	[[7986.89,1916.95,0], 150]
];
} else {
d_bonus_air_positions_w = [
	[[4810.18,10198.1,0], 240],
	[[4833.96,10157.5,0], 240],
	[[4858.06,10115.1,0], 240],
	[[4882.69,10074.5,0], 240],
	[[4908.32,10032.5,0], 240],
	[[4928.85,9989.33,0], 240],
	[[4782.28,10129.4,0], 60],
	[[4806.74,10085.6,0], 60],
	[[4831.7,10043.4,0], 60],
	[[4854.84,9998.71,0], 60],
	[[4881.22,9957.26,0], 60]
];
};

if (__OAVer) then {
d_bonus_create_pos_e = [5514.88,10988.5,0];
} else {
d_bonus_create_pos_e = [12609.9,12486.8,0];
};
d_bap_counter_e = 0;
if (__OAVer) then {
d_bonus_air_positions_e = [
	[[5818.1,11362.60], 315],
	[[5774.4,11323.90], 315],
	[[5730.43,11281,0], 315],
	[[5701.43,11244.2,0], 315],
	[[5678.93,11221.8,0], 315],
	[[5653.48,11195.8,0], 315],
	[[5625.88,11167.9,0], 315]
];
} else {
d_bonus_air_positions_e = [
	[[12155.7,12747.9,0], 200],
	[[12183.7,12736.2,0], 200],
	[[12209.8,12726.5,0], 200],
	[[12233.7,12717.8,0], 200],
	[[12269.9,12703.3,0], 200]
];
};
#endif
#ifdef __EVERON__
d_bonus_create_pos = [4990.15,12084.1,0];
d_bap_counter = 0;
d_bonus_air_positions = [
	[[4874.98,11455.4,0], 270],
	[[4875,11385.5,0], 270],
	[[4878.97,11330.5,0], 270],
	[[4814.34,11410.2,0], 90],
	[[4813.5,11464.7,0], 90]
];
#endif

#ifdef __DEFAULT__
d_bvp_counter = 0;
if (__OAVer) then {
d_bonus_vec_positions = [
	[[8128.62,2068.79,0], 60],
	[[8130.76,2055.11,0], 60],
	[[8132.96,2051.2,0], 60],
	[[8135.27,2047.27,0], 60],
	[[8135.27,2042.9,0], 60],
	[[8140.16,2038.67,0], 60],
	[[8142.7,2034.35,0], 60],
	[[8145.38,2030.12,0], 60],
	[[8147.78,2026.13,0], 60],
	[[8143.23,2067.33,0], 240],
	[[8145.73,2063.16,0], 240],
	[[8147.93,2058.41,0], 240],
	[[8150.36,2054.63,0], 240],
	[[8152.8,2050.83,0], 240],
	[[8155.23,2046.74,0], 240],
	[[8157.66,2042.82,0], 240],
	[[8160.22,2038.89,0], 240],
	[[8162.65,2034.82,0], 240]
];
} else {
d_bonus_vec_positions = [
	[[4549.62,10662.3,0], 240],
	[[4535.23,10684.9,0], 240],
	[[4522.52,10707,0], 240],
	[[4512.36,10724.5,0], 240],
	[[4501.14,10742.5,0], 240],
	[[4487.8,10765.4,0], 240],
	[[4477.91,10783.2,0], 240],
	[[4467.64,10802.1,0], 240]
];
};
#endif
#ifdef __TT__
d_bvp_counter_w = 0;
if (__OAVer) then {
d_bonus_vec_positions_w = [
	[[8128.62,2068.79,0], 60],
	[[8130.76,2055.11,0], 60],
	[[8132.96,2051.2,0], 60],
	[[8135.27,2047.27,0], 60],
	[[8135.27,2042.9,0], 60],
	[[8140.16,2038.67,0], 60],
	[[8142.7,2034.35,0], 60],
	[[8145.38,2030.12,0], 60],
	[[8147.78,2026.13,0], 60],
	[[8143.23,2067.33,0], 240],
	[[8145.73,2063.16,0], 240],
	[[8147.93,2058.41,0], 240],
	[[8150.36,2054.63,0], 240],
	[[8152.8,2050.83,0], 240],
	[[8155.23,2046.74,0], 240],
	[[8157.66,2042.82,0], 240],
	[[8160.22,2038.89,0], 240],
	[[8162.65,2034.82,0], 240]
];
} else {
d_bonus_vec_positions_w = [
	[[5071.31,2352.51,0], 212],
	[[5095.94,2338.93,0], 212],
	[[5120.67,2323.57,0], 212],
	[[5147.34,2306.6,0], 212],
	[[5169.8,2292.16,0], 212]
];
};

d_bvp_counter_e = 0;
if (__OAVer) then {
d_bonus_vec_positions_e = [
	[[5933.06,11360.7,0], 305],
	[[5939.04,11371.5,0], 305],
	[[5950.53,11387.4,0], 305],
	[[5960.81,11399.6,0], 305],
	[[5973.8,11412.1,0], 305],
	[[5986.26,11426.2,0], 305]
];
} else {
d_bonus_vec_positions_e = [
	[[11937.9,12683.1,0], 15],
	[[11909.5,12691.1,0], 15],
	[[11885.3,12700.7,0], 15],
	[[11861.4,12708.5,0], 15],
	[[11833.7,12718.1,0], 15]
];
};
#endif
#ifdef __EVERON__
d_bvp_counter = 0;
d_bonus_vec_positions = [
	[[4871.23,11569.1,0], 270],
	[[4874.05,11532.8,0], 270],
	[[4876.1,11503.9,0], 270]
];
#endif

d_firebase =
#ifndef __OA__
if (d_enemy_side == "EAST") then {"Firebase1_RU"} else {"Firebase1_US"};
#else
if (d_enemy_side == "EAST") then {"Firebase1_TK_EP1"} else {"Firebase1_US_EP1"};
#endif

#ifndef __OA__
d_artillery_radar = switch (d_enemy_side) do {
	case "WEST": {"USMC_WarfareBArtilleryRadar"};
	case "EAST": {"RU_WarfareBArtilleryRadar"};
	case "GUER": {"Gue_WarfareBArtilleryRadar"};
};
#else
d_artillery_radar = switch (d_enemy_side) do {
	case "WEST": {"US_WarfareBArtilleryRadar_EP1"};
	case "EAST": {"TK_WarfareBArtilleryRadar_EP1"};
	case "GUER": {"TK_GUE_WarfareBArtilleryRadar_EP1"};
};
#endif

#ifndef __OA__
d_air_radar = switch (d_enemy_side) do {
	case "WEST": {"USMC_WarfareBAntiAirRadar"};
	case "EAST": {"RU_WarfareBAntiAirRadar"};
	case "GUER": {"GUE_WarfareBAntiAirRadar"};
};
#else
d_air_radar = switch (d_enemy_side) do {
	case "WEST": {"US_WarfareBAntiAirRadar_EP1"};
	case "EAST": {"TK_WarfareBAntiAirRadar_EP1"};
	case "GUER": {"TK_GUE_WarfareBAntiAirRadar_EP1"};
};
#endif

#ifndef __OA__
d_enemy_hq = switch (d_enemy_side) do {
	case "EAST": {"BTR90_HQ_unfolded"};
	case "WEST": {"LAV25_HQ_unfolded"};
	case "GUER": {"BRDM2_HQ_Gue_unfolded"};
};
#else
d_enemy_hq = switch (d_enemy_side) do {
	case "EAST": {"BMP2_HQ_TK_unfolded_EP1"};
	case "WEST": {"M1130_HQ_unfolded_EP1"};
	case "GUER": {"BRDM2_HQ_TK_GUE_unfolded_EP1"};
};
#endif

// _E = East
// _W = West
// _G = Guer
// this is what gets spawned
d_allmen_E =
#ifndef __OA__
[
	["East","RU","Infantry","RU_InfSquad"] call XfGetConfigGroup,
	["East","RU","Infantry","RU_InfSection"] call XfGetConfigGroup,
	["East","RU","Infantry","RU_InfSection_AT"] call XfGetConfigGroup,
	["East","RU","Infantry","RU_InfSection_AA"] call XfGetConfigGroup,
	["East","RU","Infantry","RU_InfSection_MG"] call XfGetConfigGroup,
	["East","RU","Infantry","RU_SniperTeam"] call XfGetConfigGroup,
	["East","RU","Infantry","RUS_ReconTeam"] call XfGetConfigGroup,
	["East","RU","Infantry","MVD_AssaultTeam"] call XfGetConfigGroup,
	["East","INS","Infantry","INS_InfSquad"] call XfGetConfigGroup,
	["East","INS","Infantry","INS_InfSquad_Weapons"] call XfGetConfigGroup,
	["East","INS","Infantry","INS_InfSection_AT"] call XfGetConfigGroup,
	["East","INS","Infantry","INS_InfSection_AA"] call XfGetConfigGroup,
	["East","INS","Infantry","INS_SniperTeam"] call XfGetConfigGroup,
	["East","INS","Infantry","INS_MilitiaSquad"] call XfGetConfigGroup
];
#else
[
	["East","BIS_TK","Infantry","TK_InfantrySquad"] call XfGetConfigGroup,
	["East","BIS_TK","Infantry","TK_InfantrySection"] call XfGetConfigGroup,
	["East","BIS_TK","Infantry","TK_InfantrySectionAT"] call XfGetConfigGroup,
	["East","BIS_TK","Infantry","TK_InfantrySectionAA"] call XfGetConfigGroup,
	["East","BIS_TK","Infantry","TK_InfantrySectionMG"] call XfGetConfigGroup,
	["East","BIS_TK","Infantry","TK_SniperTeam"] call XfGetConfigGroup,
	["East","BIS_TK","Infantry","TK_SpecialPurposeSquad"] call XfGetConfigGroup,
	["East","BIS_TK_INS","Infantry","TK_INS_Group"] call XfGetConfigGroup,
	["East","BIS_TK_INS","Infantry","TK_INS_Patrol"] call XfGetConfigGroup,
	["East","BIS_TK_INS","Infantry","TK_INS_AATeam"] call XfGetConfigGroup,
	["East","BIS_TK_INS","Infantry","TK_INS_ATTeam"] call XfGetConfigGroup
];
#endif
d_allmen_W = 
#ifndef __OA__
[
	["West","USMC","Infantry","USMC_InfSquad"] call XfGetConfigGroup,
	["West","USMC","Infantry","USMC_FireTeam"] call XfGetConfigGroup,
	["West","USMC","Infantry","USMC_FireTeam_MG"] call XfGetConfigGroup,
	["West","USMC","Infantry","USMC_FireTeam_AT"] call XfGetConfigGroup,
	["West","USMC","Infantry","USMC_FireTeam_Support"] call XfGetConfigGroup,
	["West","USMC","Infantry","USMC_HeavyATTeam"] call XfGetConfigGroup,
	["West","USMC","Infantry","USMC_SniperTeam"] call XfGetConfigGroup,
	["West","USMC","Infantry","USMC_FRTeam"] call XfGetConfigGroup,
	["West","USMC","Infantry","USMC_FRTeam_Razor"] call XfGetConfigGroup,
	["West","CDF","Infantry","CDF_InfSquad"] call XfGetConfigGroup,
	["West","CDF","Infantry","CDF_InfSquad_Weapons"] call XfGetConfigGroup,
	["West","CDF","Infantry","CDF_InfSection_AT"] call XfGetConfigGroup,
	["West","CDF","Infantry","CDF_InfSection_AA"] call XfGetConfigGroup,
	["West","CDF","Infantry","CDF_InfSection_MG"] call XfGetConfigGroup,
	["West","CDF","Infantry","CDF_InfSection_Patrol"] call XfGetConfigGroup,
	["West","CDF","Infantry","CDF_SniperTeam"] call XfGetConfigGroup
];
#else
[
	["West","BIS_US","Infantry","US_RifleSquad"] call XfGetConfigGroup,
	["West","BIS_US","Infantry","US_WeaponsSquad"] call XfGetConfigGroup,
	["West","BIS_US","Infantry","US_Team"] call XfGetConfigGroup,
	["West","BIS_US","Infantry","US_TeamMG"] call XfGetConfigGroup,
	["West","BIS_US","Infantry","US_TeamAT"] call XfGetConfigGroup,
	["West","BIS_US","Infantry","US_TeamSupport"] call XfGetConfigGroup,
	["West","BIS_US","Infantry","US_HeavyATTeam"] call XfGetConfigGroup,
	["West","BIS_US","Infantry","US_SniperTeam"] call XfGetConfigGroup,
	["West","BIS_US","Infantry","US_DeltaForceTeam"] call XfGetConfigGroup,
	["West","BIS_CZ","Infantry","ACR_InfantryPatrol"] call XfGetConfigGroup,
	["West","BIS_CZ","Infantry","ACR_SpecialForcesTeam"] call XfGetConfigGroup,
	["West","BIS_GER","Infantry","KSKTeam"] call XfGetConfigGroup
];
#endif
d_allmen_G =
#ifndef __OA__
[
	["Guerrila","GUE","Infantry","GUE_InfSquad"] call XfGetConfigGroup,
	["Guerrila","GUE","Infantry","GUE_InfSquad_Assault"] call XfGetConfigGroup,
	["Guerrila","GUE","Infantry","GUE_InfSquad_Weapons"] call XfGetConfigGroup,
	["Guerrila","GUE","Infantry","GUE_InfTeam_1"] call XfGetConfigGroup,
	["Guerrila","GUE","Infantry","GUE_InfTeam_2"] call XfGetConfigGroup,
	["Guerrila","GUE","Infantry","GUE_InfTeam_AT"] call XfGetConfigGroup,
	["Guerrila","GUE","Infantry","GUE_GrpInf_TeamAA"] call XfGetConfigGroup,
	["Guerrila","GUE","Infantry","GUE_GrpInf_TeamSniper"] call XfGetConfigGroup,
	["Guerrila","GUE","Infantry","GUE_MilitiaSquad"] call XfGetConfigGroup
];
#else
[
	["Guerrila","BIS_TK_GUE","Infantry","TK_GUE_Group"] call XfGetConfigGroup,
	["Guerrila","BIS_TK_GUE","Infantry","TK_GUE_GroupWeapons"] call XfGetConfigGroup,
	["Guerrila","BIS_TK_GUE","Infantry","TK_GUE_Patrol"] call XfGetConfigGroup,
	["Guerrila","BIS_TK_GUE","Infantry","TK_GUE_ATTeam"] call XfGetConfigGroup,
	["Guerrila","BIS_TK_GUE","Infantry","TK_GUE_AATeam"] call XfGetConfigGroup,
	["Guerrila","BIS_TK_GUE","Infantry","TK_GUE_SniperTeam"] call XfGetConfigGroup,
	["Guerrila","BIS_UN","Infantry","UN_Patrol"] call XfGetConfigGroup
];
#endif

#ifndef __OA__
d_specops_E = ["RUS_Soldier_TL","RUS_Soldier_GL","RUS_Soldier_Marksman","RUS_Soldier3","RUS_Soldier1","RUS_Soldier2"];
d_specops_W = ["FR_TL","FR_AC","FR_GL","FR_Commander","FR_AR","FR_R","FR_Corpsman","FR_Marksman","FR_Sapper","FR_Assault_R","FR_Assault_GL"];
d_specops_G = ["GUE_Soldier_Sab","GUE_Soldier_Scout"];

d_sabotage_E = ["RUS_Soldier1","RUS_Soldier2"];
d_sabotage_W = ["FR_R","FR_Sapper"];
d_sabotage_G = ["GUE_Soldier_Sab"];
#else
d_specops_E = ["TK_Special_Forces_TL_EP1","TK_Special_Forces_EP1","TK_Special_Forces_MG_EP1"];
d_specops_W = ["US_Delta_Force_TL_EP1","US_Delta_Force_EP1","US_Delta_Force_Medic_EP1","US_Delta_Force_Assault_EP1","US_Delta_Force_SD_EP1","US_Delta_Force_MG_EP1","US_Delta_Force_AR_EP1","US_Delta_Force_Night_EP1","US_Delta_Force_Marksman_EP1","US_Delta_Force_M14_EP1","US_Delta_Force_Air_Controller_EP1"];
d_specops_G = ["TK_GUE_Soldier_EP1","TK_GUE_Soldier_2_EP1","TK_GUE_Soldier_3_EP1","TK_GUE_Soldier_4_EP1"];

d_sabotage_E = ["TK_Special_Forces_EP1"];
d_sabotage_W = ["US_Delta_Force_SD_EP1"];
d_sabotage_G = ["TK_GUE_Soldier_EP1"];
#endif

d_veh_a_E = switch (true) do {
	case (__OAVer): {
		[
			["T72_TK_EP1","T55_TK_EP1","T34_TK_EP1"],
			["BMP2_HQ_TK_EP1","BMP2_TK_EP1", "M113_TK_EP1"],
			["BRDM2_ATGM_TK_EP1","BRDM2_TK_EP1","BTR60_TK_EP1"],
			["ZSU_TK_EP1","Ural_ZU23_TK_EP1"],
			["UAZ_MG_TK_EP1","BTR40_MG_TK_INS_EP1","LandRover_MG_TK_INS_EP1","LandRover_MG_TK_EP1"],
			["UAZ_AGS30_TK_EP1","LandRover_SPG9_TK_INS_EP1","LandRover_SPG9_TK_EP1"],
			["KORD_high_TK_EP1","KORD_TK_EP1","DSHkM_Mini_TriPod_TK_INS_EP1","DSHKM_TK_INS_EP1","SPG9_TK_INS_EP1"],
			["2b14_82mm_TK_EP1","AGS_TK_EP1","Igla_AA_pod_TK_EP1","Metis_TK_EP1","ZU23_TK_EP1","2b14_82mm_TK_INS_EP1","AGS_TK_INS_EP1","ZU23_TK_INS_EP1"],
			["D30_TK_EP1","GRAD_TK_EP1","D30_TK_INS_EP1"],
			["UralRefuel_TK_EP1"],
			["UralRepair_TK_EP1"],
			["UralReammo_TK_EP1"]
		]
	};
	case (__ACEVer): {
		[
			["T72_RU","T90","T72_INS","ACE_T72B_RU","ACE_T72B_INS","ACE_T72BA_RU","ACE_T72BA_INS"],
			["BMP3","BMP2_INS","ACE_BMP2D_RU"],
			["BTR90","BTR90_HQ","BRDM2_INS","BRDM2_ATGM_INS","ACE_BRDM2_ATGM_RU","ACE_BRDM2_RU"],
			["2S6M_Tunguska","ZSU_INS","Ural_ZU23_INS","ACE_Ural_ZU23_RU","ACE_BRDM2_SA9_RU"],
			["GAZ_Vodnik","GAZ_Vodnik_HMG"],
			["UAZ_AGS30_RU","UAZ_AGS30_INS","UAZ_MG_INS","UAZ_SPG9_INS","ACE_Offroad_SPG9_INS"],
			["KORD"],
			["AGS_RU","Igla_AA_pod_East","Metis","2b14_82mm"],
			["D30_RU","GRAD_INS"],
			["KamazRefuel","ACE_KamazRefuel"],
			["KamazRepair","ACE_KamazRepair"],
			["KamazReammo","ACE_KamazReammo"]
		]
	};
	default {
		[
			["T72_RU","T90","T72_INS"],
			["BMP3","BMP2_INS"],
			["BTR90","BTR90_HQ","BRDM2_INS","BRDM2_ATGM_INS"],
			["2S6M_Tunguska","ZSU_INS","Ural_ZU23_INS"],
			["GAZ_Vodnik","GAZ_Vodnik_HMG"],
			["UAZ_AGS30_RU","UAZ_AGS30_INS","UAZ_MG_INS","UAZ_SPG9_INS"],
			["KORD"],
			["AGS_RU","Igla_AA_pod_East","Metis","2b14_82mm"],
			["D30_RU","GRAD_INS"],
			["KamazRefuel"],
			["KamazRepair"],
			["KamazReammo"]
		]
	};
};

d_veh_a_W = switch (true) do {
	case (__OAVer): {
		[
			["M1A2_US_TUSK_MG_EP1","M1A1_US_DES_EP1"],
			["M1126_ICV_M2_EP1","M1126_ICV_mk19_EP1","M1128_MGS_EP1","M1135_ATGMV_EP1"],
			["M2A2_EP1","M2A3_EP1"],
			["M6_EP1","HMMWV_Avenger_DES_EP1"],
			["HMMWV_M1151_M2_DES_EP1","HMMWV_M998_crows_M2_DES_EP1","HMMWV_M1151_M2_CZ_DES_EP1","LandRover_Special_CZ_EP1"],
			["HMMWV_M998_crows_MK19_DES_EP1","HMMWV_MK19_DES_EP1","HMMWV_TOW_DES_EP1"],
			["M2HD_mini_TriPod_US_EP1","M2StaticMG_US_EP1"],
			["M252_US_EP1","MK19_TriPod_US_EP1","Stinger_Pod_US_EP1","TOW_TriPod_US_EP1"],
			["M119_US_EP1","MLRS_DES_EP1"],
			["MtvrRefuel_DES_EP1"],
			["MtvrRepair_DES_EP1"],
			["MtvrReammo_DES_EP1"]
		]
	};
	case (__ACEVer): {
		[
			["M1A1","M1A2_TUSK_MG","T72_CDF"],
			["LAV25","BRDM2_CDF","BRDM2_ATGM_CDF","ACE_Stryker_TOW","ACE_Stryker_MGS_Slat","ACE_Stryker_TOW_MG","ACE_Stryker_ICV_M2","ACE_Stryker_ICV_M2_SLAT","ACE_Stryker_ICV_MK19","ACE_Stryker_ICV_MK19_SLAT","ACE_Stryker_RV"],
			["AAV","BMP2_CDF","ACE_M113A3","ACE_M2A2_W"],
			["HMMWV_Avenger","ZSU_CDF","ACE_Vulcan","ACE_M6A1_W"],
			["HMMWV_M2","HMMWV_Armored","UAZ_MG_CDF","ACE_HMMWV_GMV"],
			["HMMWV_MK19","HMMWV_TOW","UAZ_AGS30_CDF","ACE_HMMWV_GMV_MK19"],
			["M2StaticMG","M2HD_mini_TriPod","AGS_CDF"],
			["Stinger_Pod","M2HD_mini_TriPod","MK19_TriPod","M252","M2StaticMG","TOW_TriPod","ZU23_CDF"],
			["M119","MLRS","GRAD_CDF"],
			["MtvrRefuel","ACE_MTVRRefuel"],
			["MtvrRepair","ACE_MTVRRepair"],
			["MtvrReammo","ACE_MTVRReammo"]
		]
	};
	default {
		[
			["M1A1","M1A2_TUSK_MG","T72_CDF"],
			["LAV25","BRDM2_CDF","BRDM2_ATGM_CDF"],
			["AAV","BMP2_CDF"],
			["HMMWV_Avenger","ZSU_CDF"],
			["HMMWV_M2","HMMWV_Armored","UAZ_MG_CDF"],
			["HMMWV_MK19","HMMWV_TOW","UAZ_AGS30_CDF"],
			["M2StaticMG","M2HD_mini_TriPod","AGS_CDF"],
			["Stinger_Pod","M2HD_mini_TriPod","MK19_TriPod","M252","M2StaticMG","TOW_TriPod","ZU23_CDF"],
			["M119","MLRS","GRAD_CDF"],
			["MtvrRefuel"],
			["MtvrRepair"],
			["MtvrReammo"]
		]
	};
};
d_veh_a_G = if !(__OAVer) then {
	[
		["T72_Gue","T34"],
		["BMP2_Gue"],
		["BRDM2_Gue"],
		["Ural_ZU23_Gue"],
		["Offroad_DSHKM_Gue"],
		["Offroad_SPG9_Gue"],
		["DSHKM_Gue","2b14_82mm_GUE"],
		["2b14_82mm_GUE","SPG9_Gue"],
		["ZU23_Gue"],
		["V3S_Gue"],
		["V3S_Gue"],
		["V3S_Gue"]
	]
} else {
	[
		["T55_TK_GUE_EP1","T34_TK_GUE_EP1"],
		["BRDM2_TK_GUE_EP1"],
		["BTR40_MG_TK_GUE_EP1"],
		["Ural_ZU23_TK_GUE_EP1"],
		["Offroad_DSHKM_TK_GUE_EP1"],
		["Offroad_SPG9_TK_GUE_EP1"],
		["DSHkM_Mini_TriPod_TK_GUE_EP1","DSHKM_TK_GUE_EP1"],
		["2b14_82mm_TK_GUE_EP1","AGS_TK_GUE_EP1","SPG9_TK_GUE_EP1","ZU23_TK_GUE_EP1"],
		["D30_TK_GUE_EP1"],
		["V3S_Refuel_TK_GUE_EP1"],
		["V3S_Repair_TK_GUE_EP1"],
		["V3S_Reammo_TK_GUE_EP1"]
	]
};

// first element (array. for example: [2,1]): number of vehicle groups that will get spawned, the first number is the max number that will get spawned,
// the second one the minimum. So [2,0] means, there can be no vehicle groups at all or a maximum of 2 groups of this kind
// second element: maximum number of vehicles in group; randomly chosen
switch (WithLessArmor) do {
	case 0: {
		d_vehicle_numbers_guard = [
#ifndef __ACE__
			[[1,0], 1], // tanks
			[[1,0], 1], // apc (bmp)
			[[1,1], 1], // apc2 (brdm)
			[[1,1], 1], // jeep with mg (uaz mg)
			[[1,0], 1] // jeep with gl (uaz grenade)
#else
			[[1,0], 1], // tanks
			[[1,0], 1], // apc (bmp)
			[[1,0], 1], // apc2 (brdm)
			[[1,1], 1], // jeep with mg (uaz mg)
			[[1,1], 1] // jeep with gl (uaz grenade)
#endif
		];
		d_vehicle_numbers_guard_static = [
#ifndef __ACE__
			[[1,1], 1], // tanks
			[[1,1], 1], // apc (bmp)
			[[2,1], 1] // aa (shilka)
#else
			[[1,1], 1], // tanks
			[[1,1], 1], // apc (bmp)
			[[2,1], 1] // aa (shilka)
#endif
		];
		d_vehicle_numbers_patrol = [
#ifndef __ACE__
			[[1,1], 1], // tanks
			[[1,1], 1], // apc (bmp)
			[[1,1], 1], // apc2 (brdm)
			[[2,1], 1], // jeep with mg (uaz mg)
			[[2,1], 1] // jeep with gl (uaz grenade)
#else
			[[1,1], 1], // tanks
			[[1,1], 1], // apc (bmp)
			[[1,1], 1], // apc2 (brdm)
			[[2,1], 1], // jeep with mg (uaz mg)
			[[2,1], 1] // jeep with gl (uaz grenade)
#endif
		];

		// allmost the same like above
		// first element the max number of ai "foot" groups that will get spawned, second element minimum number (no number for vehicles in group necessary)
		d_footunits_guard = [
#ifndef __TT__
			[1,1], // basic groups
			[1,1] // specop groups
#else
			[2,1], // basic groups
			[2,1] // specop groups
#endif
		];
		d_footunits_patrol = [
#ifndef __ACE__
			[5,3], // basic groups
			[5,3] // specop groups
#else
			[4,3], // basic groups
			[5,3] // specop groups
#endif
		];
		d_footunits_guard_static = [
#ifndef __ACE__
			[1,1], // basic groups
			[1,0] // specop groups
#else
			[1,1], // basic groups
			[1,0] // specop groups
#endif
		];
	};
	case 1: {
		d_vehicle_numbers_guard = [
#ifndef __ACE__
			[[1,0], 1], // tanks
			[[1,0], 1], // apc (bmp)
			[[1,0], 1], // apc2 (brdm)
			[[1,1], 1], // jeep with mg (uaz mg)
			[[1,1], 1] // jeep with gl (uaz grenade)
#else
			[[1,0], 1], // tanks
			[[1,0], 1], // apc (bmp)
			[[1,0], 1], // apc2 (brdm)
			[[1,1], 1], // jeep with mg (uaz mg)
			[[1,1], 1] // jeep with gl (uaz grenade)
#endif
		];
		d_vehicle_numbers_guard_static = [
#ifndef __ACE__
			[[1,0], 1], // tanks
			[[1,0], 1], // apc (bmp)
			[[1,0], 1] // aa (shilka)
#else
			[[1,0], 1], // tanks
			[[1,0], 1], // apc (bmp)
			[[1,0], 1] // aa (shilka)
#endif
		];
		d_vehicle_numbers_patrol = [
#ifndef __ACE__
			[[1,0], 1], // tanks
			[[1,0], 1], // apc (bmp)
			[[1,0], 1], // apc2 (brdm)
			[[1,1], 1], // jeep with mg (uaz mg)
			[[1,1], 1] // jeep with gl (uaz grenade)
#else
			[[1,0], 1], // tanks
			[[1,0], 1], // apc (bmp)
			[[1,0], 1], // apc2 (brdm)
			[[1,1], 1], // jeep with mg (uaz mg)
			[[1,1], 1] // jeep with gl (uaz grenade)
#endif
		];

		// allmost the same like above
		// first element the max number of ai "foot" groups that will get spawned, second element minimum number (no number for vehicles in group necessary)
		d_footunits_guard = [
#ifndef __TT__
			[3,1], // basic groups
			[3,1] // specop groups
#else
			[3,1], // basic groups
			[3,1] // specop groups
#endif
		];
		d_footunits_patrol = [
#ifndef __ACE__
			[8,3], // basic groups
			[8,3] // specop groups
#else
			[8,3], // basic groups
			[8,3] // specop groups
#endif
		];
		d_footunits_guard_static = [
#ifndef __ACE__
			[3,1], // basic groups
			[2,1] // specop groups
#else
			[3,1], // basic groups
			[2,1] // specop groups
#endif
		];
	};
	case 2: {
		d_vehicle_numbers_guard = [
#ifndef __ACE__
			[[0,0], 1], // tanks
			[[0,0], 1], // apc (bmp)
			[[0,0], 1], // apc2 (brdm)
			[[2,1], 1], // jeep with mg (uaz mg)
			[[2,1], 1] // jeep with gl (uaz grenade)
#else
			[[0,0], 1], // tanks
			[[0,0], 1], // apc (bmp)
			[[0,0], 1], // apc2 (brdm)
			[[2,1], 1], // jeep with mg (uaz mg)
			[[2,1], 1] // jeep with gl (uaz grenade)
#endif
		];
		d_vehicle_numbers_guard_static = [
#ifndef __ACE__
			[[0,0], 1], // tanks
			[[0,0], 1], // apc (bmp)
			[[0,0], 1] // aa (shilka)
#else
			[[0,0], 1], // tanks
			[[0,0], 1], // apc (bmp)
			[[0,0], 1] // aa (shilka)
#endif
		];
		d_vehicle_numbers_patrol = [
#ifndef __ACE__
			[[0,0], 1], // tanks
			[[0,0], 1], // apc (bmp)
			[[0,0], 1], // apc2 (brdm)
			[[2,1], 1], // jeep with mg (uaz mg)
			[[2,1], 1] // jeep with gl (uaz grenade)
#else
			[[0,0], 1], // tanks
			[[0,0], 1], // apc (bmp)
			[[0,0], 1], // apc2 (brdm)
			[[2,1], 1], // jeep with mg (uaz mg)
			[[2,1], 1] // jeep with gl (uaz grenade)
#endif
		];

		// allmost the same like above
		// first element the max number of ai "foot" groups that will get spawned, second element minimum number (no number for vehicles in group necessary)
		d_footunits_guard = [
#ifndef __TT__
			[4,1], // basic groups
			[4,1] // specop groups
#else
			[4,1], // basic groups
			[4,1] // specop groups
#endif
		];
		d_footunits_patrol = [
#ifndef __ACE__
			[8,3], // basic groups
			[6,3] // specop groups
#else
			[8,3], // basic groups
			[6,3] // specop groups
#endif
		];
		d_footunits_guard_static = [
#ifndef __ACE__
			[4,1], // basic groups
			[3,1] // specop groups
#else
			[4,1], // basic groups
			[3,1] // specop groups
#endif
		];
	};
};

#ifndef __OA__
d_arti_observer_E = "RU_Soldier_Spotter";
d_arti_observer_W = "USMC_Soldier_Officer";
d_arti_observer_G = "GUE_Commander";
#else
d_arti_observer_E = "TK_Soldier_Spotter_EP1";
d_arti_observer_W = "US_Soldier_Spotter_EP1";
d_arti_observer_G = "TK_GUE_Soldier_AR_EP1";
#endif

// type of enemy plane that will fly over the main target
d_airki_attack_plane = switch (true) do {
	case (__OAVer): {
		switch (d_enemy_side) do {
			case "EAST": {["Su25_TK_EP1","L39_TK_EP1"]};
			case "WEST": {["A10_US_EP1"]};
			default {[]};
		}
	};
	case (__ACEVer): {
		switch (d_enemy_side) do {
			case "EAST": {["Su34","Su39","ACE_Su27_CAP","ACE_Su27_CAS","ACE_Su27_CASP"]};
			case "WEST": {["A10","AV8B2","AV8B","F35B"]};
			default {[]};
		}
	};
	default {
		switch (d_enemy_side) do {
			case "EAST": {["Su34","Su39"]};
			case "WEST": {["A10","AV8B2","AV8B","F35B"]};
			default {[]};
		}
	};
};
d_number_attack_planes = 2;

// type of enemy chopper that will fly over the main target
d_airki_attack_chopper = switch (true) do {
	case (__OAVer): {
		switch (d_enemy_side) do {
			case "EAST": {["Mi24_D_TK_EP1"]};
			case "WEST": {["AH64D_EP1"]};
			default {[]};
		}
	};
	case (__ACEVer): {
		switch (d_enemy_side) do {
			case "EAST": {["Ka52","Ka52Black","Mi24_P","Mi24_V"]};
			case "WEST": {["AH1Z","AH64D","ACE_AH1W_AGM_W","ACE_AH1W_AGM_D"]};
			default {[]};
		}
	};
	default {
		switch (d_enemy_side) do {
			case "EAST": {["Ka52","Ka52Black","Mi24_P","Mi24_V"]};
			case "WEST": {["AH1Z","AH64D"]};
			default {[]};
		}
	};
};

d_number_attack_choppers = 2;

// enemy parachute troops transport chopper
d_transport_chopper = switch (true) do {
	case (__OAVer): {
		switch (d_enemy_side) do {
			case "EAST": {["Mi17_TK_EP1"]};
			case "WEST": {["CH_47F_EP1","UH60M_EP1"]};
			case "GUER": {["UH1H_TK_GUE_EP1"]};
		}
	};
	default {
		switch (d_enemy_side) do {
			case "EAST": {["Mi17_rockets_RU"]};
			case "WEST": {["MH60S"]};
			case "GUER": {["Mi17_Civilian"]};
		}
	};
};

// light attack chopper (for example Mi17 with MG)
d_light_attack_chopper = switch (true) do {
	case (__OAVer): {
		switch (d_enemy_side) do {
			case "EAST": {["UH1H_TK_EP1"]};
			case "WEST": {["AH6J_EP1"]};
			default {[]};
		};
	};
	case (__ACEVer): {
		switch (d_enemy_side) do {
			case "EAST": {["Mi17_Ins"]};
			case "WEST": {["UH1Y","ACE_AH6_GAU19","ACE_AH6"]};
			default {[]};
		};
	};
	default {
		switch (d_enemy_side) do {
			case "EAST": {["Mi17_Ins"]};
			case "WEST": {["UH1Y"]};
			default {[]};
		};
	};
};

// enemy ai skill: [base skill, random value (random 0.3) that gets added to the base skill]
d_skill_array = switch (EnemySkill) do {
	case 1: {[0.2,0.2]};
	case 2: {[0.4,0.3]};
	case 3: {[0.7,0.3]};
};

// Type of aircraft, that will air drop stuff
x_drop_aircraft =
#ifdef __OWN_SIDE_GUER__
	if (__OAVer) then {"UH1H_TK_GUE_EP1"} else {"MH60S"};
#endif
#ifdef __OWN_SIDE_WEST__
	if (__OAVer) then {"C130J_US_EP1"} else {"MH60S"};
#endif
#ifdef __OWN_SIDE_EAST__
	if (__OAVer) then {"An2_TK_EP1"} else {"Mi17_rockets_RU"};
#endif
#ifdef __TT__
	if (__OAVer) then {"C130J_US_EP1"} else {"MH60S"};
#endif
	
if (d_with_ai) then {
x_taxi_aircraft =
#ifdef __OWN_SIDE_GUER__
	if (__OAVer) then {"UH1H_TK_GUE_EP1"} else {"MH60S"};
#endif
#ifdef __OWN_SIDE_WEST__
	if (__OAVer) then {"UH60M_EP1"} else {"MH60S"};
#endif
#ifdef __OWN_SIDE_EAST__
	if (__OAVer) then {"Mi17_TK_EP1"} else {"Mi17_rockets_RU"};
#endif
#ifdef __TT__
	if (__OAVer) then {"UH60M_EP1"} else {"MH60S"};
#endif
};

// max men for main target clear
d_man_count_for_target_clear = 6;
// max tanks for main target clear
d_tank_count_for_target_clear = 0;
// max cars for main target clear
d_car_count_for_target_clear = 0;

// add some random patrols on the island
// if the array is empty, no patrols
// same size like a rectangular trigger
// first element = center position, second element = a, third element = b, fourth element = angle, fifth element = number of groups
d_with_isledefense = if (WithIsleDefense == 0) then {
	if (__OAVer) then {[[6985.26,6356.13,0], 6000, 6000, 0, if (d_SidemissionsOnly == 1) then {4} else {8}]} else {[[6592.61,8606.63,0], 6000, 6000, 0, 8]}
} else {
	[]
};

// if set to false, empty vehicles will not get deleted after the main target gets cleared. true = empty vehicles will get deleted after 25-30 minutes
d_do_delete_empty_main_target_vecs = true;

#ifndef __TT__
// if set to true no enemy AI will attack base and destroy bonus vehicles or whatever
d_no_sabotage = if (WithBaseAttack == 0) then {false} else {true};
#endif

// time (in sec) between attack planes and choppers over main target will respawn once they were shot down (a random value between 0 and 240 will be added)
d_airki_respawntime = 1200;

d_side_missions_random = [];

#ifndef __TT__
// don't remove d_recapture_indices even if you set d_with_recapture to false
d_recapture_indices = [];
// if set to false enemy forces will not recapture towns !!!
d_with_recapture = if (WithRecapture == 0) then {true} else {false};

// max number of cities that the enemy will recapture at once
// if set to -1 no check is done
d_max_recaptures = 2;

if (isNil "d_with_carrier" && d_SidemissionsOnly == 1) then {
	[] spawn {
		_wairfac = if !(__OAVer) then {
			switch (d_own_side) do {
				case "WEST": {"USMC_WarfareBAircraftFactory"};
				case "EAST": {"RU_WarfareBAircraftFactory"};
				case "GUER": {"WarfareBAircraftFactory_Gue"};
			}
		} else {
			switch (d_own_side) do {
				case "WEST": {"US_WarfareBAircraftFactory_EP1"};
				case "EAST": {"TK_WarfareBAircraftFactory_EP1"};
				case "GUER": {"TK_GUE_WarfareBAircraftFactory_EP1"};
			}
		};
		_pos = (d_aircraft_facs select 0) select 0;
		_dir = (d_aircraft_facs select 0) select 1;
		["d_jet_serviceH",false] call XNetSetJIP;
		_fac = createVehicle [_wairfac, _pos, [], 0, "NONE"];
		_fac setPos _pos;
		_fac setDir _dir;
		_fac addEventHandler ["killed", {[_this select 0, 0] call x_fackilled}];

		_pos = (d_aircraft_facs select 1) select 0;
		_dir = (d_aircraft_facs select 1) select 1;
		["d_chopper_serviceH",false] call XNetSetJIP;
		_fac = createVehicle [_wairfac, _pos, [], 0, "NONE"];
		_fac setPos _pos;
		_fac setDir _dir;
		_fac addEventHandler ["killed", {[_this select 0, 1] call x_fackilled}];

		_pos = (d_aircraft_facs select 2) select 0;
		_dir = (d_aircraft_facs select 2) select 1;
		["d_wreck_repairH",false] call XNetSetJIP;
		_fac = createVehicle [_wairfac, _pos, [], 0, "NONE"];
		_fac setPos _pos;
		_fac setDir _dir;
		_fac addEventHandler ["killed", {[_this select 0, 2] call x_fackilled}];
	};
} else {
	if (isNil "d_with_carrier" && d_SidemissionsOnly == 0) then {
		["d_jet_serviceH",false] call XNetSetJIP;
		["d_chopper_serviceH",false] call XNetSetJIP;
		["d_wreck_repairH",false] call XNetSetJIP;
	};
};
#endif

d_time_until_next_sidemission = [
	[10,300], // if player number <= 10, it'll take 300 seconds = 5 minutes until the next sidemission
	[20,600], // if player number <= 20, it'll take 600 seconds = 10 minutes until the next sidemission
	[30,900], // if player number <= 30, it'll take 900 seconds = 15 minutes until the next sidemission
	[40,1200] // if player number <= 40, it'll take 1200 seconds = 20 minutes until the next sidemission
];

#ifndef __OA__
d_civilians_t = ["Assistant","Citizen1","Citizen2","Citizen2","Citizen4","Worker1","Worker2","Worker3","Worker4","Priest","Doctor","Functionary1","Functionary2","Damsel1","Damsel2","Damsel3","Damsel4","Damsel5","Profiteer1","Profiteer2","Profiteer3","Profiteer4","Rocker1","Rocker2","Rocker3","Rocker4","Woodlander1","Woodlander2","Woodlander3","Woodlander4","Villager1","Villager2","Villager3","Villager4","Secretary1","Secretary2","Secretary3","Secretary4","Sportswoman1","Sportswoman2","Sportswoman3","Sportswoman4","Madam1","Madam2","Madam3","Madam4","Farmwife1","Farmwife2","Farmwife3","Farmwife4","HouseWife1","HouseWife2","HouseWife3","HouseWife4","Hooker1","Hooker2","Hooker3","Hooker4","WorkWoman1","WorkWoman2","WorkWoman3","WorkWoman4","SchoolTeacher","Policeman"];
#else
d_civilians_t = ["TK_CIV_Takistani01_EP1","TK_CIV_Takistani02_EP1","TK_CIV_Takistani03_EP1","TK_CIV_Takistani04_EP1","TK_CIV_Takistani05_EP1","TK_CIV_Takistani06_EP1","TK_CIV_Worker01_EP1","TK_CIV_Worker02_EP1","Citizen2_EP1","Citizen3_EP1","CIV_EuroMan01_EP1","CIV_EuroMan02_EP1","Haris_Press_EP1","Profiteer2_EP1"];
#endif

// position and direction of the AI HUT
d_pos_ai_hut = 
#ifdef __DEFAULT__
	if (isNil "d_with_carrier") then {
		if (__OAVer) then {[[8209.56,2138.36,0],65]} else {[[4671.4,10203.9,0],325]}
	} else {[[14509.6,364.861,15.9], 34]};
#endif
#ifdef __EVERON__
	if (isNil "d_with_carrier") then {[[4891.39,11722.6,0],270]} else {[[14696.9,543.778,15.9], 34]};
#endif
#ifdef __TT__
	[];
#endif

if (d_with_ai) then {
#ifndef __OA__
	_wbarracks = switch (d_own_side) do {
		case "WEST": {if (isNil "d_with_carrier") then {"USMC_WarfareBBarracks"} else {"WarfareBunkerSign"}};
		case "EAST": {"RU_WarfareBBarracks"};
		case "GUER": {"Gue_WarfareBBarracks"};
	};
#else
	_wbarracks = switch (d_own_side) do {
		case "WEST": {if (isNil "d_with_carrier") then {"US_WarfareBBarracks_EP1"} else {"WarfareBunkerSign"}};
		case "EAST": {"TK_WarfareBBarracks_EP1"};
		case "GUER": {"TK_GUE_WarfareBBarracks_EP1"};
	};
#endif

	_D_AI_HUT = createVehicle [_wbarracks, (d_pos_ai_hut select 0), [], 0, "NONE"];
	_D_AI_HUT setDir (d_pos_ai_hut select 1);
	if (isNil "d_with_carrier") then {
		_D_AI_HUT setPos (d_pos_ai_hut select 0)
	} else {
		_D_AI_HUT setPosASL (d_pos_ai_hut select 0)
	};
	_D_AI_HUT allowDamage false;
	["D_AI_HUT",_D_AI_HUT] call XNetSetJIP;
};

#ifdef __CARRIER__
d_chop_s_trig setPosASL [position d_chop_s_trig select 0, position d_chop_s_trig select 1, 15.9];
d_jet_s_trig setPosASL [position d_jet_s_trig select 0, position d_jet_s_trig select 1, 15.9];
#endif

d_banti_airdown = false;

d_wreck_cur_ar = [];

#ifdef __OA__
d_soldier_officer = switch (d_enemy_side) do {
	case "EAST": {"TK_Soldier_Officer_EP1"};
	case "WEST": {"US_Soldier_Officer_EP1"};
	case "GUER": {"TK_GUE_Warlord_EP1"};
};
#endif
#ifndef __TT__
d_intel_unit = objNull;
#endif
};