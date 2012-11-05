// by Xeno
#include "x_setup.sqf"
private ["_vehicle", "_nearest", "_id", "_pos", "_nobjects", "_dummy", "_alt", "_nx", "_ny", "_px", "_py", "_npos"];

if (!X_Client) exitWith {};

_vehicle = _this select 0;

_menu_lift_shown = false;
_nearest = objNull;
_id = -1212;
_release_id = -1212;

_vehicle setVariable ["D_Vehicle_Attached", false];
_vehicle setVariable ["D_Vehicle_Released", false];
_vehicle setVariable ["D_Attached_Vec", objNull];

_possible_types = _vehicle getVariable "d_lift_types";

sleep 10.123;

while {(alive _vehicle) && (alive player) && (player in _vehicle)} do {
	if ((driver _vehicle) == player) then {
		_pos = getPos _vehicle;
		
		if (!(_vehicle getVariable "D_Vehicle_Attached") && (_pos select 2 > 2.5) && (_pos select 2 < 50)) then {
			_nearest = objNull;
			_nobjects = nearestObjects [_vehicle, ["LandVehicle","Air"],70];
			if (count _nobjects > 0) then {
				_dummy = _nobjects select 0;
				if (_dummy == _vehicle) then {
					if (count _nobjects > 1) then {_nearest = _nobjects select 1};
				} else {
					_nearest = _dummy;
				};
			};
			if (!isNull _nearest) then {
				if (_nearest isKindOf "Man") then {
					_nearest = objNull;
				} else {
					#ifndef __ACE__
					if ((damage _nearest < 1) || !((typeof _nearest) in _possible_types)) then {_nearest = objNull};
					#else
					_alt = _nearest call ace_v_alive;
					if (isNil "_alt") then {
						if ((damage _nearest < 1) || !((typeof _nearest) in _possible_types)) then {_nearest = objNull};
					} else {
						if (_alt || !((typeof _nearest) in _possible_types)) then {_nearest = objNull};
					};
					#endif
				};
			};
			sleep 0.1;
			if (!(isNull _nearest) && _nearest != (_vehicle getVariable "D_Attached_Vec")) then {
				_nearest_pos = getPos _nearest;
				_nx = _nearest_pos select 0;_ny = _nearest_pos select 1;_px = _pos select 0;_py = _pos select 1;
				if ((_px <= _nx + 10 && _px >= _nx - 10) && (_py <= _ny + 10 && _py >= _ny - 10)) then {
					if (!_menu_lift_shown) then {
						_id = _vehicle addAction ["Lift wreck" call XBlueText, "x_client\x_heli_action.sqf",-1,100000];
						_menu_lift_shown = true;
					};
				} else {
					_nearest = objNull;
					if (_menu_lift_shown) then {
						_vehicle removeAction _id;
						_id = -1212;
						_menu_lift_shown = false;
					};
				};
			};
		} else {
			if (_menu_lift_shown) then {
				_vehicle removeAction _id;
				_id = -1212;
				_menu_lift_shown = false;
			};
			
			sleep 0.1;
			
			if (isNull _nearest) then {
				_vehicle setVariable ["D_Vehicle_Attached", false];
				_vehicle setVariable ["D_Vehicle_Released", false];
			} else {
				if (_vehicle getVariable "D_Vehicle_Attached") then {
					_release_id = _vehicle addAction ["Release wreck" call XRedText, "x_client\x_heli_release.sqf",-1,100000];
					[_vehicle, "Vehicle attached to chopper"] call XfVehicleChat;
					_vehicle setVariable ["D_Attached_Vec", _nearest];
					
					_nearest engineOn false;
					_nearest attachTo [_vehicle, [0,0,-15]];
					
					while {alive _vehicle && (player in _vehicle) && !isNull _nearest && alive player && !(_vehicle getVariable "D_Vehicle_Released")} do {sleep 0.312};
					
					detach _nearest;
					_nearest setVelocity [0,0,0];
					
					_vehicle setVariable ["D_Vehicle_Attached", false];
					_vehicle setVariable ["D_Vehicle_Released", false];
					
					_vehicle setVariable ["D_Attached_Vec", objNull];
					
					if (!alive _nearest || !alive _vehicle) then {
						_vehicle removeAction _release_id;
						_release_id = -1212;
					} else {
						if (alive _vehicle && alive player) then {[_vehicle, "Vehicle released"] call XfVehicleChat};
					};
					
					if (!(_nearest isKindOf "StaticWeapon") && (position _nearest) select 2 < 200) then {
						waitUntil {(position _nearest) select 2 < 10};
					} else {
						_npos = position _nearest;
						_nearest setPos [_npos select 0, _npos select 1, 0];
					};
					
					_nearest setVelocity [0,0,0];
					
					sleep 1.012;
				};
			};
		};
	};
	sleep 0.51;
};

if (alive _vehicle) then {
	if (_id != -1212) then {_vehicle removeAction _id};
	if (_release_id != -1212) then {_vehicle removeAction _release_id};
};