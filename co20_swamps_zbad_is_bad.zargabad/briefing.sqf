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


tskobj_16 = player createSimpleTask["Destroy the Radar"];
tskobj_16 setSimpleTaskDescription ["Destroy the Radar site near the Dam.", "Destroy Radar", "Radar"];
tskobj_16 setSimpleTaskDestination (getMarkerPos "obj_RADAR");
if (obj_16_var) then {tskobj_16 setTaskState "SUCCEEDED";};

tskobj_15 = player createSimpleTask["Clear the Road Block"];
tskobj_15 setSimpleTaskDescription ["Destroy all containers and armor at the road block.", "Clear Road Block", "Road Block"];
tskobj_15 setSimpleTaskDestination (getMarkerPos "obj_ROADBLOCK");
if (obj_15_var) then {tskobj_15 setTaskState "SUCCEEDED";};

tskobj_14 = player createSimpleTask["Recapture Forward Operations Base"];
tskobj_14 setSimpleTaskDescription ["Destroy all enemy forces and recapture our Forward Operations Base.", "Capture FOB", "FOB"];
tskobj_14 setSimpleTaskDestination (getMarkerPos "obj_FOB");
if (obj_14_var) then {tskobj_14 setTaskState "SUCCEEDED";};

tskobj_13 = player createSimpleTask ["Find evidence"];
tskobj_13 setSimpleTaskDescription ["Our agent left the evidence in a blue folder near his bed. Recover the documents.", "Find evidence.", "Search for Evidence"];
tskobj_13 setSimpleTaskDestination (getMarkerPos "obj_13_marker");
if (obj_13_var) then {tskobj_13 setTaskState "SUCCEEDED";};

tskobj_12 = player createSimpleTask["Destroy Radio Tower"];
tskobj_12 setSimpleTaskDescription ["Cut the enemys communications ability. Target the airfield radio tower.", "Destroy Radio Tower", "Location of Radio Tower"];
tskobj_12 setSimpleTaskDestination (getMarkerPos "obj_12_marker");
if (obj_12_var) then {tskobj_12 setTaskState "SUCCEEDED";};

tskobj_11 = player createSimpleTask["Destroy Oil Well"];
tskobj_11 setSimpleTaskDescription ["Destroy the oil well.", "Destroy Oil Well", "Location of Oil wells"];
tskobj_11 setSimpleTaskDestination (getMarkerPos "obj_11_marker");
if (obj_11_var) then {tskobj_11 setTaskState "SUCCEEDED";};

tskobj_10 = player createSimpleTask["Destroy Oil Well"];
tskobj_10 setSimpleTaskDescription ["Destroy the oil well.", "Destroy Oil Well", "Location of Oil wells"];
tskobj_10 setSimpleTaskDestination (getMarkerPos "obj_10_marker");
if (obj_10_var) then {tskobj_10 setTaskState "SUCCEEDED";};

tskobj_9 = player createSimpleTask["Destroy Oil Well"];
tskobj_9 setSimpleTaskDescription ["Destroy the oil well.", "Destroy Oil Well", "Location of Oil wells"];
tskobj_9 setSimpleTaskDestination (getMarkerPos "obj_9_marker");
if (obj_9_var) then {tskobj_9 setTaskState "SUCCEEDED";};

tskobj_8 = player createSimpleTask["Destroy Oil Well"];
tskobj_8 setSimpleTaskDescription ["Destroy the oil well.", "Destroy Oil Well", "Location of Oil wells"];
tskobj_8 setSimpleTaskDestination (getMarkerPos "obj_8_marker");
if (obj_8_var) then {tskobj_8 setTaskState "SUCCEEDED";};

tskobj_7 = player createSimpleTask["Hunt Down Scud Launcher Delta"];
tskobj_7 setSimpleTaskDescription ["Hunt Down Scud Launcher Delta.", "Kill Delta", "Scud Delta"];
//tskobj_7 setSimpleTaskDestination (getMarkerPos "SKUDD");
if (obj_7_var) then {tskobj_7 setTaskState "SUCCEEDED";};

tskobj_6 = player createSimpleTask["Hunt Down Scud Launcher Charlie"];
tskobj_6 setSimpleTaskDescription ["Hunt Down Scud Launcher Charlie.", "Kill Charlie", "Scud Charlie"];
//tskobj_6 setSimpleTaskDestination (getMarkerPos "SKUDC");
if (obj_6_var) then {tskobj_6 setTaskState "SUCCEEDED";};

tskobj_5 = player createSimpleTask["Hunt Down Scud Launcher Beta"];
tskobj_5 setSimpleTaskDescription ["Hunt Down Scud Launcher Beta.", "Kill Beta", "Scud Beta"];
//tskobj_5 setSimpleTaskDestination (getMarkerPos "SKUDB");
if (obj_5_var) then {tskobj_5 setTaskState "SUCCEEDED";};

tskobj_4 = player createSimpleTask["Hunt Down Scud Launcher Alpha"];
tskobj_4 setSimpleTaskDescription ["Hunt Down Scud Launcher Alpha.", "Kill Alpha", "Scud Alpha"];
//tskobj_4 setSimpleTaskDestination (getMarkerPos "SKUDA");
if (obj_4_var) then {tskobj_4 setTaskState "SUCCEEDED";};

tskobj_3 = player createSimpleTask["The Palace"];
tskobj_3 setSimpleTaskDescription ["Clear all enemy from the palace.", "Clear the Palace", "Government Palace"];
tskobj_3 setSimpleTaskDestination (getMarkerPos "obj_3");
if (obj_3_var) then {tskobj_3 setTaskState "SUCCEEDED";};

tskobj_2 = player createSimpleTask["Kill Col. Aziz"];
tskobj_2 setSimpleTaskDescription ["We have intellegence that Col. Aziz is Zargabad. He must be eliminated.", "Kill Col. Aziz", "Possible Location of Aziz"];
tskobj_2 setSimpleTaskDestination (getMarkerPos "obj_2");
if (obj_2_var) then {tskobj_2 setTaskState "SUCCEEDED";};

tskobj_1 = player createSimpleTask["Destroy Ammunition Depot"];
tskobj_1 setSimpleTaskDescription ["Destroy all enemy ammunition reserves at this location... trucks, creates and containers.", "Ammo Truck go BOOM!", "Ammo Depot"];
tskobj_1 setSimpleTaskDestination (getMarkerPos "obj_1");
if (obj_1_var) then {tskobj_1 setTaskState "SUCCEEDED";};