// by Xeno
#define THIS_FILE "x_deleteplayermarker.sqf"
#include "x_setup.sqf"
private "_marker";

_d_show_player_marker = GVAR(show_player_marker);
if (_d_show_player_marker > 0) then {
	switch (_d_show_player_marker) do {
		case 1: {"Player markers with player names available" call FUNC(GlobalChat)};
		case 2: {"Player markers only (without names) available" call FUNC(GlobalChat)};
		case 3: {"Player markers with player roles available" call FUNC(GlobalChat)};
		case 4: {"Player markers with player health available" call FUNC(GlobalChat)};
	};
};

if (_d_show_player_marker == 0) then {
	"Hiding player markers, one moment" call FUNC(GlobalChat);
	sleep 2.123;
	{
		_marker = _x;
		_marker setMarkerPosLocal [0,0];
		_marker setMarkerAlphaLocal 0;
	} forEach GVAR(player_entities);
	"Player markers hidden" call FUNC(GlobalChat);
} else {
	{
		_marker = _x;
		_marker setMarkerAlphaLocal 1;
	} forEach GVAR(player_entities);
};