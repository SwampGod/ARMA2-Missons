// by Xeno
#include "x_setup.sqf"
private ["_defaultvalue", "_zchange", "_oldAperture", "_zChangeFinal", "_aperture","_flir_display"];

disableSerialization;

switch (X_FLIR_ONOFF) do {
	case 0: {X_FLIR_ONOFF = 1};
	case 1: {X_FLIR_ONOFF = 0};
};

if (X_FLIR_ONOFF == 1) then {
	if (isNil {X_FLIR_VEC getVariable "X_UAV_aperture"}) then {
		_defaultvalue = if (daytime > 6 && daytime < 19) then {24} else {0.07};
		X_FLIR_VEC setvariable ["X_UAV_aperture",_defaultValue];
		setAperture _defaultvalue;
	} else {
		setAperture (X_FLIR_VEC getvariable "X_UAV_aperture");
	};
	_flir_display = (findDisplay 46);
	X_displayEH_mousezchanged = _flir_display  displayAddEventHandler ["mousezchanged","
		_zchange = _this select 1;
		_oldAperture = X_FLIR_VEC getvariable 'X_UAV_aperture';
		_zChangeFinal = _zChange / 2;
		if (_oldAperture <= 1.0) then {_zChangeFinal = _zChange / 10};
		if (_oldAperture <= 0.1) then {_zChangeFinal = _zChange / 1000};
		_aperture = _oldAperture + _zchangeFinal;
		if (_oldaperture > 1.0 && _aperture < 1.0) then {_aperture = 1.0};
		if (_oldaperture > 0.1 && _aperture < 0.1) then {_aperture = 0.1};
		if (_aperture < 0.001) then {_aperture = 0.001};
		X_FLIR_VEC setvariable ['X_UAV_aperture',_aperture];
		setaperture _aperture;
	"];
	call XFLIRON;
} else {
	if (!isNil "X_displayEH_mousezchanged") then {
		_flir_display = (findDisplay 46);
		_flir_display  displayAddEventHandler ["mousezchanged",X_displayEH_mousezchanged];
	};
	true call XFLIROFF;
};