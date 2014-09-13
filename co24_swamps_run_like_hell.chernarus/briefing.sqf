/*
  *	Unofficial Zeus Briefing Template v0.01
  *
  *
  *	Notes: 
  *		- Use the tsk prefix for any tasks you add. This way you know what the varname is for by just looking at it, and 
  *			aids you in preventing using duplicate varnames.
  *		- To add a newline: 		<br/>
  *		- To add a marker link:	<marker name='mkrObj1'>attack this area!</marker>
  *		- To add an image: 		<img image='somePic.jpg'/>
  *
  *		Required briefing commands:		
  *		- Create Note:			player createDiaryRecord ["Diary", ["*The Note Title*", "*The Note Message*"]]; 
  *		- Create Task:			tskExample = player createSimpleTask ["*The Task Title*"];
  *		- Set Task Description:	tskExample setSimpleTaskDescription ["*Task Message*", "*Task Title*", "*Task HUD Title*"];
  *		
  *		Optional briefing commands:
  * 		- Set Task Destination:	tskExample setSimpleTaskDestination (getMarkerPos "mkrObj1"); // use existing "empty marker" 
  *		- Set the Current Task:	player setCurrentTask tskExample;
  *		
  *		Commands to use in-game:
  *		- Set Task State:		tskExample setTaskState "SUCCEEDED";   // states: "SUCCEEDED"  "FAILED"  "CANCELED" 
  *		- Get Task State:		taskState tskExample;
  *		- Get Task Description:	taskDescription tskExample;   // returns the *task title* as a string
  *		- Show Task Hint:		[tskExample] call mk_fTaskHint; // make sure you've set the taskState before using this function 
  *							
  *
  *	Authors: Jinef & mikey
  */

// since we're working with the player object here, make sure it exists
waitUntil { !isNil {player} };
waitUntil { player == player };
 
//player createDiaryRecord ["Diary", ["*The Note Title*", "*The Note Message*"]];

checkpoint1 = player createSimpleTask["Reach Checkpoint 1"];
checkpoint1 setSimpleTaskDescription ["Pass through the checkpoint", "Checkpoint 1", "1"];
checkpoint1 setSimpleTaskDestination (getMarkerPos "Checkpoint1");
if (checkpoint1_var) then {checkpoint1 setTaskState "SUCCEEDED";};
if (!checkpoint1_var) then {player setCurrentTask checkpoint1;};

checkpoint2 = player createSimpleTask["Reach Checkpoint 2"];
checkpoint2 setSimpleTaskDescription ["Pass through the checkpoint", "Checkpoint 2", "2"];
checkpoint2 setSimpleTaskDestination (getMarkerPos "Checkpoint2");
if (checkpoint2_var) then {checkpoint2 setTaskState "SUCCEEDED";};

checkpoint3 = player createSimpleTask["Reach Checkpoint 3"];
checkpoint3 setSimpleTaskDescription ["Pass through the checkpoint", "Checkpoint 3", "3"];
checkpoint3 setSimpleTaskDestination (getMarkerPos "Checkpoint3");
if (checkpoint3_var) then {checkpoint3 setTaskState "SUCCEEDED";};

checkpoint4 = player createSimpleTask["Reach Checkpoint 4"];
checkpoint4 setSimpleTaskDescription ["Pass through the checkpoint", "Checkpoint 4", "4"];
checkpoint4 setSimpleTaskDestination (getMarkerPos "Checkpoint4");
if (checkpoint4_var) then {checkpoint4 setTaskState "SUCCEEDED";};

checkpoint5 = player createSimpleTask["Reach Checkpoint 5"];
checkpoint5 setSimpleTaskDescription ["Pass through the checkpoint", "Checkpoint 5", "5"];
checkpoint5 setSimpleTaskDestination (getMarkerPos "Checkpoint5");
if (checkpoint5_var) then {checkpoint5 setTaskState "SUCCEEDED";};

checkpoint6 = player createSimpleTask["Reach Checkpoint 6"];
checkpoint6 setSimpleTaskDescription ["Pass through the checkpoint", "Checkpoint 6", "6"];
checkpoint6 setSimpleTaskDestination (getMarkerPos "Checkpoint6");
if (checkpoint6_var) then {checkpoint6 setTaskState "SUCCEEDED";};

checkpoint7 = player createSimpleTask["Reach Checkpoint 7"];
checkpoint7 setSimpleTaskDescription ["Pass through the checkpoint", "Checkpoint 7", "7"];
checkpoint7 setSimpleTaskDestination (getMarkerPos "Checkpoint7");
if (checkpoint7_var) then {checkpoint7 setTaskState "SUCCEEDED";};

checkpoint8 = player createSimpleTask["Reach Checkpoint 8"];
checkpoint8 setSimpleTaskDescription ["Pass through the checkpoint", "Checkpoint 8", "8"];
checkpoint8 setSimpleTaskDestination (getMarkerPos "Checkpoint8");
if (checkpoint8_var) then {checkpoint8 setTaskState "SUCCEEDED";};

checkpointBOAT = player createSimpleTask["Reach Extraction Point"];
checkpointBOAT setSimpleTaskDescription ["Reach Extraction Point", "Extraction", "9"];
checkpointBOAT setSimpleTaskDestination (getMarkerPos "extraction_marker");
if (checkpointBOAT_var) then {checkpointBOAT setTaskState "SUCCEEDED";};