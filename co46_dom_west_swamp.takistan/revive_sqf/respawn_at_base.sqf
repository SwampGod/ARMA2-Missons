/*
RESPAWN AT BASE SCRIPT

© AUGUST 2009 - norrin
*/
disableserialization;

_spawn_pos = _this select 0;
_name = _this select 1;

_no_respawn_points = NORRN_revive_array select 12;
_Base_1 = NORRN_revive_array select 13;
_Base_2 = NORRN_revive_array select 14;
_Base_3 = NORRN_revive_array select 15;
_Base_4 = NORRN_revive_array select 16;
_max_respawns = NORRN_revive_array select 38;
_mobile_spawn = NORRN_revive_array select 51;
_mobile_base_start = NORRN_revive_array select 52;
_respawnAtBaseWait = NORRN_revive_array select 68;
_baseWait = false;
_height = 0;

_no_base_1 = no_base_1;
_no_base_1b = no_base_1b;
_no_base_2 = no_base_2;
_no_base_2b = no_base_2b;
_no_base_3 = no_base_3;
_no_base_3b = no_base_3b;
_no_base_4 = no_base_4;
_no_base_4b = no_base_4b;

_r_dialog_1 = "";
_r_dialog_2 = "";
_r_dialog_3 = "";
_r_dialog_4 = "";
_r_display  = "";

detach _name;

_pos = getPos _name;
_offset = _name distance _pos;
_name setVariable ["NORRN_uncPos", [(_pos select 0),(_pos select 1), _offset], true];

if (_mobile_spawn == 1) then {
	if (!NORRN_camo_net) then {
		_Base_1 = NORRN_revive_array select 14;
		_Base_2 = NORRN_revive_array select 15;
		_Base_3 = NORRN_revive_array select 16;
		_no_respawn_points  = _no_respawn_points - 1;
		if ((_spawn_pos == 2 && _Base_2 == "") || (_spawn_pos == 3 && _Base_3 == "") || (_spawn_pos == 4 && _Base_4 == "")) then {_Base_2 = NORRN_revive_array select 14};
		_no_base_1  = no_base_2;
		_no_base_1b = no_base_2b;
		_no_base_2  = no_base_3;
		_no_base_2b = no_base_3b;
		_no_base_3  = no_base_4;
		_no_base_3b = no_base_4b;
	};
};

