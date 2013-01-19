_unit = _this select 1;


if (!alive Team_Leader) then {
	hint "The Team Leader is currently dead.";
} else {
	if (vehicle Team_Leader == Team_Leader) then {
		_unit setDir direction Team_Leader;
		_unit setPosATL [getPosATL Team_Leader select 0,getPosATL Team_Leader select 1,getPosATL Team_Leader select 2];
		_unit setPos (Team_Leader modelToWorld [+0.75,-1,((position Team_Leader) select 2)+0]);
    		playSound "teleport";
	} else {
		if (vehicle Team_Leader != Team_Leader) then {
		_freePosGunner = (vehicle Team_Leader) emptyPositions "gunner";
		_freePosCommander = (vehicle Team_Leader) emptyPositions "commander";
		_freePosCargo = (vehicle Team_Leader) emptyPositions "cargo";
		_freePosDriver = (vehicle Team_Leader) emptyPositions "driver";
			if (_freePosGunner > 0) then {
				_unit moveInGunner (vehicle Team_Leader);
    				playSound "teleport";
			} else {
				if (_freePosCommander > 0) then {
					_unit moveInCommander (vehicle Team_Leader);
    					playSound "teleport";
				} else {
					if (_freePosCargo > 0) then {
						_unit moveInCargo (vehicle Team_Leader);
    						playSound "teleport";
					} else {
						if (_freePosDriver > 0) then {
							_unit moveInDriver (vehicle Team_Leader);
    							playSound "teleport";
						} else {
							hint "The Team Leader's vehicle currently has no empty seats to teleport to.";
						};
					};
				};
			};
		};
	};
};