
while {alive _this} do
{

// Remove the stock items from the crate
//clearMagazineCargo _this;
//clearWeaponCargo _this;

// Rifles


// Rifle ammo
_this addMagazineCargo ["20Rnd_762x51_B_SCAR", 20];
_this addMagazineCargo ["30Rnd_556x45_Stanag", 20];

// AT & AA

// AT & AA ammo
_this addMagazineCargo ["MAAWS_HEAT", 3];
_this addMagazineCargo ["javelin", 3];
_this addMagazineCargo ["stinger", 3];

// M203 ammo
_this addMagazineCargo ["1Rnd_HE_M203", 20];

_this addMagazineCargo ["HandGrenade_West", 20];

// Restock time.
// sleep 1800;
};