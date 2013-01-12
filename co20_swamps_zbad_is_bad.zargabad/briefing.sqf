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
 
player createDiaryRecord ["Diary", ["*The Note Title*", "*The Note Message*"]];
 
tskobj_3 = player createSimpleTask["The the Palace"];
tskobj_3 setSimpleTaskDescription ["Clear all enemy from the palace.", "Clear the Palace", "Government Palace"];
tskobj_3 setSimpleTaskDestination (getMarkerPos "obj_3");
 
tskobj_2 = player createSimpleTask["Kill Col. Aziz"];
tskobj_2 setSimpleTaskDescription ["We have intellegence that Col. Aziz is Zargabad. He must be eliminated.", "Kill Col. Aziz", "Possible Location of Aziz"];
tskobj_2 setSimpleTaskDestination (getMarkerPos "obj_2");
 
tskobj_1 = player createSimpleTask["Destroy Ammunition Depot"];
tskobj_1 setSimpleTaskDescription ["Destroy all enemy ammunition reserves at this location... trucks, creates and containers.", "Ammo Truck go BOOM!", "Ammo Depot"];
tskobj_1 setSimpleTaskDestination (getMarkerPos "obj_1");