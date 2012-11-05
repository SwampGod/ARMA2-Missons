private ["_HALOunit", "_HALOunitaltitude"];

_HALOunit = _this select 0;
_HALOunitaltitude = _this select 1;

[_HALOunit, _HALOunitaltitude] call XfSetHeight;

sleep 0.01;
if (_HALOunit == player) then {
	playsound "DPara"; setAperture 0.05; setAperture -1; _HALOunit switchMove "para_pilot"; [_HALOunit] execVM "aahalo\scripts\halo.sqf";
} else {
	[_HALOunit] execVM "aahalo\scripts\halo_ai.sqf";
};
