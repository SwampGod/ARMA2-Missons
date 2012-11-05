/*
TEAM KILL PUNISHMENT SCRIPT

© JUNE 2009 - norrin 
*/
_killed = _this select 0;
_killer = _this select 1;
_ally_side_1 = switch (NORRN_revive_array select 42) do {
	case "EAST": {east};
	case "WEST": {west};
	case "RESISTANCE": {resistance};
	default {sideUnknown};
};
_ally_side_2 = switch (NORRN_revive_array select 43) do {
	case "EAST": {east};
	case "WEST": {west};
	case "RESISTANCE": {resistance};
	default {sideUnknown};
};

if (_killer != _killed && side _killer == _ally_side_1 || _killer != _killed && side _killer == _ally_side_2) then {
	_var = _killer getVariable "NORRN_teamkill_punish";
	_killer setVariable ["NORRN_teamkill_punish", (_var + 1), true];
};