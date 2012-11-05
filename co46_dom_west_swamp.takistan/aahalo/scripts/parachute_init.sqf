private ["_para"];

_para = _this select 0;

while {true} do {
	if (count (crew _para) > 0) exitWith {
		"RadialBlur" ppEffectEnable false;
		if ((gunner _para) == player) then {
			[_para, (gunner _para)] execVM "aahalo\scripts\parachute.sqf";
		} else {
			[_para, (gunner _para)] execVM "aahalo\scripts\parachute_ai.sqf";
		};
	};

	_float_dir = ((vectorUp _para select 1) * (vectorUp _para select 1));
	_float_angle = -1 * atan((vectorUp _para select 2) * sqrt((vectorUp _para select 1)^2 + ( vectorUp _para select 0)^2));

	_float_vX = cos _float_dir;
	_float_vY = sin _float_dir;
	_float_vZ = tan _float_angle;
	_float_speedH = 10;
	_para setVelocity [_float_speedH * _float_vX, _float_speedH * _float_vY, - 3];
	sleep 0.01;
};