// by Xeno
#include "x_setup.sqf"
private ["_delay","_disabled","_newveh","_startdir","_startpos","_type","_vehicle"];
if (!isServer) exitWith{};

_vehicle = _this select 0;
_delay = _this select 1;
_startpos = position _vehicle;
_startdir = getDir _vehicle;
_type = typeOf _vehicle;

_vehicle setVariable ["d_vec_islocked", if (locked _vehicle) then {true} else {false}];

while {true} do {
	sleep (_delay + random 15);

	_empty = if ((_vehicle call XfGetAliveCrew) > 0) then {false} else {true};
	
	if (_empty) then {	
		_disabled = if (damage _vehicle > 0.9) then {true} else {false};
		
		if ((_disabled && _empty) || (_empty && !(alive _vehicle))) then {
			_isitlocked = _vehicle getVariable "d_vec_islocked";
			deletevehicle _vehicle;
			_vehicle = objNull;
			sleep 0.5;
			_vehicle = createVehicle [_type, _startpos, [], 0, "NONE"];
			_vehicle setpos _startpos;
			_vehicle setdir _startdir;
			_vehicle setVariable ["d_vec_islocked", _isitlocked];
			if (_isitlocked) then {_vehicle lock true};
#ifndef __ACE__
			if ((getNumber(configFile >> "CfgVehicles" >> _type >> "ARTY_IsArtyVehicle")) == 1) then {
				switch (_type) do {
					case "MLRS": {
						_vehicle removeMagazine "12Rnd_MLRS";
						_vehicle addMagazine "ARTY_12Rnd_227mmHE_M270";
					};
					case "GRAD_RU": {
						_vehicle removeMagazine "40Rnd_GRAD";
						_vehicle addMagazine "ARTY_40Rnd_120mmHE_BM21";
					};
					case "MLRS_DES_EP1": {
						_vehicle removeMagazine "12Rnd_MLRS";
						_vehicle addMagazine "ARTY_12Rnd_227mmHE_M270";
					};
					case "GRAD_TK_EP1": {
						_vehicle removeMagazine "40Rnd_GRAD";
						_vehicle addMagazine "ARTY_40Rnd_120mmHE_BM21";
					};
				};
				["d_bi_a_v", _vehicle] call XNetCallEvent;
			};
#endif
		};
	};
};
