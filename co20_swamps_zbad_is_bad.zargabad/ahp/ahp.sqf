/*
A D V A N C E D   H O U S E   P A T R O L   S C R I P T
B Y
HAROON1992 
version :  0.9
*/

/*
------------------------GETTING STARTED------------------------
Initialize by putting the below code into init.sqf/sqs :
_nul = [] execVM "ahp\ahp_init.sqf";

Start with the below sample : 
[<group>,<buildings array>,[<min waitTime>,<max  waitTime>],<Repeating>,[<building patrolmode>,<bpos patrolmode>],<chance  to patrol outside>,<debug hint>,<black list>] spawn AHP;

------------------------IMPORTANT NOTE!------------------------


*/





if (not isServer) exitWith {};

//Arguments Array
private ["_grp","_bArray","_MinWaitSec","_MaxWaitSec","_Repeat","_modeB","_modeBPos","_outsides","_debugOn","_blackList"];
//Other Variables
private ["_behav","_spdMd","_GrpDetectedEnemy","_r","_bx","_i","_aUnit","_radiusToFind","_unitsInGrp","_cB","_cBP","_cBParray","_cDest","_DoHousePatrol","_deadUnits","_DeadBodyDetected","_GRPmoving","_LdPos","_isStuck"];
//Debugging
private ["_InstanceIndex"];

sleep 1 + random 2;
waitUntil {NOT (isNil "AHP_InitDone")};
waitUntil {AHP_InitDone};

// = = = = = = = = = = = = = = = = = = = = = = = = = = =  
//	DEFAULT  VALUES  FOR  ARGUMENTS
// = = = = = = = = = = = = = = = = = = = = = = = = = = = 

// NOTE : These are just default values! You CAN STILL define them as you like in the editor.
// Changing the values here WILL AFFECT ALL group running AHP with default values.

// buildings array ([200] means ALL enterable blds within 200 meter of leader of group will be in bld.array)
_bArray = [200]; 

// Min seconds to wait at each stop
_MinWaitSec = 5;

 // Max seconds to wait at each stop
_MaxWaitSec = 60;

// Repeating (Default is Repeat 15 times)
_Repeat = 15;

 // patrol mode for building ( 0 = random, 1 = sequentially, 2 = reverse order of b.array)
_modeB = 1;

// patrol mode for building pos (0 = random, 1 = sequentially, 2 = reverse order of b.pos
//(if 10 pos present in bld. start b.pos will be 10 and last will be 1)
_modeBPos = 1; 

// chance to patrol outside ( 0 = no chance, 1 = 100 percent chance)
_outsides = 0.25; 

 // debug hint
_debugOn = FALSE;

// black listed types of buildings (letters are NOT case sensitive, you can type "LAnD_wAtER_TOwEr" and it will work.
if ("CAManBase" counttype units (_this select 0) >= 2) then
{
	// value when group has more than 2 infantry units
	_blackList = ["Land_Water_Tower","Land_Vez"]; 
}else
{
	// value when group has only 1 or 2 guys.
	_blackList = []; 
};	
/*
	Note :
	Land_Water_Tower : water tower without border fences at the top.
	Land_Vez : watch towers at the military bases.
	The problem of these buildings is :
	if group has many units, all units will try to climb the ladder and half of them will drop to ground and die.*/

// Alterable Vars

_behav = "SAFE";// Default Behaviour
_spdMd = "LIMITED";// Default SpeedMode



/*

SETTING BEHAVIOUR AND SPEEDMODE 

Behaviour :

leader groupName setVariable ["AHP_Behaviour",value];

(value can be : "SAFE","AWARE","STEALTH","COMBAT","CARELESS")

SpeedMode :

leader groupName setVariable ["AHP_SpeedMode",value];

(value can be : "LIMITED","NORMAL","FULL")

**CAUTION**
Type in UPPERCASE!  > things like "limited" will possibly NOT work

NOTE :
It's not a must, just optional. If not defined/set, default values will be used.
The default for behaviour is : "SAFE" and that of speedMode is : "LIMITED"
*/



/* !!!!!!!!!!!!!!!!!!
NOTHING BELOW SHOULD BE EDITED 
WITHOUT PROPER EXPERIENCE OR 
IF YOU AREONLY PLANNING TO USE AHP IN YOUR MISSION
 !!!!!!!!!!!!!!!!!! */
 
 // You can modify this as you like and use it in your mission. 
 // Just make sure to include the original author in credits.
  
 
