// by Xeno
#include "x_setup.sqf"
private ["_current_target_name","_target_array2","_extra_bonus_number"];

if (!X_Client) exitWith {};

_extra_bonus_number = _this;

__TargetInfo

_current_target_name setMarkerColorLocal "ColorGreen";

if (!isNil "task1") then {task1 setTaskState "Succeeded"};

if (!isNil "d_current_task") then {
	d_current_task setTaskState "Succeeded";
	[d_current_task, "SUCCEEDED"] spawn XTaskHint;
};

if ((count __XJIPGetVar(resolved_targets)) < d_MainTargets) then {
	_bonus_pos = "your base";
	
	_mt_str = format ["%1 has been cleared...", _current_target_name];
#ifndef __TT__
	_type_name = d_mt_bonus_vehicle_array select _extra_bonus_number;

	_bonus_vehicle = [_type_name,0] call XfGetDisplayName;
	
	_bonus_string = format["Your team gets a %1, it's available at %2", _bonus_vehicle, _bonus_pos];
	
	hint composeText[
		parseText("<t color='#f02b11ed' size='1'>" + _mt_str + "</t>"), lineBreak,lineBreak,
		"Congratulations...", lineBreak,lineBreak,
		_bonus_string, lineBreak,lineBreak,
		"Waiting for new orders..."
	];
	if (__RankedVer) then {
		_current_target_pos = _target_array2 select 0;
		if (player distance _current_target_pos < (d_ranked_a select 10)) then {
			(format ["You get %1 extra points for clearing the main target!",(d_ranked_a select 9)]) call XfHQChat;
			[] spawn {
				sleep (0.5 + random 2);
				["d_pas", [player, (d_ranked_a select 9)]] call XNetCallEvent;
			};
		};
	};
#else
	_winner_string = "";
	_points_array = __XJIPGetVar(points_array);
	_kill_points_west = _points_array select 2;
	_kill_points_east = _points_array select 3;
	switch (d_mt_winner) do {
		case 1: {_winner_string = format ["The US Team won the main target with %1 : %2 kill points.\nThe US Team gets %3 main points.",_kill_points_west,_kill_points_east, d_tt_points select 0]};
		case 2: {_winner_string = format ["The East Team won the main target with %1 : %2 kill points.\nThe East Team gets %3 main points.",_kill_points_east,_kill_points_west, d_tt_points select 0]};
		case 3: {_winner_string = format ["Both teams have %1 kill points.\nBoth teams get %2 main points.",_kill_points_east, d_tt_points select 1]};
	};
	_team = switch (d_mt_winner) do {
		case 1: {"Team West gets"};
		case 2: {"Team East gets"};
		case 3: {"Both teams get"};
	};
	_bonus_string = format["%1 a bonus vehicle, it's available at %2", _team, _bonus_pos];
	
	hint composeText[
		parseText("<t color='#f02b11ed' size='1'>" + _mt_str + "</t>"), lineBreak,lineBreak,
		"Congratulations...", lineBreak,lineBreak,
		_bonus_string, lineBreak,lineBreak,
		"Waiting for new orders..."
	];
	titleText [_winner_string, "PLAIN"];
	if (__RankedVer) then {
		_current_target_pos = _target_array2 select 0;
		if (player distance _current_target_pos < 400) then {
			(format ["You get %1 extra points for clearing the main target!",(d_ranked_a select 9)]) call XfHQChat;
			[] spawn {
				sleep (0.5 + random 2);
				["d_pas", [player, (d_ranked_a select 9)]] call XNetCallEvent;
			};
		};
	};
#endif
} else {
	_mt_str = format ["%1 has been cleared...", _current_target_name];
#ifndef __TT__
	hint  composeText[
		parseText("<t color='#f02b11ed' size='1'>" + _mt_str + "</t>"), lineBreak,lineBreak,
		"Congratulations..."
	];
#else
	_points_array = __XJIPGetVar(points_array);
	_kill_points_west = _points_array select 2;
	_kill_points_east = _points_array select 3;
	_winner_string = switch (d_mt_winner) do {
		case 1: {format ["The US Team won the main target with %1 : %2 kill points.\nThe US Team gets %3 main points.",_kill_points_west,_kill_points_east, d_tt_points select 0]};
		case 2: {format ["The East Team won the main target with %1 : %2 kill points.\nThe East Team gets %3 main points.",_kill_points_east,_kill_points_west, d_tt_points select 0]};
		case 3: {format ["Both teams have %1 kill points.\nBoth teams get %2 main points.",_kill_points_east, d_tt_points select 1]};
		default {""};
	};
	hint  composeText[
		parseText("<t color='#f02b11ed' size='1'>" + _mt_str + "</t>"), lineBreak,lineBreak,
		"Congratulations..."
	];
	titleText [_winner_string, "PLAIN"];
#endif
};

sleep 2;

if (!X_SPE) then {__XJIPSetVar ["current_target_index", -1]};