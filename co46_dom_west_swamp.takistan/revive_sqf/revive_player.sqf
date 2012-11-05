/*
  AI ENABLED REVIVE SCRIPT

  © NOVEMBER 2009 - norrin  
*/

private ["_unit","_units","_name","_respawn","_conscious","_group","_leader","_c","_cc","_d","_doMove_time","_respawn_at_base","_dead",
	"_busy","_unc_unit","_revive_array","_unit_type","_r_marker_side","_revive_units","_marker_pos",
	"_mrkr_ex","_revives","_revives_remain","_max_respawns","_no_revives","_close_array","_unc_array","_mags","_goto_reviver","_close_unc",
	"_smoke_rounds","_busy","_round","_bloggs_pos","_bloggs_offset","_sav_pos","_sav_dir","_doMove_time","_water","_body","_pos","_dir",
	"_offset","_weapons","_magazines","_AI_dismount"];

_unit = _this select 0;
_strunit = str(_unit);
_units = _this select 1;

waitUntil{!isNull (missionNamespace getVariable _strunit)};
_name = missionNamespace getVariable _strunit;

_respawn = false;
_conscious = false;
_respawn_at_base = false;
_dead = false;
NORRN_load_wounded_action = false;
r_drag_sqf = false;
r_carry_sqf = false;
all_dead_check = false;
_revive_array = NORRN_revive_array;
_my_group = [];
_revive_units = [];
_base_weps = [];
_base_mags = [];
_near_Objects = [];
_c = 0;
_cc = 0;
_ccc = 0;
_cccc = 0;
_ccccc = 0;
_cccccc = 0;
_ccccccc = 0;	
_d = 0;
_dd = 0;
_ddd = 0;
_dddd = 0;
_ddddd = 0;
_doMove_time = 0;
_NORRN_random = 0;
_bleed_damage = 0;
_total_medpacks = 0;
_total_bandages = 0;
_blackout = 0;
_bonus = 0;
_respawns = 0;
_respawn_chance = 0; 
_var = 0;
_reviveWait = 0;
NORRN_max_slope = 0.78;
if (_name == player) then {unconscious_body = objNull};
_unc_unit = objNull;
_goto_reviver = objNull;
_goto_protect = objNull;
_near_dragUnit = objNull;
_near_loadUnit = objNull;
_reviver = objNull;
GetSlopeObject = objNull;

_group = group _name;
_unit_type = typeOf _name;

_unconscious_markers = _revive_array select 4;
_call_out_function = _revive_array select 6;
_revive_timer = _revive_array select 7;
_goto_revive = _revive_array select 9;

_respawn_at_base_addWeapons	= _revive_array select 11;
_no_respawn_points = _revive_array select 12;
_Base_1 = _revive_array select 13;
_Base_2 = _revive_array select 14;
_Base_3 = _revive_array select 15;
_Base_4 = _revive_array select 16;

_can_revive = _revive_array select 18;
_can_revive_2 = _revive_array select 19;
_can_be_revived = _revive_array select 20;
_can_be_revived_2 = _revive_array select 21;
_medic_1 = _revive_array select 76;
_medic_2 = _revive_array select 77;

_enemy_side_1 = _revive_array select 23;
_enemy_side_2 = _revive_array select 24;

_revive_time_limit = _revive_array select 27;
_respawn_position = _revive_array select 28;

_goto_revive_distance = _revive_array select 33;
_respawn_at_base_magazines = _revive_array select 34;
_respawn_at_base_weapons = _revive_array select 35;
_revive_damage = _revive_array select 37;
_max_respawns = _revive_array select 38;
_JIP_respawns = _revive_array select 63;
_unc_drag = _revive_array select 39;
_AI_smoke = _revive_array select 40;
_visible_timer = _revive_array select 41;
_water_dialog = _revive_array select 45;

_enemy_units_1 = _revive_array select 47;
_enemy_units_2 = _revive_array select 48;
_mobile_spawn = _revive_array select 51;
_QG_animation = _revive_array select 54;

_load_wounded = _revive_array select 61;
_caseVAC = _revive_array select 64;
_chance_ofDeath = _revive_array select 66;

_medpacks = _revive_array select 80;
_bleeding = _revive_array select 82;
_medic_medpacks = _revive_array select 83;
_unit_medpacks = _revive_array select 84;
_medic_bandages = _revive_array select 85;
_unit_bandages = _revive_array select 86;

_deadSpectator_cam = _revive_array select 92;
_drop_weapons = _revive_array select 93;
_cadaver = _revive_array select 94;
_reward_function = _revive_array select 96;
_revives_required = _revive_array select 97;
_team_kill_function = _revive_array select 98;
_no_team_kills = _revive_array select 99;

_AI_disabled = getNumber(missionConfigFile >> "disabledAI");

if (_QG_animation == 1) then {
	r_unc_animation = "ainjppnemstpsnonwrfldnon";
} else {
	r_unc_animation = "AmovPpneMstpSnonWnonDnon_healed";
};

commentsBrian = ["DBrian_Im_hit","DBrian_Im_bleeding","DBrian_Medic","DBrian_Bastards","DBrian_Shit_Man_down","DBrian_Oh_no","DBrian_Fuck","DBrian_Fuck_it","DBrian_Shit","DBrian_Need_help","DBrian_A_little_help_here"];

