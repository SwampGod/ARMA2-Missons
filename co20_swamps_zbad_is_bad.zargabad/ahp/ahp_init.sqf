if (not isServer) exitWith {};

private ["_cv","_bl","_op","_re"];

_cv = [];_bl = [];_op = [];_re = [];

AHPS = compile preprocessFileLineNumbers "ahp\ahp.sqf";

if (isNil "AHP_Debug") then
{
	
	AHP_Debug = FALSE;
	
};

if (isNil "AHP_OverAllStatHint") then
{
	// Over all status hint which displays how many groups per side are running AHP and other things.
	AHP_OverAllStatHint = FALSE;
	
};
AHP_Instance = 0;
AHP_Groups = [];


// = = = = = = = = = = = = = = = = = = = = = = = = = = = 




// My Own Shuffle Array Function


AHP_ShuffleArray =
{
/*
    Argument : [array] call _shuffleArray;
    Returns : same array with elements shuffled.
    Sample : [[1,2,3,4,5,6]] call _shuffleArray;
    Result could be [3,2,5,4,1,6] or maybe [2,1,3,5,6,4] (noone except god know the result)    
    */
    private ["_arr","_ind","_n","_result"];
    _ind = 0;
    _n = 0;
    _result = [];
    _arr = _this select 0;

    while {_n < count _arr} do
    {
        _ind = _arr select ( (random (count _arr)) - 0.5 );
        while {_ind in _result AND count _result < count _arr} do
        {
            _ind = _arr select ( (random (count _arr)) - 0.5 );
        };
        _result = _result + [_ind];
        _n = _n + 1;
    };
    _result
};


// = = = = = = = = = = = = = = = = = = = = = = = = = = = 

//  DEBUG HINTS


//	 i've put these at the top to make the rest of the script look cleaner.

//  Information
AHP_DebugHint1 =
 {
	 private ["_mdBld","_mdBldPos","_bs"];
	 	_bs = [];
	 	_mdBls = "";
	 	_mdBldPos = "";
	 
		if (count _bArray > 0) then 
		{
			if (count _bArray < 10) then 
			{
				{ _bs = _bs + [typeOf _x]} foreach _bArray;
				} else {_bs = ["More than 10 blds, so only count is shown :",count _bArray]};
			}else 
			{
				_bs = ["No buildings found within given radius!"];
				};
		if (_modeB == 0) then {_mdBld = "0 (Random bld. from bld.array)"};
		if (_modeB == 1) then {_mdBld = "1 (First-to-last of bld. array)"};
		if (_modeB == 2) then {_mdBld = "2 (Reverse Order of bld. array)"};

		if (_modeBPos == 0) then {_mdBldPos = "0 (Random bld.pos of a bld. from bld.array)"};
		if (_modeBPos == 1) then {_mdBldPos = "1 (Orderly from bld.pos of bld.)"};
		if (_modeBPos == 2) then {_mdBldPos = "2 (Reverse Order of bld.pos of bld.)"};

hint parseText format [ "
<t color='#dff209'>GROUP STATS</t><br/>
<t color='#dff209' size = '0.8'>
Name : <t color='#ffffff'>%1</t><br/>
Leader : <t color='#ffffff'>%2</t><br/>
Side : <t color='#ffffff'>%3</t><br/>
Units Count : <t color='#ffffff'>%4</t><br/>
</t>
<t color='#ffffff'>------------------------</t><br/>
<t color='#dff209'>BUILDINGS</t><br/><t color='#ffffff'>%5</t><t color='#ffffff'><br/>
<t color='#dff209'>TOTAL BUILDINGS</t>: <t color='#ffffff'>%6</t><br/><t color='#ffffff'>------------------------</t><br/>
<t color='#dff209'>MIN/MAX WAITTIME</t><br/><t color='#ffffff'>%7</t>/<t color='#ffffff'>%8</t><br/><t color='#ffffff'>------------------------</t><br/>
<t color='#dff209'>TIMES TO REPEAT</t><br/><t color='#ffffff'>%9</t><br/><t color='#ffffff'>------------------------</t><br/>
<t color='#dff209'>PATROL MODES</t><br/>
:BUILDING<br/><t color='#ffffff'>%10</t><br/>
:BUILDING POS<br/><t color='#ffffff'>%11</t><br/><br/>",
_grp,format ["%1 (%2)",name (leader _grp),typeOf (leader _grp)],side _grp,count units _grp, _bs,count _bArray, _minwaitsec, _maxwaitsec, _Repeat, _mdBld, _mdBldPos];
sleep 2;

};

