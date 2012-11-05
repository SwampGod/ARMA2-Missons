// unLoad_act.sqf
// JUNE 2009 - norrin
private ["_args","_dragger","_vcl","_wounded"];
_args = _this select 3;
_name = _args select 0;
_vcl = _args select 1;
_crewVcl = _args select 2;

_name removeAction NORRN_pullOutAction;

{
	_unit = _x;

	if (_unit getVariable "NORRN_AIunconscious") then {
		unassignVehicle _unit;
		sleep 0.05;
		_unit action ["EJECT", _vcl];
		sleep 1;
		["swmunc", _unit] call RNetCallEvent;
		_unit setVariable ["NORRN_unit_dragged", false, true];
	};
	sleep 0.1;
} forEach _crewVcl;