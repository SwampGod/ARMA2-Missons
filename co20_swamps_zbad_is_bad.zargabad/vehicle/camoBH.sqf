// No dedicated
if (isDedicated) exitWith {};

_veh = _this select 0;
_man = _this select 1;

// What to execute
_option = (_this select 3) select 0;

// Exec only at caller
//if (_man != player) exitWith {};

// Deploy
if (_option == "DeployCamo") exitWith {

    if (isEngineOn _veh) then {
        hint "You must turn engine off before you can perform this action.";
	sleep 4;
	hint "";
    } else {
    	//_veh setFuel 0;

	_man playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 5;

        _Net = "Land_CamoNetB_EAST_EP1" createVehicle [0,0,0];

        _Net setDir ((direction _veh) +0);
        _Net setPos (_veh modelToWorld [0,0,((position _veh) select 2)-2.4]);
        
        // Set variable for vehicle

        _veh setVariable ["camoDeployedBH", true, true];
	camoDeployedBH = true; publicVariable "camoDeployedBH";
	waitUntil {!isNil "camoDeployedBH"};
        
        // String ;)
        sleep 1;
        waitUntil {!(_veh getVariable "camoDeployedBH") || (_veh distance _Net > 12) || !(alive _veh) || !(alive _Net)};
        
        // If stowed, no clean up needed, exit
        if (!(_veh getVariable "camoDeployedBH")) exitWith {};
       
    	//_veh setFuel 1;
        _Net setDamage 1;
        sleep 3;
        deleteVehicle _Net;

        _veh setVariable ["camoDeployedBH", false, true];
	camoDeployedBH = false; publicVariable "camoDeployedBH";
	waitUntil {!isNil "camoDeployedBH"};
    };
};


// Stow
if (_option == "StowCamo") exitWith {

    	//_veh setFuel 1;
        // Remove nearest tent
        _Net = nearestObject [_veh, "Land_CamoNetB_EAST_EP1"];
    
        _Net setDamage 1;

	_man playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 5;

        deleteVehicle _Net;
        
        // Set variable for vehicle

        _veh setVariable ["camoDeployedBH", false, true];
	camoDeployedBH = false; publicVariable "camoDeployedBH";
	waitUntil {!isNil "camoDeployedBH"};

};