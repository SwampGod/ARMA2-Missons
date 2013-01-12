_unit = _this select 1;

_weapons = weapons _unit;
_magazines = magazines _unit;
_backpack = unitBackpack _unit;
_backpackmagazines = getMagazineCargo _backpack;
_backpackweapons = getWeaponCargo _backpack;

savedloadout = [_weapons,_magazines,typeOf _backpack,_backpackmagazines,_backpackweapons];

hint "Loadout saved.";