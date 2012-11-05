// by Xeno
#include "x_setup.sqf"
private ["_chance", "_btype", "_vec_type", "_vecclass", "_bonus_num", "_d_bonus_create_pos", "_d_bonus_air_positions", "_d_bonus_vec_positions", "_d_bap_counter", "_d_bvp_counter", "_btype_e", "_btype_w", "_bonus_num_e", "_vec_typex", "_bonus_num_w", "_d_bonus_create_pos2", "_vec_type2", "_d_bonus_air_positions2", "_d_bonus_vec_positions2", "_d_bvp_counter2", "_d_bap_counter2", "_vehicle", "_endpos", "_dir", "_vehicle2", "_endpos2", "_dir2","_airval", "_bonus_number"];

if (!isServer) exitWith {};

if (d_SidemissionsOnly == 0) exitWith {
	["sm_res_client", [d_side_mission_winner,0]] call XNetCallEvent;
#ifndef __TT__
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MissionAccomplished",true];
#else
	if (d_side_mission_winner == 1) then {
		d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","MissionFailure",true];
		d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","MissionAccomplished",true];
	} else {
		d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","MissionAccomplished",true];
		d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","MissionFailure",true];
	};
#endif

	if (!X_SPE) then {d_side_mission_winner = 0};
};

#ifndef __TT__
_airval = 72;

_chance = 0;

if (d_land_bonus_vecs == 0) then {
	_chance = _airval + 1;
} else {
	if (d_air_bonus_vecs == 0) then {
		_chance = 0;
	} else {
		if (d_air_bonus_vecs > d_land_bonus_vecs) then {
			_airval = floor ((d_land_bonus_vecs / d_air_bonus_vecs) * 100);
		};
		_chance = floor (random 100);
	};
};

_btype = "";
_vec_type = "";

while {_btype == ""} do {
	_bonus_number = d_sm_bonus_vehicle_array call XfRandomFloorArray;
	_vec_type = d_sm_bonus_vehicle_array select _bonus_number;
	_vecclass = toUpper (getText(configFile >> "CfgVehicles" >> _vec_type >> "vehicleClass"));
	if (_chance > _airval) then {
		if (_vecclass == "AIR") then {if (d_last_bonus_vec != _vec_type) then {_btype = _vec_type}};
	} else {
		if (_vecclass != "AIR") then {if (d_last_bonus_vec != _vec_type) then {_btype = _vec_type}};
	};
	sleep 0.01;
};
d_last_bonus_vec = _vec_type;
_bonus_num = _bonus_number;
_d_bonus_create_pos = d_bonus_create_pos;
_vec_type = d_sm_bonus_vehicle_array select _bonus_number;
_d_bonus_air_positions = d_bonus_air_positions;
_d_bonus_vec_positions = d_bonus_vec_positions;
_d_bap_counter = d_bap_counter;
_d_bvp_counter = d_bvp_counter;
#else
_airval = 50;
_chance = floor (random 100);

_bonus_number = 1;
_btype_e = "";
_btype_w = "";

