_para_unit = _this select 1;
hintsilent "";

f_steerChute = {
	_camera = "camera" camcreate [6000,6000,0];
	_camera camcommand "manual on";
	_camera camcommand "inertia off";
	_turn = 0;
	_decend = -2;
	_setTurn = 0;
	_currentTurn = 0;
	_speed = 5;

	while {(alive _para_unit) && (position _para_unit select 2 >= 1)} do {
		_oldDir = (getDir _chute);
		_camPosOld = getPosASL _camera;
		_camera camSetDir _oldDir;
		_camera camcommit 0;
		sleep 0.01;
		_x = ((getPosASL _camera) select 0) - (_camPosOld select 0);
		_y = ((getPosASL _camera) select 1) - (_camPosOld select 1);

		if ((abs _x) > 0.01) then {if ((abs (_turn + _x)) < 8) then {_turn = _turn + _x}};

		if ((abs _y) > 0.01) then {
			if (((_speed + _y) < 15) && ((_speed +_y) > 0)) then {
				_speed = _speed + _y;
				_decend = -(2 + (_speed / 6));
			};
		};

		if ((abs _turn) < 0.1) then {
			_turn = 0;
			_setTurn = 0;
		} else {
			_turn = 0.90 * _turn;
			_setTurn = _turn * 10;
		};

		_newDir = (_oldDir + _turn);

		if (_setTurn != _currentTurn) then {_currentTurn = _currentTurn  + (_setTurn - _currentTurn) * 0.1};

		_nDs = sin _newDir; _nDc = cos _newDir;
		_nTs = sin _currentTurn; _nTc = cos _currentTurn;
		(vehicle _para_unit) setVectorDirAndUp [[_nDs,_nDc, 0],[_nDc * _nTs,-_nDs * _nTs,_nTc]];

		_chute setVelocity [_speed * _nDs, _speed * _nDc, _decend];

		if (position _chute select 2 <= 1) then {
			_para_unit action ["eject", _chute];
			_chute animate ["hide_chute", 1];
			deleteVehicle _chute;
			_para_unit setdammage 0;
			_para_unit setvelocity [0, 0, 0];  
			_para_unit setpos [ getPosASL _para_unit select 0, getPosASL _para_unit select 1, 0];   
			"RadialBlur" ppEffectAdjust [0.0, 0.0, 0.0, 0.0]; "RadialBlur" ppEffectCommit 1.0; "RadialBlur" ppEffectEnable false;	       
			titleCut ["", "BLACK FADED", 100];
			sleep 1.5;
			titleCut ["", "BLACK IN", 2];
		};
		
		if (!alive _para_unit) then {
			_chute animate ["hide_chute", 1];
			_para_unit action ["getout", _chute];
			deleteVehicle _chute;
		};
	};
};

f_main = {
	private ["_camera"];
	_chute = vehicle _para_unit;

	[] call f_steerChute;

	if (! alive _para_unit) then {sleep 10};

	if ((typeOf _camera) == "camera") then {
		_camera camcommand "manual off";
		_camera camcommand "inertia on";
		camdestroy _camera;
	};
};

if ((_this select 0) == vehicle _para_unit) then {[] call f_main};

disableSerialization;
if (!isNil "d_halo_keyhandler") then {(findDisplay 46) displayRemoveEventHandler ["KeyDown",d_halo_keyhandler];d_halo_keyhandler = nil};