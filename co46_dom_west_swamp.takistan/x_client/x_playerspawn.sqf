// by Xeno
#include "x_setup.sqf"
#define __prma _p removeAction _id
#define __addari1 __pSetVar [#d_ari1, _p addAction ["Call Artillery" call XGreyText, "x_client\x_artillery.sqf",[1,D_AriTarget],-1,false]]
#define __adddrop __pSetVar [#d_dropaction, _p addAction ["Call Drop" call XGreyText, "x_client\x_calldrop.sqf",[],-1,false]]
#define __addbp __pSetVar [#d_pbp_id, _p addAction [_s call XGreyText, "x_client\x_backpack.sqf",[],-1,false]]
private ["_weapons", "_magazines", "_p", "_hasruck", "_ruckmags", "_ruckweapons", "_backwep", "_types", "_type", "_action", "_ar", "_primw", "_muzzles", "_s", "_items"];
_weapons = [];
_magazines = [];

_p = player;
#ifdef __OA__
_ubackp = if (!isNull (unitBackpack _p)) then {typeOf (unitBackpack _p)} else {""};
#endif

#ifdef __ACE__
_hasruck = false;
_ruckmags = [];
_ruckweapons = [];
_items = [];
if (_p call ace_sys_ruck_fnc_hasRuck) then {
	_ruckmags = __pGetVar(ACE_RuckMagContents);
	_hasruck = true;
	_ruckweapons = __pGetVar(ACE_RuckWepContents);
};
_backwep = __pGetVar(ACE_weapononback);
_ident = __pGetVar(ACE_Identity);
#endif
if (x_weapon_respawn) then {
	_weapons = weapons _p;
	_magazines = magazines _p;
	_items = items _p;
};
if (!d_with_ai) then {
	if (!(__ACEVer)) then {
		if (d_player_can_call_arti) then {
			_id = __pGetVar(d_ari1);
			if (_id != -8877) then {
				__prma;
				__pSetVar ["d_ari1", -8877];
			};
		};
		if (d_player_can_call_drop) then {
			_id = __pGetVar(d_dropaction);
			if (_id != -8878) then {
				__prma;
				__pSetVar ["d_dropaction", -8878];
			};
		};
	};
} else {	
	if (!(__ACEVer)) then {
		_id = __pGetVar(d_ari1);
		if (_id != -8877) then {
			__prma;
			__pSetVar ["d_ari1", -8877];
		};
		_id = __pGetVar(d_dropaction);
		if (_id != -8878) then {
			__prma;
			__pSetVar ["d_dropaction", -8878];
		};
	};
};

_id = __pGetVar(d_ass);
if (_id != -8879) then {
	__prma;
	__pSetVar ["d_ass", -8879];
};

if (WithBackpack) then {
	_id = __pGetVar(d_pbp_id);
	if (_id != -9999) then {
		__prma;
		__pSetVar ["d_pbp_id", -9999];
	};
};

if (d_player_is_medic) then {
	_id = __pGetVar(d_medicaction);
	if (_id != -3333) then {
		__prma;
		__pSetVar ["d_medicaction", -3333];
	};
};

