_unit = _this select 1;
if ( !alive blackhawk ) then {
    hint "The Blackhawk is currently destroyed.";
    } else {
    _unit moveInCargo (vehicle blackhawk);
//    playSound "teleport";
};