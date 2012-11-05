// by Xeno
#include "x_setup.sqf"
private "_marker";

_d_show_player_marker = d_show_player_marker;
if (_d_show_player_marker > 0) then {
	switch (_d_show_player_marker) do {
		case 1: {"Player markers with player names available" call XfGlobalChat};
		case 2: {"Player markers only (without names) available" call XfGlobalChat};
		case 3: {"Player markers with player roles available" call XfGlobalChat};
		case 4: {"Player markers with player health available" call XfGlobalChat};
	};
};

if (_d_show_player_marker == 0) then {
	"Hiding player markers, one moment" call XfGlobalChat;
	sleep 2.123;
	{
		_marker = _x;
		_marker setMarkerPosLocal [0,0];
		_marker setMarkerAlphaLocal 0;
	} forEach d_player_entities;
	"Player markers hidden" call XfGlobalChat;
} else {
	{
		_marker = _x;
		_marker setMarkerAlphaLocal 1;
	} forEach d_player_entities;
};