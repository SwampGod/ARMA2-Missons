// by Xeno
#define THIS_FILE "x_pnselchanged.sqf"
#include "x_setup.sqf"
private ["_selection", "_selectedIndex"];

disableSerialization;

_selection = _this select 0;

_selectedIndex = _selection select 1;

if (_selectedIndex == -1) exitWith {};

if (GVAR(show_player_namesx) != _selectedIndex) then {
	GVAR(show_player_namesx) = _selectedIndex;
	switch (GVAR(show_player_namesx)) do {
		case 0: {
			x_show_pname_hud = false;
			"Turning player names off..." call FUNC(GlobalChat);
		};
		case 1: {
			x_show_pname_hud = true;
			"Turning player names on..." call FUNC(GlobalChat);
		};
		case 2: {
			x_show_pname_hud = true;
			"Turning player roles on..." call FUNC(GlobalChat);
		};
		case 3: {
			x_show_pname_hud = true;
			"Turning player health on..." call FUNC(GlobalChat);
		};
	};
};