switch (_spawn_pos) do {
	case 1: {
		if (isNil "d_with_carrier") then {
			_name setpos markerpos "base_spawn_1";
		} else {
			_name setPosASL [markerpos "base_spawn_1" select 0, markerpos "base_spawn_1" select 1, 16.20];
		};
		_respawn_message = "You have respawned at your Main Base";
		if (_name == player) then {titletext [_respawn_message, "BLACK FADED", 1]};
		_name setVariable ["NORRN_respawn_at_base", true];
		NORRN_spawn_chosen = true;
		_baseWait = true;
		sleep 1;
		if (NORRNCustomExec3 != "") then {call compile NORRNCustomExec3};
		_nobs = if ("OA" in d_version) then {
			nearestObjects [player, ["USSpecialWeapons_EP1","TKSpecialWeapons_EP1","RUBasicAmmunitionBox","LocalBasicAmmunitionBox","M1133_MEV_EP1","BMP2_HQ_TK_EP1"], 30]
		} else {
			nearestObjects [player, ["USSpecialWeaponsBox","RUBasicAmmunitionBox","LocalBasicAmmunitionBox","LAV25_HQ","BTR90_HQ"], 30]
		};
		{player reveal _x} forEach _nobs;
	};
	case 2: {
		if (X_JIPH getVariable "mr1_in_air") then {
			if (NORRN_r_time_expire) then {
				titleText ["Mobile Respawn One gets currently transported.\n\nChoose another Spawn Point", "BLACK FADED", 10];
			}else{
				titleText ["Mobile Respawn One gets currently transported.\n\nChoose another Spawn Point", "PLAIN", 0.3];
			};
			closedialog 0;
			switch (_no_respawn_points) do {
				case 3: {_dialog_1 = createDialog "respawn_button_3map";ctrlSetText [1, "Base"];ctrlSetText [2, "MR 1"];ctrlSetText [3, "MR 2"];};
			};
			if (NORRNCustomExec4 != "") then {call compile NORRNCustomExec4};
		} else {
			if (speed MRR1 > 4) then {
				if (NORRN_r_time_expire) then {
					titleText ["Mobile Respawn One currently driving.\n\nChoose another Spawn Point", "BLACK FADED", 10];
				}else{
					titleText ["Mobile Respawn One currently driving.\n\nChoose another Spawn Point", "PLAIN", 0.3];
				};
				closedialog 0;
				switch (_no_respawn_points) do {
					case 3: {_dialog_1 = createDialog "respawn_button_3map";ctrlSetText [1, "Base"];ctrlSetText [2, "MR 1"];ctrlSetText [3, "MR 2"];};
				};
				if (NORRNCustomExec4 != "") then {call compile NORRNCustomExec4};
			} else {
				if (surfaceIsWater [(position MRR1) select 0,(position MRR1) select 1]) then {
					if (NORRN_r_time_expire) then {
						titleText ["Mobile Respawn One currently in water.\n\nChoose another Spawn Point", "BLACK FADED", 10];
					}else{
						titleText ["Mobile Respawn One currently in water.\n\nChoose another Spawn Point", "PLAIN", 0.3];
					};
					closedialog 0;
					switch (_no_respawn_points) do {
						case 3: {_dialog_1 = createDialog "respawn_button_3map";ctrlSetText [1, "Base"];ctrlSetText [2, "MR 1"];ctrlSetText [3, "MR 2"];};
					};
					if (NORRNCustomExec4 != "") then {call compile NORRNCustomExec4};
				} else {
					_depl = MRR1 getVariable "D_MHQ_Deployed";
					if (isNil "_depl") then {_depl = false};
					if (!_depl) then {
						if (NORRN_r_time_expire) then {
							titleText ["Mobile Respawn One not deployed.\n\nChoose another Spawn Point", "BLACK FADED", 10];
						}else{
							titleText ["Mobile Respawn One not deployed.\n\nChoose another Spawn Point", "PLAIN", 0.3];
						};
						closedialog 0;
						switch (_no_respawn_points) do {
							case 3: {_dialog_1 = createDialog "respawn_button_3map";ctrlSetText [1, "Base"];ctrlSetText [2, "MR 1"];ctrlSetText [3, "MR 2"];};
						};
						if (NORRNCustomExec4 != "") then {call compile NORRNCustomExec4};
					} else {
						_global_pos = MRR1 modelToWorld [0,-5,0];
						_global_dir = direction MRR1;
						player setPos _global_pos;
						player setDir _global_dir;
						_respawn_message = "You have respawned at Mobile Respawn One"; 
						if (_name == player) then {titleText [_respawn_message, "BLACK FADED", 1]};
						_name setVariable ["NORRN_respawn_at_base", true];
						NORRN_spawn_chosen = true;
						_baseWait = true;
						sleep 1;
						if (NORRNCustomExec3 != "") then {call compile NORRNCustomExec3};
						_nobs = if ("OA" in d_version) then {
							nearestObjects [player, ["USBasicWeapons_EP1","TKBasicWeapons_EP1","LocalBasicAmmunitionBox","M1133_MEV_EP1","BMP2_HQ_TK_EP1"], 30]
						} else {
							nearestObjects [player, ["USBasicWeaponsBox","RUBasicAmmunitionBox","LocalBasicAmmunitionBox","LAV25_HQ","BTR90_HQ"], 30]
						};
						{player reveal _x} forEach _nobs;
					};
				};
			};
		};
	};
	case 3: {
		if (X_JIPH getVariable "mr2_in_air") then {
			if (NORRN_r_time_expire) then {
				titleText ["Mobile Respawn Two gets currently transported.\n\nChoose another Spawn Point", "BLACK FADED", 10];
			}else{
				titleText ["Mobile Respawn Two gets currently transported.\n\nChoose another Spawn Point", "PLAIN", 0.3];
			};
			closedialog 0;
			switch (_no_respawn_points) do {
				case 3: {_dialog_1 = createDialog "respawn_button_3map";ctrlSetText [1, "Base"];ctrlSetText [2, "MR 1"];ctrlSetText [3, "MR 2"];};
			};
			if (NORRNCustomExec4 != "") then {call compile NORRNCustomExec4};
		} else {
			if (speed MRR2 > 4) then {
				if (NORRN_r_time_expire) then {
					titleText ["Mobile Respawn Two currently driving.\n\nChoose another Spawn Point", "BLACK FADED", 10];
				}else{
					titleText ["Mobile Respawn Two currently driving.\n\nChoose another Spawn Point", "PLAIN", 0.3];
				};
				closedialog 0;
				switch (_no_respawn_points) do {
					case 3: {_dialog_1 = createDialog "respawn_button_3map";ctrlSetText [1, "Base"];ctrlSetText [2, "MR 1"];ctrlSetText [3, "MR 2"];};
				};
				if (NORRNCustomExec4 != "") then {call compile NORRNCustomExec4};
			} else {
				if (surfaceIsWater [(position MRR2) select 0,(position MRR2) select 1]) then {
					if (NORRN_r_time_expire) then {
						titleText ["Mobile Respawn Two currently in water.\n\nChoose another Spawn Point", "BLACK FADED", 10];
					}else{
						titleText ["Mobile Respawn Two currently in water.\n\nChoose another Spawn Point", "PLAIN", 0.3];
					};
					closedialog 0;
					switch (_no_respawn_points) do {
						case 3: {_dialog_1 = createDialog "respawn_button_3map";ctrlSetText [1, "Base"];ctrlSetText [2, "MR 1"];ctrlSetText [3, "MR 2"];};
					};
					if (NORRNCustomExec4 != "") then {call compile NORRNCustomExec4};
				} else {
					_depl = MRR2 getVariable "D_MHQ_Deployed";
					if (isNil "_depl") then {_depl = false};
					if (!_depl) then {
						if (NORRN_r_time_expire) then {
							titleText ["Mobile Respawn Two not deployed.\n\nChoose another Spawn Point", "BLACK FADED", 10];
						}else{
							titleText ["Mobile Respawn Two not deployed.\n\nChoose another Spawn Point", "PLAIN", 0.3];
						};
						closedialog 0;
						switch (_no_respawn_points) do {
							case 3: {_dialog_1 = createDialog "respawn_button_3map";ctrlSetText [1, "Base"];ctrlSetText [2, "MR 1"];ctrlSetText [3, "MR 2"];};
						};
						if (NORRNCustomExec4 != "") then {call compile NORRNCustomExec4};
					} else {
						_global_pos = MRR2 modelToWorld [0,-5,0];
						_global_dir = direction MRR2;
						player setPos _global_pos;
						player setDir _global_dir;
						_respawn_message = "You have respawned at Mobile Respawn Two"; 
						if (_name == player) then {titleText [_respawn_message, "BLACK FADED", 1]};
						_name setVariable ["NORRN_respawn_at_base", true];
						NORRN_spawn_chosen = true;
						_baseWait = true;
						sleep 1;
						If (NORRNCustomExec3 != "") then {call compile NORRNCustomExec3};
						_nobs = if ("OA" in d_version) then {
							nearestObjects [player, ["USBasicWeapons_EP1","TKBasicWeapons_EP1","LocalBasicAmmunitionBox","M1133_MEV_EP1","BMP2_HQ_TK_EP1"], 30]
						} else {
							nearestObjects [player, ["USBasicWeaponsBox","RUBasicAmmunitionBox","LocalBasicAmmunitionBox","LAV25_HQ","BTR90_HQ"], 30]
						};
						{player reveal _x} forEach _nobs;
					};
				};
			};
		};
	};
};
sleep 2;

if ((_respawnAtBaseWait select 0) == 1 && _baseWait && _max_respawns != 2000) then {
	_timer	= (_respawnAtBaseWait select 1);
	_c = 1;
	["r_setcap", [_name, true]] call RNetCallEvent;
	while {_timer >= 0} do {
			if (_c >= 1 ) then {
				_timer_message = format ["You will respawn in %1 seconds", _timer];
				if (_name == player) then {titletext [_timer_message,"BLACK FADED", 0.3]};
				_timer = _timer - 1;
				_c = 0;
			};
			sleep 0.05;
			_c = _c + 0.05;
	};
};
["r_setcap", [_name, false]] call RNetCallEvent;