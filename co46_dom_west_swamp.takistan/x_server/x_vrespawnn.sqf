// by Xeno
#include "x_setup.sqf"
private ["_vehicles", "_var", "_vec", "_empty", "_disabled", "_lastt"];
if (!isServer) exitWith{};

_vehicles = [];

{
	_vehicles set [count _vehicles, [_x, typeOf _x, position _x, direction _x]];
	_x setVariable ["d_lastusedrr", time];
	_x setVariable ["d_vec_islocked", if (locked _x) then {true} else {false}];
} forEach _this;

_this = nil;

while {true} do {
	sleep 10;
	
	{
		_var = _x;
		_vec = _var select 0;
		
		_empty = if ((_vec call XfGetAliveCrew) > 0) then {false} else {true};
		
		if (_empty) then {
			_disabled = if (damage _vec > 0.9) then {true} else {false};
			
			if (!_disabled) then {
				_lastt = _vec getVariable "d_lastusedrr";
				if (time - _lastt > 600) then {_disabled = true};
			};
			
			if (_disabled || !alive _vec) then {
				_isitlocked = _vec getVariable "d_vec_islocked";
				deletevehicle _vec;
				_vec = objNull;
				sleep 0.5;
				_vec = createVehicle [_var select 1, _var select 2, [], 0, "NONE"];
				_vec setpos (_var select 2);
				_vec setdir (_var select 3);
				_var set [0, _vec];
				_vec setVariable ["d_vec_islocked", _isitlocked];
				if (_isitlocked) then {_vec lock true};
			};
		} else {
			_vec setVariable ["d_lastusedrr", time];
		};
		
		sleep 2;
	} forEach _vehicles;
};