_r_marker_side = switch (side _name) do {
	case west: {"respawn_west"};
	case east: {"respawn_east"};
	case resistance: {"respawn_guerrila"};
	case civilian: {"respawn_civilian"};
};

NORRN_respawn_mrkr = markerPos _r_marker_side;

{_ur = missionNamespace getVariable _x;if (!isNull _ur) then {_revive_units set [count _revive_units, ur]}} forEach _units;

{if (!isNull _x && _x in _revive_units) then {_my_group set [count _my_group, str(x)]}}forEach (units _group);
_group_leader = str(leader _group);

sleep 2;
if (_respawn_at_base_addWeapons == 1 && count _respawn_at_base_magazines == 0 && count _respawn_at_base_weapons == 0) then {
	_base_weps = weapons _name;
	_base_mags = magazines _name;	
}; 

if (_max_respawns != 1000 && (_JIP_respawns select 0) != 0) then {
	if (time > (_JIP_respawns select 1)) then {_max_respawns = (_JIP_respawns select 0)};
};	

if (local _name) then {
	if (isNil {_name getVariable "NORRN_lives_used"}) then {_name setVariable ["NORRN_lives_used", 0, true]};
	if (isNil {_name getVariable "NORRN_unconscious"}) then {_name setVariable ["NORRN_unconscious", false, true]};
	if (isNil {_name getVariable "NORRN_AIunconscious"}) then {_name setVariable ["NORRN_AIunconscious", false, true]};
	if (isNil {_name getVariable "NORRN_bonus_life"}) then {_name setVariable ["NORRN_bonus_life", 0, false]};
	if (isNil {_name getVariable "NORRN_teamkill_punish"}) then {_name setVariable ["NORRN_teamkill_punish", 0, true]};
	if (isNil {_name getVariable "NORRN_stopBleed"}) then {_name setVariable ["NORRN_stopBleed", false, true]};
	if (isNil {_name getVariable "NORRN_bleeding"}) then {_name setVariable ["NORRN_bleeding", false, true]};
	if (isNil {_name getVariable "NORRN_bleedDamage"}) then {_name setVariable ["NORRN_bleedDamage", 0, true]};
	if (isNil {_name getVariable "NORRN_dead"}) then {_name setVariable ["NORRN_dead", false, true]};
	if (isNil {_name getVariable "NORRN_AI_help"}) then {_name setVariable ["NORRN_AI_help", false, true]};
	//if (isNil {_name getVariable "NORRN_AISmoke"}) then {_name setVariable ["NORRN_AISmoke", [false,""]]};
	if (isNil {_name getVariable "NORRN_uncPos"}) then {_name setVariable ["NORRN_uncPos", [], true]};
	if (isNil {_name getVariable "NORRN_AIReviver"}) then {_name setVariable ["NORRN_AIReviver", objNull, true]};
	if (isNil {_name getVariable "NORRN_respawn_at_base"}) then {_name setVariable ["NORRN_respawn_at_base", false]};

	if (isNil {_name getVariable "NORRN_medpacks"}) then {_name setVariable ["NORRN_medpacks", _unit_medpacks, true]};
	if (_name isKindOf _medic_1 || _name isKindOf _medic_2) then {_name setVariable ["NORRN_medpacks", _medic_medpacks, true]};
	_total_medpacks = _name getVariable "NORRN_medpacks";
	if (isNil {_name getVariable "NORRN_bandages"}) then {_name setVariable ["NORRN_bandages", _unit_bandages, true]};
	if (_name isKindOf _medic_1 || _name isKindOf _medic_2) then {_name setVariable ["NORRN_bandages", _medic_bandages, true]};
	_total_bandages = _name getVariable "NORRN_bandages";
	
	if (_name getVariable "NORRN_unconscious") then {
		_respawn = true; 
		_conscious = false;
		if (_name == player) then {unconscious_body =_name};
		_revived_position = true;
		_pos = getPos _name;
		_dir = getDir _name;
		_offset = _name distance _pos;
		_weapons = weapons _name;
		_magazines = magazines _name;
	};

	{
		if (!isNull _x && _unconscious_markers == 1 && isplayer _name) then {
			if (!isNull _x && (_x getVariable 'NORRN_unconscious')) then {
				_mrker_pos = getPos _x;
				_mrkr_ex = format ["%1 is down", _x];
				createMarkerlocal [_mrkr_ex, _mrker_pos];
				_mrkr_ex setMarkerColorlocal "ColorBlue";
				_mrkr_ex setMarkerTypelocal "Flag1";
				_mrkr_ex setMarkerTextlocal (format ["%1 is down", name _x]);
				_mrkr_ex setMarkerSizelocal [0.4, 0.4];
			};
		}
	} forEach _revive_units;
	
	if (_max_respawns != 1000 && _name == player) then {
		_revives = _name getVariable "NORRN_lives_used"; 
		_revives_remain = _max_respawns - _revives;
		_no_revives = format ["Lives remaining: %1 out of %2", _revives_remain, _max_respawns];
		if (_name == player) then {hint _no_revives};
	};
	if (_max_respawns == 1000 && _name == player) then {hint "Unlimited lives"};

	if (_team_kill_function == 1 && _max_respawns != 1000) then {_name addEventHandler ["killed", {_this execVM "revive_sqf\team_killer.sqf"}]};

	if ((_chance_ofDeath select 0) == 1 || (_chance_ofDeath select 1) == 1) then {
		_name addEventHandler ["dammaged", {(_this select 0) setVariable ["NORRN_body_part", _this select 1]}];
		_name addeventhandler ["killed", {(_this select 0) setVariable ["NORRN_kh_killer", _this select 1, false]}];
	};

	if (_name == player) then {if (isNil "GetSlopeObject") then {GetSlopeObject = "HeliHEmpty" createVehicleLocal [0,0,0]}};
};

