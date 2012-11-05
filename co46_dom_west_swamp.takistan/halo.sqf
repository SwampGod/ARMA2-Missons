_altitude = (position (vehicle player)) select 2;
if (_altitude >= 500) then {
	_height = (position player) select 2;
	
_dir = getDir vehicle player;
moveOut player;
player setDir _dir;
sleep 0.5;
[player, _height] spawn bis_fnc_halo;
} else {
	hint "Plane too low for safe HALO jump! Reach 500";
};
