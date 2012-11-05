// by Xeno
#include "x_setup.sqf"
private ["_attack_pos","_grp","_leader","_mags","_no","_obj","_obj_pos","_one_shell","_shell_unit"];
if (!isServer) exitWith {};

_grp = _this select 0;
_attack_pos = _this select 1;

_grp setBehaviour "AWARE";
_grp setCombatMode "YELLOW";

if (isNull _grp) exitWith {};

#ifdef __OA__
{_x addMagazine "PipeBomb"} forEach (units _grp);
#endif

while {(_grp call XfGetAliveUnitsGrp) > 0} do {
	__MPCheck;
	__DEBUG_NET("x_sabotage.sqf",(call XPlayersNumber))
	_leader = leader _grp;
#ifndef __OA__
	_no = nearestObjects [_leader,["WarfareBEastAircraftFactory","WarfareBWestAircraftFactory"],300];
#else
	_no = nearestObjects [_leader,["TK_WarfareBAircraftFactory_EP1","US_WarfareBAircraftFactory_EP1"],300];
#endif
	sleep 0.32;
	if (count _no > 0) then {
		_obj = _no call XfRandomArrayVal;
		if (alive _obj) then {
			_obj_pos = position _obj;
			_units = units _grp;
			for "_i" from 1 to 3 do {
				_one_shell = "";
				_shell_unit = objNull;
				{
					scopeName "xxxx3";
					_mags = magazines _x;
					_shell_unit = _x;
					{
						if (_x == "PipeBomb") then {
							_one_shell = _x;
							breakOut "xxxx3";
						};
					} forEach _mags;
					sleep 0.011;
				} forEach _units;
				if (_shell_unit == objNull) exitWith {};
				_units = _units - [_shell_unit];
				if (_one_shell != "") then {
					_shell_unit selectWeapon "PipeBombMuzzle";
					if (_leader == _shell_unit) then {
						_shell_unit doMove _obj_pos;
						_shell_unit doTarget _obj;
						_shell_unit doFire _obj;
					} else {
						_shell_unit commandMove _obj_pos;
						_shell_unit commandTarget _obj;
						_shell_unit commandFire _obj;
					};
				};
				if (!alive _obj) exitWith {};
			};
		};
	};
	_no = nil;
	sleep 240 + (random 80);
	if (isNull _grp) exitWith {};
};
