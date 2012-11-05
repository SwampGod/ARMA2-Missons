#define THIS_FILE "init.sqf"
diag_log format ["############################# %1 #############################", missionName];
diag_log [diag_frameno, diag_ticktime, time, "Executing Dom init.sqf"];

#include "x_setup.sqf"

// just a check to prevent init.sqf running more than once
// shouldn't happen, but we want to be sure :)
if (!isNil QGVAR(init_started)) exitWith {
	diag_log [diag_frameno, diag_ticktime, time, "Dom init.sqf executed more than once"];
};
GVAR(init_started) = true;

if (!isDedicated && isMultiplayer) then {
	enableRadio false;
	0 fadeSound 0;
	titleText ["", "BLACK FADED"];
};

if (!isDedicated) then {
	onPreloadFinished {GVAR(preloaddone) = true; onPreloadFinished {}};
};

enableSaving [false,false];
enableTeamSwitch false;

#ifdef __A2ONLY__
GVAR(a2only) = true;
#endif

#ifdef __ACE__
if (isServer) then {
	ace_sys_aitalk_enabled = true;
	publicVariable "ace_sys_aitalk_enabled";
	ace_sys_aitalk_radio_enabled = true;
	publicVariable "ace_sys_aitalk_radio_enabled";
	ace_sys_tracking_markers_enabled = false;
	publicVariable "ace_sys_tracking_markers_enabled";
	ace_sys_repair_default_tyres = true;
	publicVariable "ace_sys_repair_default_tyres";
};
#endif

// process d_init in one frame
GVAR(init_obj) = "HeliHEmpty" createVehicleLocal [0, 0, 0];
GVAR(init_obj) addEventHandler ["killed", {__ccppfln(d_init.sqf);deleteVehicle GVAR(init_obj)}];
GVAR(init_obj) setDamage 1;

diag_log [diag_frameno, diag_ticktime, time, "Dom init.sqf processed"];
