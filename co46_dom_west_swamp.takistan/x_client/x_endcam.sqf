// by Xeno
#include "x_setup.sqf"
private ["_dlg", "_control", "_line", "_camera", "_posp", "_str", "_str2"];

showCinemaBorder false;
disableSerialization;
_dlg = createDialog "X_RscAnimatedLetters";
_XD_display = __uiGetVar(X_ANIM_LETTERS);
_control = _XD_display displayCtrl 66666;
_control ctrlShow false;

_line = 0;
i = 0;
#ifndef __OA__
playMusic "Track19_Debriefing";
#else
playMusic "EP1_Track03D";
#endif

_camera = "camera" camCreate position player;
_camera cameraEffect ["External","back"];

_camera camSetTarget position player;
_camera camSetRelPos [2.71,19.55,3.94];
_camera camSetFOV 1;
_camera camCommit 0.0;
waitUntil {camCommitted _camera};
[] spawn {
	if (vehicle player != player) then {
		_vec = vehicle player;
		if (_vec isKindOf "Air") then {
			_posp = position player;
			_is_driver = (if (driver _vec == player) then {true} else {false});
			player action["EJECT",_vec];
			waitUntil {vehicle player == player};
			player setPos [_posp select 0, _posp select 1, 0];
			player setVelocity [0,0,0];
			if (_is_driver) then {
				_vec spawn {
					private ["_vec"];
					_vec = _this;
					waitUntil {count crew _vec == 0};
					deleteVehicle _vec;
				};
			};
		};
	};
};

_camera camSetRelPos [80.80,120.29,633.07];
_camera camCommit 20;
d_intro_color = [0,0,0,1];
#ifndef __TT__
[5, "CONGRATULATIONS", 2] execVM "introanim\animatelettersx.sqf";__INC(_line); waitUntil {i == _line};
sleep 5;
if (d_SidemissionsOnly == 1) then {
	[0, "You have cleared the island", 4] execVM "introanim\animatelettersx.sqf";__INC(_line); waitUntil {i == _line};
} else {
	[0, "You have resolved all side missions", 4] execVM "introanim\animatelettersx.sqf";__INC(_line); waitUntil {i == _line};
};
#else
_str = "";
_str2 = "";
_points_array = __XJIPGetVar(points_array);
_points_west = _points_array select 0;
_points_east = _points_array select 1;
if (_points_west > _points_east) then {
	_str = "Winner: The US Team";
	_str2 = format [" West %1:%2 East", _points_west, _points_east];
} else {
	if (_points_east > _points_west) then {
		_str = "Winner: The East Team";
		_str2 = format ["East %1:%2 West", _points_east, _points_west];
	} else {
		if (_points_east == _points_west) then {
			_str = "Winner: Both Teams";
			_str2 = format ["West %1:%2 East", _points_west, _points_east];
		};
	};
};
[4, _str, 2] execVM "introanim\animatelettersx.sqf";__INC(_line); waitUntil {i == _line};
sleep 5;
[6, _str2, 4] execVM "introanim\animatelettersx.sqf";__INC(_line); waitUntil {i == _line};
#endif
waitUntil {camCommitted _camera};

_camera camSetFOV 2;

_camera camCommit 20;
[2, "Have a good time !!!", 6] execVM "introanim\animatelettersx.sqf";__INC(_line); waitUntil {i == _line};
waitUntil {camCommitted _camera};

_camera cameraEffect ["terminate","front"];
camDestroy _camera;

3 FADEMUSIC 0;
