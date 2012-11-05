// by Xeno
#include "x_setup.sqf"
private ["_val", "_pvar_name", "_body"];
if (!isServer) exitWith {};

_pvar_name = _this;

_val = d_placed_objs_store getVariable _pvar_name;

if (!isNil "_val") then {
	{
		deleteMarker (_x select 1);
		if (!isNull (_x select 0)) then {
			_farpsar = __XJIPGetVar(d_farps); 
			_cof = count _farpsar;
			_farpsar = _farpsar - [_x];
			if (_cof != count _farpsar) then {
				__XJIPSetVar ["d_farps", _farpsar, true];
			};
			deleteVehicle (_x select 0);
		};
	} forEach _val;
	d_placed_objs_store setVariable [_pvar_name, nil];
};

#ifdef __REVIVE__
["d_del_m", _pvar_name] call XNetCallEvent;
#endif

_body = missionNamespace getVariable _pvar_name;
if (!isNil "_body") then {
	if (!isNull _body) then {deleteVehicle _body};
};