if (d_with_mgnest) then {
	if (d_player_can_build_mgnest) then {
		_id = __pGetVar(d_mgnestaction);
		if (_id != -11111) then {
			__prma;
			__pSetVar ["d_mgnestaction", -11111];
		};
	};
};
if (!isNil "d_action_menus_type") then {
	if (count d_action_menus_type > 0) then {
		{
			_types = _x select 0;
			if (count _types > 0) then {
				if (_type in _types) then {
					_id = _x select 3;
					__prma;
				};
			} else {
				_id = _x select 3;
				__prma;
			};
		} forEach d_action_menus_type;
	};
};
if (!isNil "d_action_menus_unit") then {
	if (count d_action_menus_unit > 0) then {
		{
			_types = _x select 0;
			_ar = _x;
			if (count _types > 0) then {
				{
					_hh = missionNamespace getVariable _x;
					if (_p ==  _hh) exitWith { 
						_id = _ar select 3;
						__prma;
					};
				} forEach _types
			} else {
				_id = _x select 3;
				__prma;
			};
		} forEach d_action_menus_unit;
	};
};
waitUntil {alive player};
#ifndef __ACE__
if (!isNil {__pGetVar(d_p_ev_hd)}) then {d_phd_invulnerable = true};
#else
__pSetVar ["ace_w_allow_dam", false];
#endif
#ifdef __OA__
removeBackpack player;
#endif
_p = player;
if (x_weapon_respawn) then {
	removeAllItems _p;
	removeAllWeapons _p;
	#define __addmx _p addMagazine _x
	#define __addwx _p addWeapon _x
#ifndef __REVIVE__
	if (count d_custom_layout > 0) then {
		{__addmx} forEach (d_custom_layout select 1);
		{__addwx} forEach (d_custom_layout select 0);
	} else {
		{__addmx} forEach _magazines;
		{__addwx} forEach _weapons;
		{if !(_p hasWeapon _x) then {_p addWeapon _x}} forEach _items;
		if (count d_backpack_helper > 0) then {
			{__addmx} forEach (d_backpack_helper select 0);
			{__addwx} forEach (d_backpack_helper select 1);
			d_backpack_helper = [];
		};
	};
#else
	{__addmx} forEach _magazines;
	{__addwx} forEach _weapons;
	{if !(_p hasWeapon _x) then {_p addWeapon _x}} forEach _items;
	if (count d_backpack_helper > 0) then {
		{__addmx} forEach (d_backpack_helper select 0);
		{__addwx} forEach (d_backpack_helper select 1);
		d_backpack_helper = [];
	};
#endif
	if (WithBackpack) then {
		if (count __pGetVar(d_custom_backpack) > 0) then {
			__pSetVar ["d_player_backpack", [__pGetVar(d_custom_backpack) select 0, __pGetVar(d_custom_backpack) select 1]];
		};
	};
#ifdef __ACE__
	if (!isNil "d_custom_ruckbkw") then {
		if ((typeName d_custom_ruckbkw) == "STRING") then {_backwep = d_custom_ruckbkw};
	};
	if (!isNil "d_custom_ruckmag") then {
		if ((typeName d_custom_ruckmag) == "ARRAY") then {_ruckmags = d_custom_ruckmag};
	};
	if (!isNil "d_custom_ruckwep") then {
		if ((typeName d_custom_ruckwep) == "ARRAY") then {_ruckweapons = d_custom_ruckwep};
	};
	if (__pGetVar(d_earwear)) then {
		if !(_p hasWeapon "ACE_Earplugs") then {_p addWeapon "ACE_Earplugs"}
	};
#endif
	_primw = primaryWeapon _p;
	if (_primw != "") then {
		_p selectWeapon _primw;
		_muzzles = getArray(configFile>>"cfgWeapons" >> _primw >> "muzzles");
		_p selectWeapon (_muzzles select 0);
	};
#ifdef __OA__
	if (_ubackp != "") then {
		_p addBackpack _ubackp;
	};
#endif
};
"RadialBlur" ppEffectAdjust [0.0, 0.0, 0.0, 0.0];
"RadialBlur" ppEffectCommit 0;
"RadialBlur" ppEffectEnable false;
#ifdef __ACE__
if (_hasruck) then {
	if (!isNil "_ruckmags") then {__pSetVar ["ACE_RuckMagContents", _ruckmags]};
	if (!isNil "_ruckweapons") then {__pSetVar ["ACE_RuckWepContents", _ruckweapons]};
};
if (!isNil "_backwep") then {if((typeName _backwep) == "STRING") then {__pSetVar ["ACE_weapononback", _backwep]}};
ACE_MvmtFV = 0;ACE_FireFV = 0;ACE_WoundFV = 0;ACE_FV = 0;
ACE_Heartbeat = [0,20];ACE_Blackout = 0;ACE_Breathing = 0;
#endif

