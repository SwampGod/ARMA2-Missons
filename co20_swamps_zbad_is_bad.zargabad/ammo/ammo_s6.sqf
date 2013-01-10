
while {alive _this} do
{

// Remove the stock items from the crate
clearMagazineCargo _this;
clearWeaponCargo _this;

// Rifles
_this addWeaponCargo ["SCAR_H_STD_EGLM_Spect", 5];

// Rifle ammo
_this addMagazineCargo ["20Rnd_762x51_B_SCAR", 50];

// AT & AA
_this addWeaponCargo ["MAAWS", 4];
_this addWeaponCargo ["javelin", 4];
_this addWeaponCargo ["Stinger", 4];

// AT & AA ammo
_this addMagazineCargo ["MAAWS_HEAT", 20];
_this addMagazineCargo ["javelin", 10];
_this addMagazineCargo ["stinger", 10];

//Pistol
_this addWeaponCargo ["Colt1911", 5];

//Pistol Ammo
_this addMagazineCargo ["7Rnd_45ACP_1911", 20];

// M203 ammo
_this addMagazineCargo ["1Rnd_HE_M203", 20];

_this addMagazineCargo ["HandGrenade_West", 20];
_this addMagazineCargo ["PipeBomb", 4];
_this addMagazineCargo ["SmokeShell",20];

// Restock time.
sleep 1800;
};