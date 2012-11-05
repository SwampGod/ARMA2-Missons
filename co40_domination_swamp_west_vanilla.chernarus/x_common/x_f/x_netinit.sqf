// by Xeno
#define THIS_FILE "x_netinit.sqf"
#include "x_setup.sqf"

GVAR(event_holder) = GVAR(HeliHEmpty) createVehicleLocal [0, 0, 0];

// multiple events per type
FUNC(NetAddEvent) = {
	private ["_a", "_ea"];
	_a = switch (_this select 0) do {
		case 0: {true}; // all
		case 1: {isServer}; // server only
		case 2: {X_Client}; // client only
		case 3: {isDedicated}; // dedicated only
		case 4: {!isServer}; // client only, 2
	};
	if (_a) then {
		_ea = GVAR(event_holder) getVariable (_this select 1);
		if (isNil "_ea") then {_ea = []};
		_ea set [count _ea, _this select 2];
		GVAR(event_holder) setVariable [_this select 1, _ea];
	};
};

FUNC(NetRemoveEvent) = {
	if (!isNil {GVAR(event_holder) getVariable _this}) then {GVAR(event_holder) setVariable [_this, nil]};
};

FUNC(NetRunEvent) = {
	private ["_ea", "_p", "_pa"];
	_ea = GVAR(event_holder) getVariable (_this select 0);
	if (!isNil "_ea") then {
		_pa = _this select 1;
		if (!isNil "_pa") then {
			{_pa call _x} forEach _ea;
		} else {
			{call _x} forEach _ea;
		};
	};
};

FUNC(NetCallEvent) = {
	GVAR(negl) = _this; publicVariable QGVAR(negl);
	_this call FUNC(NetRunEvent);
};

XNetCallEvent = FUNC(NetCallEvent);

QGVAR(negl) addPublicVariableEventHandler {
	(_this select 1) call FUNC(NetRunEvent);
};

FUNC(NetSetJIP) = {
	__XJIPSetVar [_this select 0,_this select 1,true];
};

/////////////////////////////////////
// Local events

FUNC(LocalCallEvent) = {
	_this call FUNC(NetRunEvent);
};
