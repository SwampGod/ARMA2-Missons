// by Xeno
#define THIS_FILE "x_target_clear_client.sqf"
#include "x_setup.sqf"
private ["_current_target_name","_target_array2","_extra_bonus_number"];

if (!X_Client) exitWith {};

_extra_bonus_number = _this;

__TargetInfo

_current_target_name setMarkerColorLocal "ColorGreen";

if (!isNil QGVAR(task1)) then {GVAR(task1) setTaskState "Succeeded"};

if (!isNil QGVAR(current_task)) then {
	GVAR(current_task) setTaskState "Succeeded";
	[GVAR(current_task), "SUCCEEDED"] spawn FUNC(TaskHint);
};

if (count __XJIPGetVar(resolved_targets) < GVAR(MainTargets)) then {
	_bonus_pos = "your base";
	
	_mt_str = format ["%1 has been cleared...", _current_target_name];
#ifndef __TT__
	if (_extra_bonus_number != -1) then {
		_bonus_string = format["Your team gets a %1, it's available at %2", [GVAR(mt_bonus_vehicle_array) select _extra_bonus_number, 0] call FUNC(GetDisplayName), _bonus_pos];
		
		hint composeText[
			parseText("<t color='#f02b11ed' size='1'>" + _mt_str + "</t>"), lineBreak,lineBreak,
			"Congratulations...", lineBreak,lineBreak,
			_bonus_string, lineBreak,lineBreak,
			"Waiting for new orders..."
		];
	} else {
		hint composeText[
			parseText("<t color='#f02b11ed' size='1'>" + _mt_str + "</t>"), lineBreak,lineBreak,
			"Congratulations...", lineBreak,lineBreak,
			"Waiting for new orders..."
		];
	};
	
	if (GVAR(with_ranked)) then {
		_current_target_pos = _target_array2 select 0;
		if (player distance _current_target_pos < (GVAR(ranked_a) select 10)) then {
			(format ["You get %1 extra points for clearing the main target!", GVAR(ranked_a) select 9]) call FUNC(HQChat);
			0 spawn {
				sleep (0.5 + random 2);
				[QGVAR(pas), [player, GVAR(ranked_a) select 9]] call FUNC(NetCallEvent);
			};
		};
	};
#else
	_points_array = __XJIPGetVar(points_array);
	_kill_points_west = _points_array select 2;
	_kill_points_east = _points_array select 3;
	_winner_string = switch (GVAR(mt_winner)) do {
		case 1: {format ["The US Team won the main target with %1 : %2 kill points.\nThe US Team gets %3 main points.",_kill_points_west,_kill_points_east, GVAR(tt_points) select 0]};
		case 2: {format ["The East Team won the main target with %1 : %2 kill points.\nThe East Team gets %3 main points.",_kill_points_east,_kill_points_west, GVAR(tt_points) select 0]};
		case 3: {format ["Both teams have %1 kill points.\nBoth teams get %2 main points.",_kill_points_east, GVAR(tt_points) select 1]};
		default {""};
	};
	_team = switch (GVAR(mt_winner)) do {
		case 1: {"Team West gets"};
		case 2: {"Team East gets"};
		case 3: {"Both teams get"};
		default {"No Team gets"};
	};
	
	if (_extra_bonus_number != -1) then {
		_bonus_string = format["%1 a bonus vehicle, it's available at %2", _team, _bonus_pos];
		
		hint composeText[
			parseText("<t color='#f02b11ed' size='1'>" + _mt_str + "</t>"), lineBreak,lineBreak,
			"Congratulations...", lineBreak,lineBreak,
			_bonus_string, lineBreak,lineBreak,
			"Waiting for new orders..."
		];
	} else {
		hint composeText[
			parseText("<t color='#f02b11ed' size='1'>" + _mt_str + "</t>"), lineBreak,lineBreak,
			"Congratulations...", lineBreak,lineBreak,
			"Waiting for new orders..."
		];
	};
	
	titleText [_winner_string, "PLAIN"];
	
	if (GVAR(with_ranked)) then {
		_current_target_pos = _target_array2 select 0;
		if (player distance _current_target_pos < 400) then {
			(format ["You get %1 extra points for clearing the main target!", GVAR(ranked_a) select 9]) call FUNC(HQChat);
			0 spawn {
				sleep (0.5 + random 2);
				[QGVAR(pas), [player, GVAR(ranked_a) select 9]] call FUNC(NetCallEvent);
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
	_winner_string = switch (GVAR(mt_winner)) do {
		case 1: {format ["The US Team won the main target with %1 : %2 kill points.\nThe US Team gets %3 main points.",_kill_points_west,_kill_points_east, GVAR(tt_points) select 0]};
		case 2: {format ["The East Team won the main target with %1 : %2 kill points.\nThe East Team gets %3 main points.",_kill_points_east,_kill_points_west, GVAR(tt_points) select 0]};
		case 3: {format ["Both teams have %1 kill points.\nBoth teams get %2 main points.",_kill_points_east, GVAR(tt_points) select 1]};
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

if (!X_SPE) then {__XJIPSetVar [QGVAR(current_target_index), -1]};