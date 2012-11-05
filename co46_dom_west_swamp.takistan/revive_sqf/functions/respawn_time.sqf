// respawn_time.sqf
// © JUNE 2009 - norrin
private ["_body", "_respawns", "_val", "_revive_time_limit"];
_body = _this select 0;
_respawns = _this select 1;
_revive_time_limit = Norrn_revive_array select 27;

_revive_time_limit = switch (_body getVariable "NORRN_body_part") do {
	case "": {_revive_time_limit};
	case "hands": {_revive_time_limit};
	case "legs": {(_revive_time_limit * 4)/5};
	case "body": {(_revive_time_limit * 3)/5};
	case "head_hit": {(_revive_time_limit * 2)/5};
};
_val = switch (_respawns) do {
	case 2: {2};
	case 3: {3};
	case 4: {4};
	case 5: {5};
	default {1};
};

(_revive_time_limit / _val)
