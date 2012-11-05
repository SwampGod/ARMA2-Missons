// by Xeno
#include "x_setup.sqf"
private ["_vehicle", "_endpos", "_dir", "_extra_bonus_number", "_extra_bonus_number2", "_vehicle2", "_d_bonus_air_positions", "_d_bap_counter", "_d_bonus_vec_positions", "_d_bvp_counter", "_d_bonus_air_positions2", "_d_bap_counter2", "_d_bonus_vec_positions2", "_d_bvp_counter2", "_endpos2", "_dir2", "_rextra_bonus_number"];

if (!isServer) exitWith {};

sleep 1.012;

#ifndef __TT__
_rextra_bonus_number = d_mt_bonus_vehicle_array call XfRandomFloorArray;
_vehicle = createVehicle [(d_mt_bonus_vehicle_array select _rextra_bonus_number), d_bonus_create_pos, [], 0, "NONE"];
_endpos = [];
_dir = 0;
if (_vehicle isKindOf "Air") then {
	_endpos = (d_bonus_air_positions select d_bap_counter) select 0;
	_dir = (d_bonus_air_positions select d_bap_counter) select 1;
	d_bap_counter = d_bap_counter + 1;
	if (d_bap_counter > (count d_bonus_air_positions - 1)) then {d_bap_counter = 0};
} else {
	_endpos = (d_bonus_vec_positions select d_bvp_counter) select 0;
	_dir = (d_bonus_vec_positions select d_bvp_counter) select 1;
	d_bvp_counter = d_bvp_counter + 1;
	if (d_bvp_counter > (count d_bonus_vec_positions - 1)) then {d_bvp_counter = 0};
	if (!("ACE" in d_version)) then {
		if ((getNumber(configFile >> "CfgVehicles" >> (d_mt_bonus_vehicle_array select _rextra_bonus_number) >> "ARTY_IsArtyVehicle")) == 1) then {
			switch (typeOf _vehicle) do {
				case "MLRS": {
					_vehicle removeMagazine "12Rnd_MLRS";
				};
				case "GRAD_RU": {
					_vehicle removeMagazine "40Rnd_GRAD";
					_vehicle addMagazine "ARTY_40Rnd_120mmHE_BM21";
				};
				case "MLRS_DES_EP1": {
					_vehicle removeMagazine "12Rnd_MLRS";
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
_rextra_bonus_number = 1;

_extra_bonus_number = (d_mt_bonus_vehicle_array select 0) call XfRandomFloorArray;
_extra_bonus_number2 = (d_mt_bonus_vehicle_array select 1) call XfRandomFloorArray;

_vehicle2 = objNull;

if (d_mt_winner == 1) then {
	_vehicle = createVehicle [((d_mt_bonus_vehicle_array select 0) select _extra_bonus_number), d_bonus_create_pos_w, [], 0, "NONE"];
	_vehicle setVariable ["D_VEC_SIDE", 2];
	_d_bonus_air_positions = d_bonus_air_positions_w;
	_d_bap_counter = d_bap_counter_w;
	_d_bonus_vec_positions = d_bonus_vec_positions_w;
	_d_bvp_counter = d_bvp_counter_w;
} else {
	if (d_mt_winner == 2) then {
		_vehicle = createVehicle [((d_mt_bonus_vehicle_array select 1) select _extra_bonus_number2), d_bonus_create_pos_e, [], 0, "NONE"];
		_vehicle setVariable ["D_VEC_SIDE", 1];
		_d_bonus_air_positions = d_bonus_air_positions_e;
		_d_bap_counter = d_bap_counter_e;
		_d_bonus_vec_positions = d_bonus_vec_positions_e;
		_d_bvp_counter = d_bvp_counter_e;
	} else {
		_vehicle = createVehicle [((d_mt_bonus_vehicle_array select 0) select _extra_bonus_number), d_bonus_create_pos_w, [], 0, "NONE"];
		_vehicle2 = createVehicle [((d_mt_bonus_vehicle_array select 1) select _extra_bonus_number2), d_bonus_create_pos_e, [], 0, "NONE"];
		_vehicle setVariable ["D_VEC_SIDE", 2];
		_vehicle2 setVariable ["D_VEC_SIDE", 1];
		_d_bonus_air_positions = d_bonus_air_positions_w;
		_d_bonus_air_positions2 = d_bonus_air_positions_e;
		_d_bap_counter = d_bap_counter_w;
		_d_bap_counter2 = d_bap_counter_e;
		_d_bonus_vec_positions = d_bonus_vec_positions_w;
		_d_bonus_vec_positions2 = d_bonus_vec_positions_e;
		_d_bvp_counter = d_bvp_counter_w;
		_d_bvp_counter2 = d_bvp_counter_e;
	};
};

_endpos = [];
_dir = 0;
if (_vehicle isKindOf "Air") then {
	_endpos = (_d_bonus_air_positions select _d_bap_counter) select 0;
	_dir = (_d_bonus_air_positions select _d_bap_counter) select 1;
	switch (d_mt_winner) do {
		case 1: {
			d_bap_counter_w = d_bap_counter_w + 1;
			if (d_bap_counter_w > (count d_bonus_air_positions_w - 1)) then {d_bap_counter_w = 0};
		};
		case 2: {
			d_bap_counter_e = d_bap_counter_e + 1;
			if (d_bap_counter_e > (count d_bonus_air_positions_e - 1)) then {d_bap_counter_e = 0};
		};
		case 3: {
			d_bap_counter_w = d_bap_counter_w + 1;
			if (d_bap_counter_w > (count d_bonus_air_positions_w - 1)) then {d_bap_counter_w = 0};
			d_bap_counter_e = d_bap_counter_e + 1;
			if (d_bap_counter_e > (count d_bonus_air_positions_e - 1)) then {d_bap_counter_e = 0};
		};
	};
} else {
	_endpos = (_d_bonus_vec_positions select _d_bvp_counter) select 0;
	_dir = (_d_bonus_vec_positions select _d_bvp_counter) select 1;
	switch (d_mt_winner) do {
		case 1: {
			d_bvp_counter_w = d_bvp_counter_w + 1;
			if (d_bvp_counter_w > (count d_bonus_vec_positions_w - 1)) then {d_bvp_counter_w = 0};
		};
		case 2: {
			d_bvp_counter_e = d_bvp_counter_e + 1;
			if (d_bvp_counter_e > (count d_bonus_vec_positions_e - 1)) then {d_bvp_counter_e = 0};
		};
		case 3: {
			d_bvp_counter_w = d_bvp_counter_w + 1;
			if (d_bvp_counter_w > (count d_bonus_vec_positions_w - 1)) then {d_bvp_counter_w = 0};
			d_bvp_counter_e = d_bvp_counter_e + 1;
			if (d_bvp_counter_e > (count d_bonus_vec_positions_e - 1)) then {d_bvp_counter_e = 0};
		};
	};
	if (!("ACE" in d_version)) then {
		if ((getNumber(configFile >> "CfgVehicles" >> typeOf _vehicle >> "ARTY_IsArtyVehicle")) == 1) then {
			switch (typeOf _vehicle) do {
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
			if ((getNumber(configFile >> "CfgVehicles" >> typeOf _vehicle2 >> "ARTY_IsArtyVehicle")) == 1) then {
				switch (typeOf _vehicle2) do {
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

["target_clear",true] call XNetSetJIP;
["target_clear", _rextra_bonus_number] call XNetCallEvent;
__TargetInfo
_tname = _current_target_name call XfKBUseName;
#ifndef __TT__
d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"Captured",["1","",_current_target_name,[_tname]],true];
#else
d_hq_logic_en1 kbTell [d_hq_logic_en2,"HQ_W","Captured",["1","",_current_target_name,[_tname]],true];
d_hq_logic_ru1 kbTell [d_hq_logic_ru2,"HQ_E","Captured",["1","",_current_target_name,[_tname]],true];
#endif