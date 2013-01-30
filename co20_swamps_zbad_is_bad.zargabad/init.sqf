waitUntil {(isDedicated) || !(isNull player)};

player setVariable ["BIS_noCoreConversations", true];

// START - MURK SPAWN STUFF //
catch_trigger = "none";
Mission_capture = [];
	sleep 10;
	copyToClipboard str(Mission_capture);
//	"PROCESSING DONE..." hintC "MISSION CAPTURING IS DONE!!!";

	"TESTING!!!!" hintC "Press 'J' to get objectives!! You can also teleport using the flagpole at spawn.";
// END - MURK SPAWN STUFF //


if (isServer) then
{
	camoDeployed=false;
	publicVariable "camoDeployed";
	camoDeployedBH=false;
	publicVariable "camoDeployedBH";
//	rallyDeployed=false;
//	publicVariable "rallyDeployed";
//	camoDeployedR=false;
//	publicVariable "camoDeployedR";
//	rallyMoved=false;
//	publicVariable "rallyMoved";
};

if (isServer) then
{
    _objplaces = [missionammo1, missionammo2, missionammo3, missionammo4];
	_random = floor(random count _objplaces);
    objdest = (_objplaces) select _random;
    PublicVariable "objdest";
    nul = [ammotruckObjects,objdest,25] execvm "mover.sqf";
	
    _azizobjplaces = [missionaziz1, missionaziz2, missionaziz3];
	_azizrandom = floor(random count _azizobjplaces);
    azizobjdest = (_azizobjplaces) select _random;
    PublicVariable "azizobjdest";
    nul = [azizObjects,azizobjdest,25] execvm "mover.sqf";

    _objplaces2 = [missionFOB1, missionFOB2, missionFOB3, missionFOB4, missionFOB5, missionFOB6];
	_random2 = floor(random count _objplaces2);
    objdest2 = (_objplaces2) select _random2;
    PublicVariable "objdest2";
    nul = [fobobjects,objdest2,75] execvm "mover.sqf";
	
    _objplaces15 = [missionROADBLOCK1, missionROADBLOCK2, missionROADBLOCK3, missionROADBLOCK4, missionROADBLOCK5];
	_random15 = floor(random count _objplaces15);
    objdest15 = (_objplaces15) select _random15;
    PublicVariable "objdest15";
    nul = [ROADBLOCKobjects,objdest15,75] execvm "mover.sqf";
};
"obj_ROADBLOCK" setmarkerpos (getpos objdest15);
"FOB" setmarkerpos (getpos objdest2);
"obj_FOB" setmarkerpos (getpos objdest2);
"FOB_DUDES" setmarkerpos (getpos objdest2);
"obj_2" setmarkerpos (getpos azizobjdest);
"obj_2_patrol" setmarkerpos (getpos azizobjdest);   
"obj_1" setmarkerpos (getpos objdest);
"obj_1_patrol" setmarkerpos (getpos objdest);

// Execute the mission settings script
[] execVM "mission_settings\init.sqf";
// Force your desired view distance and grass level at the start of the mission
// players can still change it client-side through the script
setViewDistance 2000;
setTerrainGrid 50;

// AHP VARIABLES
AHP_Debug = False;
// INITIALIZE AHP 
_nul = [] execVM "ahp\ahp_init.sqf";

/* Initialises the revive script */
server execVM "revive_init.sqf";



execVM "briefing.sqf";




[] spawn {
  while {not isnull ScudA} do { "SKUDA" setmarkerpos getpos ScudA; sleep 5; };
};
[] spawn {
  while {not isnull ScudB} do { "SKUDB" setmarkerpos getpos ScudB; sleep 5; };
};
[] spawn {
  while {not isnull ScudC} do { "SKUDC" setmarkerpos getpos ScudC; sleep 5; };
};
[] spawn {
  while {not isnull ScudD} do { "SKUDD" setmarkerpos getpos ScudD; sleep 5; };
};

// JIP Objective Syncing
if (isNil "obj_1_var") then {obj_1_var = false};
if (isNil "obj_2_var") then {obj_2_var = false};
if (isNil "obj_3_var") then {obj_3_var = false};
if (isNil "obj_4_var") then {obj_4_var = false};
if (isNil "obj_5_var") then {obj_5_var = false};
if (isNil "obj_6_var") then {obj_6_var = false};
if (isNil "obj_7_var") then {obj_7_var = false};
if (isNil "obj_8_var") then {obj_8_var = false};
if (isNil "obj_9_var") then {obj_9_var = false};
if (isNil "obj_10_var") then {obj_10_var = false};
if (isNil "obj_11_var") then {obj_11_var = false};
if (isNil "obj_12_var") then {obj_12_var = false};
if (isNil "obj_13_var") then {obj_13_var = false};
if (isNil "obj_14_var") then {obj_14_var = false};
if (isNil "obj_15_var") then {obj_15_var = false};
