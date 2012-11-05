// by Xeno
#include "x_setup.sqf"
private ["_exitj", "_rank", "_unit", "_type_soldier"];

_type_soldier = _this select 3;

d_grp_caller = group player;
if (player != leader d_group_caller) exitWith {
	"You are currently not a group leader, no AI available. Create a new group" call XfHQChat;
};

_exitj = false;
if (d_with_ranked) then {
	_rank = rank player;
	if (_rank == "PRIVATE") exitWith {
		"You current rank is private. You can't recruit soldiers!" call XfHQChat;
		_exitj = true;
	};

	if (score player < ((d_points_needed select 0) + (d_ranked_a select 3))) exitWith {
		(format ["You can't recruit an AI soldier, costs %2 points, your current score (%1) will drop below 10!", score player,d_ranked_a select 3]) call XfHQChat;
		_exitj = true;
	};

	_max_rank_ai = switch (_rank) do {
		case "CORPORAL": {3};
		case "SERGEANT": {4};
		case "LIEUTENANT": {5};
		case "CAPTAIN": {6};
		case "MAJOR": {7};
		case "COLONEL": {8};
	};
	if (d_current_ai_num >= _max_rank_ai) exitWith {
		(format ["You allready have %1 AI soldiers under your control, it is not possible to recruit more with your current rank...", _max_rank_ai]) call XfHQChat;
		_exitj = true;
	};
	// each AI soldier costs score points
	["d_pas", [player, (d_ranked_a select 3) * -1]] call XNetCallEvent;
} else {
	if (d_current_ai_num >= d_max_ai) exitWith {
		(format ["You allready have %1 AI soldiers under your control...", d_max_ai]) call XfHQChat;
		_exitj = true;
	};
};
if (_exitj) exitWith {};

#ifdef __OA__
_ai_side_char = switch (d_own_side) do {
	case "GUER": {"GUE"};
	case "WEST": {"US"};
	case "EAST": {"TK"};
};
#else
_ai_side_char = switch (d_own_side) do {
	case "GUER": {"GUE"};
	case "WEST": {"USMC"};
	case "EAST": {"RU"};
};
#endif

_ai_side_unit = if (_type_soldier == "Specop") then {
#ifndef __OA__
	switch (d_own_side) do {
		case "GUER": {"GUE_Soldier_Sab"};
		case "WEST": {"FR_Sapper"};
		case "EAST": {"RUS_Soldier_Sab"};
	}
#else
	switch (d_own_side) do {
		case "GUER": {"GUE_Soldier_Sab"};
		case "WEST": {"US_Delta_Force_Night_EP1"};
		case "EAST": {"TK_Special_Forces_EP1"};
	}
#endif
} else {
	format [_type_soldier, _ai_side_char]
};

_unit = d_grp_caller createUnit [_ai_side_unit, position AISPAWN, [], 0, "FORM"];
_unit setVariable ["BIS_noCoreConversations", true];
[_unit] join d_grp_caller;
_unit setSkill 1;
_unit setRank "PRIVATE";
["d_ad", _unit] call XNetCallEvent;
if (d_with_ranked) then {
	_unit addEventHandler ["handleHeal", {_this call XHandleHeal}];
};
_d_ai_punits = d_ai_punits;
_d_ai_punits set [count _d_ai_punits, _unit];
d_ai_punits = _d_ai_punits;
__INC(d_current_ai_num);