while {true} do {
	scopeName "Revive_01";
	if(!alive _name) then {_respawn = true; _conscious = false;_busy = 0};
	_name = missionNamespace getVariable _strunit;

	while{!isNull _name && !local _name || isNull _name} do {
		if (!alive _name) then {waitUntil{alive (missionNamespace getVariable _strunit)}};
		_name = missionNamespace getVariable _strunit;
		if (isnull _name) exitWith {breakOut "Revive_01"};
		if (_name getVariable "NORRN_unconscious") then {
			_respawn = true; 
			_conscious = false;
			if (!surfaceIsWater getPos _name) then {
				_revived_position = true;
			} else {
				_revived_position = false;
			};
		} else {
			_respawn = false; 
			_conscious = false;
			_c = 0;
			_d = 0;
			_respawn_at_base = false;
			_revived_position = false;
		};
		sleep 1.5;
	};

	while {alive _name && !_respawn && !_conscious} do {
		_name = missionNamespace getVariable _strunit;
		_group = group _name;
		if (!isnull _name && !local _name || isnull _name) exitWith {};

		if (count (nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 2]) > 1 && _name == player) then {
			_nearest_unit = (nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 2] select 1);
			if (_c == 0 && !r_carry_sqf && (_nearest_unit getVariable "NORRN_AIunconscious")) then {
				if (_name isKindOf _can_revive   && _medpacks  == 0 ||
					_name isKindOf _can_revive_2 && _medpacks  == 0 ||
					_name isKindOf _can_revive   && _medpacks  == 1 && (_name getVariable "NORRN_medpacks") > 0 ||
					_name isKindOf _can_revive_2 && _medpacks  == 1 && (_name getVariable "NORRN_medpacks") > 0 ||
					_name isKindOf _medic_1  	 && _medpacks  == 1 && (_name getVariable "NORRN_medpacks") > 0 ||
					_name isKindOf _medic_2      && _medpacks  == 1 && (_name getVariable "NORRN_medpacks") > 0) then {
					Norrn_reviveAction = _name addAction ["Revive", "revive_sqf\heal.sqf",_nearest_unit, 0, false, true];
					_c = 1;
				};
			};
			if (!(_nearest_unit getVariable "NORRN_AIunconscious") || r_drag_sqf || r_carry_sqf) then {
				_name removeAction Norrn_reviveAction;
				_c = 0;
				sleep 0.1;
			};
		};
		if (count (nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 2]) == 1 && _c == 1) then {
			_name removeAction Norrn_reviveAction;
			_c = 0;
		};

		if (_unc_drag == 1 && _name == player) then {
			if (count (nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 3]) > 1) then {
				_near_dragUnit = (nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 4] select 1);
				if (_cc == 0) then {
					if(_near_dragUnit getVariable "NORRN_AIunconscious" && !r_carry_sqf) then {
						Norrn_dragAction = _name addAction ["Drag body", "revive_sqf\drag.sqf",_near_dragUnit, 0, false, true];
						_cc = 1;
					};
				};
				if (_cc == 1 && !(_near_dragUnit getVariable "NORRN_AIunconscious") || r_drag_sqf) then {
					_name removeAction Norrn_dragAction;
					_cc = 0;
					sleep 0.5; 	
				};
			};
			if (count (nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 3]) == 1) then {
				_name removeAction Norrn_dragAction;
				_cc = 0;
			};

			if (r_drag_sqf && _ccc == 0) then {
				_near_carryUnit = (nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 4] select 1);
				Norrn_carryAction = _name addAction ["Carry body", "revive_sqf\carry.sqf",_near_carryUnit, 0, false, true];
				_ccc = 1;
			};
			if (!r_drag_sqf && _ccc ==1) then {
				_name removeAction Norrn_carryAction;
				_ccc = 0;
			};

			if (_load_wounded == 1 && r_drag_sqf && count (nearestObjects [_name, ["Car","Tank","Helicopter","Plane"], 5]) > 0) then {
				_vcl = (nearestObjects [_name, ["Car","Tank","Helicopter","Plane"], 5]) select 0;
				_near_loadUnit = (nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 4] select 1);

				if (_dd == 0 && count (nearestObjects [_name, ["Car","Tank","Helicopter","Plane"], 5]) > 0 && alive _near_loadUnit) then {
					_action = format ["Load Wounded on %1", (typeOf _vcl)];
					NORRN_loadWoundedAction = _name addAction [_action, "revive_sqf\load_wounded\Load_act.sqf",[_name, _vcl, _near_loadUnit], 0, true, true];
					_dd = 1;
				};
			};
			if (_load_wounded == 1 && !r_drag_sqf || _load_wounded == 1 && _dd == 1 && count (nearestObjects [_name, ["Car","Tank","Helicopter","Plane"], 5]) == 0 || _load_wounded == 1 && _dd == 1 && NORRN_load_wounded_action || _load_wounded == 1 && _dd == 1 && !alive _near_loadUnit) then {
				_name removeAction NORRN_loadWoundedAction;
				NORRN_load_wounded_action = false;
				_dd = 0;
			};

			if (_load_wounded == 1 && count (nearestObjects [_name, ["Car","Tank","Helicopter","Plane"], 5]) > 0) then {
				_vcl = (nearestObjects [_name, ["Car","Tank","Helicopter","Plane"], 5]) select 0;
				_crewVcl = [];
				_crewVcl = crew _vcl;
				if (count _crewVcl > 0) then {
					_unconscious_crew = [];
					{if (_x getVariable "NORRN_AIunconscious") then {_unconscious_crew set [count _unconscious_crew, _x]}} forEach _crewVcl;
					if (count _unconscious_crew > 0 && _ddd == 0) then {
						_action = format ["Unload Wounded from %1", (typeOf _vcl)];
						NORRN_pullOutAction = _name  addAction [_action, "revive_sqf\load_wounded\unLoad_act.sqf",[_name, _vcl, _crewVcl], 0, true, true];
						_ddd = 1;
					};
					if (count _unconscious_crew == 0 && _ddd == 1) then {
						_name removeAction NORRN_pullOutAction;
						_ddd = 0;
					};
				};
			};
			if (_load_wounded == 1 && _ddd == 1  && count (nearestObjects [_name, ["Car","Tank","Helicopter","Plane"], 5]) == 0) then {
				_name removeAction NORRN_pullOutAction;
				_ddd = 0;
			};
		};

		if (_dddd  == 1 && !(_name getVariable "NORRN_AI_help")) then {_dddd = 0};
		if (_ddddd == 1 && _reviveWait < time) then {_ddddd = 0};
		if (_goto_revive == 0 && !isplayer _name && (count (nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 4])) > 1 ) then {
			if (_name isKindOf _can_revive   && _medpacks  == 0 ||
				_name isKindOf _can_revive_2 && _medpacks  == 0 ||
				_name isKindOf _can_revive   && _medpacks  == 1 && (_name getVariable "NORRN_medpacks") > 0 ||
				_name isKindOf _can_revive_2 && _medpacks  == 1 && (_name getVariable "NORRN_medpacks") > 0 ||
				_name isKindOf _medic_1  	 && _medpacks  == 1 && (_name getVariable "NORRN_medpacks") > 0 ||
				_name isKindOf _medic_2      && _medpacks  == 1 && (_name getVariable "NORRN_medpacks") > 0) then {
				_unc_friend = (nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 4] select 1);
				if ((_unc_friend getVariable "NORRN_AIunconscious") && !(_name getVariable "NORRN_unconscious") && animationState _name != "AinvPknlMstpSlayWrflDnon_medic") then {
					_name playMove "AinvPknlMstpSlayWrflDnon_medic";
					if (_medpacks == 1 && _dddd	== 0 && (_name getVariable "NORRN_AI_help") || _medpacks == 1 && !(_name getVariable "NORRN_AI_help") && _ddddd == 0) then {
						_var = _name getVariable "Norrn_medpacks";
						_name setVariable ["Norrn_medpacks", (_var - 1), true];
						_dddd = 1;
						_ddddd = 1;
						if !(_name getVariable "NORRN_AI_help") then {_reviveWait = time + 10};
					};
					if (_reward_function == 1) then {
						_var = _name getVariable "NORRN_bonus_life";
						_name setVariable ["NORRN_bonus_life", _var + 1, false];
					};
				};
			};
		};

		if (_goto_revive == 1 && !isplayer _name) then {[_name,_units] call Norrn_AIBehaviour};

		if (_medpacks == 1) then {
			_lar = if ("OA" in d_version) then {["HMMWV_Ambulance_DES_EP1","M113Ambul_TK_EP1","MASH_EP1"]} else {["M113Ambul","BMP2Ambul","MASH"]};
			if (count (nearestObjects [_name, _lar, 5]) > 0) then {
				if (_cccc == 0 && (_name getVariable "NORRN_medpacks") < _total_medpacks || _cccc == 0 && (_name getVariable "Norrn_bandages") < _total_bandages) then {
					if (_name == player) then {
						NORRN_medSuppliesAction = _name addAction ["Take medical supplies", "revive_sqf\medic\supplies.sqf","", 0, false, true];
						_cccc = 1;
					} else {
						_name setVariable ["NORRN_medpacks", _unit_medpacks, true];
						if (_name isKindOf _medic_1 || _name isKindOf _medic_2) then {_name setVariable ["NORRN_medpacks", _medic_medpacks, true]};
						_name setVariable ["NORRN_bandages", _unit_bandages, true];
						if (_name isKindOf _medic_1 || _name isKindOf _medic_2) then {_name setVariable ["NORRN_bandages", _medic_bandages, true]};
					};
				};
			};
			if (count (nearestObjects [_name, _lar, 5]) == 0 && _name == player) then {
				_name removeAction NORRN_medSuppliesAction;
				_cccc = 0;
				NORRN_medic_sup = false;
			};
		};

		if (_bleeding == 1) then {
			if ((damage _name) > 0.4 && !(_name getVariable "NORRN_stopBleed") && !(_name getVariable "NORRN_Bleed")) then {_name setVariable ["NORRN_Bleed", true, true]; _name setVariable ["NORRN_bleedDamage", (damage _name), true]; _ccccccc = 0};   
			if ((damage _name) > ((_name getVariable "NORRN_bleedDamage") + 0.2) && (_name getVariable "NORRN_stopBleed")) then {_name setVariable ["NORRN_Bleed", true, true]; _name setVariable ["NORRN_bleedDamage", (damage _name), true]; _ccccccc = 0};
			if (damage _name <= 0.4) then {_name setVariable ["NORRN_Bleed", false, true]; _name setVariable ["NORRN_stopBleed", false, true]};

			if (_name == player) then {
				if ((_name getVariable "NORRN_Bleed") && (_name getVariable "Norrn_bandages") > 0 && _ccccc == 0) then {
					NORRN_bandageAction = _name addAction ["Bandage wound", "revive_sqf\medic\bandage.sqf",_name, 0, false, true]; 
					_ccccc = _ccccc + 1;
				};
				if (!(_name getVariable "NORRN_Bleed") && _ccccc == 1 || (_name getVariable "Norrn_bandages") == 0 && _ccccc == 1) then {
					_name removeAction NORRN_bandageAction;
					_ccccc = 0;
				};

				if (count (nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 2]) > 1 && (_name getVariable "Norrn_bandages") > 0) then {
					_bloggs = (nearestObjects [player, [_can_be_revived, _can_be_revived_2], 2] select 1);

					if (_cccccc == 0 && (_bloggs getVariable "NORRN_Bleed")) then {
						NORRN_bandageBuddyAction = _name addAction ["Bandage Teamate", "revive_sqf\medic\bandage_teammate.sqf",[_name, _bloggs], 0, false, true]; 
						_cccccc = _cccccc + 1;
					};
					if (!(_bloggs getVariable "NORRN_Bleed")) then {
						_name removeAction NORRN_bandageBuddyAction;
						_cccccc = 0;
					};
				};
				if (count (nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 2]) == 1 || (_name getVariable "Norrn_bandages") == 0) then {
					_name removeAction NORRN_bandageBuddyAction;
					_cccccc = 0;
				};
			};

			if (_name getVariable "NORRN_Bleed") then {
				if (_ccccccc == 0 && _name == player) then {
					titleCut ["You are bleeding","PLAIN DOWN", 0.2]
				} else {
					if (_ccccccc in [10,30,50,70,90]) then {
						_blackout = if ((damage _name) > 0.4 && (damage _name) <= 0.7) then {random 0.2} else {random 0.4};
						if (_name == player) then {
							titleText ["", "BLACK", 1];
							sleep _blackout;
							titleText ["", "BLACK IN", 1];
						};
					} else {
						if (_ccccccc == 100) then {
							_damage_unit = damage _name;
							_damage_unit = _damage_unit + 0.05;
							_name setdammage _damage_unit;
							_ccccccc = -1;
						};
					};
				};
				_ccccccc = _ccccccc + 1;
			};
		};

		if ((_name getVariable "NORRN_teamkill_punish") == _no_team_kills && _team_kill_function == 1 && _max_respawns != 1000) then {
			if (NORRNCustomExec2 != "") then {call compile NORRNCustomExec2};
			_no_respawns = (_name getVariable "NORRN_lives_used") + 1;
			_respawns_left = _max_respawns - _no_respawns;
			_no_left = "You have lost a life for excessive team killing.";
			if (local _name) then {hint _no_left};
			_name setVariable ["NORRN_lives_used", _no_respawns, false];
			_name setVariable ["NORRN_teamkill_punish", 0, true];
		};

		if ((_name getVariable "Norrn_bonus_life") >= _revives_required && _reward_function == 1 && _max_respawns != 1000) then {
			_no_respawns = (_name getVariable "Norrn_lives_used") - 1;
			_respawns_left = _max_respawns - _no_respawns;
			if (_name == player) then {hint "You have received a bonus life for teamplay."};
			_name setVariable ["Norrn_lives_used", _no_respawns, true]; 
			_name setVariable ["Norrn_bonus_life", 0, true];
			_bonus = 0;
		};

		if (_reward_function == 1 && _max_respawns != 1000 && _bonus != (_name getVariable "Norrn_life_bonus") && _name == player) then {
			_bonus = _name getVariable "Norrn_life_bonus";
			_revives_till_bonus = _revives_required - _bonus;
			_hint = format ["Revives required for next bonus: %1", _revives_till_bonus];
			hint _hint;
		};
		sleep 0.5;
	};

	if (_respawn && !_conscious && !_dead) then {
		scopeName "Revive_02";
		_body = _name;
		_water = false;
		if (_body  == player) then {titleText ["","BLACK FADED",10]};
		_body setVariable ["NORRN_stopBleed", false, true];
		_body setVariable ["NORRN_Bleed", false, true];
		_ccccc = 0;

		_pos = getPos _body;
		_dir = (getDir _body) + 0.1;
		_offset = _body distance _pos;
		_weapons = weapons _body;
		_magazines = magazines _body;
		_body setVariable ["NORRN_unc_array", [_dir, _offset, _magazines, _weapons, _revive_damage], true];
		_body setVariable ["NORRN_uncPos", [(_pos select 0),(_pos select 1), _offset], true];
		_pos = _name getVariable "NORRN_uncPos";

		if ((_chance_ofDeath select 0) == 1 || (_chance_ofDeath select 1) == 1) then {
			_respawns = _respawns + 1;

			if ((_body getVariable "NORRN_kh_killer") == _body) then {
				if ((_chance_ofDeath select 0) == 1) then {
					_respawn_chance = 500;
				};
			} else {
				if ((_chance_ofDeath select 0) == 1) then {_respawn_chance = [_body, _respawns] call Norrn_respawn_Chance};
				if ((_chance_ofDeath select 1) == 1) then {_revive_time_limit   = [_body, _respawns] call Norrn_respawn_Time};
			};
			if (_respawns == 6) then {_dead = true};
			_random_chance = ceil (random 100);	
			if ((_chance_ofDeath select 0) == 1 && _random_chance > _respawn_chance) then {_dead = true};
		};

		if (!surfaceIsWater getPos _body) then {["swmhealed", _body] call RNetCallEvent};

		if (_AI_disabled == 0) then {
			if (format["%1", name _body] == "Error: No unit") exitWith {
				_respawn = false;
				_conscious = false;
				breakout "Revive_01";
			};
		};

		if (_body == player) then {
			_body removeAction Norrn_reviveAction;
			_name removeAction Norrn_dragAction;
			_name removeAction NORRN_loadWoundedAction;
		};

		if (!isNil "T_Server" && !isNil "T_Client") then {
			if (!T_Server && T_Client && _body == player) then {disableUserInput true};
		} else {
			if (_body == player) then {disableUserInput true}; 
		};

		if (_revived_position) then {
			waitUntil{alive (missionNamespace getVariable _strunit)};
			_body = missionNamespace  getVariable _strunit;
		};

		if (player == _name) then {NORRN_r_time_expire = false};

		if (local _name) then {if (_max_respawns  <= (_name getVariable "NORRN_lives_used")) then {_dead = true}};

		if (vehicle _body != _body) then {_vcl_pos = getpos vehicle _body; _body setPos [((_vcl_pos select 0)- 5), (_vcl_pos select 1), 0]};

		if (surfaceIsWater getPos _body && !_dead && _offset < 10) then	{_body = [_body, _strunit,_pos] call Norrn_WaterFix};

		_pos = _body getVariable "NORRN_uncPos";

		_slope = [_pos, 1] call GetTerrainSlope;
		if (_slope >= NORRN_max_slope) then {[_pos, _slope, _body] call Norrn_SlopeFix};

		if (_body == player) then {enableRadio false};		
		_respawn = true;
		_water = false;

		waitUntil{alive (missionNamespace getVariable _strunit)};
		_name = missionNamespace getVariable _strunit;
		["tripple", _name] call RNetCallEvent;

		_name setdir ((_name getVariable "NORRN_unc_array") select 0);
		_name setPos _pos;

		if (_name  == player) then {titlecut [" ","BLACK FADED",1]};
		if (_name == player && !_dead) then {
			_bee = "butterfly" createVehicle [_pos select 0, _pos select 1, (_pos select 2) + 1];
			[_bee, _pos] spawn NORRN_UNC_CAM;
		};

		if (_unconscious_markers == 1 && !surfaceIsWater _pos  && !_dead && local _name) then {
			_mrkr = format["%1 is down", _name]; 
			createMarker [_mrkr, _pos];
			_mrkr setMarkerColor "ColorBlue";
			_mrkr setMarkerType "Flag1";
			_mrkr setMarkerText format ["%1 is down", name _name]; 
			_mrkr setMarkerSize [0.4, 0.4];
		};

		if (isNil "d_init_started") then {
			removeAllWeapons _name;
			{_name removeMagazine _x} forEach magazines _name;
			removeAllItems _name;
			{_name addMagazine _x} forEach _magazines;
			{_name addWeapon _x} forEach _weapons;
			_name selectWeapon (primaryWeapon _name);
		};
		
		if (!alive _body) then {deleteVehicle _body};

		if (local _name) then {disableUserInput false};
		if (_name == player) then {unconscious_body = _name};
		["swmrollback", _name] call RNetCallEvent;

		_name setVariable ["NORRN_unconscious", true, true];
		_name setVariable ["NORRN_AIunconscious", true, true];
		_name setVariable ["NORRN_AI_help", false, true];
		_name setVariable ["NORRN_unit_dragged", false, true];
		_name setVariable ["NORRN_AI_help", false, true];

		_name stop true;
		if (_name == leader (group _name)) then {
			{if (currentCommand _x == "") then {_x doMove getPos _x} }forEach (units group _name);
		};
		_conscious = true;
	};

	if (alive _name && _respawn && _conscious && !_respawn_at_base && !_dead) then {
		_name = missionNamespace getVariable _strunit;
		_revive_time = time + _revive_time_limit;

		if(_revive_timer == 1 && _visible_timer == 1 && _name == player) then {[]spawn NORRN_uncTimer};
		sleep 0.01;

		while {_revive_timer == 0 && alive _name && _respawn && _conscious && !_respawn_at_base && !_dead ||
			 _revive_timer == 1 && alive _name && _respawn && _conscious && !_respawn_at_base && !_dead && time < _revive_time} do {
			if(!local _name) exitWith {};

			if (_name getVariable "Norrn_respawn_at_base") then {_respawn_at_base = true};

			if (_d == 0 && !all_dead_check) then {_NORRN_random = [_name] call Norrn_CallOut};
			_d = _d + 1;
			if (_d == _NORRN_random) then {_d = 0};

			if (!(_name getVariable "NORRN_unit_dragged")) then {
				if (_d == 0) then {_name playMoveNow "ainjppnemstpsnonwrfldnon_rolltoback"};
				if (_d == 22 && count (nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 4.5]) == 1) then {_name playMoveNow "ainjppnemstpsnonwrfldnon_rolltofront"};
			};

			sleep 0.3;

			if (alive _name && _respawn && _conscious && !_respawn_at_base && count (nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 4.5]) > 1 || count _caseVAC > 0) then {
				if (_name getVariable "Norrn_respawn_at_base") then {_respawn_at_base = true};

				_caseVAC_check = false;
				{
					if (count (nearestObjects [_name, [_x], 5]) > 0 && (_caseVAC select 0) == 1 && (_name getVariable "NORRN_unit_dragged")) then {
						_MASHvcl = (nearestObjects [_name, [_x], 5]) select 0; 
						if (_MASHvcl isKindOf "LandVehicle" || _MASHvcl isKindOf "Air") then {
							if (speed _MASHvcl == 0 && _name in (crew _MASHvcl)) then {
								_caseVAC_check = true;
							};
						} else {
							_caseVAC_check = true
						};
					};
				} forEach (_caseVAC select 1);

				_near_Objects = nearestObjects [_name, [_can_revive, _can_revive_2, _medic_1, _medic_2], 4.5];
				_e = 0;
				{if(_QG_animation == 1 && isplayer _x && animationState _x == "ainvpknlmstpsnonwnondr_medic0" || _QG_animation == 1 && !isplayer _x && animationState _x == "AinvPknlMstpSlayWrflDnon_medic" || _QG_animation == 0 && animationState _x == "AinvPknlMstpSlayWrflDnon_medic")then {_e = _e + 1}}forEach _near_Objects;
				if (_e >= 1 || _caseVAC_check) then {
					_reviver = objNull;
					_reviver_name = "";
					if (_e >= 1) then {
						_reviver = nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 4.5] select 1;
						if(animationState _reviver != "ainvpknlmstpsnonwnondr_medic0" && animationState _reviver != "AinvPknlMstpSlayWrflDnon_medic") then {_reviver = nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 4.5] select 2};
						if(animationState _reviver != "ainvpknlmstpsnonwnondr_medic0" && animationState _reviver != "AinvPknlMstpSlayWrflDnon_medic") then {_reviver = nearestObjects [_name, [_can_be_revived, _can_be_revived_2], 4.5] select 3};

						_reviver_name = if (alive _reviver) then {name _reviver} else {"Unknown"};
					};
					if (_caseVAC_check) then {
						if (vehicle _name != _name) then {_name action ["EJECT", (vehicle _name)]; sleep 1};
						["swmunc", _name] call RNetCallEvent;
					};

					if (isplayer _reviver && _QG_animation == 1) then {sleep 8};
					_name playMoveNow "ainjppnemstpsnonwrfldnon_rolltofront";
					sleep 2;
					_name playMoveNow "AmovPpneMstpSnonWnonDnon_healed";

					if (_name == player) then {titletext [" ","BLACK", 3]};

					_name setdamage _revive_damage;
					["double", _name] call RNetCallEvent;

					if (NORRNCustomExec1 != "") then {call compile NORRNCustomExec1};

					_name setVariable ["NORRN_unconscious", false, true];
					_name setVariable ["NORRN_AIunconscious", false, true];

					_name stop false;
					enableRadio true;

					if (_unconscious_markers == 1) then {deleteMarker format["%1 is down", _name]};

					if (local _name && _max_respawns != 1000) then {[_name, _max_respawns]call Norrn_LivesRemain};

					if (local _name && !isNull _reviver) then {
						["globalchat", [name _name, _reviver_name]] call RNetCallEvent;
					};

					if (_name == player) then {
						if (!isNull _reviver) then {
							_revived_by = format ["\nYou have been revived by %1", name _reviver];
							titletext [_revived_by,"BLACK IN",2];
							titleCut ["","PLAIN", 0.1];
						} else {
							titletext ["\nYou have been revived by CASEVAC","BLACK IN",2];
							titleCut ["","PLAIN", 0.1];
						};
					};

					[_group_leader, _my_group] call Norrn_LeaderFix;

					_name doMove getPos _name;

					["allowdam", _name] call RNetCallEvent;
					_name setVariable ["NORRN_AIReviver", objNull, true];
					_respawn = false;
					_conscious = false;
					["r_setcap", [_name, false]] call RNetCallEvent;
					//if (_AI_smoke == 1) then {_name setVariable ["NORRN_AISmoke", [false,""], true]};
					_c = 0;
					_d = 0;
					sleep 0.1;
				};
			};
		};

		if (_revive_timer == 1 && alive _name && _respawn && _conscious && !_respawn_at_base && time >= _revive_time && !_dead) then {
			if (_respawn_position == 0) then {
				if (local _name && isplayer _name) then {titleText ["Revive timer has been exceeded. Respawning at base", "PLAIN", 0.3]};
				sleep 2;
				[1, _name] execVM "revive_sqf\respawn_at_base.sqf"; 
				_respawn_at_base = true
			};
			switch (_respawn_position) do {
				case 1: {_respawn_at_base = [_name, _pos] call Norrn_RespawnPos1};
				case 2: {
					if (isplayer _name) then {
						_respawn_at_base = [_name] call Norrn_RespawnPos2
					} else {
						_respawn_at_base = [_name, _pos] call Norrn_RespawnPos2AI
					};
				};
				case 3: {_dead = true};
			};
		};
	};

	if (alive _name && _respawn && _conscious && _respawn_at_base && !_dead) then {
		titleCut["","plain down", 0.1];
		if (count(_name getVariable "NORRN_unc_array") != 0) then {[_name] spawn Norrn_createBody};

		_name enableAI "ANIM";
		_name playMoveNow "AmovPpneMstpSnonWnonDnon_healed";
		["double", _name] call RNetCallEvent;

		_name setVariable ["NORRN_unconscious", false, true];
		_name setVariable ["NORRN_AIunconscious", false, true];

		if (_unconscious_markers == 1) then {deleteMarker format["%1 is down", _name]};
		enableRadio true;
		_name selectweapon primaryweapon _name;

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

		_name stop false;

		if (!isNull _name) then {
			if (_drop_weapons == 1|| _cadaver == 0) then {
				sleep 2;
				_body = missionNamespace getVariable format ["norrn_dead_%1", _name];
				[_body] spawn NORRN_DropWeapons
			};
		};

		if (local _name && _max_respawns != 1000) then {[_name, _max_respawns]call Norrn_LivesRemain};

		[_group_leader, _my_group] call Norrn_LeaderFix;

		_name doMove getPos _name;

		if (_medpacks == 1) then {
			_name setVariable ["NORRN_medpacks", _unit_medpacks, true];
			if (_name isKindOf _medic_1 || _name isKindOf _medic_2) then {_name setVariable ["NORRN_medpacks", _medic_medpacks, true]};
		};
		if (_bleeding == 1) then {
			_name setVariable ["NORRN_bandages", _unit_bandages, true];
			if (_name isKindOf _medic_1 || _name isKindOf _medic_2) then {_name setVariable ["NORRN_bandages", _medic_bandages, true]};
		};

		["allowdam", _name] call RNetCallEvent;
		if (_name == player) then {
			all_dead_check = false
		};
		_name setVariable ["NORRN_AIReviver", objNull, true];
		//if (_AI_smoke == 1) then {_name setVariable ["NORRN_AISmoke", [false,""], true]};
		_name setVariable ["NORRN_respawn_at_base", false];
		_respawn_at_base = false;
		_respawn = false;
		_conscious = false;
		_c = 0;
		_d = 0;
		if (player == _name) then {NORRN_r_time_expire = false};
		sleep 2;
	};

	if (_dead) exitWith {
		if (local _name) then {
			if (count(_name getVariable "NORRN_unc_array") != 0) then {[_name, _pos] call Norrn_createBody};
			[_name] join grpNull;
			_name setVariable ["NORRN_unconscious", false, true];
			_name setVariable ["NORRN_AIunconscious", false, true];
			_name setVariable ["NORRN_life_bonus", 0, true];
			_name setDammage 1;
			_name setVariable ["NORRN_dead", true, true];
			if (_name == player && _dead) then {
				closedialog 0;
				titleText ["You are dead", "BLACK FADED", 3]; 
				sleep 2;
				if(_deadSpectator_cam == 1) then {
					_bee = "butterfly" createVehicle [_pos select 0, _pos select 1, (_pos select 2) + 1];
					[_bee, _pos] execVM "revive_sqf\cam_dead.sqf";
					sleep 0.1;
				} else {
					titleText ["Player is dead. Please press escape, return to the unit selection menu and choose another playable unit", "BLACK FADED", 10];
				};
			};
			_name setPos getMarkerPos "Boot_hill";
			["r_setcap", [_name, true]] call RNetCallEvent;
		};
		sleep 5;
		_dead = false;
		_respawn = false;
		_conscious = false;
	};
	sleep 0.1;
};