// = = = = = = = = = = = = = = = = = = = = = = = = = = = 
// 	OTHER VARIABLE DECLARATIONS
// = = = = = = = = = = = = = = = = = = = = = = = = = = = 


//Number
_InstanceIndex = 0;
_isStuck = 0;
_aUnit = 0;
_radiusToFind = 0; // the first element of bld.array (assigned only if its a number)
_i = 0;
_r = 0;
_bx = -1;
_cBP = 0; // current building pos

//Array

_LdPos = []; // leader's position ( used to avoid Stuck)
_unitsInGrp = []; // units in group (used to check if a member dies)
_deadUnits =[];
_cBParray = []; // building pos array of current building
_cDest = []; // current destination

//Boolean
_GRPmoving = FALSE;
_DeadBodyDetected = FALSE;
_DoHousePatrol = TRUE;
_GrpDetectedEnemy = FALSE;

//String\Object
_cB = "";// current building


// = = = = = = = = = = = = = = = = = = = = = = = = = = =  

// A R G U M E N T S 

// = = = = = = = = = = = = = = = = = = = = = = = = = = = 

// 1st : Group (group)
_grp = _this select 0;


// 2nd : Buildings Array (array >> n elements)
if (count _this > 1) then { _bArray =_this select 1};

// 3rd : Min Wait Time and Max Wait Time (array >> 2 elements)
if (count _this > 2) then
{
	if (count (_this select 2) == 2) then
	{
		_minwaitsec = (_this select 2) select 0;
		_maxwaitsec = (_this select 2) select 1;
		}else
		{
			if (count (_this select 2) == 1) then 
			{
				_minWaitSec = (_this select 2) select 0;
			};
		};
};
// 4th : Repeating (boolean)
if (count _this > 3) then {_Repeat =  _this select 3};

// 5th : Patrol Mode (array >> 2 elements)
if (count _this > 4) then
{
	if (typeName (_this select 4) == "ARRAY") then
	{
		if (count (_this select 4) == 1) then
		{
		 _modeB = (_this select 4) select 0;
		 _modeBpos = (_this select 4) select 1;
		 };
		if (count (_this select 4) == 2) then
		{
		 _modeB = (_this select 4) select 0;
		 _modeBpos = (_this select 4) select 1;
		 };
	};
};

// 6th : Chance to patrol outside of bld. (number >> 0~1)
if (count _this > 5) then {_outsides = _this select 5};

// 7th : Debug Hint (boolean)
if (count _this > 6) then {_deBugOn = _this select 6};

// 8th : Building Type BlackList (array >> n elements)
if (count _this > 7) then {_blackList = _this select 7};

// = = = = = = = = = = = = = = = = = = = = = = = = = = = 



_unitsInGrp = units _grp;

if (NOT (vehicle (leader _grp) isKindOf "CAManBase")) exitWith {};

if (_MinWaitSec > _MaxWaitSec) then 
{
	_MaxWaitSec = _MinWaitSec*2;
};
_MinWaitSec = abs (_MinWaitSec);
_MaxWaitSec = abs (_MaxWaitSec);
if (isPlayer (leader _grp)) exitWith {};

if (_grp in AHP_Groups) exitWith
{
	if (_debugOn) then
	{
		hint "Group is ALREADY on AHP, this instance is terminated!";
	};
	if (AHP_Debug) then
	{
		(leader _grp) globalChat format ["Inst %1 > Group is already on 'AHP'. This instance is terminated!",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)]];			
	};
};

if (_DeBugOn) then {(leader _grp) setVariable ["AHP_DebugOn",TRUE]};

//Add group to global variable
AHP_Groups = AHP_Groups + [_grp];

//Add this instance
AHP_Instance = AHP_Instance + 1;
_InstanceIndex = AHP_Instance;


// = = = = = = = = = = = = = = = = = = = = = = = = = = =   
//	GROUP  PROPERTIES
// = = = = = = = = = = = = = = = = = = = = = = = = = = =   

{_x setVariable ["AHP_Controled",TRUE]} foreach units _grp;

// Select Behaviour
if (isNil {_grp getVariable "AHP_Behaviour"}) then
{
	_grp setVariable ["AHP_Behaviour",_Behav];
};

// Select SpeedMode
if (isNil {_grp getVariable "AHP_SpeedMode"}) then
{
	_grp setVariable ["AHP_SpeedMode",_spdMd];
};

