_unit = _this select 1;


if (!alive s1) then {
	hint "The Team Leader is currently dead.";
} else {
	if (vehicle s1 == s1) then {
		_unit setDir direction s1;
		_unit setPosATL [getPosATL s1 select 0,getPosATL s1 select 1,getPosATL s1 select 2];
		_unit setPos (s1 modelToWorld [+0.75,-1,((position s1) select 2)+0]);
    		playSound "teleport";
	} else {
		if (vehicle s1 != s1) then {
		_freePosGunner = (vehicle s1) emptyPositions "gunner";
		_freePosCommander = (vehicle s1) emptyPositions "commander";
		_freePosCargo = (vehicle s1) emptyPositions "cargo";
		_freePosDriver = (vehicle s1) emptyPositions "driver";
			if (_freePosGunner > 0) then {
				_unit moveInGunner (vehicle s1);
    				playSound "teleport";
			} else {
				if (_freePosCommander > 0) then {
					_unit moveInCommander (vehicle s1);
    					playSound "teleport";
				} else {
					if (_freePosCargo > 0) then {
						_unit moveInCargo (vehicle s1);
    						playSound "teleport";
					} else {
						if (_freePosDriver > 0) then {
							_unit moveInDriver (vehicle s1);
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