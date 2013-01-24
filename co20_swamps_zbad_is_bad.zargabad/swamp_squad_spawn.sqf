// USE: init="nul=[""SWAMPSQUAD1"", EAST, 1, 0] execVM ""swamp_squad_spawn.sqf"";";
if (!isServer) exitWith {};

private ["_marker","_side","_type","_dudes","_leader","_actions"];
_marker		= _this select 0;
_side		= _this select 1;
_type		= _this select 2;
_actions	= _this select 3;



switch (_type) do
{
    case 0:
    {
		_dudes = [
			"TK_INS_Soldier_AR_EP1",
			"TK_INS_Soldier_Sniper_EP1",
			"TK_INS_Soldier_3_EP1",
			"TK_INS_Soldier_4_EP1",
			"TK_INS_Soldier_AA_EP1",
			"TK_INS_Soldier_AA_EP1",
			"TK_INS_Soldier_AA_EP1",
			"TK_INS_Soldier_TL_EP1",
			"TK_INS_Soldier_AT_EP1",
			"TK_INS_Soldier_AT_EP1",
			"TK_INS_Soldier_EP1"
			];

    };

    case 1:
    {
		_dudes = [
			"TK_Special_Forces_TL_EP1",
			"TK_Special_Forces_MG_EP1",
			"TK_Special_Forces_EP1",
			"TK_Special_Forces_EP1",
			"TK_Special_Forces_MG_EP1",
			"TK_Special_Forces_EP1",
			"TK_Special_Forces_EP1"
			];

    };
	
	case 2:
	{
		_dudes = [
			"TK_Special_Forces_TL_EP1",
			"TK_Special_Forces_MG_EP1",
			"TK_Special_Forces_EP1",
			"TK_Special_Forces_EP1",
			"TK_Special_Forces_MG_EP1",
			"TK_Special_Forces_EP1",
			"TK_Special_Forces_EP1",
			"TK_Soldier_HAT_EP1",
			"TK_Soldier_HAT_EP1",
			"TK_Soldier_AT_EP1",
			"TK_Soldier_AT_EP1",
			"TK_Soldier_AAT_EP1",
			"TK_Soldier_SniperH_EP1",
			"TK_Soldier_Spotter_EP1",
			"TK_Soldier_AA_EP1",
			"TK_Soldier_AA_EP1",
			"TK_Soldier_AA_EP1",
			"TK_Soldier_MG_EP1",
			"TK_Soldier_MG_EP1",
			"TK_Soldier_AT_EP1",
			"TK_Soldier_GL_EP1",
			"TK_Soldier_AMG_EP1"
			];
	};
	
	case 3:
	{
		_dudes = [

			"LandRover_MG_TK_INS_EP1",
			"LandRover_MG_TK_INS_EP1"
		];
	};

};




_grp = [getMarkerPos _marker, _side, _dudes] call BIS_fnc_spawnGroup;


{
	_x setBehaviour "AWARE"

} foreach units _grp;

_grp setFormation "STAG COLUMN";

_leader = leader _grp;





// Start Actions

switch (_actions) do
{
    case "PATROL":
    {
		_leader setVehicleInit "nul=[600,0,true] execVM 'cly_removedead.sqf';"; processInitCommands;

		private["_obj","_radius","_patrol","_maxwait","_pos","_bldgpos","_i","_j","_nearbldgs"];


		_obj = _leader;
		_radius = 30;
		_patrol = true;
		_maxwait = 300;
		_pos = getMarkerPos _marker;

		_bldgpos = [];
		_i = 0;
		_j = 0;
		_nearbldgs = nearestObjects [_pos, ["Building"], _radius];
		{
			private["_y"];
			_y = _x buildingPos _i;
			while {format["%1", _y] != "[0,0,0]"} do {
				_bldgpos set [_j, _y];
				_i = _i + 1;
				_j = _j + 1;
				_y = _x buildingPos _i;
			};
			_i = 0;
		} forEach _nearbldgs;

		_pos = _bldgpos select floor(random count _bldgpos);

		if(_obj isKindOf "Man" || _obj isKindOf "Car") then {
			if(_patrol) then {
				_obj setSpeedMode "LIMITED";
			};
			_obj setCombatMode "YELLOW";
			_obj move _pos;
		} else {
			_obj setPos _pos;
			_obj setDir (random 360);
			_obj setVectorUp [0,0,1];
		};
		_obj setDir (random 360);

		while{_patrol && alive _obj} do {
			sleep (random _maxwait);
			_pos = _bldgpos select floor(random count _bldgpos);
			_obj move _pos;

		};

    };

	case "UPS":
	{
		_leader setVehicleInit "nul=[this,""Patrol_Everything"",""delete:1800"",""min:"",1,""max:"",1] execVM ""ups.sqf"";"; processInitCommands;
	};
	
	case "AHP":
	{
		_leader setVehicleInit "nul=[group this,[1000],[60,300],6,[0,0],0.1,FALSE,[""Land_Water_Tank"",""Land_Vez""]] execVM ""ahp\ahp.sqf"";"; processInitCommands;
	};
};

