/*
		Random House Patrol Script v1.1
                        for Arma 2
		    by Tophe of Östgöta Ops [OOPS]
*/

if (!isServer) exitWith {};

private ["_unit", "_beh", "_wtime", "_position", "_house", "_y", "_t", "_timeout", "_notbugged", "_name", "_pospat", "_counter", "_leader"];

_unit = _this select 0;
if (!alive _unit) exitWith {};
_beh = if (count _this > 1) then {_this select 1} else {"SAFE"};
_wtime = if (count _this > 2) then {_this select 2} else {40};
if (_wtime < 11) then {_wtime = 40}; 

_position = getPos _unit;
_house = nearestObject [_unit, "House"];
if (isNull _house) exitWith {_unit setVariable ["d_hpatrol", false];};
_x = 0;
_y = 0;
_t = 0;
_timeout = 0;
_notbugged = true;
_name = vehicleVarName _unit;
if (isNil _name) then {_name = "guard"};

while {str(_house buildingPos _x) != "[0,0,0]"} do {_x = _x + 1};
if (_x == 0) exitWith {_unit setVariable ["d_hpatrol", false];};
if (_beh in ["CARELESS","SAFE","AWARE","COMBAT","STEALTH"]) then {
	_unit setBehaviour _beh
} else {
	_unit setBehaviour "SAFE"
};
_x = _x - 1;
_unit doMove (_house buildingPos (random _x));
_timeout = time + 80;
waitUntil {moveToCompleted _unit || moveToFailed _unit || !alive _unit || _timeout < time};

_pospat = (ceil (random _x)) max 2;
_counter = 0;
while {alive _unit && _counter <= _pospat} do {
	_y = random _x;
	_t = random (_wtime) max 10;
	_unit doMove (_house buildingPos _y);
	sleep 0.5;
	_timeout = time + 80;
	waitUntil {moveToCompleted _unit || moveToFailed _unit || !alive _unit || _timeout < time};
	sleep _t;
	_counter = _counter + 1;
};

if (alive _unit) then {
	_leader = leader _unit;
	if (_leader != _unit) then {
		_unit doFollow _leader;
	};
	_unit setVariable ["d_hpatrol", false];
};