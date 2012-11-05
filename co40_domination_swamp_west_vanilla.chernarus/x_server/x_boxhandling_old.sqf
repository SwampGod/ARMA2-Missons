// by Xeno
#define THIS_FILE "x_boxhandling_old.sqf"
#include "x_setup.sqf"
private ["_vec", "_box_pos"];
if (!isServer) exitWith {};

while {true} do {
	__MPCheck;
	_boxes = __XJIPGetVar(GVAR(ammo_boxes));
	#ifdef __A2ONLY__
	private "_forEachIndex";
	_forEachIndex = 0;
	#endif
	{
		_vec = _x select 0;
		_box_pos = _x select 1;
		if (isNull _vec) then {
			GVAR(check_boxes) set [_forEachIndex, -1];
			_boxes set [_forEachIndex, -1];
			["ammo_boxes",__XJIPGetVar(ammo_boxes) - 1] call FUNC(NetSetJIP);
			[QGVAR(r_box), _box_pos] call FUNC(NetCallEvent);
		} else {
			if (_vec distance _box_pos > 30) then {
				GVAR(check_boxes) set [_forEachIndex, -1];
				_boxes set [_forEachIndex, -1];
				["ammo_boxes",__XJIPGetVar(ammo_boxes) - 1] call FUNC(NetSetJIP);
				[QGVAR(r_box), _box_pos] call FUNC(NetCallEvent);
			};
		};
		#ifdef __A2ONLY__
		__INC(_forEachIndex);
		#endif
	} forEach GVAR(check_boxes);
	_boxes = _boxes - [-1];
	[QGVAR(ammo_boxes),_boxes] call FUNC(NetSetJIP);
	sleep 0.1;
	GVAR(check_boxes) = GVAR(check_boxes) - [-1];
	sleep 5.321;
};