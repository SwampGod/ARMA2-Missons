/*
// Put the following line in the vehicle you want to make exclusive:
handle = [this, 360, 120, 0, false, false, "this addEventHandler ['GetIn', {_this execVM 'TAWonly.sqf'}];"] execVM "vehicle.sqf"; this addEventHandler ["GetIn", {_this execVM "TAWonly.sqf"}];
*/

//if (isServer) exitWith {};

_vehicle = _this select 0;
_seat = _this select 1;
_player = _this select 2;
_nameCheck = false;
_startFuel = fuel _vehicle;

sleep 0.1;

if (!(local _vehicle) || !(_player == player)) exitWith {hint str _player};

sleep 0.1;
_vehicle setFuel 0;
_vehicle vehicleChat format["Welcome %1!", name _player];

//Debug
//hint format ["%1 got in %2 seat of %3", name _player, _seat, typeOf _vehicle];
//hint str toArray name _player;

if (!(_player in _vehicle))  exitWith {_vehicle setFuel _startFuel;};

_name = toArray name _player;

if ((_name select 0 == 84) && (_name select 1 == 65) && (_name select 2 == 87) && (_name select 3 == 95)) then {
	_nameCheck = true;
	_vehicle vehicleChat "TAW member!";
};

sleep 0.1;
if (!(_player in _vehicle))  exitWith {_vehicle setFuel _startFuel;};

if (_nameCheck) then {
	_vehicle vehicleChat format ["Engine Unlocked: Have a safe flight %1!", name _player];
	_vehicle setFuel _startFuel;
	
} else {
	_vehicle vehicleChat "You are not a TAW member or your identity could not be verified.";
	_vehicle vehicleChat "Join TAW at taw.net to become qualified to fly!";
	moveOut _player;
	_vehicle setFuel _startFuel;	
};
