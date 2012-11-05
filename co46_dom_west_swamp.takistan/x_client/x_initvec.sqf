// by Xeno
#include "x_setup.sqf"
#define __vecmarker [_car select 2, position _vec,"ICON",_car select 4,[1,1],_mt,0,_car select 3] call XfCreateMarkerLocal;\
_vec setVariable ["d_marker", _car select 2];\
d_marker_vecs set [count d_marker_vecs, _vec];

#define __chopmarker [_car select 2, position _vec,"ICON",_car select 5,[1,1],_car select 6,0,_car select 4] call XfCreateMarkerLocal;\
_vec setVariable ["d_marker", _car select 2];\
d_marker_vecs set [count d_marker_vecs, _vec];\
if (count _car > 8) then {_vec setVariable ["d_lift_types", _car select 8]}

#define __chopset _index = _car select 1;\
_vec setVariable ["d_choppertype", _index];\
_vec setVariable ["d_vec_type", "chopper"];\
switch (_index) do {\
	case 0: {_vec addEventHandler ["getin", {[_this,0] call x_checkhelipilot}]};\
	case 1: {_vec addEventHandler ["getin", {_this call x_checkhelipilot_wreck}]};\
	case 2: {_vec addEventHandler ["getin", {[_this,1] call x_checkhelipilot}]};\
};\
_vec addEventHandler ["getout", {_this spawn x_checkhelipilotout}]

#define __checkkillw if (!X_SPE) then {_vec addEventHandler ["killed", {_this spawn x_checkveckillwest}]}
#define __checkkille if (!X_SPE) then {_vec addEventHandler ["killed", {_this spawn x_checkveckilleast}]}
#define __sidew _vec setVariable ["d_side", west]
#define __sidee _vec setVariable ["d_side", east]
#define __vecname _vec setVariable ["d_vec_name", _car select 6]
#define __chopname _vec setVariable ["d_vec_name", _car select 7]
#define __checkenterer _vec addEventHandler ["getin", {_this call x_checkenterer}]
#define __pvecs {if ((_x select 1) == _d_vec) exitWith {_car = _x}} forEach d_p_vecs
#define __pvecss(sname) {if ((_x select 1) == _d_vec) exitWith {_car = _x}} forEach d_p_vecs_##sname

#define __staticl \
_vec addAction["Load Static" call XGreyText,"scripts\load_static.sqf",_d_vec,-1,false];\
_vec addAction["Unload Static" call XRedText,"scripts\unload_static.sqf",_d_vec,-1,false]

#define __addchopm _vec addAction ["Chopper Menu" call XGreyText,"x_client\x_vecdialog.sqf",[],-1,false]
#define __halo _vec addAction ["HALO Jump" call XGreyText,"x_client\x_halo.sqf",[],-1,false,true,"","vehicle player != player && ((vehicle player) call XfGetHeight) > 50"]

private "_vec";

_vec = _this;

_d_vec = _vec getVariable "d_vec";
if (isNil "_d_vec") exitWith {};

if (!isNil {_vec getVariable "d_vcheck"}) exitWith {};
_vec setVariable ["d_vcheck", true];

if (_d_vec < 10) exitWith {
	_car = [];
#ifndef __TT__
	__pvecs;
#else
	__pvecss(west);
#endif
	if (count _car > 0) then {
		__mNsSetVar [_car select 0, _vec];
		if (!alive _vec) exitWith {};
#ifdef __ACE__
		if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
#endif
#ifdef __TT__
		if (playerSide == west) then {
#endif
		_mt = _car select 5;
		if (!isNil {_vec getVariable "D_MHQ_Deployed"}) then {
			if (_vec getVariable "D_MHQ_Deployed") then {_mt = _mt + " (Deployed)"};
		};
		if (str(markerPos (_car select 2)) != "[0,0,0]") then {
			(_car select 2) setMarkerTextLocal _mt;
		};
		__vecmarker;
		_vec setVariable ["d_marker_text", _car select 5];
#ifdef __TT__
		};
#endif
		__vecname;
	};
	if (!alive _vec) exitWith {};
#ifdef __ACE__
	if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
#endif
	_vec addeventhandler ["killed", {(_this select 0) setVariable ["D_MHQ_Deployed",false,true]}];
#ifdef __TT__
	if (playerSide == west) then {
#endif
	_vec addAction ["MHQ Menu" call XGreyText,"x_client\x_vecdialog.sqf",_d_vec,-1,false];
#ifdef __TT__
	};
#endif
	_vec setVariable ["d_vec_type", "MHQ"];
#ifdef __TT__
	_vec addEventHandler ["getin", {_this call x_checkdriver}];
	__sidew;
	__checkkillw;
#endif
	_vec setAmmoCargo 0;
};

