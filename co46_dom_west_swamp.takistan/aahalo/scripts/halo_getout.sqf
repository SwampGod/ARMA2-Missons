private ["_HALOunit", "_defaultparachute"];

_HALOunit = _this select 0;

waitUntil {(typeOf (vehicle _HALOunit)) in ["ParachuteWest","ParachuteEast","ParachuteG","ParachuteC","Parachute"]};

_defaultparachute = vehicle _HALOunit;
deleteVehicle _defaultparachute;

titleCut ["", "BLACK FADED", 100];
sleep 1;
titleCut ["", "BLACK IN", 2];

if (_HALOunit == player) then {playsound "DPara"};

if (_HALOunit == player) then {
	[_HALOunit] execVM "aahalo\scripts\halo.sqf"
} else {
	[_HALOunit] execVM "aahalo\scripts\halo_ai.sqf"
};
