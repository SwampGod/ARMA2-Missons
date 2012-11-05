// respawn_chance.sqf
// © JUNE 2009 - norrin
private ["_body", "_respawns", "_val", "_respawn_chance"];
_body 		= _this select 0;
_respawns 	= _this select 1;

_respawn_chance = switch (_body getVariable "NORRN_body_part") do {
	case "": {500};
	case "hands": {200};
	case "legs": {70};
	case "body": {50};
	case "head_hit": {20};
};

_val = switch (_respawns) do {
	case 2: {2};
	case 3: {3};
	case 4: {4};
	case 5: {5};
	default {1};
};

(_respawn_chance / _val)