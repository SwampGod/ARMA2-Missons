/////////////////////////////////////////////////////
// Called from an ammocrate's init field via:
// null = this execVM "bafCrate.sqf";
/////////////////////////////////////////////////////

while {alive _this} do
{

// Remove the stock items from the crate
clearMagazineCargo _this;
clearWeaponCargo _this;

/////////////////////////////////////////////////////
// WEAPONS
/////////////////////////////////////////////////////

_this addWeaponCargo ["BAF_AS50_scoped", 100];
_this addWeaponCargo ["BAF_AS50_TWS", 100];
_this addWeaponCargo ["BAF_L110A1_Aim", 100];
_this addWeaponCargo ["BAF_L7A2_GPMG", 100];
_this addWeaponCargo ["BAF_L85A2_RIS_ACOG", 100];
_this addWeaponCargo ["BAF_L85A2_RIS_CWS", 100];
_this addWeaponCargo ["BAF_L85A2_RIS_Holo", 100];
_this addWeaponCargo ["BAF_L85A2_RIS_SUSAT", 100];
_this addWeaponCargo ["BAF_L85A2_UGL_ACOG", 100];
_this addWeaponCargo ["BAF_L85A2_UGL_Holo", 100];
_this addWeaponCargo ["BAF_L85A2_UGL_SUSAT", 100];
_this addWeaponCargo ["BAF_L86A2_ACOG", 100];
_this addWeaponCargo ["BAF_LRR_scoped", 100];
_this addWeaponCargo ["BAF_LRR_scoped_W", 100];
_this addWeaponCargo ["BAF_NLAW_Launcher", 100];

/////////////////////////////////////////////////////
// AMMO
/////////////////////////////////////////////////////

_this addMagazineCargo ["NLAW", 100];
_this addMagazineCargo ["5Rnd_127x99_as50", 100];
_this addMagazineCargo ["200Rnd_556x45_L110A1", 100];
_this addMagazineCargo ["5Rnd_86x70_L115A1", 100];
_this addMagazineCargo ["NLAW", 100];
_this addMagazineCargo ["30Rnd_556x45_Stanag", 100];
_this addMagazineCargo ["30Rnd_556x45_StanagSD", 100];
_this addMagazineCargo ["100Rnd_762x51_M240", 100];
_this addMagazineCargo ["200Rnd_556x45_M249", 100];
_this addMagazineCargo ["100Rnd_556x45_BetaCMag", 100];
_this addMagazineCargo ["1Rnd_HE_M203", 100];
_this addMagazineCargo ["1Rnd_Smoke_M203", 100];
_this addMagazineCargo ["1Rnd_SmokeGreen_M203", 100];
_this addMagazineCargo ["1Rnd_SmokeRed_M203", 100];
_this addMagazineCargo ["1Rnd_SmokeYellow_M203", 100];
_this addMagazineCargo ["FlareGreen_M203", 100];
_this addMagazineCargo ["FlareRed_M203", 100];
_this addMagazineCargo ["FlareWhite_M203", 100];
_this addMagazineCargo ["FlareYellow_M203", 100];
_this addWeaponCargo ["Binocular", 100];
_this addWeaponCargo ["Binocular_Vector", 100];
_this addWeaponCargo ["NVGoggles", 100];
_this addWeaponCargo ["ItemGPS", 100];
_this addWeaponCargo ["LaserDesignator", 100];
_this addMagazineCargo ["LaserBatteries", 100];
_this addMagazineCargo ["HandGrenade_West", 100];
_this addMagazineCargo ["SmokeShell", 100];
_this addMagazineCargo ["SmokeShellGreen", 100];
_this addMagazineCargo ["SmokeShellRed", 100];
_this addMagazineCargo ["SmokeShellYellow", 100];
_this addMagazineCargo ["SmokeShellBlue", 100];
_this addMagazineCargo ["SmokeShellPurple", 100];
_this addMagazineCargo ["SmokeShellOrange", 100];
_this addMagazineCargo ["PipeBomb", 100];
_this addMagazineCargo ["Mine", 100];
_this addMagazineCargo ["IR_Strobe_Target", 100];
_this addMagazineCargo ["IR_Strobe_Marker", 100];

// Restock time.
sleep 1200;
}; 