if (!d_with_ai) then {
	if (!(__ACEVer)) then {
		if (d_player_can_call_arti) then {
			switch (d_string_player) do {
				case ("RESCUE"): {__addari1};
				case ("RESCUE2"): {
					__pSetVar ["d_ari1", _p addAction ["Call Artillery" call XGreyText, "x_client\x_artillery.sqf",[2,D_AriTarget2],-1,false]];
				};
			};
		};
		if (d_player_can_call_drop) then {__adddrop};
	};
} else {
	if (!(__ACEVer)) then {
		if (d_player_can_call_arti) then {__addari1};
		if (d_player_can_call_drop) then {__adddrop};
	};
	if (rating _p < 20000) then {_p addRating 20000};
};
__pSetVar ["d_ass", _p addAction ["Show Status" call XGreyText, "x_client\x_showstatus.sqf",[],-1,false]];
if (WithBackpack) then {
	if (count __pGetVar(d_player_backpack) == 0) then {
		if (primaryWeapon _p != "" && primaryWeapon _p != " ") then {
			_s = format ["%1 to Backpack", [primaryWeapon _p,1] call XfGetDisplayName];
			if (__pGetVar(d_pbp_id) == -9999) then {__addbp};
		};
	} else {
		_s = format ["Weapon %1", [__pGetVar(d_player_backpack) select 0,1] call XfGetDisplayName];
		if (__pGetVar(d_pbp_id) == -9999) then {__addbp};
	};
};
if (d_player_is_medic) then {
	if (__pGetVar(d_medicaction) == -3333) then {
		__pSetVar ["d_medicaction", _p addAction ["Build Mash" call XGreyText, "x_client\x_mash.sqf",[],-1,false]];
	};
};
if (d_with_mgnest) then {
	if (d_player_can_build_mgnest) then {
		if (__pGetVar(d_mgnestaction) == -11111) then {
			__pSetVar ["d_mgnestaction", _p addAction ["Build MG Nest" call XGreyText, "x_client\x_mgnest.sqf",[],-1,false]];
		};
	};
};
if (!isNil "d_action_menus_type") then {
	if (count d_action_menus_type > 0) then {
		{
			_types = _x select 0;
			if (count _types > 0) then {
				if (_type in _types) then { 
					_action = _p addAction [(_x select 1) call XGreyText,_x select 2,[],-1,false];
					_x set [3, _action];
				};
			} else {
				_action = _p addAction [(_x select 1) call XGreyText,_x select 2,[],-1,false];
				_x set [3, _action];
			};
		} forEach d_action_menus_type;
	};
};
if (!isNil "d_action_menus_unit") then {
	if (count d_action_menus_unit > 0) then {
		{
			_types = _x select 0;
			_ar = _x;
			if (count _types > 0) then {
				{
					_hh = missionNamespace getVariable _x;
					if (_p ==  _hh) exitWith { 
						_action = _p addAction [(_ar select 1) call XGreyText,_ar select 2,[],-1,false];
						_ar set [3, _action];
					};
				} forEach _types
			} else {
				_action = _p addAction [(_x select 1) call XGreyText,_x select 2,[],-1,false];
				_x set [3, _action];
			};
		} forEach d_action_menus_unit;
	};
};
if (!isNil {__pGetVar(d_bike_created)}) then {__pSetVar ["d_bike_created", false]};
if (_p hasWeapon "NVGoggles") then {if (daytime > 19.75 || daytime < 4.15) then {_p action ["NVGoggles",_p]}};
waitUntil {!dialog};
sleep 5;
#ifndef __ACE__
if (!isNil {__pGetVar(d_p_ev_hd)}) then {d_phd_invulnerable = false};
#else
__pSetVar ["ace_w_allow_dam", nil];
if (_ident != "") then {
	["ace_sys_goggles_setident2", [player, _ident]] call CBA_fnc_globalEvent;
	__pSetVar ["ACE_Identity",_ident];
};
#endif