switch (d_side_mission_winner) do {
	case 1: {
		while {_btype_e == ""} do {
			_bonus_num_e = (d_sm_bonus_vehicle_array select 1) call XfRandomFloorArray;
			_vec_typex = (d_sm_bonus_vehicle_array select 1) select _bonus_num_e;
			_vecclass = toUpper (getText(configFile >> "CfgVehicles" >> _vec_typex >> "vehicleClass"));
			// 50 % chance for an Air vehicle now
			if (_chance > _airval) then {
				if (_vecclass == "AIR") then {_btype_e = _vec_typex};
			} else {
				if (_vecclass != "AIR") then {_btype_e = _vec_typex};
			};
			sleep 0.01;
		};
		_d_bonus_create_pos = d_bonus_create_pos_e;
		_vec_type = _btype_e;
		_d_bonus_air_positions = d_bonus_air_positions_e;
		_d_bonus_vec_positions = d_bonus_vec_positions_e;
		_d_bvp_counter = d_bvp_counter_e;
		_d_bap_counter = d_bap_counter_e;
	};
	case 2: {
		while {_btype_w == ""} do {
			_bonus_num_w = (d_sm_bonus_vehicle_array select 0) call XfRandomFloorArray;
			_vec_typex = (d_sm_bonus_vehicle_array select 0) select _bonus_num_w;
			_vecclass = toUpper (getText(configFile >> "CfgVehicles" >> _vec_typex >> "vehicleClass"));
			// 50 % chance for an Air vehicle now
			if (_chance > _airval) then {
				if (_vecclass == "AIR") then {_btype_w = _vec_typex};
			} else {
				if (_vecclass != "AIR") then {_btype_w = _vec_typex};
			};
			sleep 0.01;
		};
		_d_bonus_create_pos = d_bonus_create_pos_w;
		_vec_type = _btype_w;
		_d_bonus_air_positions = d_bonus_air_positions_w;
		_d_bonus_vec_positions = d_bonus_vec_positions_w;
		_d_bvp_counter = d_bvp_counter_w;
		_d_bap_counter = d_bap_counter_w;
	};
	case 123: {
		while {_btype_e == ""} do {
			_bonus_num_e = (d_sm_bonus_vehicle_array select 1) call XfRandomFloorArray;
			_vec_typex = (d_sm_bonus_vehicle_array select 1) select _bonus_num_e;
			_vecclass = toUpper (getText(configFile >> "CfgVehicles" >> _vec_typex >> "vehicleClass"));
			// 50 % chance for an Air vehicle now
			if (_chance > _airval) then {
				if (_vecclass == "AIR") then {_btype_e = _vec_typex};
			} else {
				if (_vecclass != "AIR") then {_btype_e = _vec_typex};
			};
			sleep 0.01;
		};
		_d_bonus_create_pos = d_bonus_create_pos_e;
		_vec_type = _btype_e;
		_d_bonus_air_positions = d_bonus_air_positions_e;
		_d_bonus_vec_positions = d_bonus_vec_positions_e;
		_d_bvp_counter = d_bvp_counter_e;
		_d_bap_counter = d_bap_counter_e;
		
		while {_btype_w == ""} do {
			_bonus_num_w = (d_sm_bonus_vehicle_array select 0) call XfRandomFloorArray;
			_vec_typex = (d_sm_bonus_vehicle_array select 0) select _bonus_num_w;
			_vecclass = toUpper (getText(configFile >> "CfgVehicles" >> _vec_typex >> "vehicleClass"));
			// 50 % chance for an Air vehicle now
			if (_chance > _airval) then {
				if (_vecclass == "AIR") then {_btype_w = _vec_typex};
			} else {
				if (_vecclass != "AIR") then {_btype_w = _vec_typex};
			};
			sleep 0.01;
		};
		
		_d_bonus_create_pos2 = d_bonus_create_pos_w;
		_vec_type2 = _btype_w;
		_d_bonus_air_positions2 = d_bonus_air_positions_w;
		_d_bonus_vec_positions2 = d_bonus_vec_positions_w;
		_d_bvp_counter2 = d_bvp_counter_w;
		_d_bap_counter2 = d_bap_counter_w;
	};
};
#endif

sleep 1.012;

#ifndef __TT__
_vehicle = createVehicle [_vec_type, _d_bonus_create_pos, [], 0, "NONE"];
_endpos = [];
_dir = 0;