if (_d_vec < 20) exitWith {
	_car = [];
#ifndef __TT__
	__pvecs;
#else
	__pvecss(west);
#endif
	if (count _car > 0) then {
		__mNsSetVar [_car select 0, _vec];
		if (!alive _vec) exitWith {};
#ifdef __TT__
		if (playerSide == west) then {
#endif
		_mt = _car select 5;
		__vecmarker;
#ifdef __TT__
		};
#endif
		__vecname;
	};
	if (!alive _vec) exitWith {};
#ifdef __ACE__
	if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
#endif
#ifdef __TT__
	__sidew;
	__checkenterer;
	__checkkillw;
#endif
	_vec setAmmoCargo 0;
};

if (_d_vec < 30) exitWith {
	_car = [];
#ifndef __TT__
	__pvecs;
#else
	__pvecss(west);
#endif
	if (count _car > 0) then {
		__mNsSetVar [_car select 0, _vec];
		if (!alive _vec) exitWith {};
#ifdef __ACE__
		if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
#endif
#ifdef __TT__
		if (playerSide == west) then {
#endif
		_mt = _car select 5;
		__vecmarker;
#ifdef __TT__
		};
#endif
		__vecname;
	};
	if (!alive _vec) exitWith {};
#ifdef __ACE__
	if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
#endif
#ifdef __TT__
	__sidew;
	__checkenterer;
	__checkkillw;
#endif
	_vec setAmmoCargo 0;
};

