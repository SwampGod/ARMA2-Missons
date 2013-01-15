_unit = _this select 1;
if ( !alive merlin ) then {
    hint "The Merlin is currently destroyed.";
    } else {
    _unit moveInCargo (vehicle merlin);
//    playSound "teleport";
};