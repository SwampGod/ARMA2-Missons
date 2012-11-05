// init_respawn.sqf 
// © JULY 2009 - norrin 
_heal_yourself = NORRN_revive_array select 8;

{if (!isNull (missionNamespace getVariable _x)) then {[_x] execVM "revive_sqf\respawn\respawn.sqf"}}forEach NORRN_player_units;

if (_heal_yourself == 1 && !isNull player) then {[player] execVM "revive_sqf\heal_sqf\player_heal.sqf"};