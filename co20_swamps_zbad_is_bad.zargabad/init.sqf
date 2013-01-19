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
};
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


// START - MURK SPAWN STUFF //
catch_trigger = "none";
Mission_capture = [];
	sleep 10;
	copyToClipboard str(Mission_capture);
//	"PROCESSING DONE..." hintC "MISSION CAPTURING IS DONE!!!";
	"TESTING!!!!" hintC "This mission is under beta testing.";
// END - MURK SPAWN STUFF //



