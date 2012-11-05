// by Xeno
#include "x_setup.sqf"

_units_player = units (group player);

if ((_units_player call XfGetAliveUnits) > 0) then {
	_has_ai = false;
	{
		if (!isPlayer _x) then {
			_has_ai = true;
			_x removeAllEventHandlers "killed";
			if (vehicle _x == _x) then {
				deleteVehicle _x;
			} else {
				_x action ["eject", vehicle _x];
				unassignVehicle _x;
				sleep 0.532;
				deleteVehicle _x;
			};
		};
	} forEach _units_player;
	if (_has_ai) then {"All AI soldiers dismissed !!!!" call XfHQChat};
};

d_current_ai_num = 0;