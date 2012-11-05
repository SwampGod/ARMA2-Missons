///////////////////////////////////
/*

For vanilla Arma 2 OA only!
This script called from an ammocrate's init field via:

x = [this, type] execVM "crateFiller.sqf";

Parameters:
crate (object), type of crate (string)

Valid types:
"BAF_ALL"
"US_ALL"
"EU_ALL"
"PMC_ALL"

Where type of crate is any number of preset weapon loadouts.

*/
///////////////////////////////////
#include "cratearray.sqf"

_crate = _this select 0;
_type = _this select 1;

sleep 10;

while {alive _crate} do {
// Remove the stock items from the crate
	clearMagazineCargo _crate;
	clearWeaponCargo _crate;

	if (_type == "BAF_ALL") then {
		{_crate addWeaponCargo [_x, 30]} forEach _BAF_Rifles;
		{_crate addWeaponCargo [_x, 30]} forEach _BAF_MGs;
		{_crate addWeaponCargo [_x, 30]} forEach _BAF_Snipers;
		{_crate addWeaponCargo [_x, 30]} forEach _BAF_Launchers;

		{_crate addMagazineCargo [_x, 60]} forEach _BAF_Rifle_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _BAF_MG_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _BAF_Sniper_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _BAF_Launcher_Ammo;	
	};

	if (_type == "US_ALL") then {
		{_crate addWeaponCargo [_x, 30]} forEach _US_Rifles;
		{_crate addWeaponCargo [_x, 30]} forEach _US_MGs;
		{_crate addWeaponCargo [_x, 30]} forEach _US_Snipers;
		{_crate addWeaponCargo [_x, 30]} forEach _US_Launchers;

		{_crate addMagazineCargo [_x, 60]} forEach _US_Rifle_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _US_MG_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _US_Sniper_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _US_Launcher_Ammo;		
	};

	if (_type == "EU_ALL") then {
		{_crate addWeaponCargo [_x, 30]} forEach _EU_Rifles;
		{_crate addWeaponCargo [_x, 30]} forEach _EU_MGs;
		{_crate addWeaponCargo [_x, 30]} forEach _EU_Snipers;
		{_crate addWeaponCargo [_x, 30]} forEach _EU_Launchers;

		{_crate addMagazineCargo [_x, 60]} forEach _EU_Rifle_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _EU_MG_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _EU_Sniper_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _EU_Launcher_Ammo;		
	};

	if (_type == "PMC_ALL") then {
		{_crate addWeaponCargo [_x, 30]} forEach _PMC_Rifles;
		{_crate addWeaponCargo [_x, 30]} forEach _PMC_MGs;

		{_crate addMagazineCargo [_x, 60]} forEach _PMC_Rifle_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _PMC_MG_Ammo;		
	};
	
	if (_type == "ALL") then {
		{_crate addWeaponCargo [_x, 30]} forEach _BAF_Rifles;
		{_crate addWeaponCargo [_x, 30]} forEach _BAF_MGs;
		{_crate addWeaponCargo [_x, 30]} forEach _BAF_Snipers;
		{_crate addWeaponCargo [_x, 30]} forEach _BAF_Launchers;
		{_crate addMagazineCargo [_x, 60]} forEach _BAF_Rifle_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _BAF_MG_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _BAF_Sniper_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _BAF_Launcher_Ammo;	
		{_crate addWeaponCargo [_x, 30]} forEach _US_Rifles;
		{_crate addWeaponCargo [_x, 30]} forEach _US_MGs;
		{_crate addWeaponCargo [_x, 30]} forEach _US_Snipers;
		{_crate addWeaponCargo [_x, 30]} forEach _US_Launchers;
		{_crate addMagazineCargo [_x, 60]} forEach _US_Rifle_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _US_MG_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _US_Sniper_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _US_Launcher_Ammo;	
		{_crate addWeaponCargo [_x, 30]} forEach _EU_Rifles;
		{_crate addWeaponCargo [_x, 30]} forEach _EU_MGs;
		{_crate addWeaponCargo [_x, 30]} forEach _EU_Snipers;
		{_crate addWeaponCargo [_x, 30]} forEach _EU_Launchers;
		{_crate addMagazineCargo [_x, 60]} forEach _EU_Rifle_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _EU_MG_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _EU_Sniper_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _EU_Launcher_Ammo;
		{_crate addWeaponCargo [_x, 30]} forEach _PMC_Rifles;
		{_crate addWeaponCargo [_x, 30]} forEach _PMC_MGs;
		{_crate addMagazineCargo [_x, 60]} forEach _PMC_Rifle_Ammo;
		{_crate addMagazineCargo [_x, 60]} forEach _PMC_MG_Ammo;		
	};
	
{_crate addWeaponCargo [_x, 50]} forEach _itemsWeapon;
{_crate addMagazineCargo [_x, 50]} forEach _itemsAmmo;
	
sleep 1200;
};