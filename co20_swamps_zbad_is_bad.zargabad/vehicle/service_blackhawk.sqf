_vehicle = _this select 0;
_dude = _this select 1;

    if ( vehicle _dude != _dude) then {
        hint "You must dissembark before you can perform this action.";
    	sleep 6;
    	hint "";
    } else {
    if (isEngineOn _vehicle) then {
        hint "You must turn engine off before you can perform this action.";
    	sleep 6;
    	hint "";
    } else {
    _vehicle lock true;
    	hint "";
	_dude playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 6;

    _vehicle setPos [ getPos _vehicle select 0, (getPos _vehicle select 1) +0, getPos _vehicle select 2];
    _vehicle setpos [ getPos _vehicle select 0, getPos _vehicle select 1, +0.01]; 

    _vehicle setDamage 0;
	sleep 3;
    _vehicle lock false;

    if (isServer) then {
    hint composeText [parsetext format["<t size='1.2' align='center' color='#FFA500'>Blackhawk Repaired%1</t>"]];
    sleep 6;
    hint "";
    };
  };
};