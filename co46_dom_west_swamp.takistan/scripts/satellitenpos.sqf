// Sat View  by Vienna
#include "x_setup.sqf"
private "_ok";

_ok = true;

switch (_this) do {
	case "N" : {d_SatellitenPos_Y = d_SatellitenPos_Y +50};
	case "S" : {d_SatellitenPos_Y = d_SatellitenPos_Y -50};
	case "W" : {d_SatellitenPos_X = d_SatellitenPos_X -50};
	case "E" : {d_SatellitenPos_X = d_SatellitenPos_X +50};
	case "X" : {d_SatellitenPos_X = d_SatellitenPos_XC; d_SatellitenPos_Y = d_SatellitenPos_YC};
	case "ZE": {d_SatellitenZoom  = 0.10};
	case "ZA": {d_SatellitenZoom  = 0.27};
	default {
		d_SatellitenPos_XC = _this select 0;
		d_SatellitenPos_X = d_SatellitenPos_XC;
		d_SatellitenPos_YC = _this select 1;
		d_SatellitenPos_Y = d_SatellitenPos_YC-0.9;
		d_SatellitenZoom  = 0.27;
		titleCut["Satellite ON","Black out"];
		sleep 1;
		d_SatellitenCamera = "camera" camCreate [d_SatellitenPos_X,d_SatellitenPos_Y,530];
		d_SatellitenCamera cameraEffect ["internal", "back"];
		showCinemaBorder false;
		d_SatellitenCamera camSetTarget [d_SatellitenPos_X,d_SatellitenPos_Y+5,-99999];
		d_SatellitenCamera camSetFOV d_SatellitenZoom;
		d_SatellitenCamera camCommit 0;
		waitUntil {camCommitted d_SatellitenCamera};
		sleep 1;
		_ok = createDialog "SAT_Satellitenbild";
		titleCut["Satellite ON","Black in"];
		waitUntil {!dialog || !alive player};
		if (alive player) then {
			titleCut["Satellite OFF","Black out"];
			sleep 1;
		};
		d_SatellitenCamera cameraEffect ["terminate", "back"];
		camDestroy d_SatellitenCamera;
		camUseNVG false;
		if (alive player) then {
			titleCut["Satellite OFF","Black in"];
		};
		_ok = false
	}
};

if (_ok) then {
	d_SatellitenCamera camSetPos [d_SatellitenPos_X,d_SatellitenPos_Y,530];
	d_SatellitenCamera camSetTarget [d_SatellitenPos_X,d_SatellitenPos_Y+5,-99999];
	d_SatellitenCamera camSetFOV d_SatellitenZoom;
	d_SatellitenCamera camCommit 0;
	waitUntil {camCommitted d_SatellitenCamera};
};