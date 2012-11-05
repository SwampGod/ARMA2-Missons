// by Xeno
#include "x_setup.sqf"
private ["_fac", "_index"];
if (!isServer) exitWith {};

_fac = _this select 0;
_index = _this select 1;

deleteVehicle _fac;

switch (_index) do {
	case 0: {
		["d_jet_serviceH",true] call XNetSetJIP;
		["d_jet_sf"] call XNetCallEvent;
		d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"JetServiceDestroyed",true];
	};
	case 1: {
		["d_chopper_serviceH",true] call XNetSetJIP;
		["d_chop_sf"] call XNetCallEvent;
		d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"ChopperServiceDestroyed",true];
	};
	case 2: {
		["d_wreck_repairH",true] call XNetSetJIP;
		["d_wreck_rf"] call XNetCallEvent;
		d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"WreckServiceDestroyed",true];
	};
};