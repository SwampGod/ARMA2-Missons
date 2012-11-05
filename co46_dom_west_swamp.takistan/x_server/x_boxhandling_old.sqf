// by Xeno
#include "x_setup.sqf"
private ["_i", "_element", "_vec", "_box_pos"];
if (!isServer) exitWith {};

while {true} do {
	__MPCheck;
	_boxes = __XJIPGetVar(d_ammo_boxes);
	for "_i" from 0 to (count d_check_boxes - 1) do {
		_element = d_check_boxes select _i;
		_vec = _element select 0;
		_box_pos = _element select 1;
		if (isNull _vec) then {
			d_check_boxes set [_i, -1];
			_boxes set [_i, -1];
			["ammo_boxes",__XJIPGetVar(ammo_boxes) - 1] call XNetSetJIP;
			["d_r_box", _box_pos] call XNetCallEvent;
		} else {
			if (_vec distance _box_pos > 30) then {
				d_check_boxes set [_i, -1];
				_boxes set [_i, -1];
				["ammo_boxes",__XJIPGetVar(ammo_boxes) - 1] call XNetSetJIP;
				["d_r_box", _box_pos] call XNetCallEvent;
			};
		};
	};
	_boxes = _boxes - [-1];
	["d_ammo_boxes",_boxes] call XNetSetJIP;
	sleep 0.1;
	d_check_boxes = d_check_boxes - [-1];
	sleep 5.321;
};