if (_d_vec < 40) exitWith {
	_car = [];
#ifndef __TT__
	__pvecs;
#else
	__pvecss(west);
#endif
	if (count _car > 0) then {
		__mNsSetVar [_car select 0, _vec];
		if (!alive _vec) exitWith {};
#ifdef __ACE__
		if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
#endif
#ifdef __TT__
		if (playerSide == west) then {
#endif
		_mt = _car select 5;
		__vecmarker;
#ifdef __TT__
		};
#endif
		__vecname;
	};
	if (!alive _vec) exitWith {};
#ifdef __ACE__
	if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
#endif
#ifndef __TT__
	if (d_with_ai || d_string_player in d_is_engineer) then {
#else
	if (d_string_player in d_is_engineer && playerSide == west) then {
#endif
		__staticl;
	} else {
		_vec addEventHandler ["getin", {_this call x_checktrucktrans}];
	};
	_vec setVariable ["d_vec_type", "Engineer"];
#ifdef __TT__
	__sidew;
	__checkkillw;
#endif
	_vec setAmmoCargo 0;
};

if (_d_vec < 50) exitWith {
	_car = [];
#ifndef __TT__
	__pvecs;
#else
	__pvecss(west);
#endif
	if (count _car > 0) then {
		__mNsSetVar [_car select 0, _vec];
		if (!alive _vec) exitWith {};
#ifdef __ACE__
		if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
#endif
#ifdef __TT__
		if (playerSide == west) then {
#endif
		_mt = _car select 5;
		__vecmarker;
#ifdef __TT__
		};
#endif
		__vecname;
	};
	if (!alive _vec) exitWith {};
#ifdef __ACE__
	if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
#endif
#ifdef __TT__
	__sidew;
	__checkenterer;
	__checkkillw;
#endif
	_vec setAmmoCargo 0;
};

#ifdef __TT__
if (_d_vec < 110) exitWith {
	_car = [];
	__pvecss(east);
	if (count _car > 0) then {
		__mNsSetVar [_car select 0, _vec];
		if (!alive _vec) exitWith {};
		if (__ACEVer) then {
			if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
		};
		if (playerSide == east) then {
			_mt = _car select 5;
			if (!isNil {_vec getVariable "D_MHQ_Deployed"}) then {
				if (_vec getVariable "D_MHQ_Deployed") then {_mt = _mt + " (Deployed)"};
			};
			if (str(markerPos (_car select 2)) != "[0,0,0]") then {
				(_car select 2) setMarkerTextLocal _mt;
			};
			__vecmarker;
			_vec setVariable ["d_marker_text", _car select 5];
		};
		__vecname;
	};
	if (!alive _vec) exitWith {};
	if (__ACEVer) then {
		if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
	};
	_vec addeventhandler ["killed", {(_this select 0) setVariable ["D_MHQ_Deployed",false,true]}];
	if (playerSide == east) then {
		_vec addAction ["MHQ Menu" call XGreyText,"x_client\x_vecdialog.sqf",_d_vec,-1,false];
	};
	_vec setVariable ["d_vec_type", "MHQ"];
	__sidee;
	_vec addEventHandler ["getin", {_this call x_checkdriver}];
	__checkkille;
	_vec setAmmoCargo 0;
};

if (_d_vec < 120) exitWith {
	_car = [];
	__pvecss(east);
	if (count _car > 0) then {
		__mNsSetVar [_car select 0, _vec];
		if (!alive _vec) exitWith {};
		if (__ACEVer) then {
			if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
		};
		if (playerSide == east) then {
			_mt = _car select 5;
			__vecmarker;
		};
		__vecname;
	};
	if (!alive _vec) exitWith {};
	if (__ACEVer) then {
		if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
	};
	__sidee;
	__checkenterer;
	__checkkille;
	_vec setAmmoCargo 0;
};

if (_d_vec < 130) exitWith {
	_car = [];
	__pvecss(east);
	if (count _car > 0) then {
		__mNsSetVar [_car select 0, _vec];
		if (!alive _vec) exitWith {};
		if (__ACEVer) then {
			if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
		};
		if (playerSide == east) then {
			_mt = _car select 5;
			__vecmarker;
		};
		__vecname;
	};
	if (!alive _vec) exitWith {};
	if (__ACEVer) then {
		if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
	};
	__sidee;
	__checkenterer;
	__checkkille;
	_vec setAmmoCargo 0;
};

if (_d_vec < 140) exitWith {
	_car = [];
	__pvecss(east);
	if (count _car > 0) then {
		__mNsSetVar [_car select 0, _vec];
		if (!alive _vec) exitWith {};
		if (__ACEVer) then {
			if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
		};
		if (playerSide == east) then {
			_mt = _car select 5;
			__vecmarker;
		};
		__vecname;
	};
	if (!alive _vec) exitWith {};
	if (__ACEVer) then {
		if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
	};
	if (d_string_player in d_is_engineer && playerSide == east) then {
		__staticl;
	};
	_vec setVariable ["d_vec_type", "Engineer"];
	__sidee;
	__checkkille;
	_vec addEventHandler ["getin", {_this call x_checktrucktrans}];
	_vec setAmmoCargo 0;
};

if (_d_vec < 150) exitWith {
	_car = [];
	__pvecss(east);
	if (count _car > 0) then {
		__mNsSetVar [_car select 0, _vec];
		if (!alive _vec) exitWith {};
		if (__ACEVer) then {
			if (!(if (!isNil {_vec getVariable "ace_canmove"}) then {_vec call ace_v_alive} else {true})) exitWith {};
		};
		if (playerSide == east) then {
			_mt = _car select 5;
			__vecmarker;
		};
		__vecname;
	};
	__sidee;
	__checkenterer;
	__checkkille;
	_vec setAmmoCargo 0;
};
#endif

if (_d_vec < 400) exitWith {
	_car = [];
#ifndef __TT__
	{if ((_x select 3) == _d_vec) exitWith {_car = _x}} forEach d_choppers;
#else
	{if ((_x select 3) == _d_vec) exitWith {_car = _x}} forEach d_choppers_west;
#endif
	if (count _car > 0) then {
		if (!alive _vec) exitWith {};
		__mNsSetVar [_car select 0, _vec];
		__chopname;
#ifdef __TT__
		if (playerSide == west) then {
#endif
		__chopmarker;
#ifdef __TT__
		};
#endif
	};
	if (!alive _vec) exitWith {};
#ifdef __TT__
	if (playerSide == west) then {
#endif
	__addchopm;
#ifdef __TT__
	};
	__checkkillw;
	__sidew;
#endif
	__chopset;
#ifdef __TT__
	if (playerSide == west) then {
#endif
	if (!(__ACEVer)) then {__halo};
#ifdef __TT__
	};
#endif
};

#ifdef __TT__
if (_d_vec < 500) exitWith {
	_car = [];
	{if ((_x select 3) == _d_vec) exitWith {_car = _x}} forEach d_choppers_east;
	if (count _car > 0) then {
		if (!alive _vec) exitWith {};
		__mNsSetVar [_car select 0, _vec];
		__chopname;
		if (playerSide == east) then {__chopmarker};
	};
	if (!alive _vec) exitWith {};
	__checkkille;
	if (playerSide == east) then {__addchopm};
	__chopset;
	if (playerSide == east) then {
		if (!(__ACEVer)) then {__halo};
	};
	__sidee;
};
#endif