if (_vehicle isKindOf "Air") then {
	_endpos = (_d_bonus_air_positions select _d_bap_counter) select 0;
	_dir = (_d_bonus_air_positions select _d_bap_counter) select 1;
	d_bap_counter = d_bap_counter + 1;
	if (d_bap_counter > (count _d_bonus_air_positions - 1)) then {d_bap_counter = 0};
} else {
	_endpos = (_d_bonus_vec_positions select _d_bvp_counter) select 0;
	_dir = (_d_bonus_vec_positions select _d_bvp_counter) select 1;
	d_bvp_counter = d_bvp_counter + 1;
	if (d_bvp_counter > (count _d_bonus_vec_positions - 1)) then {d_bvp_counter = 0};
	if (!("ACE" in d_version)) then {
		if ((getNumber(configFile >> "CfgVehicles" >> _vec_type >> "ARTY_IsArtyVehicle")) == 1) then {
			switch (_vec_type) do {
				case "MLRS": {
					_vehicle removeMagazine "12Rnd_MLRS";
					_vehicle addMagazine "ARTY_12Rnd_227mmHE_M270";
				};
				case "GRAD_RU": {
					_vehicle removeMagazine "40Rnd_GRAD";
					_vehicle addMagazine "ARTY_40Rnd_120mmHE_BM21";
				};
				case "MLRS_DES_EP1": {
					_vehicle removeMagazine "12Rnd_MLRS";
					_vehicle addMagazine "ARTY_12Rnd_227mmHE_M270";
				};
				case "GRAD_TK_EP1": {
					_vehicle removeMagazine "40Rnd_GRAD";
					_vehicle addMagazine "ARTY_40Rnd_120mmHE_BM21";
				};
			};
			["d_bi_a_v", _vehicle] call XNetCallEvent;
		};
	};
};

_vehicle setPos _endpos;
_vehicle setDir _dir;

_vehicle execFSM "fsms\Wreckmarker.fsm";
#else
_vehicle2 = objNull;

_vehicle = createVehicle [_vec_type, _d_bonus_create_pos, [], 0, "NONE"];
if (d_side_mission_winner == 123) then {
	_vehicle2 = createVehicle [_vec_type2, _d_bonus_create_pos2, [], 0, "NONE"];
};

if (_vehicle isKindOf "Air") then {
	_endpos = (_d_bonus_air_positions select _d_bap_counter) select 0;
	_dir = (_d_bonus_air_positions select _d_bap_counter) select 1;
	switch (d_side_mission_winner) do {
		case 1: {
			_vehicle setVariable ["D_VEC_SIDE", 1];
			d_bap_counter_e = d_bap_counter_e + 1;
			if (d_bap_counter_e > (count _d_bonus_air_positions - 1)) then {d_bap_counter_e = 0};
		};
		case 2: {
			_vehicle setVariable ["D_VEC_SIDE", 2];
			d_bap_counter_w = d_bap_counter_w + 1;
			if (d_bap_counter_w > (count _d_bonus_air_positions - 1)) then {d_bap_counter_w = 0};
		};
		case 123: {
			_vehicle setVariable ["D_VEC_SIDE", 1];
			_vehicle2 setVariable ["D_VEC_SIDE", 2];
			d_bap_counter_e = d_bap_counter_e + 1;
			if (d_bap_counter_e > (count _d_bonus_air_positions - 1)) then {d_bap_counter_e = 0};
			d_bap_counter_w = d_bap_counter_w + 1;
			if (d_bap_counter_w > (count _d_bonus_air_positions2 - 1)) then {d_bap_counter_w = 0};
		};
	};
} else {
	_endpos = (_d_bonus_vec_positions select _d_bvp_counter) select 0;
	_dir = (_d_bonus_vec_positions select _d_bvp_counter) select 1;
	switch (d_side_mission_winner) do {
		case 1: {
			_vehicle setVariable ["D_VEC_SIDE", 1];
			d_bvp_counter_e = d_bvp_counter_e + 1;
			if (d_bvp_counter_e > (count _d_bonus_vec_positions - 1)) then {d_bvp_counter_e = 0};
		};
		case 2: {
			_vehicle setVariable ["D_VEC_SIDE", 2];
			d_bvp_counter_w = d_bvp_counter_w + 1;
			if (d_bvp_counter_w > (count _d_bonus_vec_positions - 1)) then {d_bvp_counter_w = 0};
		};
		case 123: {
			_vehicle setVariable ["D_VEC_SIDE", 1];
			_vehicle2 setVariable ["D_VEC_SIDE", 2];
			d_bvp_counter_e = d_bvp_counter_e + 1;
			if (d_bvp_counter_e > (count _d_bonus_vec_positions - 1)) then {d_bvp_counter_e = 0};
			d_bvp_counter_w = d_bvp_counter_w + 1;
			if (d_bvp_counter_w > (count _d_bonus_vec_positions2 - 1)) then {d_bvp_counter_w = 0};
		};
	};
	if (!("ACE" in d_version)) then {
		if ((getNumber(configFile >> "CfgVehicles" >> _vec_type >> "ARTY_IsArtyVehicle")) == 1) then {
			switch (_vec_type) do {
				case "MLRS": {
					_vehicle removeMagazine "12Rnd_MLRS";
					_vehicle addMagazine "ARTY_12Rnd_227mmHE_M270";
				};
				case "GRAD_RU": {
					_vehicle removeMagazine "40Rnd_GRAD";
					_vehicle addMagazine "ARTY_40Rnd_120mmHE_BM21";
				};
				case "MLRS_DES_EP1": {
					_vehicle removeMagazine "12Rnd_MLRS";
					_vehicle addMagazine "ARTY_12Rnd_227mmHE_M270";
				};
				case "GRAD_TK_EP1": {
					_vehicle removeMagazine "40Rnd_GRAD";
					_vehicle addMagazine "ARTY_40Rnd_120mmHE_BM21";
				};
			};
			["d_bi_a_v", _vehicle] call XNetCallEvent;
		};
	};
};

