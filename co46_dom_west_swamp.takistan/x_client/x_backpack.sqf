// by Xeno
#include "x_setup.sqf"
private ["_anim","_mag_types","_magazines","_mags_backpack","_muzzles","_p","_primary","_s","_pistol","_base"];
_p = player;
_id = __pGetVar(d_pbp_id);
if (_id != -9999) then {
	_p removeAction _id;
	__pSetVar ["d_pbp_id", -9999];
};

if (count __pGetVar(d_player_backpack) == 0) then {
	_primary = primaryWeapon _p;
	if (_primary != "") then {
		_mag_types = getArray(configFile>> "cfgWeapons" >> _primary >> "magazines");
		for "_ii" from 0 to (count _mag_types) - 1 do {_mag_types set [_ii, toUpper(_mag_types select _ii)]};
		_magazines = magazines _p;
		_mags_backpack = [];
		{_tou = toUpper _x;if (_tou in _mag_types) then {_mags_backpack set [count _mags_backpack, _tou]}} forEach _magazines;
		_muzzles = getArray(configFile>> "cfgWeapons" >> _primary >> "muzzles");
		if (count _muzzles == 2) then {
			_mag_types = getArray(configFile>> "cfgWeapons" >> _primary >> (_muzzles select 1) >> "magazines");
			{_tou = toUpper _x;if (_tou in _mag_types) then {_mags_backpack set [count _mags_backpack, _tou]}} forEach _magazines;
		};
		_weapons = weapons _p;
		d_backpack_helper = [_magazines, _weapons];
		_pistol = "";
		{if ((getNumber (configFile >> "CfgWeapons" >> _x >> "Type")) == 2) exitWith {_pistol = _x}} forEach _weapons;
		if (_pistol != "") then {_p removeWeapon _pistol};
		{_p removeMagazine _x} forEach _mags_backpack;
		_p removeWeapon _primary;
		_anim = animationState _p;
		__pSetVar ["d_player_backpack", [_primary, _mags_backpack]];
		waitUntil {animationState player != _anim || !alive player};
		if (!alive player) exitWith {};
		_p = player;
		_s = format ["Weapon %1", [_primary,1] call XfGetDisplayName];
		if (_pistol != "") then {
			_p addWeapon _pistol; _p selectWeapon _pistol;
		};
		if (__pGetVar(d_pbp_id) == -9999) then {__pSetVar ["d_pbp_id", _p addAction [_s call XGreyText, "x_client\x_backpack.sqf",[],-1,false]]};
		if (alive player) then {d_backpack_helper = []};
	};
} else { // switch weapon
	_primary = primaryWeapon _p;
	if (_primary == "") then {
		{_p addMagazine _x} forEach (__pGetVar(d_player_backpack) select 1);
		_p addWeapon (__pGetVar(d_player_backpack) select 0);
		_muzzles = getArray(configFile>>"cfgWeapons" >> (__pGetVar(d_player_backpack) select 0) >> "muzzles");
		_p selectWeapon (__pGetVar(d_player_backpack) select 0);
		_p selectWeapon (_muzzles select 0);
		_s = format ["%1 to Backpack", [__pGetVar(d_player_backpack) select 0,1] call XfGetDisplayName];
		__pSetVar ["d_player_backpack", []];
		_id = __pGetVar(d_pbp_id);
		if (_id != -9999) then {
			_p removeAction _id;
			__pSetVar ["d_pbp_id", -9999];
		};
		__pSetVar ["d_pbp_id", _p addAction [_s call XGreyText, "x_client\x_backpack.sqf",[],-1,false]];
	} else {
		_mag_types = getArray(configFile>> "cfgWeapons" >> _primary >> "magazines");
		for "_ii" from 0 to (count _mag_types) - 1 do {_mag_types set [_ii, toUpper(_mag_types select _ii)]};
		_magazines = magazines _p;
		_mags_backpack = [];
		{_tou = toUpper _x;if (_tou in _mag_types) then {_mags_backpack set [count _mags_backpack, _tou]}} forEach _magazines;
		_muzzles = getArray(configFile>> "cfgWeapons" >> _primary >> "muzzles");
		if (count _muzzles == 2) then {
			_mag_types = getArray(configFile>> "cfgWeapons" >> _primary >> (_muzzles select 1) >> "magazines");
			{_tou = toUpper _x;if (_tou in _mag_types) then {_mags_backpack set [count _mags_backpack, _tou]}} forEach _magazines;
		};
		{_p removeMagazine _x} forEach _mags_backpack;
		_weapons = weapons _p;
		d_backpack_helper = [_mags_backpack, _primary];
		_pistol = "";
		{if ((getNumber (configFile >> "CfgWeapons" >> _x >> "Type")) == 2) exitWith {_pistol = _x}} forEach _weapons;
		if (_pistol != "") then {_p removeWeapon _pistol};
		_p removeWeapon _primary;
		sleep 1;
		_anim = animationState _p;
		waitUntil {animationState player != _anim || !alive player};
		if (!alive player) exitWith {};
		_p = player;
		{_p addMagazine _x} forEach (__pGetVar(d_player_backpack) select 1);
		if (_pistol != "") then {_p addWeapon _pistol};
		_p addWeapon (__pGetVar(d_player_backpack) select 0);
		_muzzles = getArray(configFile>> "cfgWeapons" >> (__pGetVar(d_player_backpack) select 0) >> "muzzles");
		_p selectWeapon (__pGetVar(d_player_backpack) select 0);
		_p selectWeapon (_muzzles select 0);
		__pSetVar ["d_player_backpack", [_primary, _mags_backpack]];
		_s = format ["Weapon %1", [_primary,1] call XfGetDisplayName];
		_id = __pGetVar(d_pbp_id);
		if (_id == -9999) then {__pSetVar ["d_pbp_id", _p addAction [_s call XGreyText, "x_client\x_backpack.sqf",[],-1,false]]};
		if (alive player) then {d_backpack_helper = []};
	};
};