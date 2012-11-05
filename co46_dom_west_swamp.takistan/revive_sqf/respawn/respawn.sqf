// respawn.sqf 
// © JULY 2009 - norrin 
_unit = _this select 0;
_respawn_position = NORRN_revive_array select 28;
_respawn_at_base_addWeapons	= NORRN_revive_array select 11;
_respawn_at_base_magazines = NORRN_revive_array select 34;
_respawn_at_base_weapons = NORRN_revive_array select 35;
_respawnAtBaseWait = NORRN_revive_array select 68;

_no_respawn_points = NORRN_revive_array select 12;
_Base_1 = NORRN_revive_array select 13;
_Base_2 = NORRN_revive_array select 14;
_Base_3 = NORRN_revive_array select 15;
_Base_4 = NORRN_revive_array select 16;	

_mobile_spawn = NORRN_revive_array select 51; 

waitUntil{!isNull (missionNamespace getVariable _unit)};
_name = missionNamespace getVariable _unit;
_unconscious_body = objNull;
_pos = [];

sleep 2;

_base_weps = [];
_base_mags = [];
if (_respawn_at_base_addWeapons == 1 && count _respawn_at_base_magazines == 0 && count _respawn_at_base_weapons == 0) then {
	_base_weps = weapons _name;
	_base_mags = magazines _name;	
};
hint "No revive";
while {true} do {
	waitUntil {local (missionNamespace getVariable _unit)};
	_name = missionNamespace getVariable _unit;
	waitUntil {!alive _name || !local _name};

	if (local _name) then {
		if (_name == player) then {titletext["","BLACK FADED", 5]};
		_pos = getPos _name;
		_weps = weapons _name;
		_mags = magazines _name;	
		waitUntil{alive (missionNamespace getVariable _unit)};
		_name 	= missionNamespace getVariable _unit;

		removeAllWeapons _name;
		{_name removeMagazine _x} forEach magazines _name;
		removeAllItems _name;
		{_name addMagazine _x} forEach _mags;
		{_name addWeapon _x} forEach _weps;
		_name selectWeapon (primaryWeapon _name);

		if (_respawn_position == 2 &&  isplayer _name || _respawn_position == 3 &&  isplayer _name) then {
			if (_mobile_spawn == 1) then {
				if (NORRN_camo_net) then {
					_no_respawn_points = NORRN_revive_array select 12;
					_Base_1 = NORRN_revive_array select 13;
					_Base_2 = NORRN_revive_array select 14;
					_Base_3 = NORRN_revive_array select 15;
					_Base_4 = NORRN_revive_array select 16;
				} else {
					_no_respawn_points = NORRN_revive_array select 12;
					_no_respawn_points = _no_respawn_points - 1;
					_Base_1 = NORRN_revive_array select 14;
					_Base_2 = NORRN_revive_array select 15;
					_Base_3 = NORRN_revive_array select 16;	
				};
			};

			closedialog 0;
			_dialog_5 = createDialog (switch (_no_respawn_points) do {
				case 1: {"respawn_button_1map"};
				case 2: {"respawn_button_2map"};
				case 3: {"respawn_button_3map"};
				case 4: {"respawn_button_4map"};
			});
			if (_no_respawn_points > 0) then {ctrlSetText [1, "Base"]};
			if (_no_respawn_points > 1) then {ctrlSetText [2, "MR 1"]};
			if (_no_respawn_points > 2) then {ctrlSetText [3, "MR 2"]};
			if (_no_respawn_points > 3) then {ctrlSetText [4, _Base_4]};
		};

		switch (_respawn_position) do {
			case 1: {_respawn_at_base = [_name, _pos] call Norrn_RespawnPos1};
			case 2: {if (isplayer _name || _respawn_position == 3 &&  isplayer _name) then {_respawn_at_base = [_unconscious_body] call Norrn_RespawnPos2}};
			case 3: {if (!isplayer _name || _respawn_position == 3 && !isplayer _name) then {_respawn_at_base = [_name, _pos] call Norrn_RespawnPos2AI}};
		};

		if ((_respawnAtBaseWait select 1) != 0) then {
			_timer	= time + (_respawnAtBaseWait select 1);
			_name disableAI "anim";
			_c = 1;
			["r_setcap", [_name, true]] call RNetCallEvent;
			while {_timer >= time} do {
				if (_name == player) then {
					titletext [format ["You will respawn in %1 seconds", round (_timer - time)],"BLACK FADED", 0.3];
				};
				sleep 1;
			};
			["r_setcap", [_name, false]] call RNetCallEvent;
			_name enableAI "anim";
		};

		if (_respawn_at_base_addWeapons == 1) then {
			if (count _respawn_at_base_magazines == 0 && count _respawn_at_base_weapons == 0) then {
				removeAllWeapons _name;
				{_name removeMagazine _x} forEach magazines _name;
				removeAllItems _name;
				{_name addMagazine _x} forEach _base_mags;
				{_name addWeapon _x} forEach _base_weps;
				_name selectweapon primaryweapon _name;
			} else {
				removeAllWeapons _name;
				{_name removeMagazine _x} forEach magazines _name;
				removeAllItems _name;
				{_name addMagazine _x} forEach _respawn_at_base_magazines;
				{_name addWeapon _x} forEach _respawn_at_base_weapons;
				_name selectweapon primaryweapon _name;
			};
		};
	};
	sleep 1;
}; 