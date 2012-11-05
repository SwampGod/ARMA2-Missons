#include "x_setup.sqf"
/*********************************
 mando_heliroute_arma.sqf v1.3
 August 2009 Mandoble 
 
 Moves a chopper accurately to the desired destination point following the indicated route and land it if so indicated.
**********************************/

private["_heli", "_route", "_endpos", "_height", "_landing ", "_pilot", "_i", "_j", "_pos", "_dist", "_distold", "_angh", "_dir", "_accel", "_speed", "_steps", "_inipos", "_offset"];

_heli = _this select 0;
_route = _this select 1;
_height = _this select 2;
_landing = _this select 3;

if (!local _heli) exitWith {hint "mando_heliroute: vehicle must be local"};

_pilot = driver _heli;

_heli setVariable ["mando_heliroute", "busy"];

_heli flyinHeight _height;
_pilot doMove [getPos _heli select 0, getPos _heli select 1, _height];
sleep 2;
while {(!unitReady _pilot)&&(alive _pilot)&&(damage _heli < 0.5)} do {sleep 2};
if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {_heli setVariable ["mando_heliroute", "damaged"]};

for "_j" from 0 to (count _route) - 1 do {
	_endpos = _route select _j;
	_inipos = getPos _heli;
	_dist = sqrt(((_endpos select 0) - (_inipos select 0))^2 + ((_endpos select 1) - (_inipos select 1))^2);
	_steps = _dist / 3000;
	_steps = _steps - (_steps % 1);
	_ang = ((_endpos select 0) - (_inipos select 0)) atan2 ((_endpos select 1) - (_inipos select 1));

	for "_i" from 0 to _steps - 1 do {
		_pos = [(_inipos select 0) + sin(_ang)*3000*_i,(_inipos select 1) + cos(_ang)*3000*_i];
		_pilot doMove _pos;
		sleep 2;

		_offset = if (_i < (_steps - 1)) then {5} else {1};

		while {((sqrt(((_pos select 0) - (getPos _heli select 0))^2 + ((_pos select 1) - (getPos _heli select 1))^2))>500)&&(alive _pilot)&&(damage _heli < 0.5)} do {
			sleep 2;
		};
		if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {};
	};
	if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {};

	_pilot doMove _endpos;
	sleep 2;
	while {((!unitReady _pilot) || (abs(speed _heli) > 1))&&(alive _pilot)&&(damage _heli < 0.5)} do {
		sleep 0.2;
	};
	if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {};
};

while {(abs(vectorUp _heli select 2) < 0.996)&&(alive _pilot)&&(damage _heli < 0.5)} do {
	sleep 0.2;
};

if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {_heli setVariable ["mando_heliroute", "damaged"]};
_pilot doMove [getPos _heli select 0, getPos _heli select 1];

_dist = sqrt(((_endpos select 0) - (getPos _heli select 0))^2 + ((_endpos select 1) - (getPos _heli select 1))^2);
_dir = getDir _heli;

if (_dist > 2) then {
	_pos = _heli worldToModel _endpos;
	_angh = (_pos select 0) atan2 (_pos select 1);
	_dist = sqrt((_pos select 0)^2+(_pos select 1)^2);

	for "_i" from 0 to (abs _angh) - 1 do {
		if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {};
		_heli setDir ((getDir _heli)+abs(_angh)/_angh);
		_heli setVelocity [0,0,0];
		sleep 0.05;
	};  
};
_heli setDir (_dir + _angh);
_dir = getDir _heli;

_distold = 99999;
_dist = 99998;
_speed = 0;
while {(_distold >= _dist) && (alive _pilot) && (damage _heli < 0.5)} do {
	if (_speed < 7) then {_speed = _speed + 0.1};
	_distold = _dist;
	_dist = sqrt(((_endpos select 0) - (getPos _heli select 0))^2 + ((_endpos select 1) - (getPos _heli select 1))^2);
	_heli setVelocity [sin(_dir)*_speed, cos(_dir)*_speed, 0];
	_heli setDir _dir;
	sleep 0.005;
};

if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {_heli setVariable ["mando_heliroute", "damaged"]};

if (_landing) then {
	while {(isEngineOn _heli) && (alive _pilot) && (damage _heli < 0.5)} do {
		if ((getPos _heli select 2) > ((_endpos select 2) + 1)) then {
			_heli setDir _dir;
			if ((getPos _heli select 2) > ((_endpos select 2) + 5)) then {
				_heli setVelocity [0,0,-7];
			} else {
				_heli setVelocity [0,0,7*((getPos _heli select 2)-(_endpos select 2))/-5 min -1];
			};
		} else {
			_pilot action ["ENGINEOFF", _heli];
			_heli setVelocity [0,0,0];
		};
		sleep 0.01;
	};

	for "_i" from 0 to 99 do {
		_heli setVelocity [0,0,-0.1];
		sleep 0.05;
	};

	if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {};

	_heli setVariable ["mando_heliroute", "waiting"];
	while {(alive _pilot) && (damage _heli < 0.5) && ((_heli getVariable "mando_heliroute") == "waiting")} do {
		_pilot action ["ENGINEOFF", _heli];
		sleep 0.01;
	};
} else {
	_heli setVariable ["mando_heliroute", "waiting"];
};

if (!(alive _pilot) || (damage _heli >= 0.5)) exitWith {_heli setVariable ["mando_heliroute", "damaged"]};