if (!isNull _vehicle2) then {
	if (_vehicle2 isKindOf "Air") then {
		_endpos2 = (_d_bonus_air_positions2 select _d_bap_counter2) select 0;
		_dir2 = (_d_bonus_air_positions2 select _d_bap_counter2) select 1;
	} else {
		_endpos2 = (_d_bonus_vec_positions2 select _d_bvp_counter2) select 0;
		_dir2 = (_d_bonus_vec_positions2 select _d_bvp_counter2) select 1;
		if (!("ACE" in d_version)) then {
			if ((getNumber(configFile >> "CfgVehicles" >> _vec_type2 >> "ARTY_IsArtyVehicle")) == 1) then {
				switch (_vec_type2) do {
					case "MLRS": {
						_vehicle2 removeMagazine "12Rnd_MLRS";
						_vehicle2 addMagazine "ARTY_12Rnd_227mmHE_M270";
					};
					case "GRAD_RU": {
						_vehicle2 removeMagazine "40Rnd_GRAD";
						_vehicle2 addMagazine "ARTY_40Rnd_120mmHE_BM21";
					};
					case "MLRS_DES_EP1": {
						_vehicle2 removeMagazine "12Rnd_MLRS";
						_vehicle2 addMagazine "ARTY_12Rnd_227mmHE_M270";
					};
					case "GRAD_TK_EP1": {
						_vehicle2 removeMagazine "40Rnd_GRAD";
						_vehicle2 addMagazine "ARTY_40Rnd_120mmHE_BM21";
					};
				};
				["d_bi_a_v", _vehicle2] call XNetCallEvent;
			};
		};
	};
};

_vehicle setPos _endpos;
_vehicle setDir _dir;
_vehicle execFSM "fsms\Wreckmarker.fsm";
if (!isNull _vehicle2) then {
	_vehicle2 setPos _endpos2;
	_vehicle2 setDir _dir2;
	_vehicle2 execFSM "fsms\Wreckmarker.fsm";
};
#endif

["sm_res_client", [d_side_mission_winner,_bonus_number]] call XNetCallEvent;
#ifndef __TT__
d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MissionAccomplished",true];
#else
if (d_side_mission_winner == 1) then {
	d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","MissionFailure",true];
	d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","MissionAccomplished",true];
} else {
	d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","MissionAccomplished",true];
	d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","MissionFailure",true];
};
#endif

if (!X_SPE) then {d_side_mission_winner = 0};