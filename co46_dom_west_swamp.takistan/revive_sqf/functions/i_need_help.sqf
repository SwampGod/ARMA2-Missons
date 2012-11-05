// I_need_help
// © AUGUST 2009 - norrin
private ["_can_revive","_can_revive_2","_goto_revive_distance","_AI_smoke","_AI_cover","_call_for_AI_help","_smoke_shell_types","_helpComments","_revive_units","_potential_revivers","_possible_reviver","_reviver","_mags","_smoke_rounds"];

_unit = player;
_can_revive = Norrn_revive_array select 18;
_can_revive_2 = Norrn_revive_array select 19;
_can_be_revived = Norrn_revive_array select 20;
_can_be_revived_2 = Norrn_revive_array select 21;
_medic_1 = Norrn_revive_array select 76;
_medic_2 = Norrn_revive_array select 77;
_goto_revive_distance = Norrn_revive_array select 33;
_AI_smoke = Norrn_revive_array select 40;
_AI_cover = Norrn_revive_array select 50;
_call_for_AI_help = Norrn_revive_array select 59;
_medic_1 = Norrn_revive_array select 76;
_medic_2 = Norrn_revive_array select 77;
_medpacks = Norrn_revive_array select 80;

_smoke_shell_types = ["SmokeShell","SmokeShellRed","SmokeShellGreen"];

_reviver = objNull;

if (_call_for_AI_help == 0) exitWith {titleText ["This option is not enabled in this mission","PLAIN",1]};

_helpComments = ["DBrian_Need_help","DBrian_A_little_help_here"];
["r_say", [_unit, _helpComments select floor(random 2)]] call RNetCallEvent;

_revive_units = [];
{_ur = missionNamespace getVariable _x;if (!isNull _ur) then {_revive_units set [count _revive_units, _ur]}} forEach NORRN_player_units;

if (count (nearestObjects [_unit, [_can_be_revived, _can_be_revived_2], _goto_revive_distance]) > 1) then {
	_potential_revivers = [];
	_potential_revivers = nearestObjects [_unit, [_can_revive, _can_revive_2, _medic_1,_medic_2], _goto_revive_distance];
	_possible_reviver = [];
	_possible_protectors =[];

	{if (_x in _revive_units) then {if (!(_x getVariable "NORRN_AI_help") && !(_x getVariable "NORRN_unconscious") && _medpacks == 0 || !(_x getVariable "NORRN_AI_help") && !(_x getVariable "NORRN_unconscious") && _medpacks == 1 && (_x getVariable "NORRN_medpacks") > 0) then {_possible_reviver set [count _possible_reviver, _x]}}}forEach _potential_revivers;
	{if (_x in _revive_units) then {if (!(_x getVariable "NORRN_AI_help") && !(_x getVariable "NORRN_unconscious")) then {_possible_protectors set [count _possible_protectors, _x]}}}forEach _potential_revivers;

	if ((count _possible_reviver) > 0) then {
		_reviver = _possible_reviver select 0;
		titleCut [format ["\n\nCalling %1 for help", name _reviver], "PLAIN", 0.5];
		_reviver setVariable ["NORRN_AI_help", true, true];

		Norrn_helper_list set [count Norrn_helper_list, _reviver];

		if (!isplayer _reviver) then {
			if (currentCommand _reviver  == "stop") then {
				if (!local _reviver) then {
					["joingrpnull", _reviver] call RNetCallEvent;
				} else { 
					[_reviver] join grpNull;
				};
			};

			["moveair", [_reviver, _unit]] call RNetCallEvent;

			// if (_AI_smoke == 1) then {
				// _mags = magazines _reviver;
				// _smoke_rounds = [];
				// {if (_x in _smoke_shell_types) then {_smoke_rounds set [count _smoke_rounds, _x]}} forEach _mags;

				// if (count _smoke_rounds > 0) then {[_reviver, _smoke_rounds] spawn Norrn_AI_throwSmoke};
			// };
		} else {
			["hintcall", r_name_player] call RNetCallEvent;
			hint "";
		};
	};
	_possible_protectors = _possible_protectors - [_reviver ];
	if ((count _possible_protectors) > 1 && _AI_cover == 1) then {
		_goto_protector =  _possible_protectors select 0;	
		
		if (!isplayer _goto_protector) then {
			if (currentCommand _goto_protector == "stop") then {
				if (!local _goto_protector) then {
					["joingrpnull", _goto_protector] call RNetCallEvent;
				} else {
					[_goto_protector] join grpNull;
				};
			};

			["moveprot", [_goto_protector, _unit]] call RNetCallEvent;
		};
	};
};

[_reviver,_unit] execVM "revive_sqf\functions\wait_check.sqf";