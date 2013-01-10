// No dedicated
if (isDedicated) exitWith {};

_veh = _this select 0;
_man = _this select 1;

// What to execute
_option = (_this select 3) select 0;

// Exec only at caller
//if (_man != player) exitWith {};

// Deploy
if (_option == "DeployCrate") exitWith {

    if (isEngineOn _veh) then {
        hint "You must turn engine off before you can perform this action.";
	sleep 4;
	hint "";
    } else {

	_man playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 5;

        ammo = "USSpecialWeapons_EP1" createVehicle [0,0,0];

	ammo setDir ((direction _veh) +135);
	ammo setPos (_veh modelToWorld [-3.5,-4.5,((position _veh) select 2)]);
	ammo setpos [(getpos ammo) select 0, (getpos ammo) select 1, -0.01];
        
	ammo setVehicleInit "this setVehicleVarName 'ammo'; this allowDamage false; null = this execVM 'ammo\ammo_small.sqf'; this addAction ['Save Loadout','scripts\saveloadout.sqf',nil,1,true,true,'','player distance ammo<5.5'];";
	processInitCommands;

        // Set variable for vehicle
        _veh setVariable ["crateDeployed", true, true];
	crateDeployed = true; publicVariable "crateDeployed";
        
        // String ;)
        sleep 1;
        waitUntil {!(_veh getVariable "crateDeployed") || (_veh distance ammo > 12) || !(alive _veh) || !(alive ammo)};
        
        // If stowed, no clean up needed, exit
        if (!(_veh getVariable "crateDeployed")) exitWith {};
        
        _veh setVariable ["crateDeployed", false, true];
	crateDeployed = false; publicVariable "crateDeployed";
        
        sleep 1;
        deleteVehicle ammo;
    };
};


// Stow
if (_option == "StowCrate") exitWith {

        // Remove nearest tent
        ammo = nearestObject [_veh, "USSpecialWeapons_EP1"];

	_man playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 5;

        deleteVehicle ammo;
        
        // Set variable for vehicle
        _veh setVariable ["crateDeployed", false, true];
	crateDeployed = false; publicVariable "crateDeployed";
};