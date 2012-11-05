// by Xeno
#include "x_setup.sqf"
private ["_mhq", "_depltime", "_depl", "_camotype", "_camo"];
if (!X_Client) exitWith {};

if (!alive player) exitWith {};
if (isNil "d_curvec_dialog") exitWith {};
if (isNull d_curvec_dialog) exitWith {};
if (!alive d_curvec_dialog) exitWith {};
#ifdef __ACE__
if (!(if (!isNil {d_curvec_dialog getVariable "ace_canmove"}) then {d_curvec_dialog call ace_v_alive} else {true})) exitWith {
	"Vehicle destroyed!!!" call XfGlobalChat
};
#endif

_isthere = true;
_nmhq = nearestObject [player, "LandVehicle"];
_vty = _nmhq getVariable "d_vec_type";
if (isnil "_vty") then {_vty = ""};
if (_vty != "MHQ") then {_isthere = false};
if ((vehicle player) in (list d_base_trigger) && _isthere) exitWith {"You can't deploy a MHQ at base!!!" call XfGlobalChat};

if (surfaceIsWater (position d_curvec_dialog)) exitWith {"You can't deploy a MHQ here!!!" call XfGlobalChat};

_mhq = d_curvec_dialog;

_depltime = [_mhq, "D_MHQ_Depltime", -1] call XfGetVar;

if (_depltime > time) exitWith {"Wait a few seconds before you can deploy/undeploy the MHQ again!" call XfGlobalChat};

_depl = [_mhq, "D_MHQ_Deployed", false] call XfGetVar;
if (!_depl) then {
	_camotype = switch (playerSide) do {
#ifndef __OA__
		case west: {"Land_CamoNetB_NATO"};
		case east: {"Land_CamoNetB_EAST"};
#else
		case west: {"Land_CamoNetB_NATO_EP1"};
		case east: {"Land_CamoNetB_EAST_EP1"};
#endif
	};
	_camo = createVehicle [_camotype, position _mhq, [], 0, "NONE"];
	_camo setPos position _mhq;
	_camo setDir direction _mhq;
	_mhq setVariable ["D_MHQ_Deployed", true, true];
	_mhq setVariable ["D_MHQ_Camo", _camo, true];
	["d_mhqdepl", [_mhq, true]] call XNetCallEvent;
	_mhq setVariable ["D_MHQ_Depltime", time + 10, true];
} else {
	_camo = [_mhq, "D_MHQ_Camo", objNull] call XfGetVar;
	if (!isNull _camo) then {deleteVehicle _camo};
	_mhq setVariable ["D_MHQ_Deployed", false, true];
	["d_mhqdepl", [_mhq, false]] call XNetCallEvent;
	_mhq setVariable ["D_MHQ_Depltime", time + 10, true];
};