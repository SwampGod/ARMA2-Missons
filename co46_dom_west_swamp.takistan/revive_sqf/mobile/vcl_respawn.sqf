/*
VECHICLE RESPAWN FOR MOBILE SPAWN ACTION SCRIPT

� norrin, July 2008
*/
if (!isServer) exitWith {};

_vcl = _this select 0;
_respawn_delay = _this select 1; 
_vcl_dir = getDir _vcl;	
_vcl_pos = getPos _vcl;
_type_vcl = typeOf _vcl;

_Base_1 = NORRN_revive_array select 13;
_mobile_base_start = NORRN_revive_array select 52;

waitUntil {!alive _vcl}; 

NORRN_camo_net = false;
publicVariable "NORRN_camo_net";

_wait = time + _respawn_delay;

_vcl removeAction NORRN_l_spawn_act;
_vcl removeAction NORRN_l_remove_spawn_act;

_ammo_crates = nearestObjects [_vcl, ["ReammoBox"], 10];
{deleteVehicle _x} forEach _ammo_crates;
_shed = nearestObject [_vcl, "shedBig"];
deleteVehicle _shed;

waitUntil {time > _wait};
_vcl_new = _type_vcl createVehicle _vcl_pos;
_vcl_new setDir _vcl_dir;
_vcl_new setPos _vcl_pos;
_init = "this setVehicleVarName 'r_mobile_spawn_vcl';this addEventHandler ['GETIN',{if ((_this select 1) == 'driver') then {NORRN_landy_script = [_this select 0, _this select 2] execVM 'revive_sqf\mobile\mobile_spawn.sqf'}}];
this addEventHandler ['GETOUT',{[_this select 0] execVM 'revive_sqf\mobile\mobile_remove_spawn.sqf'}];";

_vcl_new setVehicleInit _init; 
processInitCommands;
[_vcl_new, _respawn_delay] execVM "revive_sqf\mobile\vcl_respawn.sqf";
[_vcl_new, 0]execVM "revive_sqf\mobile\move_spawn.sqf";