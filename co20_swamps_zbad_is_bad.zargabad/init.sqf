waitUntil {(isDedicated) || !(isNull player)};

if (isServer) then
{
	camoDeployed=false;
	publicVariable "camoDeployed";
	camoDeployedBH=false;
	publicVariable "camoDeployedBH";
//	rallyDeployed=false;
//	publicVariable "rallyDeployed";
	camoDeployedR=false;
	publicVariable "camoDeployedR";
//	rallyMoved=false;
//	publicVariable "rallyMoved";
};

if (isServer) then
{
    _objplaces = [missionammo1, missionammo2, missionammo3];
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
	

};
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
AHP_Debug = TRUE;
// INITIALIZE AHP 
_nul = [] execVM "ahp\ahp_init.sqf";

/* Initialises the revive script */
server execVM "revive_init.sqf";

execVM "briefing.sqf";

player setVariable ["BIS_noCoreConversations", true];

// START - MURK SPAWN STUFF //
catch_trigger = "none";
Mission_capture = [];
	sleep 10;
	copyToClipboard str(Mission_capture);
//	"PROCESSING DONE..." hintC "MISSION CAPTURING IS DONE!!!";

	"TESTING!!!!" hintC "Press 'J' to get objectives!!";
// END - MURK SPAWN STUFF //


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


