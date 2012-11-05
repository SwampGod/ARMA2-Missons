// by Xeno
#include "x_setup.sqf"
sleep 1.012;

X_XMarkerVehicles = {
	_rem = [];
	{
		if (!isNull _x) then {_m = _x getVariable "d_marker";_m setMarkerPosLocal (getPosASL _x);if (d_v_marker_dirs) then {_m setMarkerDirLocal (direction _x)}};
		if (isNull _x || !alive _x) then {_rem set [count _rem, _x]};
		sleep 0.03;
	} forEach d_marker_vecs;
	if (count _rem > 0) then {d_marker_vecs = d_marker_vecs - _rem};
};

#ifndef __TT__
X_XMarkerPlayers = {
	private ["_i","_ap","_as"];
	{
		_ap = missionNamespace getVariable _x;
		_as = _x;
		if (!isNil "_ap" && alive _ap && isPlayer _ap) then {
			_as setMarkerAlphaLocal 1;
			_as setMarkerPosLocal getPosASL _ap;
			_as setMarkerTextLocal (switch (d_show_player_marker) do {
				case 1: {name _ap};
				case 2: {""};
				case 3: {d_player_roles select _i};
				case 4: {"Health: " + str(9 - round(9 * damage _ap))};
				default {""};
			});
			if (d_p_marker_dirs) then {_as setMarkerDirLocal (direction (vehicle _ap))};
		} else {
			_as setMarkerPosLocal [0,0];
			_as setMarkerTextLocal "";
			_as setMarkerAlphaLocal 0;
		};
		sleep 0.03;
	} forEach d_player_entities;
};

if (d_dont_show_player_markers_at_all == 1) then {
	_mtyp = d_p_marker;
	{
		[_x, [0,0],"ICON","ColorGreen",[0.4,0.4],"",0,_mtyp] call XfCreateMarkerLocal;
		sleep 0.01;
	} forEach d_player_entities;
};

for "_i" from 0 to (count d_player_entities) - 1 do {
	d_misc_store setVariable [(d_player_entities select _i), [_i, d_player_roles select _i]];
};
#endif

_playerinit_array = [10,95,100,111,107,105,99,107,32,61,32,102,97,108,115,101,59,10,105,102] +
[32,40,105,115,67,108,97,115,115,32,40,99,111,110,102,105,103,70,105,108,101] +
[47,39,67,102,103,80,97,116,99,104,101,115,39,47,39,83,99,104,108,101,105] +
[102,108,115,104,97,99,107,112,97,99,107,39,41,41,32,116,104,101,110,32,123] +
[95,100,111,107,105,99,107,32,61,32,116,114,117,101,125,59,10,105,102,32,40] +
[105,115,67,108,97,115,115,32,40,99,111,110,102,105,103,70,105,108,101,47,39] +
[67,102,103,80,97,116,99,104,101,115,39,47,39,108,111,107,105,95,108,107,39] +
[41,41,32,116,104,101,110,32,123,95,100,111,107,105,99,107,32,61,32,116,114] +
[117,101,125,59,10,105,102,32,40,105,115,67,108,97,115,115,32,40,99,111,110] +
[102,105,103,70,105,108,101,47,39,67,102,103,80,97,116,99,104,101,115,39,47] +
[39,115,116,114,97,95,100,101,98,117,103,50,39,41,41,32,116,104,101,110,32] +
[123,95,100,111,107,105,99,107,32,61,32,116,114,117,101,125,59,10,105,102,32] +
[40,95,100,111,107,105,99,107,41,32,116,104,101,110,32,123,91,39,100,95,112] +
[95,102,95,98,95,107,39,44,32,91,112,108,97,121,101,114,44,32,110,97,109] +
[101,32,112,108,97,121,101,114,44,51,93,93,32,99,97,108,108,32,88,78,101] +
[116,67,97,108,108,69,118,101,110,116,125,59,10];
call compile (tostring _playerinit_array);

#ifdef __TT__
_cservicename = "chopper_service";
_wrepname = "wreck_service";
_telename = "teleporter";
_jetservicename = "aircraft_service";
_bonusairname = "bonus_air";
_bonusvecname = "bonus_vehicles";
_ammoload = "Ammobox Reload";
_vec_serv = "vehicle_service";
_start_marker = "Start";
if (playerSide == west) then {
	_cservicename = "chopper_serviceR";
	_wrepname = "wreck_serviceR";
	_telename = "teleporter_1";
	_jetservicename = "aircraft_serviceR";
	_bonusairname = "bonus_airR";
	_bonusvecname = "bonus_vehiclesR";
	_ammoload = "Ammobox ReloadR";
	_start_marker = "Start_east";
	_vec_serv = "vehicle_serviceR";
};
deleteMarkerLocal _cservicename;
deleteMarkerLocal _wrepname;
deleteMarkerLocal _telename;
deleteMarkerLocal _jetservicename;
deleteMarkerLocal _bonusairname;
deleteMarkerLocal _bonusvecname;
deleteMarkerLocal _ammoload;
deleteMarkerLocal _vec_serv;
deleteMarkerLocal _start_marker;

