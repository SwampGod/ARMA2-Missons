//respawnSpecial.sqf
_name = _this select 0;
_spawn1 = _this select 1;
_spawn2 = _this select 2;

if ((_name distance (getMarkerPos _spawn1)) < 600) then {
	_name moveINCargo Respawn_carrier;
	if (_name != player) then {unassignVehicle (vehicle _name); _name action ["EJECT", vehicle _name];};
};

if ((_name distance (getMarkerPos _spawn2)) < 20) then {
	if (isplayer _name) then {[_name] execVM "AAHALO\Scripts\HALO_getout.sqf"};
	_name moveINCargo Respawn_chopper;
	if (!isplayer _name) then {unassignVehicle (vehicle _name); _name action ["EJECT", vehicle _name];};
};