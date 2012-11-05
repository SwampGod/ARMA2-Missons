disableserialization;
_key = _this select 1;

if (_key in (actionKeys "TurnLeft")) then {[] spawn freefall_ChangedirL};
if (_key in (actionKeys "TurnRight")) then {[] spawn freefall_ChangedirR};
if (_key in (actionKeys "MoveForward")) then {BIS_HALO_unit_speed = BIS_HALO_unit_speed + 1};
if (_key in (actionKeys "MoveBack")) then {BIS_HALO_unit_speed = BIS_HALO_unit_speed - 1};