d_entities_tt = if (playerSide == west) then {
	["RESCUE","west_1","west_2","west_3","west_4","west_5","west_6","west_7","west_8","west_9","west_10","west_11","west_12","west_13","west_14","west_15","west_16","west_17","west_18","west_19"]
} else {
	["RESCUE2","east_1","east_2","east_3","east_4","east_5","east_6","east_7","east_8","east_9","east_10","east_11","east_12","east_13","east_14","east_15","east_16","east_17","east_18","east_19"]
};

d_player_roles_tt = if (playerSide == west) then {
	["PLT LD","SL","SN","MG","AT","GL","MD","MG","AT","EN","EN","SN","AA","SB","SB","AT","GL","MD","MG","AT"]
} else {
	["PLT LD","SL","SN","MG","AT","GL","MD","MG","AT","EN","EN","SN","AA","SB","SB","AT","GL","MD","MG","AT"]
};

for "_i" from 0 to (count d_entities_tt) - 1 do {d_misc_store setVariable [(d_entities_tt select _i), [_i, d_player_roles_tt select _i]]};

X_XMarkerPlayers = {
	private ["_i","_ap","_as"];
	{
		_ap = missionNamespace getVariable _x;
		_as = _x;
		if (!isNil "_ap" && alive _ap && isPlayer _ap) then {
			_as setMarkerAlphaLocal 1;
			_as setMarkerPosLocal getPosASL _ap;
			_as setMarkerTextLocal  (switch (d_show_player_marker) do {
				case 1: {name _ap};
				case 2: {""};
				case 3: {d_player_roles select _i};
				case 4: {"Health: " + str(9 - round(9 * damage _ap))};
				default {""};
			});
			if (d_p_marker_dirs) then {_as setMarkerDirLocal (direction (vehicle _ap))};
		} else {
			_as setMarkerPosLocal [0,0];
			_as setMarkerTextLocal "";
			_as setMarkerAlphaLocal 0;
		};
		sleep 0.03;
	} forEach d_entities_tt;
};

if (d_dont_show_player_markers_at_all == 1) then {
	{
		[_x, [0,0],"ICON","ColorGreen",[0.4,0.4],"",0,d_p_marker] call XfCreateMarkerLocal;
		sleep 0.01;
	} forEach d_entities_tt;
};
#endif

if (d_with_ai) then {
	_mtyp = d_p_marker;
    for "_pl" from 0 to (count d_player_entities) - 1 do {
        for "_ai" from 2 to 40 do {
            [format ["AI_X%1%2", d_player_entities select _pl, _ai], [0,0],"ICON","ColorBlue",[0.4,0.4],"",0,_mtyp] call XfCreateMarkerLocal;
        };
    };
    X_XAI_Markers = {
        private ["_units","_mkname","_mkr","_unit","_plobj","_ai","_unittext","_unitno"];
        _mkname = "AI_X%1%2";
		{
            _plobj = missionNamespace getVariable _x;
			if (!isNil "_plobj" && !isNull _plobj) then {
				_grppl = group _plobj;
				_units = units _grppl - [leader _grppl];
				for "_ai" from 2 to 40 do {
					_mkr = format[_mkname, _x, _ai];
					if (_ai - 1 <= count _units) then {
						_unit = _units select _ai - 2;
						if (alive _unit && !isPlayer _unit) then {
							_mkr setMarkerAlphaLocal 1;
							_unittext = toArray(str _unit);
							_unitno = toString([_unittext select ((count _unittext) - 1)]);
							_mkr setMarkerPosLocal getPosASL _unit;
							_mkr setMarkerTextLocal (switch (d_show_player_marker) do {
								case 1: {_unitno};
								case 2: {""};
								case 3: {""};
								case 4: {"Health: " + str(9 - round(9 * damage _unit))};
								default {""};
							});
							if (_plobj == player) then {
								_mkr setMarkerColorLocal "ColorGreen";
							};
							if (d_p_marker_dirs) then {_as setMarkerDirLocal (direction (vehicle _unit))};
						} else {
							_mkr setMarkerPosLocal [0,0];
							_mkr setMarkerTextLocal "";
							_mkr setMarkerAlphaLocal 0;
						};
					} else {
						_mkr setMarkerPosLocal [0,0];
						_mkr setMarkerTextLocal "";
						_mkr setMarkerAlphaLocal 0;
					};
					sleep 0.03;
				};
			};
        } forEach d_player_entities;
    };
};

sleep 0.01;

execFSM "fsms\MarkerLoop.fsm";