_grp setBehaviour (_grp getVariable "AHP_Behaviour");
_grp setSpeedMode (_grp getVariable "AHP_SpeedMode");

// = = = = = = = = = = = = = = = = = = = = = = = = = = =  
// CAPITALIZE TYPENAMES OF BLACKLIST (IF PRESENT)
// = = = = = = = = = = = = = = = = = = = = = = = = = = =   

if (count _blackList > 0) then
{
		{
		_blackList = _blackList - [_x]; 
		_x = toUpper _x;
		_blackList = _blackList + [_x]; 
		} foreach _blackList;
		if (_deBugOn) then
		{
			hintSilent format ["Advanced House Patrol\n(Haroon1992)\n\nFinished Capitalizing typeNames of BlackList.\n\nResult :\n%1",_blackList];
			sleep 2;
		};

};



// = = = = = = = = = = = = = = = = = = = = = = = = = = =  
//  NO BLD. GIVEN (GET ALL ENTERABLE BLD. WITHIN RADIUS)
// = = = = = = = = = = = = = = = = = = = = = = = = = = =   

if (typeName (_bArray select 0) in ["NUMBER","SCALAR"]) then
{
	_radiusToFind = _bArray select 0;
	_bArray = nearestObjects [(leader _grp),["BUILDING"],_radiusToFind];

	{
		if (format ["%1",_x buildingPos 0] == "[0,0,0]") then
		{
			_bArray = _bArray - [_x];
		};
		if ((toUpper (typeOf _x)) in _blackList) then
		{
			_bArray = _bArray - [_x];
			};
	}foreach _bArray;
	
	
if (count _bArray >1) then {_bArray = [_bArray] call AHP_ShuffleArray};

// random building
if (_deBugOn) then {_nul = [] call AHP_DebugHintNB};
};


if (AHP_Debug) then
{
	(leader _grp) globalChat format ["Inst %1 >Units: %2 Buildings: %3 Beh: [%4] Spd: [%5]",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)],count units _grp, count _bArray, _behav, _spdMd];			
	sleep 1;
};	

// Information about this instance
if (_deBugOn) then {_nul = [] call AHP_DebugHint1};


