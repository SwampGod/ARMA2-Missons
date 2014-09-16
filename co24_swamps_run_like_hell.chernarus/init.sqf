waitUntil {(isDedicated) || !(isNull player)};

player setVariable ["BIS_noCoreConversations", true];

execVM "R3F_revive\revive_init.sqf";



// Execute the mission settings script
[] execVM "mission_settings\init.sqf";
// Force your desired view distance and grass level at the start of the mission
// players can still change it client-side through the script
setViewDistance 2000;
setTerrainGrid 50;

// AHP VARIABLES
//AHP_Debug = False;
AHP_Debug = TRUE;
// INITIALIZE AHP 
_nul = [] execVM "ahp\ahp_init.sqf";


if (isServer) then
{
    _objplaces1 = [checkpoint1mover1, checkpoint1mover2, checkpoint1mover3];
	_random = floor(random count _objplaces1);
    objdest1 = (_objplaces1) select _random;
    PublicVariable "objdest1";
    nul = [Checkpoint1Objects,objdest1,25] execvm "mover.sqf";
	
};
	"Checkpoint1" setmarkerpos (getpos objdest1);
	"checkpoint1NMEspawnlocation" setmarkerpos (getpos objdest1);
	
if (isServer) then
{
    _objplaces2 = [checkpoint2mover1, checkpoint2mover2, checkpoint2mover3, checkpoint2mover4];
	_random = floor(random count _objplaces2);
    objdest2 = (_objplaces2) select _random;
    PublicVariable "objdest2";
    nul = [Checkpoint2Objects,objdest2,25] execvm "mover.sqf";
	
};
	"Checkpoint2" setmarkerpos (getpos objdest2);
	"checkpoint2NMEspawnlocation" setmarkerpos (getpos objdest2);

if (isServer) then
{
    _objplaces3 = [checkpoint3mover1, checkpoint3mover2, checkpoint3mover3, checkpoint3mover4];
	_random = floor(random count _objplaces3);
    objdest3 = (_objplaces3) select _random;
    PublicVariable "objdest3";
    nul = [Checkpoint3Objects,objdest3,25] execvm "mover.sqf";
	
};
	"Checkpoint3" setmarkerpos (getpos objdest3);
	"checkpoint3NMEspawnlocation" setmarkerpos (getpos objdest3);
	
if (isServer) then
{
    _objplaces4 = [checkpoint4mover1, checkpoint4mover2, checkpoint4mover3, checkpoint4mover4, checkpoint4mover5];
	_random = floor(random count _objplaces4);
    objdest4 = (_objplaces4) select _random;
    PublicVariable "objdest4";
    nul = [Checkpoint4Objects,objdest4,25] execvm "mover.sqf";
	
};
	"Checkpoint4" setmarkerpos (getpos objdest4);
	"checkpoint4NMEspawnlocation" setmarkerpos (getpos objdest4);	
	
if (isServer) then
{
    _objplaces5 = [checkpoint5mover1, checkpoint5mover2, checkpoint5mover3, checkpoint5mover4, checkpoint5mover5];
	_random = floor(random count _objplaces5);
    objdest5 = (_objplaces5) select _random;
    PublicVariable "objdest5";
    nul = [Checkpoint5Objects,objdest5,25] execvm "mover.sqf";
	
};
	"Checkpoint5" setmarkerpos (getpos objdest5);
	"checkpoint5NMEspawnlocation" setmarkerpos (getpos objdest5);	
	
if (isServer) then
{
    _objplaces6 = [checkpoint6mover1, checkpoint6mover2, checkpoint6mover3, checkpoint6mover4, checkpoint6mover5, checkpoint6mover6];
	_random = floor(random count _objplaces6);
    objdest6 = (_objplaces6) select _random;
    PublicVariable "objdest6";
    nul = [Checkpoint6Objects,objdest6,25] execvm "mover.sqf";
	
};
	"Checkpoint6" setmarkerpos (getpos objdest6);
	"checkpoint6NMEspawnlocation" setmarkerpos (getpos objdest6);	
		
if (isServer) then
{
    _objplaces7 = [checkpoint7mover1, checkpoint7mover2, checkpoint7mover3, checkpoint7mover4, checkpoint7mover5, checkpoint7mover6];
	_random = floor(random count _objplaces7);
    objdest7 = (_objplaces7) select _random;
    PublicVariable "objdest7";
    nul = [Checkpoint7Objects,objdest7,25] execvm "mover.sqf";
	
};
	"Checkpoint7" setmarkerpos (getpos objdest7);
	"checkpoint7NMEspawnlocation" setmarkerpos (getpos objdest7);
		
if (isServer) then
{
    _objplaces8 = [checkpoint8mover1, checkpoint8mover2, checkpoint8mover3, checkpoint8mover4, checkpoint8mover5, checkpoint8mover6, checkpoint8mover7];
	_random = floor(random count _objplaces8);
    objdest8 = (_objplaces8) select _random;
    PublicVariable "objdest8";
    nul = [Checkpoint8Objects,objdest8,25] execvm "mover.sqf";
	
};
	"Checkpoint8" setmarkerpos (getpos objdest8);
	"checkpoint8NMEspawnlocation" setmarkerpos (getpos objdest8);


hintC "You can teleport to vehicles using the flagpole at spawn. Checkpoints DO NOT need to be cleared, only held for 30 seconds.";
	
// START - MURK SPAWN STUFF //
catch_trigger = "none";
Mission_capture = [];
	sleep 10;
	copyToClipboard str(Mission_capture);
// END - MURK SPAWN STUFF //

execVM "briefing.sqf";

// JIP Objective Syncing
if (isNil "checkpoint1_var") then {checkpoint1_var = false};
if (isNil "checkpoint2_var") then {checkpoint2_var = false};
if (isNil "checkpoint3_var") then {checkpoint3_var = false};
if (isNil "checkpoint4_var") then {checkpoint4_var = false};
if (isNil "checkpoint5_var") then {checkpoint5_var = false};
if (isNil "checkpoint6_var") then {checkpoint6_var = false};
if (isNil "checkpoint7_var") then {checkpoint7_var = false};
if (isNil "checkpoint8_var") then {checkpoint8_var = false};


