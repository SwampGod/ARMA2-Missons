// by Xeno
#include "x_setup.sqf"
private ["_grps", "_allunits", "_grp", "_numdown"];

if (!isServer) exitWith {};

_grps = _this select 0;
_allunits = [];
{
	_grp = _x;
	_allunits = [_allunits , (units _grp)] call X_fnc_arrayPushStack;
	sleep 0.011;
} forEach _grps;

sleep 1.2123;

_numdown =
	#ifndef __ACE__
		5;
	#else
		3;
	#endif

while {!__XJIPGetVar(d_mt_radio_down)} do {
	__MPCheck;
	__DEBUG_NET("x_handleattackgroups.sqf",(call XPlayersNumber))
	if ((_allunits call XfGetAliveUnits) < _numdown) exitWith {
		d_c_attacking_grps = [];
		d_create_new_paras = true;
	};
	sleep 10.623;
};

_allunits = nil;
_grps = nil;
