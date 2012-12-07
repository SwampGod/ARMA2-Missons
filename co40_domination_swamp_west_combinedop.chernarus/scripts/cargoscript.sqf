_vehicle = _this select 0;
_caller = _this select 1;
_actionarray = _this select 3;
_action = _actionarray select 0;
_carrier = _this select 0;
_fuel = fuel _carrier;
_loadpos = _carrier ModelToWorld [0,-12,-5.5];

_cargo = _carrier getVariable "cargo";
_act1 = _carrier getVariable "act1";

if (_action == "load") then {
	if (_cargo == "") then {
		_near = nearestObjects [_loadpos, ["Land","Ship"], 8];
		_obj = _near select 0;
		_bound = boundingBox _obj;
		
		_width = (_bound select 1 select 0) - (_bound select 0 select 0);
		_length = (_bound select 1 select 1) - (_bound select 0 select 1);
		_height = (_bound select 1 select 2) - (_bound select 0 select 2);
		
		if (count _near > 0) then {
			player sidechat format ["x:%1 y:%2 z:%3",_width,_length,_height];
			if ((_width <= 9.0) && (_length <= 21) && (_height <= 16.2)) then {
				_carrier setVariable ["cargo",_obj];
				_carrier removeAction _act1;
			
				player sideChat format ["Loading %1 into cargo",typeOf _obj];
				_carrier setFuel 0;
				_carrier animate ["ramp_top", 1];
				_carrier animate ["ramp_bottom", 1];
				sleep 3;
				_obj attachTo [_carrier,[0,2,((_obj modelToWorld [0,0,0]) select 2)-4.5]];
				_id = _obj addEventHandler ["GetOut", {(_this select 2) moveInCargo (_this select 0 getvariable "carrier")}];
				_obj setVariable ["evh",_id];
				_obj setVariable ["carrier",_carrier];


				sleep 1;
				_carrier animate ["ramp_top", 0];
				_carrier animate ["ramp_bottom", 0];
				sleep 1;
				_carrier setFuel _fuel;
				_id = _carrier addaction ["Unload", "scripts\cargoscript.sqf", ["drop"]];
				_carrier setVariable ["act1",_id];
			} else {
				player sideChat "This won't fit in the cargospace";
			};
		} else {
			player sideChat "Nothing in range";
		};
	} else {
		player sideChat "Cargo is already full";
	};
};

if (_action == "drop") then {
	_carrier removeAction _act1;
	_id = _cargo getVariable "evh";
	_cargo removeEventHandler ["GetOut", _id];
	if ((getpos _carrier select 2) > 3) then {
		detach _cargo;
		_cargo setpos _loadpos;
		sleep 1;
		_chute = "ParachuteMediumWest" createVehicle getpos _cargo;
		_chute setpos (_cargo ModelToWorld [0,0,3]);
		_cargo attachTo [_chute,[0,0,0]];
	} else {
		_carrier animate ["ramp_top", 1];
		_carrier animate ["ramp_bottom", 1];
		sleep 3;
		detach _cargo;
		_cargo setpos _loadpos;
		sleep 1;
		_carrier animate ["ramp_top", 0];
		_carrier animate ["ramp_bottom", 0];
	};
	_carrier setVariable ["cargo",""];
	_id = _carrier addaction ["Load cargo", "scripts\cargoscript.sqf", ["load"]];
	_carrier setVariable ["act1",_id];

};