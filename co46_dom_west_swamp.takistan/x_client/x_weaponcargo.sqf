// by Xeno
#include "x_setup.sqf"
private "_vec";

#define __awc(wtype,wcount) _vec addWeaponCargo [#wtype,wcount];
#define __amc(mtype,mcount) _vec addMagazineCargo [#mtype,mcount];

_vec = _this select 0;
clearMagazineCargo _vec;
clearWeaponCargo _vec;

if (d_player_faction in ["USMC", "CDF"]) then {
	__awc(M9,1)
	__awc(M9SD,1)
	__awc(Colt1911,1)
	__awc(M16A2,1)
	__awc(M16A2GL,1)
	__awc(M16A4,1)
	__awc(M16A4_GL,1)
	__awc(M16A4_ACG,1)
	__awc(M16A4_ACG_GL,1)
	
	__awc(M4A1,1)
	__awc(M4A1_HWS_GL,1)
	__awc(M4A1_HWS_GL_camo,1)
	__awc(M4A1_HWS_GL_SD_Camo,1)
	__awc(M4A1_RCO_GL,1)
	__awc(M4A1_Aim,1)
	__awc(M4A1_Aim_camo,1)
	__awc(M4A1_AIM_SD_camo,1)
	
	__awc(G36a,1)
	__awc(G36c,1)
	__awc(G36_C_SD_eotech,1)
	__awc(G36k,1)
	
	__awc(M1014,1)
	__awc(MP5A5,1)
	__awc(MP5SD,1)
	
	__awc(M8_carbine,1)
	__awc(M8_carbineGL,1)
	__awc(M8_compact,1)
	
	__awc(MG36,1)
	__awc(Mk_48,1)
	__awc(M240,1)
	__awc(M249,1)
	__awc(M8_SAW,1)
	
	__awc(M24,1)
	__awc(DMR,1)
	__awc(M107,1)
	__awc(M40A3,1)
	__awc(M4SPR,1)
	__awc(M8_sharpshooter,1)
	
	__awc(M136,1)
	__awc(SMAW,1)
	
	__awc(Laserdesignator,1)
	__awc(Binocular,1)
	__awc(NVGoggles,1)
	__awc(JAVELIN,1)
	__awc(STINGER,1)
	
	__amc(HandGrenade_West,50)
	__amc(HandGrenade_Stone,50)
	__amc(Smokeshell,50)
	__amc(Smokeshellred,50)
	__amc(Smokeshellgreen,50)
	__amc(SmokeShellYellow,50)
	__amc(SmokeShellOrange,50)
	__amc(SmokeShellPurple,50)
	__amc(30Rnd_9x19_MP5,50)
	__amc(30Rnd_9x19_MP5SD,50)
	__amc(7Rnd_45ACP_1911,50)
	__amc(15Rnd_9x19_M9,50)
	__amc(15Rnd_9x19_M9SD,50)
	__amc(20Rnd_556x45_Stanag,50)
	__amc(30Rnd_556x45_Stanag,50)
	__amc(30Rnd_556x45_StanagSD,50)
	__amc(30Rnd_556x45_G36,50)
	__amc(200Rnd_556x45_M249,50)
	__amc(100Rnd_556x45_BetaCMag,50)
	__amc(8Rnd_B_Beneli_74Slug,50)
	__amc(5Rnd_762x51_M24,6)
	__amc(20Rnd_762x51_DMR,6)
	__amc(10Rnd_127x99_M107,3)
	__amc(100Rnd_762x51_M240,50)
	__amc(FlareWhite_M203,50)
	__amc(FlareGreen_M203,50)
	__amc(FlareRed_M203,50)
	__amc(FlareYellow_M203,50)
	__amc(1Rnd_HE_M203,50)
	__amc(M136,10)
	__amc(SMAW_HEAA,2)
	__amc(SMAW_HEDP,2)
	__amc(Pipebomb,5)
	__amc(Mine,30)
	__amc(Laserbatteries,20)
	__amc(JAVELIN,1)
	__amc(STINGER,2)
	__amc(30Rnd_545x39_AK,50)
	__amc(PG7V,3)
	__amc(PG7VR,3)
	__amc(PG7VL,3)
	__amc(100Rnd_762x54_PK,50)
	__amc(75Rnd_545x39_RPK,50)
} else {
	__awc(AK_107_kobra,1)
	__awc(AK_107_GL_kobra,1)
	__awc(AK_107_GL_pso,1)
	__awc(AK_107_pso,1)
	__awc(AK_74,1)
	__awc(AK_74_GL,1)
	__awc(AK_47_M,1)
	__awc(AK_47_S,1)
	__awc(AKS_74_kobra,1)
	__awc(AKS_74_pso,1)
	__awc(AKS_74_U,1)
	__awc(AKS_74_UN_kobra,1)
	__awc(Bizon,1)
	__awc(bizon_silenced,1)
	__awc(Saiga12K,1)
	__awc(VSS_vintorez,1)
	
	__awc(Pecheneg,1)
	__awc(PK,1)
	__awc(RPK_74,1)
	
	__awc(KSVK,1)
	__awc(SVD,1)
	__awc(SVD_CAMO,1)
	
	__awc(Makarov,1)
	__awc(MakarovSD,1)
	
	__awc(Igla,1)
	__awc(MetisLauncher,1)
	__awc(RPG18,1)
	__awc(RPG7V,1)
	
	__awc(STRELA,1)
	__awc(Binocular,1)
	__awc(NVGoggles,1)
	
	__amc(30Rnd_545x39_AK,50)
	__amc(30Rnd_762x39_AK47,50)
	__amc(64Rnd_9x19_Bizon,50)
	__amc(64Rnd_9x19_SD_Bizon,50)
	__amc(8Rnd_B_Saiga12_74Slug,50)
	__amc(10Rnd_9x39_SP5_VSS,50)
	__amc(75Rnd_545x39_RPK,50)
	__amc(FlareWhite_GP25,50)
	__amc(FlareGreen_GP25,50)
	__amc(FlareRed_GP25,50)
	__amc(FlareYellow_GP25,50)
	__amc(1Rnd_HE_GP25,50)
	__amc(30Rnd_545x39_AKSD,50)
	__amc(100Rnd_762x54_PK,50)
	__amc(10Rnd_762x54_SVD,6)
	__amc(8Rnd_9x18_Makarov,50)
	__amc(8Rnd_9x18_MakarovSD,50)
	__amc(PG7V,3)
	__amc(PG7VR,3)
	__amc(PG7VL,3)
	__amc(OG7,3)
	__amc(AT13,3)
	__amc(RPG18,3)
	__amc(Igla,5)
	__amc(SmokeShellRed,50)
	__amc(SmokeShellGreen,50)
	__amc(SmokeShell,50)
	__amc(HandGrenade_East,50)
	__amc(5Rnd_127x108_KSVK,3)
	__amc(Mine,30)
	__amc(Pipebomb,5)
	__amc(Laserbatteries,20)
	__amc(Strela,2)
};
