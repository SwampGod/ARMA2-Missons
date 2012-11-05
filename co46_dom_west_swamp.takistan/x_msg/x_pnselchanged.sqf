// by Xeno
#include "x_setup.sqf"
private ["_selection", "_selectedIndex"];

disableSerialization;

_selection = _this select 0;

_selectedIndex = _selection select 1;

if (_selectedIndex == -1) exitWith {};

if (d_show_player_namesx != _selectedIndex) then {
	d_show_player_namesx = _selectedIndex;
	switch (d_show_player_namesx) do {
		case 0: {
			x_show_pname_hud = false;
			"Turning player names off..." call XfGlobalChat;
		};
		case 1: {
			x_show_pname_hud = true;
			"Turning player names on..." call XfGlobalChat;
		};
		case 2: {
			x_show_pname_hud = true;
			"Turning player roles on..." call XfGlobalChat;
		};
		case 3: {
			x_show_pname_hud = true;
			"Turning player health on..." call XfGlobalChat;
		};
	};
};