// Unit is moving
AHP_debugHint2 =
{			

hintSilent parseText format ["
Group is moving to building at %9 away.<br/><br/>

<t color='#dff209' size = '1.1'>Group Stats</t><br/>
<t color='#ffffff' size = '0.8'>Name</t> %1<br/>
<t color='#ffffff' size = '0.8'>Leader</t> %2<br/>
<t color='#ffffff' size = '0.8'>Side</t> %3<br/>
<t color='#ffffff' size = '0.8'>Units Count</t> %4<br/><br/>

<t color='#dff209' size ='1.1'>Building</t><br/>
%5<br/>
<t color='#dff209' size = '1.1'>Available Bld. Positions in Bld.</t><br/> 
%6<br/>
<t color='#dff209' size = '1.1'>Bld.pos Array</t><br/>
%7<br/>
<t color='#dff209' size = '1.1'>Current Bld.Position</t><br/>
%8",
_grp,format ["%1 (%2)",name (leader _grp),typeOf (leader _grp)],side _grp,count units _grp,format ["%1 (%2)",typeOf _cB,_cB],count _cBParray,_cBParray,_cBP,(leader _grp) distance _cB];

};

// Unit stopped
AHP_DebugHint3 =
{
	
hintSilent parseText format ["
Unit has stopped.<br/><br/>
<t color='#dff209'>Dis Unit To Destination</t><br/>
%1<br/>
<t color='#dff209'>Behaviour Of Unit</t><br/>
%2<br/>
<t color='#dff209'>Damage Value of Unit</t><br/>
 %3",
(leader _grp) distance _cDest,behaviour (leader _grp),damage (leader _grp)]; 
sleep 1;

};

//No buildings given
AHP_DebugHintNB =
{
	
hint parseText format ["First element of bld.array is <t color='#ffffff'>%1</t>, so ALL enterable buildings within <t color='#ffffff'>%1</t> meters radius of unit, are added into buildings list.",_radiusToFind];
sleep 1;

};


//  END OF DEBUG HINTS
// = = = = = = = = = = = = = = = = = = = = = = = = = = = 


AHP_InitDone = TRUE;

while {alive player} do
{
	while {!AHP_OverAllStatHint} do
	{
		sleep 2;
	};
while {AHP_OverAllStatHint AND {not (isNil {leader _x getVariable "AHP_DebugOn"})} count AHP_Groups == 0} do
{

{
	switch (side _x) do
	{
		case CIVILIAN : 
		{
		 { if (NOT (_x in _cv)) then { _cv = _cv + [_x]}} foreach units _x;
			  };
		case WEST : 
		{
		 { if (NOT (_x in _bl)) then { _bl = _bl + [_x]}} foreach units _x;
			};
		case EAST : 
		{
		 { if (NOT (_x in _op)) then { _op = _op + [_x]}} foreach units _x;
			};
		case RESISTANCE : 
		{
		 { if (NOT (_x in _re)) then { _re = _re + [_x]}} foreach units _x;
			};
	};
} foreach AHP_Groups;
hintSilent parseText format ["
<t color='#dff209'>Groups Using AHP</t> : %1<br/>
<t color='#dff209'>Running AHP Instances</t>: %2<br/><br/>
<t color='#dff209' size='1.2'>STATUS</t><br/><br/>
<t color='#1aefec' size='1.1'>Groups Per Side</t><br/>
<t color='#ffffff' size= '0.8'>Civilian</t> : %3<br/>
<t color='#ffffff' size= '0.8'>Blufor</t> : %4<br/>
<t color='#ffffff' size= '0.8'>Opfor</t> : %5<br/>
<t color='#ffffff' size= '0.8'>Resistance</t> : %6<br/><br/>
<t color='#1aefec' size='1.1'>Units Per Side</t><br/>
<t color='#ffffff' size= '0.8'>Civilian</t> : %7<br/>
<t color='#ffffff' size= '0.8'>Blufor</t> : %8<br/>
<t color='#ffffff' size= '0.8'>Opfor</t> : %9<br/>
<t color='#ffffff' size= '0.8'>Resistance</t> : %10<br/><br/>
",
count AHP_Groups,AHP_Instance,{side _x == CIVILIAN} count AHP_Groups,{side _x == WEST} count AHP_Groups,{side _x == EAST} count AHP_Groups,{side _x == RESISTANCE} count AHP_Groups,count _cv,count _bl,count _op,count _re];
sleep 1;
};

};
