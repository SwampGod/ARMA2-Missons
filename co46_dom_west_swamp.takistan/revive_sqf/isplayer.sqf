/*
ISPLAYER SCRIPT

© JULY 2009 - norrin 
*/
if (!isServer) exitWith {};

_names_units = _this select 0;
_units = [];
_AI_disabled = getNumber(missionConfigFile >> "disabledAI");

sleep 10;

while {true} do {
	{_ur = missionNamespace getVariable _x;if (!isNull _ur && !(_ur in _units)) then {_units set [count _units, _ur]}} forEach _names_units;
	{
		if (!alive _x) then {
			_mrkr = format ["%1 is down", _x];
			if (str(markerPos _mrkr) != "[0,0,0]") then {
				_units = _units - [_x];
				deleteMarker _mrkr;
				if (_AI_disabled == 1) then {
					if (!isNull _x && !isPlayer _x) then {deleteVehicle _x};
				};
			};
		};
		sleep 0.01;
	} forEach _units;
	sleep 1;
};
