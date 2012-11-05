_para_unit = _this select 1;

f_steerChute = {
	_turn = 0;
	_decend = -2;
	_setTurn = 0;
	_currentTurn = 0;
	_speed = 5;
    _speedZ = 30;
	_i = 500;

	while {(position _para_unit select 2 >= 1)} do {

		_oldDir = (getDir _chute);
		_chutePosOld = position _chute;
		_i = _i - 1;
		sleep 0.001;

		_x = ((position _chute) select 0) - (_chutePosOld select 0);
		_y = ((position _chute) select 1) - (_chutePosOld select 1);

		if ((abs _x) > 0.2) then {
			if ((abs (_turn + _x)) < 8) then {
				_turn = _turn + _x;
			};
		};

		if ((abs _y) > 0.2) then {
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

		if (_setTurn != _currentTurn) then {
			_currentTurn = _currentTurn  + (_setTurn - _currentTurn) * 0.01;
		};

		_nDs = sin _newDir; _nDc = cos _newDir;
		_nTs = sin _currentTurn; _nTc = cos _currentTurn;
		(vehicle _para_unit) setVectorDirAndUp [[_nDs,_nDc, 0],[_nDc * _nTs,-_nDs * _nTs,_nTc]];

		 if (_speedZ < 5) then {
			_chute setdir (getdir _chute + (random 0.5));
		};

		if (_i > 1 && position _para_unit select 2 > 50) then {
			_speedZ = _speedZ - 0.08;
		};

		if (_i > 1 && position _para_unit select 2 < 50) then {
			_speedZ = 4;
		};

		if (_speedZ < 4) then {
			_speedZ = 4;
		};

		if ( position _para_unit select 2 <= 5 ) then {
			_speed  = 5;
			_speedZ = 1.5;
		};

		_chute setVelocity [_speed * _nDs + (wind select 0), _speed * _nDc + (wind select 1), - _speedZ];

		if ( position _para_unit select 2 <= 1.5 &&  ((speed _chute) >= 30 )) then {
			_para_unit action [ "eject", _chute];
			_chute animate [ "hide_chute", 1 ];
			deleteVehicle _chute;
			_para_unit setdammage 0.8;
			_para_unit setpos [ getpos _para_unit select 0, getpos _para_unit select 1, 0];   
		};

		if ( position _para_unit select 2 <= 1.5  &&  ((speed _chute) <= 30 )) then {
			_para_unit action [ "eject", _chute];
			_chute animate [ "hide_chute", 1 ];
			deleteVehicle _chute;
			_para_unit setpos [ getpos _para_unit select 0, getpos _para_unit select 1, 0];   
		};

		if ( (position _chute select 2 <= 1.5 ) && (count (crew _chute) == 0) ) then {
			_chute animate [ "hide_chute", 1 ];
			deleteVehicle _chute;
		};
	};
};

f_main = {
	private ["_camera"];
	_chute = vehicle _para_unit;

	[] call f_steerChute;

	if ((typeOf _camera) == "camera") then {
		_camera camcommand "manual off";
		_camera camcommand "inertia on";
		camdestroy _camera;
	};
};

if ((_this select 0) == vehicle _para_unit)then {[] call f_main};
