private ["_HALOunit", "_i1", "_i2", "_vel", "_dir"];

_HALOunit = _this select 0;

disableserialization;

BIS_HALO_unit_dir = 0;
BIS_HALO_unit_speed = 50;
BIS_HALO_turnR = 0;

_HALOunit_pitch = -90;
_i1 = 50;
_i2 = 0;

playsound "DPara";
_HALOunit switchMove "HaloFreeFall_non";

if (isNil "halokeyspressed") then {halokeyspressed = compile preprocessFile "aahalo\scripts\f\keyspressed.sqf"};
if (isNil "freefall_ChangedirL") then {freefall_ChangedirL = compile preprocessFile "aahalo\scripts\f\freefall_changedirl.sqf"};
if (isNil "freefall_ChangedirR") then {freefall_ChangedirR = compile preprocessFile "aahalo\scripts\f\freefall_changedirr.sqf"};

d_halo_keyhandler = (findDisplay 46) displayAddEventHandler ["KeyDown","_this call halokeyspressed"];

_open_chute_action = _HALOunit addAction [localize "STR_HALO_OPEN_CHUTE", "aahalo\scripts\halo_parachute.sqf"];

_HALOunit switchMove "HaloFreeFall_non";

while {alive _HALOunit && (vehicle _HALOunit == _HALOunit) && (position player select 2 >= 2)} do {
	_i1 = _i1 + 1;
	_i2 = _i2 + 1;

	_HALOunit setdir BIS_HALO_unit_dir;

	_vel = velocity _HALOunit;
	_dir = direction _HALOunit;
	_HALOunit setVelocity [(sin _dir * BIS_HALO_unit_speed), (cos _dir * BIS_HALO_unit_speed), (_vel select 2)];

	if (BIS_HALO_unit_speed > 50 && _i2 > 80) then {_HALOunit playMove "HaloFreeFall_F"; _i2 = 0};
	if (BIS_HALO_unit_speed < 50 && _i2 > 250) then {_HALOunit playMove "HaloFreeFall_non"; _i2 = 0};

	switch (true) do {
		case (BIS_HALO_unit_speed > 80): {BIS_HALO_unit_speed = 80};
		case (BIS_HALO_unit_speed < 1): {BIS_HALO_unit_speed = 0};
	};

	"RadialBlur" ppEffectAdjust [(BIS_HALO_unit_speed * 0.0002), (BIS_HALO_unit_speed * 0.0002), 0.06, 0.06];
	"RadialBlur" ppEffectCommit 0.01;
	"RadialBlur" ppEffectEnable true;  

	if (_i1 > 70) then {playsound "DPara"; _i1 = 0};

	hintsilent format [localize "STR_HALO_ALTITUDE_SPEED", (round (getpos _HALOunit select 2)), BIS_HALO_unit_speed];

	if (position _HALOunit select 2 < 2) exitWith {_HALOunit playmove ""; _HALOunit switchmove ""; _HALOunit setvelocity [0,0,0]; _HALOunit setdammage 1};
	if (vehicle _HALOunit != _HALOunit) exitWith {};
	sleep 0.01;
};

if (!isNil "d_halo_keyhandler" && !alive _HALOunit) then {(findDisplay 46) displayRemoveEventHandler ["KeyDown",d_halo_keyhandler];d_halo_keyhandler = nil};
