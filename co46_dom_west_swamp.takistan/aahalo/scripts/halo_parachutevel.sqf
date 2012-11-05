private ["_chute", "_speedZ"];

_para_unit = _this select 0;
_chute = vehicle _para_unit;

_speedZ = 30;
while {_speedZ >= 5} do {
	_speedZ = _speedZ - 0.01;
	sleep 0.01;
};