_unit = _this select 1;

_params = _this select 3;            // Params passed to this script.

_vehic = _params select 0;

if ( !alive _vehic ) then {
    hint "Currently unavailable or destroyed.";
    } else {
    _unit moveInCargo (vehicle _vehic);


};