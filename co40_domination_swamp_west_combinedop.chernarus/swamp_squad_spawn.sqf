// USE: expActiv="nul=[""AHPCHERNO"", EAST, 0, ""AHP""] execVM ""swamp_squad_spawn.sqf""; nul=[""AHPCHERNO"", EAST, 0, ""AHP""] execVM ""swamp_squad_spawn.sqf"";";
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
			"RU_Soldier_SL",
			"RU_Soldier_MG",
			"RU_Soldier_AT",
			"RU_Soldier_LAT",
			"RU_Soldier_GL",
			"RU_Soldier_Marksman",
			"RU_Soldier_MG",
			"RU_Soldier_AT",
			"RU_Soldier_AR",
			"RU_Soldier_LAT",
			"RU_Soldier_GL"
			];

    };

    case 1:
    {
		_dudes = [
			"UAZ_MG_INS",
			"GRAD_RU"
			];

    };
	
	case 2:
	{
		_dudes = [
			"Kamaz",
			"UAZ_AGS30_RU"
			];
	};
	
	case 3:
	{
		_dudes = [

			"GAZ_Vodnik",
			"GAZ_Vodnik_HMG"
		];
	};
	
    case 4:
    {
		_dudes = [
			"RU_Soldier_TL",
			"RU_Soldier_AR",
			"RU_Soldier_AT",
			"RU_Soldier_GL",
			"RU_Soldier",
			"RU_Soldier_HAT",
			"RU_Soldier_AA",
			"RU_Soldier_Sniper",
			"RU_Soldier_Spotter",
			"RUS_Soldier_Marksman",
			"RUS_Soldier3"
			];

    };
	
    case 5:
    {
		_dudes = [
			"MVD_Soldier_TL",
			"MVD_Soldier_MG",
			"MVD_Soldier_AT",
			"MVD_Soldier_GL",
			"MVD_Soldier_Sniper",
			"MVD_Soldier_Marksman",
			"MVD_Soldier_GL",
			"RUS_Soldier2",
			"RUS_Soldier1",
			"RUS_Soldier_Marksman",
			"RUS_Soldier3"
			];

    };
	
	case 666:
	{
		_dudes = ["RU_Soldier_Sniper","MVD_Soldier_AT","RU_Soldier_Spotter"];
	};
	
	case 777:
	{
		_dudes = ["Soldier_TL_PMC","Soldier_Sniper_KSVK_PMC","Soldier_AT_PMC","Soldier_MG_PMC","Soldier_PMC","Soldier_AT_PMC"];
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
		_leader setVehicleInit "nul=[group this,[1000],[120,3600],15,[0,0],0.1,FALSE,[""Land_Water_Tank"",""Land_Vez""]] execVM ""ahp\ahp.sqf""; nul=[7200,0,true] execVM ""cly_removedead.sqf"";"; processInitCommands;
	};
};

