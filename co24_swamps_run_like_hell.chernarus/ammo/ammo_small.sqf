/////////////////////////////////////////////////////
// Called from an ammocrate's init field via:
// null = this execVM "ammo.sqf";
/////////////////////////////////////////////////////

while {alive _this} do
{

// Remove the stock items from the crate
clearMagazineCargo _this;
clearWeaponCargo _this;

/////////////////////////////////////////////////////
// WEAPONS
/////////////////////////////////////////////////////

_this addBackpackCargo ["BAF_AssaultPack_ATAmmo",5];

// Rifles
_this addWeaponCargo ["M4A1", 5];
_this addWeaponCargo ["M110_NVG_EP1", 5];
_this addWeaponCargo ["SCAR_H_STD_EGLM_Spect", 5];
_this addWeaponCargo ["G36K_camo", 5];
_this addWeaponCargo ["SCAR_H_STD_TWS_SD", 5];

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

// Sniper Rifles
//_this addWeaponCargo ["BAF_AS50_scoped", 5];

// BAF ammo
_this addMagazineCargo ["10Rnd_762x54_SVD", 50];
_this addMagazineCargo ["5Rnd_762x51_M24", 50];
_this addMagazineCargo ["10Rnd_127x99_m107", 50];
_this addMagazineCargo ["5Rnd_127x99_as50", 50];
_this addMagazineCargo ["200Rnd_556x45_L110A1", 50];
_this addMagazineCargo ["5Rnd_86x70_L115A1", 50];

// Light Machineguns (LMG)
_this addWeaponCargo ["M249_EP1", 5];

// LMG ammo
_this addMagazineCargo ["100Rnd_762x51_M240", 50];
_this addMagazineCargo ["200Rnd_556x45_M249", 50];
_this addMagazineCargo ["100Rnd_556x45_BetaCMag", 50];
_this addMagazineCargo ["100Rnd_762x54_PK", 50];
_this addMagazineCargo ["75Rnd_545x39_RPK", 50];

// Sidearm
_this addWeaponCargo ["M9", 5];

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
_this addWeaponCargo ["Stinger", 5];

// AT & AA ammo
_this addMagazineCargo ["MAAWS_HEAT", 20];
_this addMagazineCargo ["NLAW", 20];
_this addMagazineCargo ["Javelin", 5];
_this addMagazineCargo ["stinger", 5];
_this addMagazineCargo ["PG7VL", 20];
_this addMagazineCargo ["RPG18", 20];
_this addMagazineCargo ["M136", 20];
_this addMagazineCargo ["Strela", 20];

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

// Grenades & Satchels
_this addMagazineCargo ["HandGrenade_West", 50];
_this addMagazineCargo ["PipeBomb", 5];
_this addMagazineCargo ["SmokeShell",50];

_this addMagazineCargo ["Laserbatteries",50];
_this addWeaponCargo ["Laserdesignator",5];

// Restock time.
sleep 3600;
};