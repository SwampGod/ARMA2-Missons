private ["_HALOunit", "_waypointreached", "_speed", "_pos1", "_waypointpos", "_pos2", "_ret", "_vel", "_dir"];

_HALOunit = _this select 0;
_waypointreached = 0;
_speed = 65;

_HALOunit switchMove "HaloFreeFall_non";

_pos1 = getpos _HALOunit;
_waypointpos = getWPPos [group _HALOunit,1];
_pos2 = [_waypointpos select 0,  _waypointpos select 1, getpos _HALOunit select 2];

_ret = ((_pos2 select 0) - (_pos1 select 0)) atan2 ((_pos2 select 1) - (_pos1 select 1));
_ret = _ret % 360;

_HALOunit setdir _ret;

while {(alive _HALOunit) && (vehicle _HALOunit == _HALOunit) && (position _HALOunit select 2 > 150)} do {
	_pos2 = [_waypointpos select 0,  _waypointpos select 1, getpos _HALOunit select 2];

	_vel = velocity _HALOunit;
	_dir = direction _HALOunit;
	_HALOunit setVelocity [(sin _dir*_speed),(cos _dir*_speed),(_vel select 2)];

	if (_waypointreached == 1) then {_speed = _speed - 0.1};
	if (_speed < 1) then {_speed = 1};

	if ((_HALOunit distance _pos2) < 200) then {_waypointreached = 1};
	sleep 0.01;
};

[_HALOunit] execVM "aahalo\scripts\halo_parachute.sqf";
