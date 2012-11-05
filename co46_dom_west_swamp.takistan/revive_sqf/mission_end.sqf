/*
MISSION END SCRIPT

© JUNE 2009 - norrin
*/
private ["_units", "_no_conscious"]; 

_names_units = _this select 0;
_no_conscious = 0;

sleep 20;

while {true} do {
	_units = [];
	{_units set [count _units, missionNamespace getVariable _x]}forEach _names_units;
	_no_conscious = 0;
	{if (isplayer _x && !(_x getVariable "NORRN_unconscious")) then {_no_conscious = 1}}forEach _units;
	if (_no_conscious == 0) exitWith {
		mission_Over = true;
		publicVariable "mission_Over";
	};
	sleep 5;
};