//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: -eutf-Myke
//////////////////////////////////////////////////////////////////
if (! isServer) exitwith {};
private ["_leader", "_unitarray", "_typearray"];
_leader = _this select 0;
_cache_side = _this select 1;
_cache_dist = _this select 2;
_grp = group _leader;
_unitarray = units group _leader;
_unitarray = _unitarray - [_leader];
_typearray = [];
{
_type = typeof _x;
_weap = weapons _x;
_mags = magazines _x;
_pos = _leader worldtomodel position _x;
_typearray = _typearray + [[_type, _weap, _mags, _pos]];
}
foreach _unitarray;
if (((_cache_side countside (position _leader nearobjects ["AllVehicles", _cache_dist])) == 0)) then
	{
		{
		deletevehicle _x;
		}
		foreach _unitarray;
	};
while {count _unitarray >= 1} do
	{
	waituntil {((_cache_side countside (position _leader nearobjects ["AllVehicles", _cache_dist])) != 0)};
		{
		_unit_init = _x select 0;
		_unit_weap = _x select 1;
		_unit_mags = _x select 2;
		_unit_offset = _x select 3;
		_unit_pos = _leader modeltoworld _unit_offset;
		_new_unit = _unit_init createunit [_unit_pos, group _leader, "myunit = this"];
		removeallweapons myunit;
			{
			myunit addmagazine _x;
			}
			foreach _unit_mags;
			{
			myunit addweapon _x;
			}
			foreach _unit_weap;
		}
		foreach _typearray;
	waituntil {((_cache_side countside (position _leader nearobjects ["AllVehicles", (_cache_dist + 15)])) == 0)};
	sleep 5;
	_leader = leader _grp;
	_unitarray = units group _leader;
	_unitarray = _unitarray - [_leader];
	_typearray = [];
		{
		_type = typeof _x;
		_weap = weapons _x;
		_mags = magazines _x;
		_pos = _leader worldtomodel position _x;
		_typearray = _typearray + [[_type, _weap, _mags, _pos]];
		}
		foreach _unitarray;
		{
		deletevehicle _x;
		}
		foreach _unitarray;
	};