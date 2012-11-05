/*
RESPAWN COUNTER SCRIPT

© JANUARY 2008 - norrin (norrins_nook@iprimus.com.au) 
*/
if(!isServer) exitWith {};

if (time < 2) then {
	{missionNamespace setVariable [format ["%1_revives", _x], 0];publicVariable format ["%1_revives", _x]} forEach NORRN_player_units;
	{missionNamespace setVariable [format ["revive_%1", _x], 0];publicVariable format ["revive_%1", _x]} forEach NORRN_player_units;
	{missionNamespace setVariable [format ["%1_killer", _x], 0];publicVariable format ["%1_killer", _x]} forEach NORRN_player_units;
};