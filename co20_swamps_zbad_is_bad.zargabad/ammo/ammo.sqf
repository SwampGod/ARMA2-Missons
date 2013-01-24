
while {alive _this} do
{

// Remove the stock items from the crate
clearMagazineCargo _this;
clearWeaponCargo _this;

_this addBackpackCargo ["BAF_AssaultPack_ATAmmo",5];

// Rifles

//_this addWeaponCargo ["AK_47_M", 5];
//_this addWeaponCargo ["AK_47_S", 5];
//_this addWeaponCargo ["AKS_74_pso", 5];
//_this addWeaponCargo ["AKS_74_U", 5];

_this addWeaponCargo ["M16A2", 5];
_this addWeaponCargo ["M16A2GL", 5];
_this addWeaponCargo ["M4A1", 5];
_this addWeaponCargo ["M79_EP1", 5];
_this addWeaponCargo ["Mk13_EP1", 5];
_this addWeaponCargo ["Sa58V_RCO_EP1", 5];
_this addWeaponCargo ["FN_FAL_ANPVS4", 5];
_this addWeaponCargo ["M110_NVG_EP1", 5];
_this addWeaponCargo ["M14_EP1", 5];
_this addWeaponCargo ["M4A3_RCO_GL_EP1", 5];
_this addWeaponCargo ["M4A3_CCO_EP1", 5];
_this addWeaponCargo ["SCAR_L_CQC_CCO_SD", 5];
_this addWeaponCargo ["SCAR_L_CQC", 5];
_this addWeaponCargo ["SCAR_L_CQC_Holo", 5];
_this addWeaponCargo ["SCAR_L_CQC_EGLM_Holo", 5];
_this addWeaponCargo ["SCAR_L_STD_EGLM_RCO", 5];
_this addWeaponCargo ["SCAR_L_STD_HOLO", 5];
_this addWeaponCargo ["SCAR_L_STD_Mk4CQT", 5];
_this addWeaponCargo ["SCAR_H_CQC_CCO", 5];
_this addWeaponCargo ["SCAR_H_CQC_CCO_SD", 5];
_this addWeaponCargo ["SCAR_H_STD_EGLM_Spect", 5];
_this addWeaponCargo ["SCAR_H_LNG_Sniper", 5];
_this addWeaponCargo ["SCAR_H_LNG_Sniper_SD", 5];
_this addWeaponCargo ["G36A_camo", 5];
_this addWeaponCargo ["G36C_camo", 5];
_this addWeaponCargo ["G36_C_SD_camo", 5];
_this addWeaponCargo ["G36K_camo", 5];
_this addWeaponCargo ["FN_FAL", 5];
_this addWeaponCargo ["AKS_74_kobra", 5];
_this addWeaponCargo ["AK_74_GL_kobra", 5];
_this addWeaponCargo ["Sa58V_CCO_EP1", 5];
_this addWeaponCargo ["Sa58P_EP1", 5];
_this addWeaponCargo ["Sa58V_CCO_EP1", 5];

// Rifle ammo
_this addMagazineCargo ["10x_303", 50];
_this addMagazineCargo ["30Rnd_762x39_AK47", 50];
_this addMagazineCargo ["20Rnd_762x51_DMR", 50];
_this addMagazineCargo ["20Rnd_762x51_B_SCAR", 50];
_this addMagazineCargo ["20Rnd_762x51_SB_SCAR", 50];
_this addMagazineCargo ["30Rnd_556x45_Stanag", 50];
_this addMagazineCargo ["30Rnd_556x45_StanagSD", 50];
_this addMagazineCargo ["30Rnd_556x45_G36", 50];
_this addMagazineCargo ["30Rnd_556x45_G36SD", 50]; 
_this addMagazineCargo ["30Rnd_545x39_AK", 50]; 
_this addMagazineCargo ["20Rnd_762x51_FNFAL", 50]; 

//PMC Rifles & Shotgun
_this addWeaponCargo ["AA12_PMC", 5];
_this addWeaponCargo ["m8_carbine_pmc", 5];
_this addWeaponCargo ["m8_carbine", 5];
_this addWeaponCargo ["m8_carbineGL", 5];
_this addWeaponCargo ["m8_compact", 5];
_this addWeaponCargo ["m8_compact_pmc", 5];
_this addWeaponCargo ["m8_holo_sd", 5];
_this addWeaponCargo ["m8_SAW", 5];
_this addWeaponCargo ["m8_sharpshooter", 5];
_this addWeaponCargo ["m8_tws_sd", 5];

//PMC Rifles & Shotgun Ammo
_this addMagazineCargo ["20Rnd_556x45_Stanag", 50];
_this addMagazineCargo ["20Rnd_B_AA12_Pellets", 50];
_this addMagazineCargo ["20Rnd_B_AA12_74Slug", 50];

// Sniper Rifles
_this addWeaponCargo ["M24_des_EP1", 5]; 
_this addWeaponCargo ["m107", 5];
_this addWeaponCargo ["KSVK", 5];
_this addWeaponCargo ["SVD", 5];
_this addWeaponCargo ["SVD_des_EP1", 5];

_this addWeaponCargo ["BAF_AS50_scoped", 5];
_this addWeaponCargo ["BAF_L110A1_Aim", 5];
_this addWeaponCargo ["BAF_L7A2_GPMG", 5];
_this addWeaponCargo ["BAF_L85A2_RIS_ACOG", 5];
_this addWeaponCargo ["BAF_L85A2_RIS_Holo", 5];
_this addWeaponCargo ["BAF_L85A2_RIS_SUSAT", 5];
_this addWeaponCargo ["BAF_L85A2_UGL_ACOG", 5];
_this addWeaponCargo ["BAF_L85A2_UGL_Holo", 5];
_this addWeaponCargo ["BAF_L85A2_UGL_SUSAT", 5];
_this addWeaponCargo ["BAF_L86A2_ACOG", 5];
_this addWeaponCargo ["BAF_LRR_scoped", 5];
_this addWeaponCargo ["BAF_LRR_scoped_W", 5];

// BAF ammo
_this addMagazineCargo ["10Rnd_762x54_SVD", 50];
_this addMagazineCargo ["5Rnd_762x51_M24", 50];
_this addMagazineCargo ["10Rnd_127x99_m107", 50];
_this addMagazineCargo ["5Rnd_127x99_as50", 50];
_this addMagazineCargo ["200Rnd_556x45_L110A1", 50];
_this addMagazineCargo ["5Rnd_86x70_L115A1", 50];

// Light Machineguns (LMG)
_this addWeaponCargo ["m240_scoped_EP1", 5];
_this addWeaponCargo ["Mk_48_DES_EP1", 5];
_this addWeaponCargo ["PK", 5];
_this addWeaponCargo ["M249_EP1", 5];
_this addWeaponCargo ["M249_m145_EP1", 5];
_this addWeaponCargo ["M60A4_EP1", 5];
_this addWeaponCargo ["MG36_camo", 5];
_this addWeaponCargo ["RPK_74", 5];

// LMG ammo
_this addMagazineCargo ["100Rnd_762x51_M240", 50];
_this addMagazineCargo ["200Rnd_556x45_M249", 50];
_this addMagazineCargo ["100Rnd_556x45_BetaCMag", 50];
_this addMagazineCargo ["100Rnd_762x54_PK", 50];
_this addMagazineCargo ["75Rnd_545x39_RPK", 50];

// Sidearm
_this addWeaponCargo ["UZI_EP1", 5];
_this addWeaponCargo ["UZI_SD_EP1", 5];
_this addWeaponCargo ["Sa61_EP1", 5];
_this addWeaponCargo ["M9", 5];
_this addWeaponCargo ["M9SD",5];
_this addWeaponCargo ["glock17_EP1", 5];
_this addWeaponCargo ["Makarov", 5];
_this addWeaponCargo ["MakarovSD", 5];
_this addWeaponCargo ["revolver_EP1", 5];

// Sidearm ammo
_this addMagazineCargo ["15Rnd_9x19_M9", 50];
_this addMagazineCargo ["15Rnd_9x19_M9SD",50];
_this addMagazineCargo ["8Rnd_9x18_Makarov", 50];
_this addMagazineCargo ["8Rnd_9x18_MakarovSD", 50];
_this addMagazineCargo ["17Rnd_9x19_glock17", 50];
_this addMagazineCargo ["20Rnd_B_765x17_Ball", 50];
_this addMagazineCargo ["30Rnd_9x19_UZI", 50];
_this addMagazineCargo ["30Rnd_9x19_UZI_SD", 50];
_this addMagazineCargo ["6Rnd_45ACP", 50];

// AT & AA
_this addWeaponCargo ["MAAWS", 5];
_this addWeaponCargo ["BAF_NLAW_Launcher", 5];
_this addWeaponCargo ["Javelin", 5];
_this addWeaponCargo ["Stinger", 5];
_this addWeaponCargo ["RPG7V", 5];
_this addWeaponCargo ["M136", 5];
_this addWeaponCargo ["RPG18", 5];
_this addWeaponCargo ["Strela", 5];

// AT & AA ammo
_this addMagazineCargo ["MAAWS_HEAT", 50];
_this addMagazineCargo ["NLAW", 50];
_this addMagazineCargo ["Javelin", 5];
_this addMagazineCargo ["stinger", 5];
_this addMagazineCargo ["PG7VL", 50];
_this addMagazineCargo ["RPG18", 50];
_this addMagazineCargo ["M136", 50];
_this addMagazineCargo ["Strela", 50];

// M203 ammo
_this addMagazineCargo ["1Rnd_HE_M203", 50];
_this addMagazineCargo ["1Rnd_HE_GP25", 50];
_this addMagazineCargo ["1Rnd_Smoke_M203", 50];
_this addMagazineCargo ["FlareWhite_M203", 50];

// Items
_this addWeaponCargo ["Binocular", 5];
_this addWeaponCargo ["Binocular_Vector", 5];
_this addWeaponCargo ["NVGoggles", 5];
_this addWeaponCargo ["ItemGPS", 5];
_this addWeaponCargo ["ItemMAP", 5];
_this addWeaponCargo ["ItemCompass", 5];
_this addWeaponCargo ["ItemWatch", 5];
_this addWeaponCargo ["LaserDesignator", 20];
_this addMagazineCargo ["LaserBatteries", 20];

// Grenades & Satchels
_this addMagazineCargo ["HandGrenade_West", 50];
_this addMagazineCargo ["PipeBomb", 50];
_this addMagazineCargo ["SmokeShell",50];
_this addMagazineCargo ["Mine", 50];

// Restock time.
sleep 3600;
};