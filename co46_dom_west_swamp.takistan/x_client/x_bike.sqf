// by Xeno
#include "x_setup.sqf"
private ["_create_bike", "_disp_name", "_str", "_pos", "_vehicle", "_exitit", "_dosearch", "_index", "_parray", "_rank"];
if (!X_Client) exitWith {};

_create_bike = (_this select 3) select 0;
_b_mode = (_this select 3) select 1;

if (d_with_ranked) then {
	_exitit = false;
	_dosearch = true;
	if (_create_bike in d_create_bike) then {
		if (count d_create_bike > 1) then {
			_index = d_create_bike find _create_bike;
			if (_index != -1) then {
				_dosearch = false;
				_parray = [(d_points_needed select 1),(d_points_needed select 2),(d_points_needed select 3),(d_points_needed select 4),(d_points_needed select 5)];
				if (_index < count _parray) then {
					if (score player < (_parray select _index)) then {
						_rank = switch (_parray select _index) do {
							case (d_points_needed select 1): {"Sergeant"};
							case (d_points_needed select 2): {"Lieutenant"};
							case (d_points_needed select 3): {"Captain"};
							case (d_points_needed select 4): {"Major"};
							case (d_points_needed select 5): {"Colonel"};
						};
						(format ["You have to be at least %1 to create a %2",_rank,_create_bike]) call XfGlobalChat;
						_exitit = true;
					};
				};
			};
		};
	};
	if (_dosearch) then {
		if (score player < (d_ranked_a select 6)) then {
			_rank = (d_ranked_a select 6) call XGetRankFromScore; 
			_exitit = true;
			(format["You have to be at least %2 to create a %1",_create_bike,_rank]) call XfGlobalChat;
		};
	};
};
if (_exitit) exitWith {};

_disp_name = [_create_bike,0] call XfGetDisplayName;

if (vehicle player != player) exitWith {
	_str = format ["Creating a %1 is not possible in a vehicle...", _disp_name];
	_str call XfGlobalChat;
};

if (isNil {__pGetVar(d_bike_created)}) then {__pSetVar ["d_bike_created", false]};
if (__pGetVar(d_bike_created) && _b_mode == 1) exitWith {"Creating a vehicle is only possible once after respawn..." call XfGlobalChat};

if (time > d_vec_end_time && !isNull d_flag_vec) then {
	if ((d_flag_vec call XfGetAliveCrew) == 0) then {
		deleteVehicle d_flag_vec;
		d_flag_vec = objNull;
		d_vec_end_time = -1;
	};
};
if (!isNull d_flag_vec && alive d_flag_vec && _b_mode == 0) exitWith {
	(format ["You have allready created a vehicle, find it and use it again!!! Or wait %1 minutes before you can create a new one (might take longer)!",0 max (round((d_vec_end_time - time)/60))]) call XfGlobalChat;
};

if (d_with_ranked) then {
	["d_pas", [player, (d_ranked_a select 5) * -1]] call XNetCallEvent;
};

_pos = position player;
_str = format ["Creating %1, stand by...", _disp_name];
_str call XfGlobalChat;
sleep 3.123;
__pSetVar ["d_bike_created", true];
_pos = position player;
_vehicle = createVehicle [_create_bike, _pos, [], 0, "NONE"];
_vehicle setDir direction player;
player reveal _vehicle;

player moveInDriver _vehicle;

if (_b_mode == 1) then {
	_vehicle spawn {
		private "_vehicle";
		_vehicle = _this;
		["d_ad", _vehicle] call XNetCallEvent;
		waitUntil {sleep 0.412;!alive player || !alive _vehicle};
		sleep 10.123;
		_vehicle spawn {
			private "_vehicle";
			_vehicle = _this;
			while {true} do {
				if ((_vehicle call XfGetAliveCrew) == 0) exitWith {deleteVehicle _vehicle};
				sleep 15.123;
			};
		};
	};
} else {
	d_flag_vec = _vehicle;
	d_vec_end_time = time + VecCreateWaitTime + 60;
	["d_ad2", [d_flag_vec,d_vec_end_time]] call XNetCallEvent;
	d_flag_vec addEventHandler ["killed", {(_this select 0) spawn {private ["_vec"];_vec = _this;sleep 10.123;while {true} do {if (isNull _vec) exitWith {};if ((_vec call XfGetAliveCrew) == 0) exitWith {deleteVehicle _vec};sleep 15.123};d_flag_vec = objNull}}];
};