while {_Repeat >= 0} do
{
	while {_r < count _bArray} do
	{	
		// = = = = = = = = = = = = = = = = = = = = = =
		//  SELECT BUILDING FROM BUILDINGS ARRAY
		// = = = = = = = = = = = = = = = = = = = = = =
		
		switch (_modeB) do 
		{
			case 0:
			{	
				// Random Position in Building
				_bx =floor (random count _bArray);
				};
			case 1:
			{
				// Sequentially
				_bx = _bx + 1;
				};	
			case 2:
			{
				// Reverse Order
               			 _bx = ((count _bArray) - 1) - _r;
			};
		};		
			
		_cB = _bArray select _bx;
		_r = _r + 1;
							
		// = = = = = = = = = = = = = = = = = = 
		//  GET ALL POSITIONS OF BUILDING
		// = = = = = = = = = = = = = = = = = = 
		
		_cBParray = [];
		_i = 0;
		while {format ["%1",_cB buildingPos _i] != "[0,0,0]"} do
		{
			_cBParray = _cBParray + [_i];
			_i = _i + 1;
			};

		// = = = = = = = = = = = = = = = = = = = = = =
		//  SELECT BUILDING POS OF CURRENT BUILDING
		// = = = = = = = = = = = = = = = = = = = = = =  
						
		// Reset _i and Re-use it for building positions array
		_i = 0;
		while {_i < count _cBPArray } do
		{			
			// Check Patrol Mode

			switch (_modeBpos) do 
			{
				case 0:
				{	
				// Random Position in Building
                   				 _cBP = _cBPArray select ( (random (count _cBPArray)) - 0.5 );
				};
				case 1:
				{
					// Sequentially
					_cBP = _cBPArray select _i;
				};	
				case 2:
				{
					// Reverse Order
                  				  _cBP = _cBPArray select ( ((count _cBPArray) -1) - _i);
				};
			};
			


		
			// = = = = = = = = = = = = = = = 
			//  MAKE GROUP MOVE TO DEST
			// = = = = = = = = = = = = = = =  
			
			_cDest = _cB buildingPos _cBP;
			_i = _i + 1;
			(leader _grp) move _cDest;
			//_grp addWaypoint [_cDest,4,currentwaypoint _grp];
			if (AHP_Debug) then
			{
				(leader _grp) globalChat format ["Inst %1 > Moving...[Dis: %2 Pos: %3 TotPos: %4]",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)],round ((leader _grp) distance _cDest),_cBP,count _cBPArray];			
			};			

			_GRPmoving = TRUE;
			sleep 3;
			

			
			
			// = = = = = = = = = = = = = = = = =
			//  WAIT WHILE GROUP IS MOVING
			// = = = = = = = = = = = = = = = = =
			
			
			_isStuck = 0;
			while {_GRPmoving} do
			{
				//Unit is moving			
				if (_deBugOn) then { _nul = [] call AHP_DebugHint2};
				_LdPos = getpos (leader _grp);
				
//			waitUntil {count _unitsInGrp != count units _grp OR moveToFailed (leader _grp) OR moveToCompleted (leader _grp) OR !(alive (leader _grp)) OR !(canMove (leader _grp)) OR (behaviour (leader _grp) != "SAFE") OR ((leader _grp) distance _cDest < 1.5) OR stopped (leader _grp)};
				if (_isStuck >= (_maxWaitSec + 10) OR count _unitsInGrp != count units _grp OR moveToFailed (leader _grp) OR moveToCompleted (leader _grp) OR !(alive (leader _grp)) OR !(canMove (leader _grp)) OR !(behaviour (leader _grp) == _behav) OR ((leader _grp) distance _cDest < 1.5)) then
				{
					if (_isStuck >= 5) then
					{
						if (AHP_Debug) then
						{
							(leader _grp) globalChat format ["Inst %1 > Stucked at position %2. Advancing to next bld.pos.",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)],getpos (leader _grp)];			
							};
						if (_deBugOn) then {hint "Leader of group is STUCKED! Advancing to next position!"};
						sleep 3;
					};
					_GRPmoving = FALSE;
					};

				sleep 2;
				if ( ( (getpos (leader _grp)) select 0 == (_LdPos select 0) ) AND ( (getpos (leader _grp)) select 1 == (_LdPos select 1)) ) then
				{
					_isStuck = _isStuck + 1;
				};				

			};				
			// Unit has stopped
			if (_deBugOn) then {_nul = [] call AHP_DebugHint3};
			
			// = = = = = = = = = = = = = = = = 
			//  GROUP HAS DETECTED ENEMY
			// = = = = = = = = = = = = = = = = 
 			
			if (behaviour (leader _grp) == "COMBAT") then
			{
				if (_deBugOn) then{ hint "Enemy detected. Script paused for 60 seconds"};
				_GrpDetectedEnemy = TRUE;
				if (AHP_Debug) then
					{
						(leader _grp) globalChat format ["Inst %1 > Enemy Detected! Pausing script for 60 seconds.",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)]];			
					};
				sleep 60;
				
				switch (side _grp) do
				{
					case CIVILIAN : 
					{
						_grp setBehaviour (_grp getVariable "AHP_Behaviour");
						_grp setSpeedMode (_grp getVariable "AHP_SpeedMode");
						if (AHP_Debug) then
						{
							(leader _grp) globalChat format ["Inst %1 > Group is [CIVILIAN], so set to 'Safe' behaviour.",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)]];			
							};
						};
					case WEST : 
					{
						if (({side _x in [EAST,RESISTANCE] AND alive _x AND (leader _grp) knowsAbout _x > 0} count (nearestObjects [(leader _grp),["CAManBase"],200])) == 0 ) then
						{
							if (AHP_Debug) then
							{
								(leader _grp) globalChat format ["Inst %1 > Group is [WEST],no [EAST,RESISTANCE] found near, so set to 'Safe' behaviour.",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)]];			
								};
							_grp setBehaviour (_grp getVariable "AHP_Behaviour");
							_grp setSpeedMode (_grp getVariable "AHP_SpeedMode");
						};
					};
					case EAST:
					{						
						if (({side _x == WEST AND alive _x AND (leader _grp) knowsAbout _x > 0} count (nearestObjects [(leader _grp),["CAManBase"],200])) == 0 ) then
						{
							if (AHP_Debug) then
							{
								(leader _grp) globalChat format ["Inst %1 > Group is [EAST], no [WEST] found near, so set to 'Safe' behaviour.",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)]];			
								};							
						_grp setBehaviour (_grp getVariable "AHP_Behaviour");
						_grp setSpeedMode (_grp getVariable "AHP_SpeedMode");						};
					};
					case RESISTANCE : 
					{
						if (({side _x == WEST AND alive _x AND (leader _grp) knowsAbout _x > 0} count (nearestObjects [(leader _grp),["CAManBase"],200])) == 0 ) then
						{
							if (AHP_Debug) then
							{
								(leader _grp) globalChat format ["Inst %1 > Group is [RESISTANCE], no [WEST] found near, so set to 'Safe' behaviour.",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)]];			
								};							
						_grp setBehaviour (_grp getVariable "AHP_Behaviour");
						_grp setSpeedMode (_grp getVariable "AHP_SpeedMode");						};
					};
				}; 
				sleep 3;
				
			};	
			
			// = = = = = = = = = = = = = = = = 
			//  SOME ONE IN GROUP IS DEAD
			// = = = = = = = = = = = = = = = =

			if (count _unitsInGrp != count units _grp AND NOT (_GrpDetectedEnemy)) then
			{
				_deadUnits = [];
				{
					if (group _x != _grp) then{_unitsInGrp = _unitsInGrp - [_x]};
					if (not ( alive _x )) then { _deadUnits = _deadUnits + [_x]};
					
					} foreach _unitsInGrp;
				
							
				_DeadBodyDetected = FALSE;
				_aUnit = 0;
				while {_aUnit < count units _grp AND not (_DeadBodyDetected)} do
				{
					if ({_x distance (units _grp select _aUnit) < 100} count _deadUnits > 0) then
					{
						_DeadBodyDetected = TRUE;
					};
					_aUnit = _aUnit + 1;
				};
				if (_DeadBodyDetected) then
				{
					_unitsInGrp = units _grp;
					_grp setBehaviour "AWARE";
					_grp setSpeedMode "NORMAL";
					(leader _grp) move getpos (units _grp select ((random (count units _grp)) - 0.5));
					if (_deBugOn) then
					{
						hint "Some one in group died.\nGroup is now on alert for 60 seconds!";
					};
					if (AHP_Debug) then
					{
						(leader _grp) globalChat format ["Inst %1 > Some one in group is dead! Pausing script for 60 seconds.",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)]];			
					};
					sleep 60;
					_grp setBehaviour (_grp getVariable "AHP_Behaviour");
					_grp setSpeedMode (_grp getVariable "AHP_SpeedMode");

				};
			}; 
			_GrpDetectedEnemy = FALSE;
						
			
			
			// = = = = = = = = = = = = = 
			//  WAIT AT STOP POINT
			// = = = = = = = = = = = = =
				if (AHP_Debug) then
				{
					(leader _grp) globalChat format ["Inst %1 > Waiting...[Time>Min: %1 Max: %2]",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)],_minWaitSec,_maxWaitSec];			
						};
			sleep (_MinWaitSec + random _MaxWaitsec);
				if (AHP_Debug) then
				{
					(leader _grp) globalChat format ["Inst %1 > Waiting Over...",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)]];			
						};
									
			if (Not (isNull _grp)) then
			{
				if ({alive _x} count units _grp == 0) exitWith 
				{
					AHP_Instance = AHP_Instance - 1;
					AHP_Groups = AHP_Groups - [_grp];
					{_x setVariable ["AHP_Controled",FALSE]} foreach units _grp;
					if (AHP_Debug) then
					{
						(leader _grp) globalChat format ["Inst %1 > No one in group is alive, Instance is terminated.",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)]];			
						};
					};
			}else
			{
				if (true) exitWith 
				{
					AHP_Instance = AHP_Instance - 1;
					AHP_Groups = AHP_Groups - [_grp];
					{_x setVariable ["AHP_Controled",TRUE]} foreach units _grp;
					if (AHP_Debug) then
					{
						(leader _grp) globalChat format ["Inst %1 > No one in group is alive, Instance is terminated.",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)]];			
						};
					};
			};



	// = = = = = = = = = = = = = = = = = 
	//  PATROL OUTSIDE OF BUILDING
	// = = = = = = = = = = = = = = = = =
			
			
			if (_outSides > 0) then
			{
				if (random 1 < _outSides) then
				{	
if (_deBugOn) then {hintSilent parseText "Group has got chance to patrol <t color='#ffffff'>outside!</t>"};	
					if (AHP_Debug) then
					{
						(leader _grp) globalChat format ["Inst %1 > Going to patrol outside areas...[Chance Given : %2 percent.]",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)],_outsides*100];			
						};
					if (_debugOn OR AHP_Debug) then {sleep 2};	
					private ["_bbX","_bbY"];
					
					_bbX= (((boundingBox _cB) select 1) select 0)+ round random 15;
					_bbY= (((boundingBox _cB) select 1) select 1) + round random 15;

					_bbX = _bbX*1.5;
					_bbY = _bbY*1.5;

					_bbX = if (random 1 < 0.5) then {_bbX} else {_bbX*-1};
					_bbY = if (random 1 < 0.5) then {_bbY} else {_bbY*-1};
					_cDest = [(getpos _cB select 0)+_bbX ,(getpos _cB select 1)+_bbY,0];					

					(leader _grp) move _cDest;
					
					_GRPmoving = TRUE;
					sleep 2;
					_isStuck = 0;
					
					if (AHP_Debug) then
					{
						(leader _grp) globalChat format ["Inst %1 > Outside Area > Moving...[Dis From Leader: %1]",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)],round ((leader _grp) distance _cDest)];			
							};
							
					while {_GRPmoving} do
					{
if (_deBugOn) then {hintSilent parseText format ["<t color='#ffffff' size = '1.2'>Outside Area</t><br/><br/>Moving to position <t color='#ffffff'>%1</t> which is <t color='#ffffff'>%2</t> meters from leader and <t color='#ffffff'>%3</t> meters from the center of the building.",_cDest,round ((leader _grp) distance _cDest),round(_cB distance _cDest)]};

//						waitUntil {moveToFailed (leader _grp) OR moveToCompleted (leader _grp) OR !(alive (leader _grp)) OR !(canMove (leader _grp)) OR (behaviour (leader _grp) != "SAFE") OR ((leader _grp) distance _cDest < 1.5)};						
						if (_isStuck >= (_maxWaitSec + 10) OR count _unitsInGrp != count units _grp OR moveToFailed (leader _grp) OR moveToCompleted (leader _grp) OR !(alive (leader _grp)) OR !(canMove (leader _grp)) OR !(behaviour (leader _grp) == _behav) OR ((leader _grp) distance _cDest < 4)) then
						{
							_GRPmoving = FALSE;
						};
						sleep 2;
						if ( ( (getpos (leader _grp)) select 0 == (_LdPos select 0) ) AND ( (getpos (leader _grp)) select 1 == (_LdPos select 1)) ) then
						{
							_isStuck = _isStuck + 1;
							};				
						if (_isStuck >= 5) then
						{
							if (AHP_Debug) then
							{
								(leader _grp) globalChat format ["Inst %1 > Stucked at position %2. Advancing to next bld.pos.",format ["%1 [%2]",_instanceIndex,typeOf (leader _grp)],getpos (leader _grp)];			
								};
							sleep 3;
							};
						};
					if (_deBugOn) then {hintSilent format["Unit has stopped.\nMove To Completed : %1\nMove To Failed : %2\nUnit can move : %3\nDmg of Unit : %4",moveToCompleted (leader _grp),moveToFailed (leader _grp),canMove (leader _grp),damage (leader _grp)]};	
				};
			};
		};
	};
	
	
	// = = = = = = = = = = = = = 
	//  CHECK REPEAT STATUS
	// = = = = = = = = = = = = = 
	if (_Repeat >= 0) then {_Repeat = _Repeat - 1};
	if (AHP_Debug AND _repeat >= 0) then
	{
		(leader _grp) globalChat format ["Inst %1 >Instance is Repeating. Repeats Left : %2",_InstanceIndex, _repeat];			
			};
	if (_deBugOn AND _repeat >= 0) then
	{
		hint format ["Script is now repeating.\nRepeats Left : %1",_repeat];
		sleep 3;
	};

};

if (true) exitWith
 {
	AHP_Instance = AHP_Instance - 1;
	AHP_Groups = AHP_Groups - [_grp];
	{_x setVariable ["AHP_Controled",TRUE]} foreach units _grp;
	if (_deBugOn) then 
	{
		hint format ["Advanced House Patrol Script Ended!\n\nGroup : %1\nLeader : %2\nSide : %3\nUnits : %4\n",_grp,leader _grp,side _grp,count units _grp];
		};
	if (AHP_Debug) then
	{
		(leader _grp) globalChat format ["Inst %1 > Instance Ended Successfully.",_InstanceIndex, _repeat];			
			};
	};



